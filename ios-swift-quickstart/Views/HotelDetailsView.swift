import SwiftUI

struct HotelDetailsView: View {
    let hotel: Hotel
    @StateObject private var viewCoordinator = ViewCoordinator.shared
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(hotel.name ?? "")
                    .font(.largeTitle)
                    .bold()
                    .accessibilityIdentifier("HotelNameLabel")
                Text(hotel.title)
                    .font(.body)
                Text(hotel.description)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth:.infinity, alignment: .leading)
                
                GroupBox {
                    VStack(alignment: .leading) {
                        Text("Address: \(hotel.address ?? "N/A")")
                        Text("City: \(hotel.city ?? "N/A")")
                        Text("State: \(hotel.state ?? "N/A")")
                        Text("Country: \(hotel.country)")
                        
                        Text("Coordinates: \(hotel.geo.lat), \(hotel.geo.lon)")
                        Text("Accuracy: \(hotel.geo.accuracy)")
                        
                        Text("Phone: \(hotel.phone ?? "N/A")")
                        Text("Toll-Free: \(hotel.tollfree ?? "N/A")")
                        Text("Email: \(hotel.email ?? "N/A")")
                        Text("Fax: \(hotel.fax ?? "N/A")")
                        Text("Website: \(hotel.url ?? "N/A")")
                        
                        Text("Check-in Time: \(hotel.checkin ?? "N/A")")
                        Text("Check-out Time: \(hotel.checkout ?? "N/A")")
                        Text("Price: \(hotel.price ?? "N/A")")
                        
                        Text(hotel.vacancy ? "Vacancy: Available" : "Vacancy: Full")
                        Text(hotel.petsOk ? "Pets Allowed" : "No Pets")
                        Text(hotel.freeBreakfast ? "Free Breakfast Available" : "No Free Breakfast")
                        Text(hotel.freeInternet ? "Free Internet Available" : "No Free Internet")
                        Text(hotel.freeParking ? "Free Parking Available" : "No Free Parking")
                    }
                    .frame(maxWidth:.infinity, alignment: .leading)
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
                    Text("Edit")
                }
                .accessibilityIdentifier("EditHotelButton")
            }
        }
    }
}
