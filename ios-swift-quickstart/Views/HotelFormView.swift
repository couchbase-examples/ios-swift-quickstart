import SwiftUI

struct HotelFormView: View {
    @ObservedObject private var viewModel: HotelFormViewModel

    
    init(viewModel: HotelFormViewModel) {
        self._viewModel = ObservedObject(initialValue: viewModel)
    }
    
    let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter
        }()
    
    var body: some View {
        Form {
            Section(header: Text("Basic Information")) {
                TextField("Title", text: $viewModel.hotel.title)
                TextField("Name", text: $viewModel.hotel.name)
                TextField("Address", text: $viewModel.hotel.address)
                TextField("City", text: $viewModel.hotel.city)
                TextField("State", text: $viewModel.hotel.state)
                TextField("Country", text: $viewModel.hotel.country)
            }
            
            Section(header: Text("Contact Details")) {
                TextField("Phone", text: $viewModel.hotel.phone)
                TextField("Toll-Free", text: $viewModel.hotel.tollfree)
                TextField("Email", text: $viewModel.hotel.email)
                TextField("Fax", text: $viewModel.hotel.fax)
                TextField("Website", text: $viewModel.hotel.url)
            }
            
            Section(header: Text("Check-in & Pricing")) {
                TextField("Check-in Time", text: $viewModel.hotel.checkin)
                TextField("Check-out Time", text: $viewModel.hotel.checkout)
                TextField("Price", text: $viewModel.hotel.price)
            }
            
            Section(header: Text("Location")) {
                TextField("Latitude", value: $viewModel.hotel.geo.lat, formatter: formatter)
                TextField("Longitude", value: $viewModel.hotel.geo.lon, formatter: formatter)
                TextField("Accuracy", text: $viewModel.hotel.geo.accuracy)
            }
            
            Section(header: Text("Amenities")) {
                Toggle("Vacancy", isOn: $viewModel.hotel.vacancy)
                Toggle("Pets Allowed", isOn: $viewModel.hotel.petsOk)
                Toggle("Free Breakfast", isOn: $viewModel.hotel.freeBreakfast)
                Toggle("Free Internet", isOn: $viewModel.hotel.freeInternet)
                Toggle("Free Parking", isOn: $viewModel.hotel.freeParking)
            }
            
            Section(header: Text("Description")) {
                TextEditor(text: $viewModel.hotel.description)
                    .frame(height: 100)
            }
        }
        .navigationTitle(viewModel.getTitle())
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.onAcceptButton()
                } label: {
                    Image(systemName: "checkmark")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 20)
                }
            }
        }
    }
    
}
