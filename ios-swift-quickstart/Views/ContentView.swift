
import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel = ContentViewModel()
    @EnvironmentObject var errorManager: ErrorManager
    @StateObject private var viewCoordinator = ViewCoordinator.shared
    
    var body: some View {
        NavigationStack(path: $viewCoordinator.path) {
            ZStack {
                HotelListView()
                if let error = $errorManager.errors.first {
                    CustomErrorView(title: error.title.wrappedValue, message: error.message.wrappedValue, closable: error.closable.wrappedValue) {
                        errorManager.dismissAndShowNext()
                    }
                    .transition(.scale)
                }
                NetworkNotificationView()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewCoordinator.show(.hotelForm(viewMode: .add))
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFill()
                            .frame(height: 20)
                            .tint(.white)
                    }
                    .accessibilityIdentifier("addHotelButton")
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Hotel Management App")
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.couchbaseRed, for: .navigationBar)
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .hotelDetails(let hotel):
                    HotelDetailsView(hotel: hotel)
                case .hotelForm(let viewMode):
                    HotelFormView(viewModel: HotelFormViewModel(viewMode: viewMode))
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
