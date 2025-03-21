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
                .accessibilityIdentifier("NameFormTextField")
            TextField("Title", text: $viewModel.hotel.title)
                .accessibilityIdentifier("TitleFormTextField")
    
            TextField("Description",text: $viewModel.hotel.description, axis: .vertical)
                .accessibilityIdentifier("DescriptionFormTextField")
                .frame(height: 100)
            
            Section {
                TextField("Address", text: $viewModel.hotel.address)
                    .accessibilityIdentifier("AddressFormTextField")
                TextField("City", text: $viewModel.hotel.city)
                    .accessibilityIdentifier("CityFormTextField")
                TextField("State", text: $viewModel.hotel.state)
                    .accessibilityIdentifier("StateFormTextField")
                TextField("Country", text: $viewModel.hotel.country)
                    .accessibilityIdentifier("CountryFormTextField")
                
                TextField("Latitude", value: $viewModel.hotel.geo.lat, formatter: formatter)
                    .accessibilityIdentifier("LatitudeFormTextField")
                TextField("Longitude", value: $viewModel.hotel.geo.lon, formatter: formatter)
                    .accessibilityIdentifier("LongitudeFormTextField")
                TextField("Accuracy", text: $viewModel.hotel.geo.accuracy)
                    .accessibilityIdentifier("AccuracyFormTextField")
                
                TextField("Phone", text: $viewModel.hotel.phone)
                    .accessibilityIdentifier("PhoneFormTextField")
                TextField("Toll-Free", text: $viewModel.hotel.tollfree)
                    .accessibilityIdentifier("TollFreeFormTextField")
                TextField("Email", text: $viewModel.hotel.email)
                    .accessibilityIdentifier("EmailFormTextField")
                TextField("Fax", text: $viewModel.hotel.fax)
                    .accessibilityIdentifier("FaxFormTextField")
                TextField("Website", text: $viewModel.hotel.url)
                    .accessibilityIdentifier("WebsiteFormTextField")
                
                TextField("Check-in Time", text: $viewModel.hotel.checkin)
                    .accessibilityIdentifier("CheckinFormTextField")
                TextField("Check-out Time", text: $viewModel.hotel.checkout)
                    .accessibilityIdentifier("CheckoutFormTextField")
                TextField("Price", text: $viewModel.hotel.price)
                    .accessibilityIdentifier("PriceFormTextField")
                
                Toggle("Vacancy", isOn: $viewModel.hotel.vacancy)
                    .accessibilityIdentifier("VacancyFormToggle")
                Toggle("Pets Allowed", isOn: $viewModel.hotel.petsOk)
                    .accessibilityIdentifier("PetsFormToggle")
                Toggle("Free Breakfast", isOn: $viewModel.hotel.freeBreakfast)
                    .accessibilityIdentifier("BreakfastFormToggle")
                Toggle("Free Internet", isOn: $viewModel.hotel.freeInternet)
                    .accessibilityIdentifier("InternetFormToggle")
                Toggle("Free Parking", isOn: $viewModel.hotel.freeParking)
                    .accessibilityIdentifier("ParkingFormToggle")
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
                .accessibilityIdentifier("HotelFormViewAcceptButton")
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
