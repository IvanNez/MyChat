//
//  Validators.swift
//  MyChat
//
//  Created by Иван Незговоров on 02.05.2024.
//

import Foundation

class Validators {
    
    static func isFillied(email: String?, password: String?, confirmPassword: String?) -> Bool {
        guard let email,
              let password,
              let confirmPassword,
              email != "",
              password != "",
              confirmPassword != "" else {
            return false
        }
        
        return true
    }
    
    static func isFillied(username: String?, desctiption: String?, sex: String?) -> Bool {
        guard let username,
              let desctiption,
              let sex,
              username != "",
              desctiption != "",
              sex != "" else {
            return false
        }
        
        return true
    }
    
    static func isSimpleEmail(_ email: String) -> Bool {
        let emailRegEx = "^.+@.+\\..{2,}$"
        return check(text: email, regEx: emailRegEx)
    }
    
    private static func check(text: String, regEx: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        return predicate.evaluate(with: text)
    }
    
}
