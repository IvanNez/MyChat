//
//  UIImageView + Extension.swift
//  MyChat
//
//  Created by Иван Незговоров on 26.04.2024.
//

import Foundation
import UIKit

extension UIImageView {
    convenience init(image: UIImage?, contentMode: UIView.ContentMode) {
        self.init()
        
        self.image = image
        self.contentMode = contentMode
    }
}
