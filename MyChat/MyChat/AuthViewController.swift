//
//  ViewController.swift
//  MyChat
//
//  Created by Иван Незговоров on 26.04.2024.
//

import UIKit

class AuthViewController: UIViewController {
   
    
    let logoImageView = UIImageView(image: UIImage(systemName: "hazam.logo.fill"), contentMode: .scaleAspectFit)
    
    let googleLabel = UILabel(text: "Get started with")
    let emailLabel = UILabel(text: "Get started with")
    let alreadyOnboardLabel = UILabel(text: "Already onboard?")
    
    let googleButton = UIButton(title: "Google", titleColor: .black, backgroundColor: .white, isShadow: true)
    let emailButton = UIButton(title: "Email", titleColor: .white, backgroundColor: .buttonDark())
    let loginButton = UIButton(title: "Login", titleColor: .buttonRed(), backgroundColor: .white, isShadow: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
    }
}


#Preview("ViewController"){
    AuthViewController()
}
