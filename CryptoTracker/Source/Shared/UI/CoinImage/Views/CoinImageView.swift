import SwiftUI

struct CoinImageView: View {

    @StateObject var viewModel: CoinImageViewModel

    init(url: String) {
        let services: CoinImageServicesProtocol = CoinImageServices(url: url)
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
            CoinImageView(url: dev.coin.image)
                .previewLayout(.sizeThatFits)
                .padding()

            CoinImageView(url: dev.coin.image)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
                .padding()
        }
    }
}
#endif
