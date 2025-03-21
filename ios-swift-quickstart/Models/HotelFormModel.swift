

struct HotelFormModel {
    var title: String = ""
    var name: String = ""
    var address: String = ""
    var directions: String = ""
    var phone: String = ""
    var tollfree: String = ""
    var email: String = ""
    var fax: String = ""
    var url: String = ""
    var checkin: String = ""
    var checkout: String = ""
    var price: String = ""
    var geo: GeoFormModel = GeoFormModel(lat: 0.0, lon: 0.0, accuracy: "")
    var type: String = "hotel"
    var id: Int = Int.random(in: 1...(.max))
    var country: String = ""
    var city: String = ""
    var state: String = ""
    var reviews: [ReviewFormModel] = []
    var publicLikes: [String] = []
    var vacancy: Bool = false
    var description: String = ""
    var alias: String = ""
    var petsOk: Bool = false
    var freeBreakfast: Bool = false
    var freeInternet: Bool = false
    var freeParking: Bool = false
    
    
    
    init() {}
    
    init(from hotel: Hotel) {
        self.title = hotel.title
        self.name = hotel.name ?? ""
        self.address = hotel.address ?? ""
        self.directions = hotel.directions ?? ""
        self.phone = hotel.phone ?? ""
        self.tollfree = hotel.tollfree ?? ""
        self.email = hotel.email ?? ""
        self.fax = hotel.fax ?? ""
        self.url = hotel.url ?? ""
        self.checkin = hotel.checkin ?? ""
        self.checkout = hotel.checkout ?? ""
        self.price = hotel.price ?? ""
        self.geo = GeoFormModel(lat: hotel.geo.lat, lon: hotel.geo.lon, accuracy: hotel.geo.accuracy)
        self.type = hotel.type
        self.id = hotel.id
        self.country = hotel.country
        self.city = hotel.city ?? ""
        self.state = hotel.state ?? ""
        self.reviews = hotel.reviews.map { ReviewFormModel(from: $0) }
        self.publicLikes = hotel.publicLikes
        self.vacancy = hotel.vacancy
        self.description = hotel.description
        self.alias = hotel.alias ?? ""
        self.petsOk = hotel.petsOk
        self.freeBreakfast = hotel.freeBreakfast
        self.freeInternet = hotel.freeInternet
        self.freeParking = hotel.freeParking
    }
}

struct GeoFormModel {
    var lat: Double
    var lon: Double
    var accuracy: String
}

struct ReviewFormModel {
    var content: String
    var ratings: [String: Double]
    var author: String
    var date: String
    
    init(from review: Review) {
        self.content = review.content
        self.ratings = review.ratings
        self.author = review.author
        self.date = review.date
    }
}
