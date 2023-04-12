//
//  TabBar.swift
//  iOSBootcamp-Final-Project
//
//  Created by Phincon on 10/04/23.
//

import UIKit

class TabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        self.view.backgroundColor = .white
    }
    
    func setupViewControllers() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyboard.instantiateViewController(withIdentifier: "homeVC")
        viewControllers = [
            createNavController(for: homeVC, title: NSLocalizedString("Home", comment: ""), image: UIImage(systemName: "house")!),
            createNavController(for: UIViewController(), title: NSLocalizedString("Account", comment: ""), image: UIImage(systemName: "person")!)
        ]
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController:  rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationItem.title = title
        return navController
    }
}
