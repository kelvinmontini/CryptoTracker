import Foundation
import Combine

protocol HomeServicesProtocol {
    var allCoins: [Coin] { get }
    var allCoinsPublished: Published<[Coin]> { get }
    var allCoinsPublisher: Published<[Coin]>.Publisher { get }
}

final class HomeServices: HomeServicesProtocol {

    @Published private(set) var allCoins: [Coin] = []
    var allCoinsPublished: Published<[Coin]> { _allCoins }
    var allCoinsPublisher: Published<[Coin]>.Publisher { $allCoins }

    private var coinSubscription: AnyCancellable?
    private let networkClient: NetworkClientProtocol

    init(networkClient: NetworkClientProtocol = NetworkClient()) {
        self.networkClient = networkClient

        getCoins()
    }

    private func getCoins() {

        let queryParams = ["vs_currency": "usd",
                           "order": "market_cap_desc",
                           "per_page": "250",
                           "page": "1",
                           "sparkline": "true",
                           "price_change_percentage": "24h"]

        let marketsRequest = MarketsRequest(queryParams: queryParams)

        coinSubscription = networkClient.dispatch(request: marketsRequest)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            })
    }
}
