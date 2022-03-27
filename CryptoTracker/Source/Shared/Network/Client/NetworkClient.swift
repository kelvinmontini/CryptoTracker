import Foundation
import Combine

protocol NetworkClientProtocol {
    var networkDispatcher: NetworkDispatcherProtocol { get }
    func dispatch<ReturnType: Decodable>(request: NetworkRequest) -> AnyPublisher<ReturnType, NetworkError>
}

struct NetworkClient: NetworkClientProtocol {

    private(set) var networkDispatcher: NetworkDispatcherProtocol

    init(networkDispatcher: NetworkDispatcherProtocol = NetworkDispatcher()) {
        self.networkDispatcher = networkDispatcher
    }

    /// Dispatches a Request and returns a Publisher
    /// - Parameter request: Request to Dispatch
    /// - Returns: A publisher containing decoded Data or an NetworkError
    func dispatch<ReturnType: Decodable>(request: NetworkRequest) -> AnyPublisher<ReturnType, NetworkError> {

        guard let urlRequest = request.asURLRequest(baseURL: request.baseURL) else {
            return Fail(outputType: ReturnType.self, failure: NetworkError.badRequest).eraseToAnyPublisher()
        }

        typealias RequestPublisher = AnyPublisher<ReturnType, NetworkError>
        let requestPublisher: RequestPublisher = networkDispatcher.dispatch(request: urlRequest)

        return requestPublisher.eraseToAnyPublisher()
    }
}
