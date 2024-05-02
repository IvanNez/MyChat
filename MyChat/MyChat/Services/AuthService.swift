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
        
        guard Validators.isFillied(email: email, password: password, confirmPassword: confirmPassword) else {
            completion(.failure(AuthError.notFilled))
            return
        }
        
        print(password)
        print(confirmPassword)
        guard password!.lowercased() == confirmPassword!.lowercased() else {
            completion(.failure(AuthError.passwordsNotMatched))
            return
        }
        
        guard Validators.isSimpleEmail(email!) else {
            completion(.failure(AuthError.invaidEmail))
            return
        }
        
        auth.createUser(withEmail: email!, password: password!) { result, error in
            guard let result else {
                completion(.failure(error!))
                return
            }
            completion(.success(result.user))
        }
    }
    
    func login(email: String?, password: String?, completion: @escaping((Result<User, Error>) -> Void)) {
        
        guard let email, let password else {
            completion(.failure(AuthError.notFilled))
            return
        }
        
        auth.signIn(withEmail: email, password: password) { result, error in
            guard let result else {
                completion(.failure(error!))
                return
            }
            
            completion(.success(result.user))
        }
    }
    
}