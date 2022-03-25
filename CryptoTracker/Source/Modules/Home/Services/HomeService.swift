import Foundation
import Combine

final class HomeService {

    @Published var allCoins: [Coin] = []

    var coinSubscription: AnyCancellable?

    init() {
        getCoins()
    }

    private func getCoins() {

        let baseURL = "https://api.coingecko.com"
        let path = "/api/v3/coins/markets"
        let query = "?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"

        guard let url = URL(string: baseURL + path + query) else { return }

        coinSubscription = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { output -> Data in

                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }

                return output.data
            }
            .receive(on: DispatchQueue.main)
            .decode(type: [Coin].self, decoder: JSONDecoder())
            .sink { completion in

                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            }
    }
}
