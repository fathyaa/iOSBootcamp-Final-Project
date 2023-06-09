//
//  Validator.swift
//  iOSBootcamp-Final-Project
//
//  Created by Phincon on 02/05/23.
//

import Foundation

/// class yang berisi validator untuk inputan
class Validator {
    
    // MARK: - Validator for Email
    /// validator for email input
    static func isValidEmail(for email: String) -> Bool {
        // inisiasi email yg diinputkan untuk dicek
        let email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        // definisikan regular expression untuk validasi inputan email
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.{1}[A-Za-z]{2,64}"
        // inisiasi var untuk cek email apakah sudah sesuai dengan regEx
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        // cek email, lalu func ini akan me-return boolean yg menanadakan email benar (true) atau salah (false)
        return emailPred.evaluate(with: email)
    }
    
    // MARK: - Validator for Username
    /// validator for username input
    static func isValidUsername(for username: String) -> Bool {
        let username = username.trimmingCharacters(in: .whitespacesAndNewlines)
        let usernameRegEx = "\\w{4,24}"
        let usernamePred = NSPredicate(format: "SELF MATCHES %@", usernameRegEx)
        return usernamePred.evaluate(with: username)
    }
    
    // MARK: - Validator for Password
    /// validator for password input
    static func isValidPassword(for password: String) -> Bool {
        let password = password.trimmingCharacters(in: .whitespacesAndNewlines)
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[$@$#!%*?&]).{6,32}$"
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: password)
    }
}
