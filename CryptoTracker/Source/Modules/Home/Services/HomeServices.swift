import Foundation
import Combine

final class HomeServices {

    @Published private(set) var allCoins: [Coin] = []
    @Published private(set) var globalMarketData: GlobalMarketData?

    private var cancellables = Set<AnyCancellable>()
    private let httpClient: HttpClientProtocol

    init(httpClient: HttpClientProtocol = HttpClient()) {
        self.httpClient = httpClient

        getCoins()
        getGlobalMarketData()
    }

    private func getCoins() {
        dispatchMarketsRequest()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            })
            .store(in: &cancellables)
    }

    private func getGlobalMarketData() {
        dispatchGlobalMarketRequest()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] returnedGlobaldata in
                self?.globalMarketData = returnedGlobaldata.data
            })
            .store(in: &cancellables)
    }
}

// MARK: - HomeServices + HttpClient

extension HomeServices {

    private func dispatchMarketsRequest() -> AnyPublisher<[Coin], HttpError> {

        let queryParams: HttpParams = ["vs_currency": "usd",
                                       "order": "market_cap_desc",
                                       "per_page": 250,
                                       "page": 1,
                                       "sparkline": true,
                                       "price_change_percentage": "24h"]

        return httpClient.dispatch(request: CoinGeckoAPI.markets(queryParams: queryParams))
    }

    private func dispatchGlobalMarketRequest() -> AnyPublisher<GlobalData, HttpError> {
        return httpClient.dispatch(request: CoinGeckoAPI.global)
    }
}
