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
        .onChange(of: viewModel.searchText, perform: checkEmptySearchText)
        .onReceive(viewModel.$allCoins, perform: checkEmptyCoins)
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}

private extension PortfolioView {

    private func cleanSelectedCoin() {
        selectedCoin = nil
        quantityText = ""
    }

    private func cleanPortfolioInputState() {
        cleanSelectedCoin()
        viewModel.searchText = ""
    }

    private func checkEmptySearchText(searchText: String) {
        if searchText.isEmpty {
            cleanPortfolioInputState()
        }
    }

    private func checkEmptyCoins(coins: [Coin]) {
        if coins.count == 0 {
            cleanSelectedCoin()
        }
    }

    private func didTappedSave() {

        withAnimation(.easeIn) {
            showCheckmark = true
            cleanPortfolioInputState()
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
