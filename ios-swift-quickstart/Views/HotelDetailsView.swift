import SwiftUI

struct HotelDetailsView: View {
    let hotel: Hotel
    @StateObject private var viewCoordinator = ViewCoordinator.shared
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(hotel.title).font(.largeTitle).bold()
                Text(hotel.description).font(.body)
                
                GroupBox(label: Text("Location")) {
                    Text("Address: \(hotel.address ?? "N/A")")
                    Text("City: \(hotel.city ?? "N/A"), State: \(hotel.state ?? "N/A"), Country: \(hotel.country)")
                    Text("Coordinates: \(hotel.geo.lat), \(hotel.geo.lon) - Accuracy: \(hotel.geo.accuracy)")
                }
                
                GroupBox(label: Text("Contact Information")) {
                    Text("Phone: \(hotel.phone ?? "N/A")")
                    Text("Email: \(hotel.email ?? "N/A")")
                    Text("Website: \(hotel.url ?? "N/A")")
                }
                
                GroupBox(label: Text("Amenities")) {
                    Text(hotel.vacancy ? "Vacancy: Available" : "Vacancy: Full")
                    Text(hotel.petsOk ? "Pets Allowed" : "No Pets")
                    Text(hotel.freeBreakfast ? "Free Breakfast Available" : "No Free Breakfast")
                    Text(hotel.freeInternet ? "Free Internet Available" : "No Free Internet")
                    Text(hotel.freeParking ? "Free Parking Available" : "No Free Parking")
                }
                
                GroupBox(label: Text("Reviews")) {
                    ForEach(hotel.reviews, id: \..content) { review in
                        VStack(alignment: .leading) {
                            Text("By: \(review.author)").bold()
                            Text(review.content)
                            Text("Date: \(review.date)").font(.caption).foregroundColor(.gray)
                        }
                        .padding(.vertical, 5)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Hotel Details")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewCoordinator.show(.hotelForm(viewMode: .edit(hotel: hotel)))
                } label: {
                    Image(systemName: "pencil")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 20)
                }
            }
        }
    }
}
