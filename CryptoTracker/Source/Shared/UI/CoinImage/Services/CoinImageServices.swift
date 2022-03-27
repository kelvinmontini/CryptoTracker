import Foundation
import Combine
import SwiftUI

protocol CoinImageServicesProtocol {
    var image: UIImage? { get }
    var imagePublished: Published<UIImage?> { get }
    var imagePublisher: Published<UIImage?>.Publisher { get }
}

final class CoinImageServices: CoinImageServicesProtocol {

    @Published private(set) var image: UIImage?
    var imagePublished: Published<UIImage?> { _image }
    var imagePublisher: Published<UIImage?>.Publisher { $image }

    private var imageSubscription: AnyCancellable?
    private let networkClient: NetworkClientProtocol

    init(url: String, networkClient: NetworkClientProtocol = NetworkClient()) {
        self.networkClient = networkClient

        getImage(url: url)
    }

    private func getImage(url: String) {
        imageSubscription = dispatchImageRequest(url: url)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
                self?.imageSubscription?.cancel()
            })
    }
}

// MARK: - CoinImageServices + NetworkClient

extension CoinImageServices {

    private func dispatchImageRequest(url: String) -> AnyPublisher<UIImage?, NetworkError> {
        return networkClient.dispatch(request: CoinGeckoAPI.image(url: url))
    }
}
