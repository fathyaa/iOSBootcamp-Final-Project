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
        // run function cek auth untuk menentukan halaman awal ketika app dibuka
        self.checkAuthentication()
    }

    // MARK: - Setup window
    /// function untuk set window ketika app dijalankan
    private func setupWindow(with scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        self.window?.makeKeyAndVisible()
    }
    
    // MARK: - Check authentication
    /// function untuk cek apakah auth user sedang terisi. Jika tidak ada user yang sedang login, maka akan direct ke page login. Jika ada user yang sedang login, maka akan direct ke ke tab bar.
    public func checkAuthentication() {
        if Auth.auth().currentUser == nil {
            self.goToController(with: LoginViewController())
        } else {
            self.goToController(with: TabBar())
        }
    }
    
    // MARK: - Direct to Controller
    /// function untuk pindah controller setelah cek auth.
    private func goToController(with viewController: UIViewController) {
        DispatchQueue.main.async { [weak self] in
            // set  animation ketika direct ke view controller
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

