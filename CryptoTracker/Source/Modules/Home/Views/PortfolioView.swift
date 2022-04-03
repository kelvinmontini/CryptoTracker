import SwiftUI

struct PortfolioView: View {

    @EnvironmentObject private var viewModel: HomeViewModel
    @Environment(\.presentationMode) var presentationMode

    @State private var selectedCoin: Coin?
    @State private var quantityText: String = ""
    @State private var showCheckmark: Bool = false

    var body: some View {

        let showSaveButton = (selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText))

        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $viewModel.searchText)

                    CoinLogoListView(coins: viewModel.allCoins, selectedCoin: $selectedCoin)

                    if selectedCoin != nil {
                        PortfolioInputSectionView(selectedCoin: selectedCoin,
                                                  quantityText: $quantityText)
                    }
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton {
                        presentationMode.wrappedValue.dismiss()
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    SaveButton(showCheckmark: showCheckmark,
                               showButton: showSaveButton,
                               didTappedSave: didTappedSave)
                }
            }
        }
    }
}

private extension PortfolioView {

    private func didTappedSave() {

        withAnimation(.easeIn) {
            showCheckmark = true
            selectedCoin = nil
            quantityText = ""
            viewModel.searchText = ""
        }

        UIApplication.shared.endEditing()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.20) {
            withAnimation(.easeOut) {
                self.showCheckmark = false
            }
        }
    }
}

#if DEBUG
struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.homeViewModel)
    }
}
#endif
