import SwiftUI

struct HotelListView: View {
    @StateObject private var viewModel = HotelListViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            if let hotels = viewModel.hotels {
                viewHeader
                ScrollView {
                    ForEach(hotels) { hotel in
                        itemView(hotel)
                    }
                }
            } else {
                Text("loading queried hotels")
            }
        }
        .onAppear() {
            viewModel.onAppear()
        }
    }
    
    var viewHeader: some View {
        VStack(spacing: 0){
            HStack {
                Text("Hotel name")
                    .frame(maxWidth: .infinity)
                Text("City")
                    .frame(maxWidth: .infinity)
                Text("Country")
                    .frame(maxWidth: .infinity)
            }
            .background(Color.gray.opacity(0.5))
            Color.black
                .frame(height: 1)
        }
    }
    
    private func itemView(_ item: Hotel) -> some View {
        VStack{
            HStack {
                Text(item.name ?? "")
                    .lineLimit(2)
                    .frame(maxWidth: .infinity)
                Text(item.city ?? "")
                    .lineLimit(1)
                    .frame(maxWidth: .infinity)
                Text(item.country)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity)
            }
            .padding(2)
            Color.black
                .frame(height: 1)
        }
    }
    
}
