import Foundation
import Combine
import UIKit

protocol HttpDispatcherProtocol {
    var urlSession: URLSession { get }

    func dispatch<ReturnType: Decodable>(request: URLRequest) -> AnyPublisher<ReturnType, HttpError>
    func dispatch(request: URLRequest) -> AnyPublisher<UIImage?, HttpError>
}

struct HttpDispatcher: HttpDispatcherProtocol {

    private(set) var urlSession: URLSession

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    /// Dispatches an URLRequest and returns a Publisher
    /// - Parameter request: URLRequest
    /// - Returns: A publisher with the provided decoded data or an error
    func dispatch<ReturnType: Decodable>(request: URLRequest) -> AnyPublisher<ReturnType, HttpError> {
        return urlSession
            .dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handleURLResponse(output: $0) })
            .decode(type: ReturnType.self, decoder: JSONDecoder())
            .mapError { handleError($0) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    /// Dispatches an URLRequest and returns a Publisher
    /// - Parameter request: URLRequest
    /// - Returns: A publisher with the provided image or an error
    func dispatch(request: URLRequest) -> AnyPublisher<UIImage?, HttpError> {
        return urlSession
            .dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try handleURLResponse(output: $0) })
            .tryMap({ UIImage(data: $0) })
            .mapError { handleError($0) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

extension HttpDispatcher {

    /// Parses a HTTP status code and returns a proper error
    /// - Parameter statusCode: HTTP status code
    /// - Returns: Mapped Error
    private func httpError(_ statusCode: Int) -> HttpError {

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
    /// - Returns: Readable HttpError
    private func handleError(_ error: Error) -> HttpError {
        switch error {
        case is Swift.DecodingError:
            return .decodingError

        case let urlError as URLError:
            return .urlSessionFailed(urlError)

        case let error as HttpError:
            return error

        default:
            return .unknownError
        }
    }
}
