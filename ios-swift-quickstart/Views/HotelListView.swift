import SwiftUI

struct HotelListView: View {
    @StateObject private var viewModel = HotelListViewModel()
    @StateObject private var viewCoordinator = ViewCoordinator.shared
    
    var body: some View {
        VStack(spacing: 0) {
            if let hotels = viewModel.hotels, !hotels.isEmpty {
                List {
                    Section {
                        ForEach(hotels) { hotel in
                            itemView(hotel)
                                .swipeActions {
                                    Button {
                                        self.viewModel.hotelToDelete = hotel
                                        viewModel.showDeleteItemAlert = true
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                    .tint(.red)
                                    Button {
                                        viewCoordinator.show(.hotelForm(viewMode: .edit(hotel: hotel)))
                                    } label: {
                                        Label("Edit", systemImage: "pencil")
                                    }
                                    .tint(.blue)
                                }
                                .listRowSeparator(.hidden)
                        }
                    } header: {
                        viewHeader
                    }
                }
                .listStyle(.plain)
                .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search by Name")
                .onChange(of: viewModel.searchText) { newValue in
                    viewModel.onSearchTextChanged(newValue)
                }
                .onAppear {
                    UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.white
                    UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = UIColor.black
                    UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = UIColor.white
                }
            } else {
                ProgressView("loading queried hotels")
            }
        }
        .onAppear() {
            viewModel.onAppear()
        }
        .alert("Are you sure you want to delete this item?", isPresented: $viewModel.showDeleteItemAlert) {
            Button("Cancel", role: .cancel) {
                viewModel.deleteItemAlertDismissed()
            }
            Button("Delete", role: .destructive) {
                viewModel.deleteItemAlertAccepted()
            }
        }

    }
    
    var viewHeader: some View {
        VStack(spacing: 0){
            HStack {
                if !(viewModel.hotels?.isEmpty ?? true) {
                    HStack{
                        Text("Sort by name")
                            .frame(maxWidth: .infinity)
                        Image(systemName: viewModel.descendingList ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                            .tint(.black)
                    }
                    .onTapGesture {
                        viewModel.onSortButtonTapped()
                    }
                }
            }
            .frame(maxHeight: .infinity)
        }
    }
    
    private func itemView(_ item: Hotel) -> some View {
        Button {
            viewCoordinator.show(.hotelDetails(hotel: item))
        } label: {
            VStack(alignment: .leading, spacing: 5) {
                Text(item.name ?? "")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text("\(item.address ?? "") \(item.city ?? "") \(item.country)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .fontWeight(.semibold)
                if let phone = item.phone {
                    Text(phone)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .fontWeight(.semibold)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background{
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.white)
                    .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 3)
            }
        }
    }
}
