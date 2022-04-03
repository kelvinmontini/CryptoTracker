import SwiftUI

struct StatisticView: View {

    let statistic: Statistic

    var body: some View {
        VStack(alignment: .center, spacing: 4) {

            let isPositivePercentage: Bool = (statistic.percentageChange ?? 0) >= 0

            Text(statistic.title)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)

            Text(statistic.value)
                .font(.headline)
                .foregroundColor(Color.theme.accent)

            HStack(spacing: 4) {
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(
                        Angle(degrees: isPositivePercentage ? 0 : 180)
                    )

                Text(statistic.percentageChange?.asPercentString() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundColor(isPositivePercentage ? Color.theme.green : Color.theme.red)
            .opacity(statistic.percentageChange == nil ? 0.0 : 1.0)
        }
        .padding(.horizontal)
    }
}

#if DEBUG
struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StatisticView(statistic: dev.marketCapStatistic)
                .previewLayout(.sizeThatFits)

            StatisticView(statistic: dev.marketCapStatistic)
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)

            StatisticView(statistic: dev.totalVolumeStatistic)
                .previewLayout(.sizeThatFits)

            StatisticView(statistic: dev.totalVolumeStatistic)
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)

            StatisticView(statistic: dev.portfolioValueStatistic)
                .previewLayout(.sizeThatFits)

            StatisticView(statistic: dev.portfolioValueStatistic)
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
        }
    }
}
#endif
