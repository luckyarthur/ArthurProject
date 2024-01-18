import SwiftUI

struct SwiftUIView: View {
    private let tasks = ["Setting 1", "Setting 2", "Setting 3", "Setting 4", "Setting 5"]
    @State private var isLoggedIn = true

    var body: some View {
        NavigationView {
            VStack{
                Image("selfie")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 200.0, height: 200.0)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 7)
                    .padding()
                    .foregroundColor(.gray)
                Text("User Name")
                List(tasks, id: \.self) { task in
                    NavigationLink(destination: {
                        Text(task)
                    }, label: {
                        Text(task)
                    }).listRowBackground(
                            LinearGradient(colors: [.cyan.opacity(0.8), .purple.opacity(0.8)], startPoint: .leading, endPoint: .trailing)
                        )
                }
                Button {
                    isLoggedIn.toggle()
                } label: {
                    Text("Logout")
                        .font(.title2)
                        .foregroundColor(.black)
                        .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                }
            }.navigationTitle("Profile")
                .navigationBarTitleDisplayMode(.inline)
                .navigationViewStyle(.stack)
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
