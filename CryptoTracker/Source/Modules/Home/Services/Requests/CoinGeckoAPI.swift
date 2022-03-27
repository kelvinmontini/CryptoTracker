import Foundation

enum CoinGeckoAPI {

    case markets(queryParams: HTTPParams?)
}

extension CoinGeckoAPI: NetworkRequest {

    var baseURL: String { "https://api.coingecko.com" }

    var path: String {
        switch self {

        case .markets:
            return "/api/v3/coins/markets"
        }
    }

    var queryParams: HTTPParams? {
        switch self {

        case .markets(let params):
            return params
        }
    }
}
