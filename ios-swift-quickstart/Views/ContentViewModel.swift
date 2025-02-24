
import Combine

class ContentViewModel: ObservableObject {
    
    @Published var hotels: [Hotel]?
    
    func onAppear() {
        hotels = DatabaseManager.shared.queryAllElements()
    }
}
