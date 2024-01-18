import UIKit

protocol ToolbarViewDelegate {
  func toolbarView(_ toolbarView: ToolbarView, didFavoritedWith tag: Int)
  func toolbarView(_ toolbarView: ToolbarView, didLikedWith tag: Int)
}

class ToolbarView: UIView {
    var delegate: ToolbarViewDelegate?
    private let likeButton = UIButton(type: .custom)
    private let favoriteButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        alpha = 0.98
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.5
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 70),
            heightAnchor.constraint(equalToConstant: 30),
        ])
        
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.distribution = .fillEqually
        stackview.axis = .horizontal
        stackview.spacing = 5
        
        let favoriteButtonImage = UIImage(named: "star")?.withRenderingMode(.alwaysTemplate)
        favoriteButton.setImage(favoriteButtonImage, for: .normal)
        favoriteButton.tintColor = .orange
        favoriteButton.addTarget(self, action: #selector(didFavorited), for: .touchUpInside)
        
        let likeButtonImage = UIImage(named: "like")?.withRenderingMode(.alwaysTemplate)
        likeButton.setImage(likeButtonImage, for: .normal)
        likeButton.tintColor = .red
        likeButton.addTarget(self, action: #selector(didLiked), for: .touchUpInside)
        
        stackview.addArrangedSubview(favoriteButton)
        stackview.addArrangedSubview(likeButton)
        
        addSubview(stackview)
        
        NSLayoutConstraint.activate([
            stackview.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackview.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackview.widthAnchor.constraint(equalToConstant: 65),
            stackview.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    func update(isLiked: Bool, isFavorited: Bool) {
        let likeButtonColor: UIColor = isLiked ? .red : .lightGray
        likeButton.tintColor = likeButtonColor
        
        let favoriteButtonColor: UIColor = isFavorited ? .orange : .lightGray
        favoriteButton.tintColor = favoriteButtonColor
    }
    
    func toogleLikeButton() {
        let color: UIColor = likeButton.tintColor == .red ? .lightGray : .red
        likeButton.tintColor = color
    }
    
    func toogleFavoriteButton() {
        let color: UIColor = favoriteButton.tintColor == .orange ? .lightGray : .orange
        favoriteButton.tintColor = color
    }
    
    @objc func didFavorited() {
        toogleFavoriteButton()
        delegate?.toolbarView(self, didFavoritedWith: tag)
    }
    
    @objc func didLiked() {
        toogleLikeButton()
        delegate?.toolbarView(self, didLikedWith: tag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
