//
//  ViewController.swift
//  MyChat
//
//  Created by Иван Незговоров on 26.04.2024.
//

import UIKit
import GoogleSignIn
import FirebaseCore
import FirebaseAuth

class AuthViewController: UIViewController {
    
    let logoImageView = UIImageView(image: UIImage(resource: .logo), contentMode: .scaleAspectFit)
    
    let googleLabel = UILabel(text: "Get started with")
    let emailLabel = UILabel(text: "Get started with")
    let alreadyOnboardLabel = UILabel(text: "Already onboard?")
    
    let googleButton = UIButton(title: "Google", titleColor: .black, backgroundColor: .white, isShadow: true)
    let emailButton = UIButton(title: "Email", titleColor: .white, backgroundColor: .buttonDark())
    let loginButton = UIButton(title: "Login", titleColor: .buttonRed(), backgroundColor: .white, isShadow: true)
    
    let signUpVC = SignUpViewController()
    let loginVC = LoginViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setup()
    }
    
    func setup() {
        setupConstraints()
        setupButton()
    }
}

// MARK: -- Layout
private extension AuthViewController {
    func setupButton() {
        emailButton.addTarget(self, action: #selector(emailButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        googleButton.addTarget(self, action: #selector(signInGoogle), for: .touchUpInside)
    }
    
    func setupConstraints() {
        googleButton.customizeGoogleButton()
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let googleView = ButtonFormView(label: googleLabel, button: googleButton)
        let emailView = ButtonFormView(label: emailLabel, button: emailButton)
        let loginView = ButtonFormView(label: alreadyOnboardLabel, button: loginButton)
        
        let stackView = UIStackView(arrangedSubviews: [googleView, emailView, loginView],axis: .vertical, spacing: 40)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(logoImageView)
        view.addSubview(stackView )
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 160),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
}

// MARK: -- OBJC

private extension AuthViewController {
    @objc func emailButtonTapped() {
        signUpVC.dismisVC = { res in
            if res {
                self.present(self.loginVC, animated: true)
            }
        }
        present(signUpVC, animated: true)
    }
    
    @objc func loginButtonTapped() {
        loginVC.dismisVC = { res in
            if res {
                self.present(self.signUpVC, animated: true)
            }
        }
        present(loginVC, animated: true)
    }
    
}

// MARK: -- SignInWith Google
private extension AuthViewController {
   @objc func signInGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { result, error in
            guard error == nil else {
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { user, error in
                guard let user else {
                    return
                }
                FirestoreService.shared.getUserData(user: user.user) { result in
                    switch result {
                    case .success(let muser):
                        let mainTabBar = MainTabBarController(currentUser: muser)
                        mainTabBar.modalPresentationStyle = .fullScreen
                        self.present(mainTabBar, animated: true)
                    case .failure(_):
                        self.present(SetupProfileViewController(currentUser: user.user), animated: true)
                    }
                }
            }
        }
    }
}

#Preview("ViewController"){
    AuthViewController()
}
