//
//  SetupProfileViewController.swift
//  MyChat
//
//  Created by Иван Незговоров on 29.04.2024.
//

import UIKit
import Firebase

class SetupProfileViewController: UIViewController {

    let fullImageView = AddPhotoView()
    
    let welcomeLabel = UILabel(text: "Set up profile!", font: .avenir26())
    let fullNameLabel = UILabel(text: "Full name")
    let aboutMeLabel = UILabel(text: "About me")
    let sexLabel = UILabel(text: "Sex")
    
    let fullNameTextField = OneLineTextField(font: .avenir20())
    let aboutMeTextField = OneLineTextField(font: .avenir20())
    
    let sexSegmentedControl = UISegmentedControl(first: "Male", second: "Female")
    
    let goToChatsButton = UIButton(title: "Go to chats!", titleColor: .white, backgroundColor: .buttonDark(), cornerRadius: 4)
    
    private let currentUser: User
    
    init(currentUser: User) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
        
        if let username = currentUser.displayName {
            fullNameTextField.text = username
        }
        // TODO set google image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        view.backgroundColor = .white
        setupConstaints()
        customizeElements()
    }
    
    
}

// MARK: -- Layout
private extension SetupProfileViewController {
    
    func customizeElements() {
        goToChatsButton.addTarget(self, action: #selector(goToChatsButtonTapped), for: .touchUpInside)
        fullImageView.plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
    }
    
    
    func setupConstaints() {
        let fullNameStackView = UIStackView(arrangedSubviews: [fullNameLabel, fullNameTextField], axis: .vertical, spacing: 0)
        let aboutMeStackView = UIStackView(arrangedSubviews: [aboutMeLabel, aboutMeTextField], axis: .vertical, spacing: 0)
        let sextackView = UIStackView(arrangedSubviews: [sexLabel, sexSegmentedControl], axis: .vertical, spacing: 12)
        
        let stackView = UIStackView(arrangedSubviews: [fullNameStackView, aboutMeStackView, sextackView, goToChatsButton], axis: .vertical, spacing: 40)
        
        fullImageView.translatesAutoresizingMaskIntoConstraints = false
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(welcomeLabel)
        view.addSubview(fullImageView)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            goToChatsButton.heightAnchor.constraint(equalToConstant: 60),
            
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            fullImageView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 40),
            fullImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: fullImageView.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
        ])
    }
}

// MARK: -- OBJC
private extension SetupProfileViewController {
    @objc func plusButtonTapped() {
        let imagePickeController = UIImagePickerController()
        imagePickeController.delegate = self
        imagePickeController.sourceType = .photoLibrary
        present(imagePickeController, animated: true)
    }
    
    @objc func goToChatsButtonTapped() {
        FirestoreService.shared.saveProfileWith(id: currentUser.uid,
                                                email: currentUser.email!,
                                                username: fullNameTextField.text,
                                                avatarImage: fullImageView.circleImageView.image,
                                                description: aboutMeTextField.text,
                                                sex: sexSegmentedControl.titleForSegment(at: sexSegmentedControl.selectedSegmentIndex)) { result in
            switch result {
            case .success(let user):
                let mainTabBar = MainTabBarController(currentUser: user)
                mainTabBar.modalPresentationStyle = .fullScreen
                self.present(mainTabBar, animated: true)
            case .failure(let error):
                let alert = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "cancel", style: .cancel))
                self.present(alert, animated: true)
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: -- UINavigationControllerDelegate, UIImagePickerControllerDelegate
extension SetupProfileViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return }
        fullImageView.circleImageView.image = image
    }
}

#Preview("SetupProfileViewController"){
    SetupProfileViewController(currentUser: Auth.auth().currentUser!)
}
