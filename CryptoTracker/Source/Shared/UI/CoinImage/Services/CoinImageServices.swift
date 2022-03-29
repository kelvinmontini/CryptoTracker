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

    private let id: String
    private let url: String
    private let httpClient: HttpClientProtocol
    private let localFileManager: LocalFileManagerProtocol
    private let folderName = "coin_images"
    private var imageSubscription: AnyCancellable?

    init(id: String,
         url: String,
         httpClient: HttpClientProtocol = HttpClient(),
         localFileManager: LocalFileManagerProtocol = LocalFileManager()) {

        self.id = id
        self.url = url
        self.httpClient = httpClient
        self.localFileManager = localFileManager

        getCoinImage()
    }

    private func getCoinImage() {

        if let savedImage = localFileManager.loadImage(imageName: id, folderName: folderName) {
            image = savedImage
        } else {
            getRemoteCoinImage(url: url)
        }
    }

    private func getRemoteCoinImage(url: String) {

        imageSubscription = dispatchImageRequest(url: url)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] returnedImage in
                guard let self = self,
                      let downloadedImage = returnedImage  else { return }

                self.image = downloadedImage
                self.imageSubscription?.cancel()
                self.localFileManager.saveImage(image: downloadedImage,
                                                imageName: self.id,
                                                folderName: self.folderName)
            })
    }
}

// MARK: - CoinImageServices + HttpClient

extension CoinImageServices {

    private func dispatchImageRequest(url: String) -> AnyPublisher<UIImage?, HttpError> {
        return httpClient.dispatch(request: CoinGeckoAPI.image(url: url))
    }
}
