import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case put = "PUT"
    case delete = "DELETE"
}

protocol NetworkRequest {
    associatedtype ReturnType: Codable

    var path: String { get }
    var method: HTTPMethod { get }
    var contentType: String { get }
    var queryParams: [String: String]? { get }
    var body: [String: Any]? { get }
    var headers: [String: String]? { get }
}

extension NetworkRequest {
    var method: HTTPMethod { .get }
    var contentType: String { "application/json" }
    var queryParams: [String: String]? { nil }
    var body: [String: Any]? { nil }
    var headers: [String: String]? { nil }
}

extension NetworkRequest {

    private func requestBodyFrom(params: [String: Any]?) -> Data? {
        guard let params = params else { return nil }
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params,
                                                         options: []) else { return nil }
        return httpBody
    }

    private func queryItemsFrom(items: [String: String]?) -> [URLQueryItem]? {
        items?.map { URLQueryItem(name: $0.key, value: $0.value) }
    }

    func asURLRequest(baseURL: String) -> URLRequest? {

        guard var urlComponents = URLComponents(string: baseURL) else { return nil }
        urlComponents.path = path
        urlComponents.queryItems = queryItemsFrom(items: queryParams)
        guard let finalURL = urlComponents.url else { return nil }

        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        request.httpBody = requestBodyFrom(params: body)
        request.allHTTPHeaderFields = headers
        return request
    }
}
