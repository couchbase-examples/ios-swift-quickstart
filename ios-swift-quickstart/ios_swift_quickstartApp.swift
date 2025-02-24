
import SwiftUI

@main
struct ios_swift_quickstartApp: App {
    @StateObject private var errorManager = ErrorManager.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(errorManager)
        }
    }
}
