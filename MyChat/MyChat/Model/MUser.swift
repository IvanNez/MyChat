//
//  MUser.swift
//  MyChat
//
//  Created by Иван Незговоров on 01.05.2024.
//

import Foundation
import UIKit

struct MUser: Hashable, Decodable {
    var username: String
    var avatarStringURL: String
    var id: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: MUser, rhs: MUser) -> Bool {
        return lhs.id == rhs.id
    }
    
    func contains(filter: String?) -> Bool {
        guard let filter else { return true }
        if filter.isEmpty  { return true }
        let lowercaseFilter = filter.lowercased()
        return username.lowercased().contains(lowercaseFilter)
    }
}
