import Foundation
import Combine

final class HomeViewModel: ObservableObject {

    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []

    private let services: HomeServicesProtocol
    private var cancellables = Set<AnyCancellable>()

    init(services: HomeServicesProtocol = HomeServices()) {
        self.services = services

        addSubscribers()
    }

    func addSubscribers() {

        services.allCoinsPublisher
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
}
