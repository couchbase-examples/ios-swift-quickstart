import SwiftUI

struct HotelFormView: View {
    @ObservedObject private var viewModel: HotelFormViewModel
    @Environment(\.dismiss) private var dismiss

    
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
            TextField("Name", text: $viewModel.hotel.name)
            TextField("Title", text: $viewModel.hotel.title)
    
            TextField("Description",text: $viewModel.hotel.description, axis: .vertical)
                .frame(height: 100)
            
            Section {
                TextField("Address", text: $viewModel.hotel.address)
                TextField("City", text: $viewModel.hotel.city)
                TextField("State", text: $viewModel.hotel.state)
                TextField("Country", text: $viewModel.hotel.country)
                
                TextField("Latitude", value: $viewModel.hotel.geo.lat, formatter: formatter)
                TextField("Longitude", value: $viewModel.hotel.geo.lon, formatter: formatter)
                TextField("Accuracy", text: $viewModel.hotel.geo.accuracy)
                
                TextField("Phone", text: $viewModel.hotel.phone)
                TextField("Toll-Free", text: $viewModel.hotel.tollfree)
                TextField("Email", text: $viewModel.hotel.email)
                TextField("Fax", text: $viewModel.hotel.fax)
                TextField("Website", text: $viewModel.hotel.url)
                
                TextField("Check-in Time", text: $viewModel.hotel.checkin)
                TextField("Check-out Time", text: $viewModel.hotel.checkout)
                TextField("Price", text: $viewModel.hotel.price)
                
                Toggle("Vacancy", isOn: $viewModel.hotel.vacancy)
                Toggle("Pets Allowed", isOn: $viewModel.hotel.petsOk)
                Toggle("Free Breakfast", isOn: $viewModel.hotel.freeBreakfast)
                Toggle("Free Internet", isOn: $viewModel.hotel.freeInternet)
                Toggle("Free Parking", isOn: $viewModel.hotel.freeParking)
            }
        }
        .navigationTitle(viewModel.getTitle())
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.onAcceptButton()
                } label: {
                    Text("Save")
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .fontWeight(.semibold)
                        Text("Back")
                    }
                }
            }
        }
    }
    
}
