import SwiftUI

struct NetworkNotificationView: View {
    @StateObject private var networkMonitor = NetworkMonitor.shared
    @State private var isVisible: Bool = false
    @State private var timer: Timer?

    var body: some View {
        VStack {
            Text(networkMonitor.isConnected ? "You are online" : "You are offline")
                .font(.headline)
                .padding(.bottom, 5)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 10)
        .opacity(isVisible ? 1 : 0)
        .animation(.default, value: isVisible)
        .onChange(of: networkMonitor.isConnected) { newValue in
            isVisible = true
            timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
                isVisible = false
            }
        }
    }
}
