import Foundation

enum CoinGeckoAPI {

    case image(url: String)
    case global
    case markets(queryParams: HttpParams?)
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

        case .image:
            return nil
        case .global:
            return "/api/v3/global"
        case .markets:
            return "/api/v3/coins/markets"

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
