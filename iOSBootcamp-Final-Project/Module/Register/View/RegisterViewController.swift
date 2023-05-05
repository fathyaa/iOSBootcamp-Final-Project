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

    @IBOutlet weak var namaLengkapLabel: UITextField!
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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
