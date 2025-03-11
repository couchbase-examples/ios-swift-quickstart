
import SwiftUI

@main
struct ios_swift_quickstartApp: App {
    @StateObject private var errorManager = ErrorManager.shared
    @StateObject private var networkMonitor = NetworkMonitor.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(errorManager)
        }
    }
}
