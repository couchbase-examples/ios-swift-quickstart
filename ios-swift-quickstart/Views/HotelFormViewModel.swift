
import Combine

class HotelFormViewModel: ObservableObject {

    @Published var hotel: HotelFormModel
    private let originalModel: HotelFormModel
    @Published private var viewCoordinator = ViewCoordinator.shared
    var modelDidChange: Bool {
        hotel != originalModel
    }
    
    enum ViewMode: Hashable {
        case add
        case edit(hotel: Hotel)
    }
    
    private let viewMode: ViewMode
    
    init(viewMode: ViewMode) {
        self.viewMode = viewMode
        var hotelFormModel = HotelFormModel()
        if case .edit(let hotel) = viewMode {
            hotelFormModel = HotelFormModel(from: hotel)
        }
        self.hotel = hotelFormModel
        self.originalModel = hotelFormModel
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
