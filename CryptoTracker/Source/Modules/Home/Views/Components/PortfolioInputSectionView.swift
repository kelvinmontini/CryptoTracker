import SwiftUI

struct PortfolioInputSectionView: View {

    let selectedCoin: Coin?
    @Binding var quantityText: String

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
            }

            Divider()

            HStack {
                Text("Amount holding:")
                Spacer()
                TextField("Ex: 1.4", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }

            Divider()

            HStack {
                Text("Current value:")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
        }
        .animation(.none)
        .padding()
        .font(.headline)
    }

    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }

        return 0
    }
}

#if DEBUG
struct PortfolioInputSectionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {

            PortfolioInputSectionView(selectedCoin: dev.coin, quantityText: .constant(""))
                .previewLayout(.sizeThatFits)

            PortfolioInputSectionView(selectedCoin: dev.coin, quantityText: .constant(""))
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
    }
}
#endif
