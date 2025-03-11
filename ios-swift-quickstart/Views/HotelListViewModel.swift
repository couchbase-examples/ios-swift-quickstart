

import Combine
import Foundation

class HotelListViewModel: ObservableObject {
    
    @Published var hotels: [Hotel]?
    @Published var descendingList: Bool = false
    @Published var showDeleteItemAlert: Bool = false
    @Published var searchText: String = ""
    var hotelToDelete: Hotel?
    private var cancellables = Set<AnyCancellable>()
    
    
    func onAppear() {
        bindListeners()
        queryAllHotels()
    }
    
    func onSearchTextChanged(_ text: String) {
        queryAllHotels()
    }
    
    private func bindListeners() {
        DatabaseManager.shared.queryUpdates
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] hotels in
                self?.hotels = hotels
            })
            .store(in: &cancellables)
    }
    
    private func queryAllHotels() {
        Task {
            DatabaseManager.shared.queryElements(descending: descendingList,textSearch: searchText.isEmpty ? nil : searchText)
        }
    }
    
    func onSortButtonTapped() {
        descendingList.toggle()
        queryAllHotels()
    }
    
    func deleteItemAlertAccepted() {
        guard let hotel: Hotel = hotelToDelete else { return }
        hotels?.removeAll(where: { $0.id == hotel.id })
        DatabaseManager.shared.deleteElement(hotel)
    }
    
    func deleteItemAlertDismissed() {
        hotelToDelete = nil
    }
}
