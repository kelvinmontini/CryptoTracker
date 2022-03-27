import Foundation
import Combine

protocol NetworkDispatcherProtocol {
    var urlSession: URLSession { get }
    func dispatch<ReturnType: Decodable>(request: URLRequest) -> AnyPublisher<ReturnType, NetworkError>
}

struct NetworkDispatcher: NetworkDispatcherProtocol {

    private(set) var urlSession: URLSession

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    /// Dispatches an URLRequest and returns a Publisher
    /// - Parameter request: URLRequest
    /// - Returns: A publisher with the provided decoded data or an error
    func dispatch<ReturnType: Decodable>(request: URLRequest) -> AnyPublisher<ReturnType, NetworkError> {
        return urlSession
            .dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handleURLResponse(output: $0) })
            .decode(type: ReturnType.self, decoder: JSONDecoder())
            .mapError { handleError($0) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

extension NetworkDispatcher {

    /// Parses a HTTP status code and returns a proper error
    /// - Parameter statusCode: HTTP status code
    /// - Returns: Mapped Error
    private func httpError(_ statusCode: Int) -> NetworkError {

        switch statusCode {
        case 400:
            return .badRequest

        case 401:
            return .unauthorized

        case 403:
            return .forbidden

        case 404:
            return .notFound

        case 402, 405...499:
            return .error4xx(statusCode)

        case 500:
            return .serverError

        case 501...599:
            return .error5xx(statusCode)

        default:
            return .unknownError
        }
    }

    /// Parses URLSession publisher output, validate HTTP status code and return proper ones
    /// - Parameter output: URLSession.DataTaskPublisher.Output
    /// - Returns: Valid Data or throw an error
    private func handleURLResponse(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        if let response = output.response as? HTTPURLResponse,
           !(200...299).contains(response.statusCode) {
            throw httpError(response.statusCode)
        }

        return output.data
    }

    /// Parses URLSession publisher errors and return proper ones
    /// - Parameter error: Error
    /// - Returns: Readable NetworkError
    private func handleError(_ error: Error) -> NetworkError {
        switch error {
        case is Swift.DecodingError:
            return .decodingError

        case let urlError as URLError:
            return .urlSessionFailed(urlError)

        case let error as NetworkError:
            return error

        default:
            return .unknownError
        }
    }
}
