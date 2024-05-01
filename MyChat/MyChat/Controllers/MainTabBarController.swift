//
//  MainTabBarController.swift
//  MyChat
//
//  Created by Иван Незговоров on 29.04.2024.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

private extension MainTabBarController {
    func setup() {
        let listViewController = ListViewController()
        let peopleViewController = PeopleViewController()
        
        tabBar.tintColor = UIColor(red: 142/255.0, green: 90/255.0, blue: 247/255.0, alpha: 1/1.0)
        
        let boldConfig = UIImage.SymbolConfiguration(weight: .medium)
        let peopleImage = UIImage(systemName: "person.2", withConfiguration: boldConfig)!
        let convImage = UIImage(systemName: "bubble.left.and.bubble.right", withConfiguration: boldConfig)!
        
        viewControllers = [
            generateNavigationController(rootViewController: peopleViewController, title: "People", image: peopleImage),
           generateNavigationController(rootViewController: listViewController, title: "Conversations", image: convImage)
        ]
    }
    
    func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }
}
