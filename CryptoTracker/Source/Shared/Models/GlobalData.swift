import Foundation

struct GlobalData: Codable {
    let data: GlobalMarketData?
}

struct GlobalMarketData: Codable {
    let totalMarketCap: [String: Double]
    let totalVolume: [String: Double]
    let marketCapPercentage: [String: Double]
    let marketCapChangePercentage24hUSD: Double

    var marketCap: String {
        guard let item = totalMarketCap.first(where: { $0.key == "usd" }) else { return "" }
        return "$" + item.value.formattedWithAbbreviations()
    }

    var volume: String {
        guard let item = totalVolume.first(where: { $0.key == "usd" }) else { return "" }
        return "$" + item.value.formattedWithAbbreviations()
    }

    var btcDominance: String {
        guard let item = marketCapPercentage.first(where: { $0.key == "btc" }) else { return "" }
        return item.value.asPercentString()
    }
}

private extension GlobalMarketData {

    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24hUSD = "market_cap_change_percentage_24h_usd"
    }
}
