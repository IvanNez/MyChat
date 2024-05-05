//
//  FirestoreService.swift
//  MyChat
//
//  Created by Иван Незговоров on 04.05.2024.
//

import Firebase
import FirebaseFirestore

class FirestoreService {
    static let shared = FirestoreService()
    
    let db = Firestore.firestore()
    
    private var userRef: CollectionReference {
        return db.collection("users")
    }
    
    func getUserData(user: User, completion: @escaping (Result<MUser, Error>) -> Void) {
        let docRef = userRef.document(user.uid)
        docRef.getDocument { document, error in
            if let document, document.exists {
                guard let muser = MUser(document: document) else {
                    completion(.failure(userError.cannotUnwrapToMUser))
                    return
                }
                completion(.success(muser))
            } else {
                completion(.failure(userError.cannotGetUserInfo))
            }
        }
    }
    
    func saveProfileWith(id: String, email: String, username: String?, avatarImageString: String?, description: String?, sex: String?, completion: @escaping (Result<MUser, Error>) -> Void) {
        
        guard Validators.isFillied(username: username, desctiption: description, sex: sex) else {
            completion(.failure(userError.notFilled))
            return
        }
        
        let muser = MUser(username: username!,
                          email: email,
                          avatarStringURL: "not exist",
                          description: description!,
                          sex: sex!,
                          id: id)
        
        self.userRef.document(muser.id).setData(muser.representation) { error in
            if let error {
                completion(.failure(error))
            } else {
                completion(.success(muser))
            }
        }
    }
}
