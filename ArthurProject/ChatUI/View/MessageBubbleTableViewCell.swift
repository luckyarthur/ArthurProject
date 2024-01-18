import UIKit

enum MessageBubbleCellType: String {
  case rightText
  case leftText
}

class MessageBubbleTableViewCell: UITableViewCell {
  let greenBubbleImageName = "green-bubble"
  let blueBubbleImageName = "blue-bubble"
  
  lazy var messageLabel: UILabel = {
    let messageLabel = UILabel(frame: .zero)
    messageLabel.textColor = .white
    messageLabel.font = UIFont.systemFont(ofSize: 13)
    messageLabel.numberOfLines = 0
    messageLabel.translatesAutoresizingMaskIntoConstraints = false
    return messageLabel
  }()
  
  lazy var sentImageView: UIImageView = {
    let iv = UIImageView()
    iv.translatesAutoresizingMaskIntoConstraints = false
    iv.contentMode = .scaleAspectFit
    return iv
  }()
  
  lazy var bubbleImageView: UIImageView = {
    let bubbleImageView = UIImageView(frame: .zero)
    bubbleImageView.contentMode = .scaleToFill
    bubbleImageView.translatesAutoresizingMaskIntoConstraints = false
    return bubbleImageView
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configureLayout()
  }
  
  func configureBubbleImage(imageName: String, insets: UIEdgeInsets) {
    let image = UIImage(named: imageName)!
    bubbleImageView.image = image.resizableImage(withCapInsets: insets, resizingMode: .stretch)
  }
  
  func configCellWith(message: MessageData) {
    messageLabel.text = message.text
    if let name = message.imageName {
      sentImageView.image = UIImage(named: name)
    }
  }
  
  func configureLayout() {
    contentView.addSubview(bubbleImageView)
    contentView.addSubview(messageLabel)
    contentView.addSubview(sentImageView)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) not implemented")
  }
}
