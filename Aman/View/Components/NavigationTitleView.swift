import SwiftUI

struct NavigationTitleView: View {
    let title: String

    var body: some View {
        VStack {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 10)
                .padding(.bottom, 5)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.white) // Adjust color to match your app's design
                .shadow(color: .gray.opacity(0.2), radius: 2, x: 0, y: 2)
            Spacer()
        }
        .frame(height: 60)
    }
}
