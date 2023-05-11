//
//  AuthService.swift
//  iOSBootcamp-Final-Project
//
//  Created by Phincon on 05/05/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthService {
    // ini namanya singleton
    public static let shared = AuthService()
    
    // MARK: - Create user to Firebase
    /// function untuk mengambil data inputan lalu create user di firebase
    public func registerUser(with userRequest: RegisterUserRequest, completion: @escaping (Bool, Error?) -> Void){
        // name, email, password berisi inputan yg didapet dari parameter userRequest
        let name = userRequest.username ?? ""
        let email = userRequest.email ?? ""
        let password = userRequest.password ?? ""
        
        // proses create user
        Auth.auth().createUser(withEmail: email, password: password) {
            result, error in
            
            if let error = error {
                completion(false, error)
                return
            }
            
            guard let resultUser = result?.user else {
                completion(false, nil)
                return
            }
            
            let db = Firestore.firestore()
            // simpan data di collection 'users'
            db.collection("users")
                .document(resultUser.uid)
                .setData([
                    "name": name,
                    "email": email
                ]) { error in
                    if let error = error {
                        completion(false, error)
                        return
                    }
                    completion(true, nil)
                }
        }
    }
    
    // MARK: - Log in authentication
    /// function untuk mengambil data inputan lalu proses login menggunakan firebase
    public func loginUser(with userRequest: LoginUserRequest, completion: @escaping (Error?) -> Void ) {
        // proses login
        Auth.auth().signIn(withEmail: userRequest.email, password: userRequest.password) {
            result, error in
            // handle error
            if let error = error {
                completion(error)
                return
            } else {
                completion(nil)
            }
        }
    }
    
    // MARK: - Log out from existing user
    /// function untuk proses logout menggunakan firebase
    public func logoutUser(completion: @escaping (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch let error {
            completion(error)
        }
    }
    
    // MARK: - Fetch user data from Firestore
    /// function untuk mengambil data dari firestore dan dimasukkan ke model User
    public func fetchUser(completion: @escaping (User?, Error?) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        
        /// pendefinisian firestore as db
        let db = Firestore.firestore()
        
        // dapetin reference collection 'user' di db
        db.collection("users")
            // dapetin reference document 'userUID'
            .document(userUID)
            // fetch data
            .getDocument { snapshot, error in
                // handle error
                if let error = error {
                    completion(nil, error)
                    return
                }
                // masukin data dari firestore ke model User, lalu pass ke class yang manggil function ini lewat completion
                if let snapshot = snapshot,
                   let snapshotData = snapshot.data(),
                   let name = snapshotData["name"] as? String,
                   let email = snapshotData["email"] as? String {
                    let user = User(name: name, email: email, userUID: userUID)
                    completion(user, nil)
                }
                
            }
    }
}
