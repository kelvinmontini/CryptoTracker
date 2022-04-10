import Foundation
import Combine

final class HomeViewModel: ObservableObject {

    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    @Published var statistics: [Statistic] = []
    @Published var searchText: String = ""

    private let services = HomeServices()
    private let storeServices = PortfolioStoreServices()
    private var cancellables = Set<AnyCancellable>()

    init() {
        addSubscribers()
    }
}

extension HomeViewModel {

    private func addSubscribers() {

        $searchText
            .combineLatest(services.$allCoins)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)

        services.$globalMarketData
            .map(mapGlobalMarketData)
            .sink { [weak self] returnedStatistics in
                self?.statistics = returnedStatistics
            }
            .store(in: &cancellables)

        $allCoins
            .combineLatest(storeServices.$savedEntities)
            .map { (coins, entities) -> [Coin] in
                coins
                    .compactMap { coin in
                        guard let entity = entities.first(where: { $0.coinID == coin.id }) else {
                            return nil
                        }
                        return coin.updateHoldings(amount: entity.amount)
                    }
            }
            .sink { [weak self] coins in
                self?.portfolioCoins = coins
            }
            .store(in: &cancellables)
    }

    func updatePortfolio(coin: Coin, amount: Double) {
        storeServices.updatePortfolio(coin: coin, amount: amount)
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

    private func mapGlobalMarketData(data: GlobalMarketData?) -> [Statistic] {

        var statistics: [Statistic] = []
        guard let data = data else { return statistics }

        let marketCap = Statistic(title: "Market Cap",
                                  value: data.marketCap,
                                  percentageChange: data.marketCapChangePercentage24hUSD)
        let volume = Statistic(title: "24h Volume", value: data.volume)
        let btcDominance = Statistic(title: "BTC Dominance", value: data.btcDominance)
        let porfolio = Statistic(title: "Portfolio Value", value: "$0.00", percentageChange: 0)

        statistics.append(contentsOf: [marketCap, volume, btcDominance, porfolio])
        return statistics
    }
}
