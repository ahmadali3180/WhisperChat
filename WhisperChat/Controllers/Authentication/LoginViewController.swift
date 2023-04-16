//
//  LoginViewController.swift
//  WhisperChat
//
//  Created by M. Ahmad Ali on 16/04/2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: - Create UI Elements
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "chat")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email"
        field.autocapitalizationType = .none
        field.keyboardType = .emailAddress
        field.enablesReturnKeyAutomatically = true
        field.autocorrectionType = .no
        field.clearButtonMode = .whileEditing
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.layer.borderColor = UIColor.lightGray.cgColor
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password"
        field.autocapitalizationType = .none
        field.keyboardType = .default
        field.enablesReturnKeyAutomatically = true
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 12
        field.clearButtonMode = .whileEditing
        field.isSecureTextEntry = true
        field.layer.borderWidth = 1
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        field.layer.borderColor = UIColor.lightGray.cgColor
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .link
        button.tintColor = .white
        button.layer.cornerRadius = 12
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        button.layer.borderWidth = 0.5
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white.withAlphaComponent(0.95 )
        title = "Log In"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(didTapRegister))
        
        //        Add Target Buttons
        loginButton.addTarget(self, action: #selector(loginButtonTapped ), for: .touchUpInside)
        
//        Setting up Delegates
        emailField.delegate = self
        passwordField.delegate = self
        
        //        Add Subviews
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(loginButton)
        
    }
    
    //MARK: -   Subviews Layouts
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        
        //          Setting Custom Size
        let size = scrollView.width / 3
        
        //        Setting frames for UI Elements
        imageView.frame = CGRect(x: (scrollView.width-size)/2, y: 50, width: size, height: size)
        emailField.frame = CGRect(x: 30, y: imageView.bottom+10, width: scrollView.width-60, height: 52)
        passwordField.frame = CGRect(x: 30, y: emailField.bottom+10, width: scrollView.width-60, height: 52)
        loginButton.frame = CGRect(x: 30, y: passwordField.bottom+10, width: scrollView.width-60, height: 52)
    }
    
    //MARK: - Login Button Functionality
    
    @objc private func loginButtonTapped() {
        
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let email = emailField.text, let password = passwordField.text, !email.isEmpty, !password.isEmpty, password.count >= 6 else {
            alertUserLoginError()
            return
            
        }
        // Firebase Login
    }
    //    Alert for Authentication Error
    
    func alertUserLoginError() {
        let alert = UIAlertController(title: "Authentication Error", message: "Enter Valid Credentials", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    @objc private func didTapRegister() {
        let vc = RegisterViewController()
        vc.title = "Create Account"
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            loginButtonTapped()
        }
        return true
    }
}
