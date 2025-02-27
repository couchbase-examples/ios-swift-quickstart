
import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel = ContentViewModel()
    @EnvironmentObject var errorManager: ErrorManager
    
    var body: some View {
        NavigationStack {
            ZStack {
                HotelListView()
                if let error = $errorManager.errors.first {
                    CustomErrorView(title: error.title.wrappedValue, message: error.message.wrappedValue) {
                        errorManager.dismissAndShowNext()
                    }
                    .transition(.scale)
                }
                NetworkNotificationView()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Airport management")
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.white, for: .navigationBar)
        }
    }
}

#Preview {
    ContentView()
}
