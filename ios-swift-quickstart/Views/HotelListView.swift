import SwiftUI

struct HotelListView: View {
    @StateObject private var viewModel = HotelListViewModel()
    @StateObject private var viewCoordinator = ViewCoordinator.shared
    
    var body: some View {
        VStack(spacing: 0) {
            if let hotels = viewModel.hotels {
                List {
                    Section {
                        ForEach(hotels) { hotel in
                            itemView(hotel)
                                .alignmentGuide(.listRowSeparatorLeading) { _ in
                                    return 0
                                }
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
                        }
                    } header: {
                        viewHeader
                    }
                }
                .listStyle(.plain)
                .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search name by regex")
                .onChange(of: viewModel.searchText) { newValue in
                    viewModel.onSearchTextChanged(newValue)
                }
            } else {
                Text("loading queried hotels")
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
                HStack{
                    Text("Hotel name")
                        .frame(maxWidth: .infinity)
                    Image(systemName: viewModel.descendingList ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                        .tint(.black)
                }
                .onTapGesture {
                    viewModel.onSortButtonTapped()
                }
                Text("City")
                    .frame(maxWidth: .infinity)
                Text("Country")
                    .frame(maxWidth: .infinity)
            }
            .frame(maxHeight: .infinity)
        }
    }
    
    private func itemView(_ item: Hotel) -> some View {
        Button {
            viewCoordinator.show(.hotelDetails(hotel: item))
        } label: {
            VStack{
                HStack {
                    Text(item.title)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity)
                    Text(item.city ?? "")
                        .lineLimit(1)
                        .frame(maxWidth: .infinity)
                    Text(item.country)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity)
                }
                .frame(maxHeight: .infinity)
            }
        }
    }
}
