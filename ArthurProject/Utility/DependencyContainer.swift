import UIKit
import SwiftUI

final class DependencyContainer {
    static let shared = DependencyContainer()
    private init() {}
    
    func tabbarViewControllerFactory() -> UITabBarController {
        let tabbarVC = UITabBarController()
        let collectionVC = collectionViewControllerFactory()
        let messageVC = messageViewControllerFactory()
        let profileVC = profileViewControllerFactory()
        tabbarVC.viewControllers = [collectionVC, messageVC, profileVC]
        let items = tabbarVC.tabBar.items
        items?[0].image = UIImage(named: "info-tab")
        items?[0].title = "collection"
        items?[1].image = UIImage(named: "chat-tab")
        items?[1].title = "message"
        items?[1].badgeValue = "\(5)"
        items?[2].image = UIImage(named: "profile-tab")
        items?[2].title = "profile"
        
        return tabbarVC
    }
    
    func collectionViewControllerFactory() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CollectionViewController")
        let navVC = UINavigationController(rootViewController: vc)
        return navVC
    }
    
    func messageViewControllerFactory() -> MessagesTableViewController {
        let viewModel = MessageViewModel()
        let vc = MessagesTableViewController(viewModel: viewModel)
        return vc
    }
    
    func profileViewControllerFactory() -> UIViewController {
        let vc = UIHostingController(rootView: SwiftUIView())
        return vc
    }
    
    func splitViewControllerFactory() -> UIViewController {
        let splitVC = UISplitViewController(style: .doubleColumn)
//        let profileVC = profileViewControllerFactory()
//        profileVC.preferredContentSize = CGSize(width: UIScreen.main.bounds.size.width*0.8, height: UIScreen.main.bounds.size.height)
//        let collectionVC = collectionViewControllerFactory()
//        splitVC.viewControllers = [profileVC, collectionVC]
//        splitVC.viewControllers = [collectionVC, profileVC]

//        splitVC.preferredDisplayMode = .oneBesideSecondary
//        splitVC.maximumPrimaryColumnWidth = 300
//        splitVC.minimumPrimaryColumnWidth = 150
//        splitVC.preferredSplitBehavior = .tile
//        
        return splitVC
    }
}

