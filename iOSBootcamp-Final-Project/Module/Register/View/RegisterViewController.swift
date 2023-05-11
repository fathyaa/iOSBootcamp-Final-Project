//
//  RegisterViewController.swift
//  iOSBootcamp-Final-Project
//
//  Created by Phincon on 05/05/23.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var shadowView: UIView!{
        didSet{
            shadowView.layer.cornerRadius = 20
            shadowView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            shadowView.layer.shadowColor = UIColor.black.cgColor
            shadowView.layer.shadowRadius = 10
            shadowView.layer.shadowOpacity = 0.1
            
        }
    }
    @IBOutlet weak var registView: UIView!{
        didSet{
            registView.layer.cornerRadius = 20
            registView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        }
    }
    @IBOutlet weak var usernameTextField: UITextField!
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
    @IBOutlet weak var registButton: UIButton!{
        didSet{
            registButton.layer.cornerRadius = 10
            registButton.tintColor = UIColor(named: "theme-color")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        // jika registButton diklik, maka akan jalankan function didTapRegist
        self.registButton.addTarget(self, action: #selector(didTapRegist), for: .touchUpInside)
    }
    
    /// function yang dijalankan ketika tombol loginButton ditekan
    @objc func didTapRegist() {
        /// inisiasi inputan user ke model RegisterUserRequest
        let registerUserRequest = RegisterUserRequest(
            username: usernameTextField.text ?? "",
            email: emailTextField.text ?? "",
            password: passwordTextField.text ?? "")
        
        // cek validasi username yang diinputkan sudah sesuai syarat
        if !Validator.isValidUsername(for: registerUserRequest.username ?? "") {
            AlertManager.showInvalidUsernameAlert(on: self)
            return
        }
        
        // cek validasi email, apakah yang diinputkan sudah sesuai syarat
        if !Validator.isValidEmail(for: registerUserRequest.email ?? "") {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        
        // cek validasi password, apakah yang diinputkan sudah sesuai syarat
        if !Validator.isValidPassword(for: registerUserRequest.password ?? "") {
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }
        
        // proses registrasi ke firebase melalui function registerUser di class AuthService
        AuthService.shared.registerUser(with: registerUserRequest) { wasRegistered, error in
            
            // jika error, maka akan memunculkan alert error
            if let error = error {
                AlertManager.showRegistrationErrorAlert(on: self, with: error)
                return
            }
            
            // jika berhasil, maka akan menjalankan function checkAuthentication
            if wasRegistered {
                if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                    sceneDelegate.checkAuthentication()
                }
            } else {
                AlertManager.showRegistrationErrorAlert(on: self)
            }
        }
    }
}
