import UIKit

class LeftMessageBubbleTableViewCell: MessageBubbleTableViewCell {
  
  private lazy var imageConstraints: [NSLayoutConstraint] = [
    sentImageView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 5),
    sentImageView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor),
    sentImageView.widthAnchor.constraint(equalToConstant: 100),
    sentImageView.heightAnchor.constraint(equalToConstant: 100),
    imageBottomConstraint
  ]
  
  private lazy var imageBottomConstraint: NSLayoutConstraint = contentView.bottomAnchor.constraint(
    equalTo: sentImageView.bottomAnchor, constant: 10)
  private lazy var textBottomConstraint: NSLayoutConstraint = contentView.bottomAnchor.constraint(
    equalTo: bubbleImageView.bottomAnchor, constant: 10)
  
  override func configureLayout() {
    super.configureLayout()
    
    NSLayoutConstraint.activate([
      contentView.topAnchor.constraint(
        equalTo: bubbleImageView.topAnchor,
        constant: -10),
      contentView.trailingAnchor.constraint(
        greaterThanOrEqualTo: bubbleImageView.trailingAnchor,
        constant: 20),
     
      contentView.leadingAnchor.constraint(
        equalTo: bubbleImageView.leadingAnchor,
        constant: -20),
      bubbleImageView.topAnchor.constraint(
        equalTo: messageLabel.topAnchor,
        constant: -5),
      bubbleImageView.trailingAnchor.constraint(
        equalTo: messageLabel.trailingAnchor,
        constant: 10),
      bubbleImageView.bottomAnchor.constraint(
        equalTo: messageLabel.bottomAnchor,
        constant: 5),
      bubbleImageView.leadingAnchor.constraint(
        equalTo: messageLabel.leadingAnchor,
        constant: -20),
    ])
    
    let insets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 10)
    let image = UIImage(named: blueBubbleImageName)!
      .imageFlippedForRightToLeftLayoutDirection()
      
    bubbleImageView.image = image.resizableImage(withCapInsets: insets, resizingMode: .stretch)
  }
  
  override func configCellWith(message: MessageData) {
    super.configCellWith(message: message)
    if let _ = message.imageName {
      NSLayoutConstraint.activate(imageConstraints)
      NSLayoutConstraint.deactivate([textBottomConstraint])
    } else {
      NSLayoutConstraint.deactivate(imageConstraints)
      NSLayoutConstraint.activate([textBottomConstraint])
    }
    
  }
}
