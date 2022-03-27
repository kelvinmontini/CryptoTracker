import SwiftUI

struct CoinImageView: View {

    @StateObject var viewModel: CoinImageViewModel

    init(id: String, url: String) {
        let services: CoinImageServicesProtocol = CoinImageServices(id: id, url: url)
        _viewModel = StateObject(wrappedValue: CoinImageViewModel(services: services))
    }

    var body: some View {
        ZStack {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else if viewModel.isLoading {
                ProgressView()
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(Color.theme.secondaryText)
            }
        }
    }
}

#if DEBUG
struct CoinImageView_Previews: PreviewProvider {
    static var previews: some View {

        Group {
            CoinImageView(id: dev.coin.id, url: dev.coin.image)
                .previewLayout(.sizeThatFits)
                .padding()

            CoinImageView(id: dev.coin.id, url: dev.coin.image)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
                .padding()
        }
    }
}
#endif
