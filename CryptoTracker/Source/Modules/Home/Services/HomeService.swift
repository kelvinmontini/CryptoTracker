import Foundation
import Combine

final class HomeService {

    @Published var allCoins: [Coin] = []

    var coinSubscription: AnyCancellable?

    private var networkingManager: NetworkingManagerProtocol

    init(networkingManager: NetworkingManagerProtocol = NetworkingManager()) {
        self.networkingManager = networkingManager

        getCoins()
    }

    private func getCoins() {

        let baseURL = "https://api.coingecko.com"
        let path = "/api/v3/coins/markets"
        let query = "?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"

        guard let url = URL(string: baseURL + path + query) else { return }

        coinSubscription = networkingManager.request(url: url)
            .decode(type: [Coin].self, decoder: JSONDecoder())
            .sink(receiveCompletion: networkingManager.handleCompletion,
                  receiveValue: { [weak self] returnedCoins in

                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            })
    }
}
