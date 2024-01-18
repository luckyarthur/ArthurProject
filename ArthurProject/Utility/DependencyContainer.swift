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
    
    func collectionViewControllerFactory() -> CollectionViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CollectionViewController")
        return vc as! CollectionViewController
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
}

