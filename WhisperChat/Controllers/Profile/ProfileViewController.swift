//
//  ProfileViewController.swift
//  WhisperChat
//
//  Created by M. Ahmad Ali on 16/04/2023.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    
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
    
    override func viewDidLayoutSubviews() {
        let customFrame = view.bounds
        
        signOutButton.frame = CGRect(x: 30, y: (navigationController?.navigationBar.bottom)! + 40, width: customFrame.width-60, height: 52)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        Adding SubViews
        view.addSubview(signOutButton)
        signOutButton.addTarget(self, action: #selector(signOutButtonTapped), for: .touchUpInside)
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
    
    func alertUserLoginError(title: String, message: String = "Error signing out.") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
}
