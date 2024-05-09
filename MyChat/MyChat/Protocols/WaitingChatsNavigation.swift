//
//  WaitingChatsNavigation.swift
//  MyChat
//
//  Created by Иван Незговоров on 09.05.2024.
//

import Foundation

protocol WaitingChatsNavigation {
    func removeWaitingChat(chat: MChat)
    func chatToActive(chat: MChat)
}
