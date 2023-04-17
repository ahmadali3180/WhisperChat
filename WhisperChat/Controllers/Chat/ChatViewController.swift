//
//  ViewController.swift
//  WhisperChat
//
//  Created by M. Ahmad Ali on 16/04/2023.
//

import UIKit
import FirebaseAuth

class ChatViewController: UIViewController {
    
    //MARK: - Create UI Elemests
    
    private let signOutButton: UIButton = {
        var button = UIButton()
        button.setTitle("Sign Out", for: .normal)
        button.layer.cornerRadius = 12
        button.tintColor = .white
        button.layer.masksToBounds = true
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.backgroundColor = .systemTeal
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        view.addSubview(signOutButton)
        signOutButton.addTarget(self, action: #selector(signOutButtonTapped), for: .touchUpInside)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        validateAuth()
    }
    
    override func viewDidLayoutSubviews() {
        let customFrame = view.bounds
        
        signOutButton.frame = CGRect(x: 30, y: view.top + 90, width: customFrame.width-60, height: 52)
    }
    
    private func validateAuth() {
        
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let vc = LoginViewController()
            let nc = UINavigationController(rootViewController: vc)
            nc.modalPresentationStyle = .fullScreen
            present(nc, animated: false)
        }
    }
    
    func alertUserLoginError(title: String, message: String = "Error signing out.") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    @objc private func signOutButtonTapped() {
        do {
            let vc = LoginViewController()
            let nc = UINavigationController(rootViewController: vc)
            nc.modalPresentationStyle = .fullScreen
            try FirebaseAuth.Auth.auth().signOut()
            present(nc, animated: true)
            print("Signed out!")
        } catch {
            alertUserLoginError(title: "Operation Failed", message: "Can't Signout current user.")
        }
    }
}

