import UIKit

// MARK: - CollectionViewController
final class CollectionViewController: UICollectionViewController {
    // MARK: - Properties
    private let cellIdentifier = "CollectionViewCell"
    private var shapes: [ShapeData] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var viewModel: CollectionViewModel
    
    init(viewModel: CollectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        self.viewModel = CollectionViewModel()
        super.init(coder: coder)
    }
    
    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViewLayout()
        viewModel.dataSource.bindTo { [weak self] data in
            guard let self = self else { return }
            self.shapes = data
        }
        
        setupNavigationBar()
    }
            
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard previousTraitCollection?.preferredContentSizeCategory != traitCollection.preferredContentSizeCategory else { return }
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    // MARK: - ConfigUI
    private func setupNavigationBar() {
        let leftNavItem = UIBarButtonItem(title: "Rotate", style: .plain, target: self, action: #selector(triggerRotate))
        navigationItem.rightBarButtonItem = leftNavItem
    }
    
    // MARK: - Flow Layout
    private func setupCollectionViewLayout() {
        guard let collectionViewLayout = collectionView.collectionViewLayout as? CollectionViewLayout else { return }
        collectionViewLayout.delegate = self
    }
    
    // MARK: - Actions
    @objc private func triggerRotate() {

        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }
        let desiredOrientation: UIInterfaceOrientationMask = windowScene.interfaceOrientation == .portrait ? .landscape : .portrait

        windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: desiredOrientation))
        
    }
    
    @IBAction func cancelBarButtonDidTouchUpInside(_ sender: UIBarButtonItem) {
        DispatchQueue.main.async { [weak self] in
            self?.dismiss(animated: true)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension CollectionViewController {
    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
            return shapes.count
        }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellIdentifier, for: indexPath)
                as? CollectionViewCell
        else { fatalError("Failed to dequeued CollectionViewCell.") }
        let shape = shapes[indexPath.item]
        cell.configureCell(shape: shape)
        return cell
    }
}

extension CollectionViewController: CollectionViewLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath) -> CGFloat {
        return shapes[indexPath.item].image.size.height
    }
    
    func collectionView(_ collectionView: UICollectionView, labelTextAtIndexPath indexPath: IndexPath) -> String {
        return shapes[indexPath.item].shapeName
    }
}
