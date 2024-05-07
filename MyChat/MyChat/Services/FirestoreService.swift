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
    
    func saveProfileWith(id: String, email: String, username: String?, avatarImage: UIImage?, description: String?, sex: String?, completion: @escaping (Result<MUser, Error>) -> Void) {
        
        guard Validators.isFillied(username: username, desctiption: description, sex: sex) else {
            completion(.failure(userError.notFilled))
            return
        }
        
        guard avatarImage != UIImage(resource: .avatar) else { 
            completion(.failure(userError.photoNotExist))
            return }
        
        var muser = MUser(username: username!,
                          email: email,
                          avatarStringURL: "not exist",
                          description: description!,
                          sex: sex!,
                          id: id)
        StorageService.shared.upload(photo: avatarImage!) { result in
            switch result {
            case .success(let url):
                muser.avatarStringURL = url.absoluteString
                self.userRef.document(muser.id).setData(muser.representation) { error in
                    if let error {
                        completion(.failure(error))
                    } else {
                        completion(.success(muser))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        } // StorageService
    } // saveProfileWTih
}
