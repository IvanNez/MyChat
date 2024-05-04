//
//  UserError.swift
//  MyChat
//
//  Created by Иван Незговоров on 04.05.2024.
//

import Foundation

enum userError {
    case notFilled
    case photoNotExist
}

extension userError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("Заполните все поля", comment: "")
        case .photoNotExist:
            return NSLocalizedString("Пользователь не выбрал фотографию", comment: "")
        }
    }
}
