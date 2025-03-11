import SwiftUI
import Combine


class ErrorManager: ObservableObject {
    static let shared = ErrorManager()
    
    @Published var errors: [ErrorModel] = []

    func showError(error: ErrorModel) {
        DispatchQueue.main.async {
            self.errors.append(ErrorModel(title: error.title, message: error.message))
        }
    }

    func dismissAndShowNext() {
        DispatchQueue.main.async {
            self.errors.removeFirst()
        }
    }
}
