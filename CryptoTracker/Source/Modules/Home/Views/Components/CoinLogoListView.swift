import SwiftUI

struct CoinLogoListView: View {

    let coins: [Coin]
    @Binding var selectedCoin: Coin?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(coins) { coin in

                    let selectedStrokeColor = selectedCoin?.id == coin.id ? Color.theme.green : Color.clear

                    CoinLogoView(coin: coin)
                        .frame(minWidth: 75, maxWidth: 75, minHeight: 100, maxHeight: 100)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                selectedCoin = coin
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedStrokeColor, lineWidth: 1)
                        )
                }
            }
            .frame(height: 120)
            .padding(.leading)
        }
    }
}

#if DEBUG
struct CoinLogoListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinLogoListView(coins: [dev.coin], selectedCoin: .constant(nil))
                .previewLayout(.sizeThatFits)

            CoinLogoListView(coins: [dev.coin], selectedCoin: .constant(nil))
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
#endif
