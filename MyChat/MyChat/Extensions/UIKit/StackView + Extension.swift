//
//  StackView + Extension.swift
//  MyChat
//
//  Created by Иван Незговоров on 29.04.2024.
//

import Foundation
import UIKit

extension UIStackView {
   
    convenience init(arrangerSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        self.init(arrangedSubviews: arrangerSubviews)
        self.axis = axis
        self.spacing = spacing
    }
}
