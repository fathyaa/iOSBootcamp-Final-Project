//
//  SceneDelegate.swift
//  iOSBootcamp-Final-Project
//
//  Created by Phincon on 06/04/23.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        self.setupWindow(with: scene)
        /// function untuk cek apakah session user sedang terisi
        self.checkAuthentication()
    }

    // MARK: - Setup window
    private func setupWindow(with scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        self.window?.makeKeyAndVisible()
    }
    
    // MARK: - Check authentication
    public func checkAuthentication() {
        /// jika tidak ada user yang sedang login, maka akan direct ke page login
        if Auth.auth().currentUser == nil {
            self.goToController(with: LoginViewController())
        /// jika ada user yang sedang login, maka akan direct ke ke tab bar
        } else {
            self.goToController(with: TabBar())
        }
    }
    
    // MARK: - Direct to Controller
    private func goToController(with viewController: UIViewController) {
        DispatchQueue.main.async { [weak self] in
            /// set  animation ketika direct ke view controller
            UIView.animate(withDuration: 0.25) {
                self?.window?.layer.opacity = 0
                
            } completion: { [weak self] _ in
                
                let nav = UINavigationController(rootViewController: viewController)
                self?.window?.rootViewController = nav
                nav.isNavigationBarHidden = true
                
                UIView.animate(withDuration: 0.25) { [weak self] in
                    self?.window?.layer.opacity = 1
                }
            }
        }
    }
}

