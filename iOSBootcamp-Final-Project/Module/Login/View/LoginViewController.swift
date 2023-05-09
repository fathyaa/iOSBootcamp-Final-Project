//
//  LoginViewController.swift
//  iOSBootcamp-Final-Project
//
//  Created by Phincon on 05/05/23.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var shadowView: UIView!{
        didSet{
            shadowView.layer.cornerRadius = 20
            shadowView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            shadowView.layer.shadowColor = UIColor.black.cgColor
            shadowView.layer.shadowRadius = 10
            shadowView.layer.shadowOpacity = 0.1
            
        }
    }
    @IBOutlet weak var loginView: UIView!{
        didSet{
            loginView.layer.cornerRadius = 20
            loginView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        }
    }
    @IBOutlet weak var emailTextField: UITextField!{
        didSet{
            emailTextField.textContentType = .emailAddress
            emailTextField.keyboardType = .emailAddress
        }
    }
    @IBOutlet weak var passwordTextField: UITextField!{
        didSet{
            passwordTextField.textContentType = .oneTimeCode
            passwordTextField.isSecureTextEntry = true
        }
    }
    @IBOutlet weak var loginButton: UIButton!{
        didSet{
            loginButton.layer.cornerRadius = 10
            loginButton.tintColor = UIColor(named: "theme-color")
        }
    }
    @IBOutlet weak var registButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// button action
        loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        self.registButton.addTarget(self, action: #selector(didTapRegist), for: .touchUpInside)
    }

    // MARK: - Actions when loginButton tapped
    @objc func didTapLogin() {
        /// inisiasi inputan user ke model LoginUserRequest
        let loginRequest = LoginUserRequest(
            email: self.emailTextField.text ?? "",
            password: self.passwordTextField.text ?? ""
        )
        
        /// cek validasi email yang diinputkan sudah sesuai syarat
        if !Validator.isValidEmail(for: loginRequest.email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        
        /// cek validasi password yang diinputkan sudah sesuai syarat
        if !Validator.isValidPassword(for: loginRequest.password) {
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }
        
        /// proses login ke firebase melalui function loginUser di class AuthService
        AuthService.shared.loginUser(with: loginRequest) { error in
            
            /// jika error, maka akan memunculkan alert error
            if let  error = error {
                AlertManager.showSignInErrorAlert(on: self, with: error)
                return
            }
            
            /// jika berhasil, maka akan menjalankan function checkAuthentication
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
        }
    }
    
    /// direct ke RegisterViewController ketika tombol registButton ditekan
    @objc func didTapRegist() {
        print("clicked didTapRegist")
        let registPage = RegisterViewController()
        self.navigationController?.pushViewController(registPage, animated: true)
    }
}
