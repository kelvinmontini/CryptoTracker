import Foundation

struct GetCoins: NetworkRequest {
    typealias ReturnType = [Coin]

    var path: String = "/api/v3/coins/markets"
    var queryParams: [String: String]?

    init(queryParams: [String: String]) {
        self.queryParams = queryParams
    }
}
