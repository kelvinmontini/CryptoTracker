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
                        40423.27175449897,
                        40588.299919297584,
                        40799.64750906399,
                        40663.72340980562,
                        40316.76188347351,
                        40413.026879882076,
                        39973.132720407004,
                        40834.46159803186,
                        41275.91165086565,
                        41065.77743058878,
                        40921.96974742411,
                        41165.63506140341,
                        40973.817295987625,
                        41062.532676072384,
                        41132.21855776482,
                        41068.38655421979,
                        41275.738744683644,
                        41091.674767873104,
                        40840.91002593043,
                        40774.90953073194,
                        40881.61609454891,
                        40837.826480753465,
                        40741.94411289332,
                        40768.230901303854,
                        41005.3113004114,
                        41071.31913134101,
                        40889.164186187474,
                        40925.6487071971,
                        40823.40714525256,
                        40840.5902231867,
                        40829.33756770281,
                        40840.78814143565,
                        40783.63682137506,
                        40962.70555541926,
                        41015.98195142964,
                        41001.70957801974,
                        40712.691098369716,
                        40590.07467511413,
                        40565.36279836173,
                        40563.712006534464,
                        40652.41274265585,
                        40799.88090728682,
                        40754.15562529224,
                        40612.63661958296,
                        40597.31477874975,
                        40555.73885712383,
                        40465.26411959411,
                        40445.755422684284,
                        40468.0007877402,
                        40590.56936572492,
                        40583.876935225344,
                        40929.97626940468,
                        41414.78786626699,
                        41656.84230583477,
                        41723.205287456854,
                        41919.13889789344,
                        41861.661476271314,
                        41799.410933178304,
                        41778.15778565683,
                        41837.41313797566,
                        41916.637402650435,
                        41781.74805111194,
                        41785.39160719793,
                        41803.64750056388,
                        41828.97174051087,
                        41760.6888335557,
                        41783.37894687464,
                        41632.696509077025,
                        41726.37197585852,
                        41693.74565541053,
                        41699.91268066034,
                        41747.247602142284,
                        41835.23488199481,
                        41766.747032085375,
                        41823.786665859385,
                        41974.049306458786,
                        42005.28015313712,
                        41905.176694056885,
                        42008.898642217304,
                        42037.48112784869,
                        42241.361850445,
                        42186.64634200785,
                        41959.42109435703,
                        42201.939920688186,
                        42039.261950265056,
                        41968.11027628634,
                        41825.679548226486,
                        41968.291621551325,
                        41876.86701485217,
                        41928.38615481458,
                        41944.607057628935,
                        41878.37349592518,
                        41892.19217190622,
                        41771.94073768242,
                        41817.751614304005,
                        41686.79716106635,
                        41687.33458316866,
                        41546.73937179682,
                        41450.35878303224,
                        41399.31392337106,
                        41335.61342782906,
                        41029.13551845392,
                        41224.47315968807,
                        41406.92400956295,
                        41314.898883813126,
                        41370.54698803537,
                        41386.078567869095,
                        41249.33316098489,
                        41387.72304546921,
                        41225.78445464155,
                        40733.51993068625,
                        40878.42415379017,
                        40913.23271383735,
                        40974.76771023744,
                        40896.31305563323,
                        41086.69151515923,
                        41239.05994723585,
                        41303.79073368092,
                        41328.36144205215,
                        41284.75253742445,
                        41220.02875546474,
                        41241.22210531826,
                        40957.00049917298,
                        41198.77468257722,
                        40842.44873156697,
                        41030.28147863076,
                        40983.024147887634,
                        41142.27614881979,
                        41214.67706050706,
                        41301.14458605765,
                        41178.32068789192,
                        41061.81589384987,
                        41089.61890343331,
                        41152.86107256775,
                        41862.727551667194,
                        42204.52011480064,
                        42994.7314717725,
                        42869.52132761208,
                        42176.70594424896,
                        42235.85272785427,
                        42536.128413685095,
                        42466.764855661975,
                        42835.55075992346,
                        42934.47003609997,
                        42927.27001787339,
                        42865.01665179204,
                        42819.447262853064,
                        42659.67890603176,
                        42552.108193483844,
                        42594.25894235249,
                        42566.80585622548,
                        42393.01082195025,
                        42572.414282050864,
                        42814.06593377567,
                        42540.24263943805
                    ]),
                    priceChangePercentage24HInCurrency: 2.5409554010577944,
                    currentHoldings: 1.5)
}
