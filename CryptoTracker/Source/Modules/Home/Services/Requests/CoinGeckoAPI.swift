import Foundation

enum CoinGeckoAPI {

    case markets(queryParams: HttpParams?)
    case image(url: String)
}

extension CoinGeckoAPI: HttpRequest {

    var baseURL: String {
        switch self {
        case .image(let url):
            return url
        default:
            return "https://api.coingecko.com"
        }
    }

    var path: String? {
        switch self {

        case .markets:
            return "/api/v3/coins/markets"
        case .image:
            return nil
        }
    }

    var queryParams: HttpParams? {
        switch self {

        case .markets(let params):
            return params
        default:
            return nil
        }
    }
}
