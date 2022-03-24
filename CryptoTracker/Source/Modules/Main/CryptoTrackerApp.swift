import SwiftUI

@main
struct CryptoTrackerApp: App {
    @StateObject private var viewModel = HomeViewModel()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(viewModel)
        }
    }
}
