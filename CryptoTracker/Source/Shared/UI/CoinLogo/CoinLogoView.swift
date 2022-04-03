import SwiftUI

struct CoinLogoView: View {

    let coin: Coin

    var body: some View {
        VStack {
            CoinImageView(id: coin.id, url: coin.image)
                .frame(width: 50, height: 50)

            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.accent)
                .lineLimit(1)
                .minimumScaleFactor(0.5)

            Text(coin.name)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
    }
}

#if DEBUG
struct CoinLogoView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinLogoView(coin: dev.coin)
                .previewLayout(.sizeThatFits)
                .padding()

            CoinLogoView(coin: dev.coin)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
                .padding()
        }
    }
}
#endif
