import Foundation
import SwiftUI

protocol LocalFileManagerProtocol {
    func saveImage(image: UIImage, imageName: String, folderName: String)
    func loadImage(imageName: String, folderName: String) -> UIImage?
}

final class LocalFileManager: LocalFileManagerProtocol {

    /// Save an image to FileManager caches directory
    /// - Parameter image: Image
    /// - Parameter imageName: Image name
    /// - Parameter folderName: Folder name
    func saveImage(image: UIImage, imageName: String, folderName: String) {

        createFolderIfNeeded(folderName: folderName)

        guard let data = image.pngData(),
              let url = getURLForImage(imageName: imageName,
                                       folderName: folderName) else { return }

        DispatchQueue.global().async {
            do {
                try data.write(to: url)
            } catch let error {
                debugPrint("[DEBUG]: Error while try save image \(imageName). \(error)")
            }
        }
    }

    /// Load an image to FileManager caches directory
    /// - Parameter imageName: Image name
    /// - Parameter folderName: Folder name
    func loadImage(imageName: String, folderName: String) -> UIImage? {

        guard let url = getURLForImage(imageName: imageName, folderName: folderName),
              FileManager.default.fileExists(atPath: url.path) else { return nil }

        return UIImage(contentsOfFile: url.path)
    }

}

extension LocalFileManager {

    /// Create a FileManager caches directory if it doesn't already exist
    /// - Parameter folderName: Folder name
    private func createFolderIfNeeded(folderName: String) {

        guard let url = getURLForFolder(folderName: folderName) else { return }

        if !FileManager.default.fileExists(atPath: url.path) {

            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
            } catch let error {
                debugPrint("[DEBUG]: Error while try create folder \(folderName). \(error)")
            }
        }
    }

    /// Load the URL to the FileManager caches directory
    /// - Parameter folderName: Folder name
    /// - Returns: An optional FileManager directory URL
    private func getURLForFolder(folderName: String) -> URL? {

        guard let url = FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first else { return nil }

        return url.appendingPathComponent(folderName)
    }

    /// Load the URL to the image saved in FileManager caches directory
    /// - Parameter folderName: Folder name
    /// - Returns: An optional FileManager directory URL
    private func getURLForImage(imageName: String, folderName: String) -> URL? {

        guard let folderURL = getURLForFolder(folderName: folderName) else { return nil }
        return folderURL.appendingPathComponent(imageName + ".png")
    }

}
