//
//  SelfConfiguringCell.swift
//  MyChat
//
//  Created by Иван Незговоров on 30.04.2024.
//

import Foundation

protocol SelfConfiguringCell {
    static var reuseId: String { get }
    func configure<U: Hashable>(with value: U)
}
