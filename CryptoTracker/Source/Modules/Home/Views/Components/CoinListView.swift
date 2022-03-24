import SwiftUI

struct CoinListView: View {

    var coins: [Coin]
    var showPortfolio: Bool
    var showHoldingsColumn: Bool

    private let screenWidth = UIScreen.main.bounds.width
    private let rowInsets = EdgeInsets.init(top: 10, leading: 0,
                                            bottom: 10, trailing: 10)

    var body: some View {
        VStack {
            HStack {
                Text("Coin")
                Spacer()

                if showPortfolio {
                    Text("Holdings")
                }

                Text("Price")
                    .frame(width: screenWidth / 3.5, alignment: .trailing)
            }
            .font(.caption)
            .foregroundColor(Color.theme.secondaryText)
            .padding(.horizontal)

            List {
                ForEach(coins) { coin in
                    CoinRowView(coin: coin, showHoldingsColumn: showHoldingsColumn)
                        .listRowInsets(rowInsets)
                }
            }
            .listStyle(.plain)
        }
    }
}

#if DEBUG
struct CoinListView_Previews: PreviewProvider {

    private static let coins: [Coin] = [dev.coin, dev.coin, dev.coin]

    static var previews: some View {
        Group {
            CoinListView(coins: coins,
                         showPortfolio: false,
                         showHoldingsColumn: false)
            .previewLayout(.sizeThatFits)

            CoinListView(coins: coins,
                         showPortfolio: false,
                         showHoldingsColumn: false)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)

            CoinListView(coins: coins,
                         showPortfolio: true,
                         showHoldingsColumn: true)
            .previewLayout(.sizeThatFits)

            CoinListView(coins: coins,
                         showPortfolio: true,
                         showHoldingsColumn: true)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
        }
    }
}
#endif
