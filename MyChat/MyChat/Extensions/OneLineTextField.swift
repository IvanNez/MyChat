//
//  OneLineTextField.swift
//  MyChat
//
//  Created by Иван Незговоров on 29.04.2024.
//

import Foundation
import UIKit

class OneLineTextField: UITextField {
    convenience init(font: UIFont? = .avenir20()) {
        self.init()
        
        self.font = font
        self.borderStyle = .none
        self.translatesAutoresizingMaskIntoConstraints = false
        
        var bottonView = UIView()
        bottonView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        bottonView.backgroundColor = .textFieldLight()
        bottonView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottonView)
        
        NSLayoutConstraint.activate([
            bottonView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottonView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottonView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottonView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
