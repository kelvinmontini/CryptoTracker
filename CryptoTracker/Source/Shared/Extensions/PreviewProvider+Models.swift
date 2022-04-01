import Foundation
import SwiftUI

extension PreviewProvider {

    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}

final class DeveloperPreview {

    static let instance = DeveloperPreview()

    private init() {}

    let homeViewModel = HomeViewModel()
    let marketCapStatistic = Statistic(title: "Market Cap", value: "$12.5Bn", percentageChange: 25.34)
    let totalVolumeStatistic = Statistic(title: "Total Volume", value: "$1.23Tr")
    let portfolioValueStatistic = Statistic(title: "Portfolio Value", value: "$50.4k", percentageChange: -12.34)

    let coin = Coin(id: "bitcoin",
                    symbol: "btc",
                    name: "Bitcoin",
                    image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
                    currentPrice: 42156,
                    marketCap: 800_828_208_519,
                    marketCapRank: 1,
                    fullyDilutedValuation: 885_536_663_870,
                    totalVolume: 28_884_750_400,
                    high24H: 43080,
                    low24H: 41111,
                    priceChange24H: 1044.61,
                    priceChangePercentage24H: 2.54096,
                    marketCapChange24H: 20_216_166_780,
                    marketCapChangePercentage24H: 2.58978,
                    circulatingSupply: 18_991_187,
                    totalSupply: 21_000_000,
                    maxSupply: 21_000_000,
                    ath: 69045,
                    athChangePercentage: -38.92599,
                    athDate: "2021-11-10T14:24:11.849Z",
                    atl: 67.81,
                    atlChangePercentage: 62087.04385,
                    atlDate: "2013-07-06T00:00:00.000Z",
                    lastUpdated: "2022-03-23T01:43:48.780Z",
                    sparklineIn7D: SparklineIn7D(price: [
                        39331.84654059453,
                        39156.503559580015,
                        39431.272080337985,
                        40795.11588258226,
                        39088.40018399517,
                        39150.78116393391,
                        39279.1770750957,
                        39554.6825820659,
                        39569.37424760386,
                        40346.52773175056,
                        40533.32824193257,
                        40355.85218270206,
                        40600.39368414035,
                        41065.77743058878,
                        40921.96974742411,
                        40973.817295987625,
                        41760.6888335557,
                        41783.37894687464,
                        41632.696509077025,
                        39279.1770750957,
                        39554.6825820659,
                        39569.37424760386,
                        41152.86107256775,
                        42540.24263943805
                    ]),
                    priceChangePercentage24HInCurrency: 2.5409554010577944,
                    currentHoldings: 1.5)
}
