import Foundation

typealias HttpParams = [String: Any]
typealias HttpHeaders = [String: String]

enum HttpContentType: String {
    case json = "application/json"
}

enum HttpHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case put = "PUT"
    case delete = "DELETE"
}

protocol HttpRequest {
    var baseURL: String { get }
    var path: String? { get }
    var method: HttpMethod { get }
    var contentType: HttpContentType { get }
    var queryParams: HttpParams? { get }
    var body: HttpParams? { get }
    var headers: HttpHeaders? { get }
}

extension HttpRequest {
    var method: HttpMethod { .get }
    var contentType: HttpContentType { .json }
    var queryParams: HttpParams? { nil }
    var body: HttpParams? { nil }
    var headers: HttpHeaders? { nil }
}

extension HttpRequest {

    /// Serializes an HTTP dictionary to a JSON Data Object
    /// - Parameter params: HTTP Parameters dictionary
    /// - Returns: Encoded JSON
    private func requestBodyFrom(params: HttpParams?) -> Data? {
        guard let params = params else { return nil }
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params,
                                                         options: []) else { return nil }
        return httpBody
    }

    /// Generates a URLQueryItems array from a Params dictionary
    /// - Parameter params: HTTP Parameters dictionary
    /// - Returns: An Array of URLQueryItems
    private func queryItemsFrom(params: HttpParams?) -> [URLQueryItem]? {
        guard let params = params else { return nil }
        return params.map {
            URLQueryItem(name: $0.key, value: "\($0.value)")
        }
    }

    /// Transforms a Request into a standard URL request
    /// - Parameter baseURL: API Base URL to be used
    /// - Returns: A ready to use URLRequest
    func asURLRequest(baseURL: String) -> URLRequest? {

        guard var urlComponents = URLComponents(string: baseURL) else { return nil }

        if let path = path {
            urlComponents.path = "\(urlComponents.path)\(path)"
        }

        urlComponents.queryItems = queryItemsFrom(params: queryParams)
        guard let finalURL = urlComponents.url else { return nil }

        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        request.httpBody = requestBodyFrom(params: body)
        let defaultHeaders: HttpHeaders = [
            HttpHeaderField.contentType.rawValue: contentType.rawValue,
            HttpHeaderField.acceptType.rawValue: contentType.rawValue
        ]
        request.allHTTPHeaderFields = defaultHeaders.merging(headers ?? [:],
                                                             uniquingKeysWith: { (first, _) in first })
        return request
    }
}
