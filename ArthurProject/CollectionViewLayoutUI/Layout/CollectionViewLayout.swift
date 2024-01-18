import UIKit

protocol CollectionViewLayoutDelegate: AnyObject {
  func collectionView(
    _ collectionView: UICollectionView,
    heightForImageAtIndexPath indexPath: IndexPath)
    -> CGFloat
  func collectionView(
    _ collectionView: UICollectionView,
    labelTextAtIndexPath indexPath: IndexPath)
    -> String
}

final class CollectionViewLayout: UICollectionViewLayout {
  
  weak var delegate: CollectionViewLayoutDelegate?
  
  private var columns: Int {
    return UIDevice.current.orientation == .portrait ? 1 : 2
  }
  
  private var contentBounds: CGRect {
    let origin: CGPoint = .zero
    let size = CGSize(width: contentWidth, height: contentHeight)
    return CGRect(origin: origin, size: size)
  }
  
  private var cachedLayoutAttributes: [UICollectionViewLayoutAttributes] = []
  
  private let cellPadding: CGFloat = 8
  private var contentWidth: CGFloat = 0
  private var contentHeight: CGFloat = 0
  override var collectionViewContentSize: CGSize {
    return contentBounds.size
  }
  
  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    guard let collectionView = collectionView else { return false }
    return newBounds.size != collectionView.bounds.size
  }
  override func prepare() {
    super.prepare()
    guard let collectionView = collectionView else { return }
    cachedLayoutAttributes.removeAll()
    let size = collectionView.bounds.size
    let safeAreaContentInset = collectionView.safeAreaInsets
    collectionView.contentInsetAdjustmentBehavior = .always
    contentWidth = size.width - safeAreaContentInset.horizontalInsets
    contentHeight = size.height - safeAreaContentInset.verticalInsets
    makeAttributes(for: collectionView)
  }
  
  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    return cachedLayoutAttributes[indexPath.item]
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    cachedLayoutAttributes.filter {
      rect.intersects($0.frame)
    }
  }
  
  private func makeAttributes(for collectionView: UICollectionView) {
    guard let delegate = delegate else {
      return
    }
    let itemWidth = contentWidth / CGFloat(columns)
    var xOffsets: [CGFloat] = []
    (0..<columns).forEach {
      xOffsets.append(CGFloat($0) * itemWidth)
    }
    var column = 0
    var yOffsets = [CGFloat](repeating: 0, count: columns)
    let items = 0..<collectionView.numberOfItems(inSection: 0)
    
    for item in items {
      let indexPath = IndexPath(item: item, section: 0)
      let itemHeight = makeItemHeight(atIndexPath: indexPath, itemWidth: itemWidth, withCollectionView: collectionView, delegate: delegate)
      let frame = CGRect(x: xOffsets[column], y: yOffsets[column], width: itemWidth, height: itemHeight)
      let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
      
      let layoutAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
      layoutAttributes.frame = insetFrame
      cachedLayoutAttributes.append(layoutAttributes)
      
      contentHeight = max(contentHeight, frame.maxY)
      yOffsets[column] += itemHeight
      
      column = column < columns - 1 ? column + 1 : 0
      
    }
  }
  
  private func makeItemHeight(
    atIndexPath indexPath: IndexPath,
    itemWidth: CGFloat,
    withCollectionView collectionView: UICollectionView,
    delegate: CollectionViewLayoutDelegate) -> CGFloat {
      let imageHeight = delegate.collectionView(collectionView, heightForImageAtIndexPath: indexPath)
      let labelText = delegate.collectionView(collectionView, labelTextAtIndexPath: indexPath)
      let maxLabelHeightSize = CGSize(width: itemWidth, height: CGFloat.greatestFiniteMagnitude)
      let boundingRect = labelText.boundingRect(with: maxLabelHeightSize,
                                                options: [.usesLineFragmentOrigin],
                                                attributes: [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline)],
                                                context: nil)
      let labelHeight = ceil(boundingRect.height)
      let itemHeight = cellPadding*2 + imageHeight + labelHeight
      return itemHeight
  }
}

// MARK: - UIEdgeInsets
private extension UIEdgeInsets {
  var horizontalInsets: CGFloat {
    return left + right
  }
  
  var verticalInsets: CGFloat {
    return top + bottom
  }
}
