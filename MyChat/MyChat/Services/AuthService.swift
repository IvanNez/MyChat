//
//  AuthService.swift
//  MyChat
//
//  Created by Иван Незговоров on 02.05.2024.
//

import Foundation
import UIKit
import Firebase

class AuthService {
    
    static let shared = AuthService()
    
    private let auth = Auth.auth()
    
    func register(email: String?, password: String?, confirmPassword: String?, completion: @escaping((Result<User, Error>) -> Void)) {
        auth.createUser(withEmail: email!, password: password!) { result, error in
            guard let result else {
                completion(.failure(error!))
                return
            }
            
            completion(.success(result.user))
        }
    }
    
    func login(email: String?, password: String?, completion: @escaping((Result<User, Error>) -> Void)) {
        auth.signIn(withEmail: email!, password: password!) { result, error in
            guard let result else {
                completion(.failure(error!))
                return
            }
            
            completion(.success(result.user))
        }
    }
    
}
