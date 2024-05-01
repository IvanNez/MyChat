//
//  UIView + Extension.swift
//  MyChat
//
//  Created by Иван Незговоров on 01.05.2024.
//

import UIKit

extension UIView {
    func applyGradients(cornerRadius: CGFloat) {
        self.backgroundColor = nil
        self.layoutIfNeeded()
        let gradientView = GradientView(from: .topTrailing, to: .bottomLeading, startColor: UIColor(red: 201/255.0, green: 161/255.0, blue: 240/255.0, alpha: 1/1.0), endColor: UIColor(red: 122/255.0, green: 178/255.0, blue: 235/255.0, alpha: 1/1.0))
        if let gradientLayer = gradientView.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = self.bounds
            gradientLayer.cornerRadius = cornerRadius
            self.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
}
