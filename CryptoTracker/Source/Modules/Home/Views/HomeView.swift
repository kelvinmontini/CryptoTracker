import SwiftUI

struct HomeView: View {

    @EnvironmentObject private var viewModel: HomeViewModel
    @State private var showPortfolio: Bool = false

    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()

            VStack {
                HomeHeaderView(showPortfolio: $showPortfolio)

                SearchBarView(searchText: $viewModel.searchText)

                if !showPortfolio {
                    CoinListView(coins: viewModel.allCoins,
                                 showPortfolio: showPortfolio,
                                 showHoldingsColumn: false)
                    .transition(.move(edge: .leading))
                }

                if showPortfolio {
                    CoinListView(coins: viewModel.portfolioCoins,
                                 showPortfolio: showPortfolio,
                                 showHoldingsColumn: false)
                    .transition(.move(edge: .trailing))
                }

                Spacer(minLength: 0)
            }
        }
    }
}

#if DEBUG
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .navigationBarHidden(true)
        }
        .environmentObject(dev.homeViewModel)
    }
}
#endif
