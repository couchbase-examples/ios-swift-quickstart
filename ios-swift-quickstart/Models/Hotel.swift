
import Foundation

struct hotelDocumentModel: Codable {
    let hotel: Hotel
}

struct Hotel: Identifiable, Codable {
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
}

struct Geo: Codable {
    let lat: Double
    let lon: Double
    let accuracy: String
}

struct Review: Codable {
    let content: String
    let ratings: [String: Double]
    let author: String
    let date: String
}
