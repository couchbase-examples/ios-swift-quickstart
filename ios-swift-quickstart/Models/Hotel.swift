
import Foundation

struct hotelDocumentModel: Codable {
    let hotel: Hotel
}

struct Hotel: Identifiable,Hashable, Codable {
    let title: String
    let name: String?
    let address: String?
    let directions: String?
    let phone: String?
    let tollfree: String?
    let email: String?
    let fax: String?
    let url: String?
    let checkin: String?
    let checkout: String?
    let price: String?
    let geo: Geo
    let type: String
    let id: Int
    let country: String
    let city: String?
    let state: String?
    let reviews: [Review]
    let publicLikes: [String]
    let vacancy: Bool
    let description: String
    let alias: String?
    let petsOk: Bool
    let freeBreakfast: Bool
    let freeInternet: Bool
    let freeParking: Bool
    
    enum CodingKeys: String, CodingKey {
        case title, name, address, directions, phone, tollfree, email, fax, url
        case checkin, checkout, price, geo, type, id, country, city, state, reviews
        case publicLikes = "public_likes"
        case vacancy, description, alias
        case petsOk = "pets_ok"
        case freeBreakfast = "free_breakfast"
        case freeInternet = "free_internet"
        case freeParking = "free_parking"
    }
    
    init(from form: HotelFormModel) {
        self.title = form.title
        self.name = form.name
        self.address = form.address
        self.directions = form.directions
        self.phone = form.phone
        self.tollfree = form.tollfree
        self.email = form.email
        self.fax = form.fax
        self.url = form.url
        self.checkin = form.checkin
        self.checkout = form.checkout
        self.price = form.price
        self.geo = Geo(lat: form.geo.lat, lon: form.geo.lon, accuracy: form.geo.accuracy)
        self.type = form.type
        self.id = form.id
        self.country = form.country
        self.city = form.city
        self.state = form.state
        self.reviews = form.reviews.map { Review(from: $0) }
        self.publicLikes = form.publicLikes
        self.vacancy = form.vacancy
        self.description = form.description
        self.alias = form.alias
        self.petsOk = form.petsOk
        self.freeBreakfast = form.freeBreakfast
        self.freeInternet = form.freeInternet
        self.freeParking = form.freeParking
    }
}

struct Geo: Hashable, Codable {
    let lat: Double
    let lon: Double
    let accuracy: String
}

struct Review:Hashable, Codable {
    let content: String
    let ratings: [String: Double]
    let author: String
    let date: String
    
    init(from review: ReviewFormModel) {
        self.content = review.content
        self.ratings = review.ratings
        self.author = review.author
        self.date = review.date
    }
}
