import Foundation
import Combine
import SwiftUI

final class CoinImageViewModel: ObservableObject {

    @Published var image: UIImage?
    @Published var isLoading: Bool = true

    private let services: CoinImageServicesProtocol
    private var cancellables = Set<AnyCancellable>()

    init(services: CoinImageServicesProtocol) {
        self.services = services

        addSubscribers()
        isLoading = true
    }

    func addSubscribers() {
        services.imagePublisher
            .sink(receiveCompletion: { [weak self] _ in
                self?.isLoading = false
            }, receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
            })
            .store(in: &cancellables)
    }
}
