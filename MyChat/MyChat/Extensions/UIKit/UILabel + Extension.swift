//
//  UILabel + Extension.swift
//  MyChat
//
//  Created by Иван Незговоров on 26.04.2024.
//

import Foundation
import UIKit

extension UILabel {

    convenience init(text: String, font: UIFont? = .avenir20()) {
        self.init()
        
        self.text = text
        self.font = font
    }
}
