import Foundation
import Combine

final class HomeViewModel: ObservableObject {

    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    @Published var searchText: String = ""

    @Published var statistics: [Statistic] = [
        Statistic(title: "Title", value: "Value", percentageChange: 1),
        Statistic(title: "Title", value: "Value"),
        Statistic(title: "Title", value: "Value"),
        Statistic(title: "Title", value: "Value", percentageChange: -7)
    ]

    private let services: HomeServicesProtocol
    private var cancellables = Set<AnyCancellable>()

    init(services: HomeServicesProtocol = HomeServices()) {
        self.services = services

        addSubscribers()
    }

    private func addSubscribers() {

        $searchText
            .combineLatest(services.allCoinsPublisher)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }

    private func filterCoins(text: String, coins: [Coin]) -> [Coin] {

        guard !text.isEmpty else { return coins }

        let lowercasedText = text.lowercased()

        return coins.filter { coin in
            coin.name.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
    }
}
