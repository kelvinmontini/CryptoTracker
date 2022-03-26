import Foundation
import Combine

final class HomeServices {

    @Published var allCoins: [Coin] = []

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

        let requestModel = GetCoins(queryParams: queryParams)

        coinSubscription = networkClient.dispatch(request: requestModel)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            })
    }
}
