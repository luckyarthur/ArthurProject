import SwiftUI

struct ProfileView: View {
    private let tasks = ["Setting 1", "Setting 2", "Setting 3", "Setting 4", "Setting 5"]
    @State private var isLoggedIn = true
    @State private var offset = CGSize.zero
    private let fullWidth = UIScreen.main.bounds.width

    var body: some View {
        let drag = DragGesture()
            .onChanged { value in
                guard value.translation.width < -100 else { return }
                print("velocity \(value.velocity)")
                if value.velocity.width < -300 {
                    offset = CGSize(width: -fullWidth, height: 0)
                    return
                }
                offset = CGSize(width: value.translation.width, height: 0)
            }
            .onEnded { value in
                print("final offset\(value.translation.width)")
                if value.translation.width < -fullWidth*0.3 {
                    offset = CGSize(width: -fullWidth, height: 0)
                }
            }
                    
        NavigationView {
            HStack{
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
                }
                Color.gray.opacity(0.6).frame(width: UIScreen.main.bounds.width * 0.3)
                    .onTapGesture {
                        offset = CGSize(width: -UIScreen.main.bounds.width, height: offset.height )
                    }
            }.animation(.spring, value: offset)
                .offset(offset)
                .gesture(drag)
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
