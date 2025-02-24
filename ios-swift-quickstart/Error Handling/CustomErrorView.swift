
import SwiftUI

struct CustomErrorView: View {
    let title: String
    let message: String
    let onDismiss: () -> Void

    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .padding(.bottom, 5)
            Text(message)
                .font(.subheadline)
            Button("OK") { onDismiss() }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 10)
    }
}
