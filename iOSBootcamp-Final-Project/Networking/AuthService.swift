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
    public static let shared = AuthService()
    
    // MARK: - Create user to Firebase
    public func registerUser(with userRequest: RegisterUserRequest, completion: @escaping (Bool, Error?) -> Void){
        let name = userRequest.username ?? ""
        let email = userRequest.email ?? ""
        let password = userRequest.password ?? ""
        
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
    public func loginUser(with userRequest: LoginUserRequest, completion: @escaping (Error?) -> Void ) {
        Auth.auth().signIn(withEmail: userRequest.email, password: userRequest.password) {
            result, error in
            if let error = error {
                completion(error)
                return
            } else {
                completion(nil)
            }
        }
    }
    
    // MARK: - Log out from existing user
    public func logoutUser(completion: @escaping (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch let error {
            completion(error)
        }
    }
    
    // MARK: - Fetch user data from Firestore
    public func fetchUser(completion: @escaping (User?, Error?) -> Void) {
        guard let userUID = Auth.auth().currentUser?.uid else { return }
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userUID)
            .getDocument { snapshot, error in
                if let error = error {
                    completion(nil, error)
                    return
                }
                
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
