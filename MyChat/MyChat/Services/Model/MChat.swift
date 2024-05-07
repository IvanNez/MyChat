//
//  MChat.swift
//  MyChat
//
//  Created by Иван Незговоров on 04.05.2024.
//

import UIKit

struct MChat: Hashable, Decodable {
    var friendUsername: String
    var friendAvataStringURL: String
    var lastMessageContent: String
    var friendId: String
    
    var representation: [String: Any] {
        var rep = ["friendUsername": friendUsername]
        rep["friendAvataStringURL"] = friendAvataStringURL
        rep["lastMessage"] = lastMessageContent
        rep["friendId"] = friendId
        return rep
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(friendId)
    }
    
    static func == (lhs: MChat, rhs: MChat) -> Bool {
        return lhs.friendId == rhs.friendId
    }
}
