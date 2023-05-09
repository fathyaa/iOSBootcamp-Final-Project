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
        tabBar.tintColor = UIColor(named: "theme-color")
    }
    
    func setupViewControllers() {
        /// definisikan storyboard karena VC-nya menggunakan storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyboard.instantiateViewController(withIdentifier: "homeVC")
        let accountVC = storyboard.instantiateViewController(withIdentifier: "accountVC")
        
        /// inisiasikan VC yang akan ada di tab bar
        viewControllers = [
            createNavController(for: homeVC, title: NSLocalizedString("Home", comment: ""), image: UIImage(systemName: "house")!),
            createNavController(for: accountVC, title: NSLocalizedString("Account", comment: ""), image: UIImage(systemName: "person")!)
        ]
    }
    
    /// buat navigation controller untuk pindah VC
    fileprivate func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController:  rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationItem.title = title
        return navController
    }
}
