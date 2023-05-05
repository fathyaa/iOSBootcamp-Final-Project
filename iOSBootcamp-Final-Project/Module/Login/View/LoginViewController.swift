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
        self.loginButton.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
        self.registButton.addTarget(self, action: #selector(didTapRegist), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    @objc func didTapLogin() {
        print("clicked didTapLogin")
        let home = TabBar()
        self.navigationController?.pushViewController(home, animated: true)
        navigationController?.isNavigationBarHidden = true
    }
    
    @objc func didTapRegist() {
        print("clicked didTapRegist")
        let registPage = RegisterViewController()
        self.navigationController?.pushViewController(registPage, animated: true)
    }
}
