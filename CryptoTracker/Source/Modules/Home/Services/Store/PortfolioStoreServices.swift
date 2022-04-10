import Foundation
import CoreData

final class PortfolioStoreServices {

    @Published var savedEntities: [Portfolio] = []

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PortfolioContainer")
        container.loadPersistentStores { _, error in
            if let error = error {
                print("[debug]: Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()

    init() {
        getPortfolio()
    }

    func updatePortfolio(coin: Coin, amount: Double) {

        if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                remove(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }
}

private extension PortfolioStoreServices {

    private func getPortfolio() {
        let entityName = "Portfolio"
        let request = NSFetchRequest<Portfolio>(entityName: entityName)

        do {
            savedEntities = try persistentContainer.viewContext.fetch(request)
        } catch let error {
            print("[debug]: Unable to fetch entities: \(error)")
        }
    }

    private func add(coin: Coin, amount: Double) {
        let entity = Portfolio(context: persistentContainer.viewContext)
        entity.coinID = coin.id
        entity.amount = amount

        applyChances()
    }

    private func update(entity: Portfolio, amount: Double) {
        entity.amount = amount
        applyChances()
    }

    private func remove(entity: Portfolio) {
        persistentContainer.viewContext.delete(entity)
        applyChances()
    }

    private func save() {
        do {
            try persistentContainer.viewContext.save()
        } catch let error {
            print("[debug]: Unable to save data: \(error)")
        }
    }

    private func applyChances() {
        save()
        getPortfolio()
    }
}
