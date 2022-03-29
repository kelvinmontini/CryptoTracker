import Foundation
import Combine
import SwiftUI

protocol HttpClientProtocol {
    var httpDispatcher: HttpDispatcherProtocol { get }

    func dispatch<ReturnType: Decodable>(request: HttpRequest) -> AnyPublisher<ReturnType, HttpError>
    func dispatch(request: HttpRequest) -> AnyPublisher<UIImage?, HttpError>
}

struct HttpClient: HttpClientProtocol {

    private(set) var httpDispatcher: HttpDispatcherProtocol

    init(httpDispatcher: HttpDispatcherProtocol = HttpDispatcher()) {
        self.httpDispatcher = httpDispatcher
    }

    /// Dispatches a Request and returns a Publisher
    /// - Parameter request: Request to Dispatch
    /// - Returns: A publisher containing decoded Data or an HttpError
    func dispatch<ReturnType: Decodable>(request: HttpRequest) -> AnyPublisher<ReturnType, HttpError> {

        guard let urlRequest = request.asURLRequest(baseURL: request.baseURL) else {
            return Fail(outputType: ReturnType.self, failure: HttpError.badRequest).eraseToAnyPublisher()
        }

        typealias RequestPublisher = AnyPublisher<ReturnType, HttpError>
        let requestPublisher: RequestPublisher = httpDispatcher.dispatch(request: urlRequest)

        return requestPublisher.eraseToAnyPublisher()
    }

    /// Dispatches a Request and returns a Publisher
    /// - Parameter request: Request to Dispatch
    /// - Returns: A publisher containing  UIImage? or an HttpError
    func dispatch(request: HttpRequest) -> AnyPublisher<UIImage?, HttpError> {

        guard let urlRequest = request.asURLRequest(baseURL: request.baseURL) else {
            return Fail(outputType: UIImage?.self, failure: HttpError.badRequest).eraseToAnyPublisher()
        }

        typealias RequestPublisher = AnyPublisher<UIImage?, HttpError>
        let requestPublisher: RequestPublisher = httpDispatcher.dispatch(request: urlRequest)

        return requestPublisher.eraseToAnyPublisher()
    }
}
