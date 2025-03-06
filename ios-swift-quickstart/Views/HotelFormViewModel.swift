
import Combine

class HotelFormViewModel: ObservableObject {

    @Published var hotel: HotelFormModel = HotelFormModel()
    @Published private var viewCoordinator = ViewCoordinator.shared
    
    enum ViewMode: Hashable {
        case add
        case edit(hotel: Hotel)
    }
    
    private let viewMode: ViewMode
    
    init (viewMode: ViewMode) {
        self.viewMode = viewMode
        if case .edit(let hotel) = viewMode {
            self.hotel = HotelFormModel(from: hotel)
        }
    }
    
    func getTitle() -> String {
        switch viewMode {
        case .add:
            return "New Hotel"
        case .edit:
            return "Edit Hotel"
        }
    }
    
    func onAcceptButton() {
        switch viewMode {
        case .add:
            DatabaseManager.shared.addNewElement(Hotel(from: hotel))
        case .edit:
            DatabaseManager.shared.updateExistingElement(Hotel(from: hotel))
        }
        viewCoordinator.popToRoot()
    }
}
