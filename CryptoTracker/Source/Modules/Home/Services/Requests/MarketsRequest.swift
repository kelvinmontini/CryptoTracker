import Foundation

struct MarketsRequest: NetworkRequest {
    typealias ReturnType = [Coin]

    let baseURL: String = "https://api.coingecko.com"
    let path: String = "/api/v3/coins/markets"
    let queryParams: [String: String]?

    init(queryParams: [String: String]) {
        self.queryParams = queryParams
    }
}
