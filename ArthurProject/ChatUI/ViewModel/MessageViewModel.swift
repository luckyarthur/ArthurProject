import Foundation

protocol MessageData {
    var text: String { get }
    var sentByMe: Bool { get }
    var imageName: String? { get }
}

final class MessageViewModel {
    let messagesData = Binder(value: [MessageData]())
    
    func fetchMessage() {
        var messages = [Message]()
        messages.append(Message(text: "Hello, it's me Libranner", sentByMe: true, imageName: "selfie"))
        messages.append(Message(
            text: "I was wondering if you'll like to meet, to go over this new tutorial I'm working on",
            sentByMe: true,
            imageName: nil))
        messages.append(Message(
            text: "I'm in California now, but we can meet tomorrow morning, at your house",
            sentByMe: false,
            imageName: nil))
        messages.append(Message(text: "Sound good! Talk to you later", sentByMe: true, imageName: nil))
        messages.append(Message(text: ":]", sentByMe: false, imageName: "ok"))
        
        messagesData.value = messages
    }
}
