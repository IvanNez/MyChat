//
//  WaitingChatCell.swift
//  MyChat
//
//  Created by Иван Незговоров on 30.04.2024.
//

import Foundation
import UIKit

class WaitingChatCell: UICollectionViewCell, SelfConfiguringCell {
    static var reuseId: String = "WaitingChatCell"
    let friendImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .yellow
        layer.cornerRadius = 4
        clipsToBounds = true
        setupConstraints()
    }
    
    func configure<U>(with value: U) {
        guard let chat = value as? MChat else { return }
        friendImageView.image = UIImage(named: chat.userImageString)
    }
    
}

private extension WaitingChatCell {
    func setupConstraints() {
        friendImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(friendImageView)
        
        NSLayoutConstraint.activate([
            friendImageView.topAnchor.constraint(equalTo: self.topAnchor),
            friendImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            friendImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            friendImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
    }
}


#Preview("MainTabBarController"){
    MainTabBarController()
}
