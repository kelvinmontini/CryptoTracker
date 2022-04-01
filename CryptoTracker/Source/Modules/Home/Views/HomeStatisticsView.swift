import SwiftUI

struct HomeStatisticsView: View {

    @EnvironmentObject private var viewModel: HomeViewModel
    @Binding var showPortfolio: Bool

    private let screenWidth = UIScreen.main.bounds.width

    var body: some View {
        HStack {
            ForEach(viewModel.statistics) { statistic in
                StatisticView(statistic: statistic)
                    .frame(width: screenWidth / 3)
            }
        }
        .frame(width: screenWidth, alignment: showPortfolio ? .trailing : .leading)
    }
}

#if DEBUG
struct HomeStatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatisticsView(showPortfolio: .constant(false))
            .environmentObject(dev.homeViewModel)
            .previewLayout(.sizeThatFits)
    }
}
#endif
