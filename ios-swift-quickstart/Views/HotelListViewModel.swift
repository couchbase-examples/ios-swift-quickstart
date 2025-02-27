

import Combine

class HotelListViewModel: ObservableObject {
    
    @Published var hotels: [Hotel]?
    
    func onAppear() {
        hotels = DatabaseManager.shared.queryAllElements()
//        DatabaseManager.shared.deleteElement(Hotel(title: "updated added Hotel", name: "updated2 Dominik's Hotel", address: "Gdynia", directions: "Go left then right", phone: "123 321 123", tollfree: "idk", email: "email@email.com", fax: nil, url: nil, checkin: nil, checkout: nil, price: nil, geo: Geo(lat: 0.0, lon: 0.1, accuracy: "40 km"), type: "hotel", id: 123321, country: "Poland", city: nil, state: nil, reviews: [], publicLikes: [], vacancy: true, description: "it's cool i guess", alias: nil, petsOk: true, freeBreakfast: true, freeInternet: true, freeParking: true))
    }
}
