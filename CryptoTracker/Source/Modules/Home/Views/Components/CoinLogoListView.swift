import SwiftUI

struct CoinLogoListView: View {

    private let coins: [Coin]
    private let updateSelectedCoin: (_ coin: Coin) -> Void
    @Binding private var selectedCoin: Coin?

    init(coins: [Coin],
         selectedCoin: Binding<Coin?>,
         updateSelectedCoin: @escaping (_ coin: Coin) -> Void) {

        self.coins = coins
        self._selectedCoin = selectedCoin
        self.updateSelectedCoin = updateSelectedCoin
    }

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
                                updateSelectedCoin(coin)
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
            CoinLogoListView(coins: [dev.coin], selectedCoin: .constant(nil)) { _ in }
                .previewLayout(.sizeThatFits)

            CoinLogoListView(coins: [dev.coin], selectedCoin: .constant(nil)) { _ in }
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
#endif
