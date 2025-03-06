import Foundation
import SwiftUI

class ViewCoordinator: ObservableObject {
    static let shared = ViewCoordinator()
    @Published var path = NavigationPath()

    func show(_ destination: Destination) {
        DispatchQueue.main.async {
            self.path.append(destination)
        }
    }

    func popToRoot() {
        DispatchQueue.main.async {
            self.path.removeLast(self.path.count)
        }
    }
}


