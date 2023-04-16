//
//  RegisterViewController.swift
//  WhisperChat
//
//  Created by M. Ahmad Ali on 16/04/2023.
//

import UIKit

class RegisterViewController: UIViewController {
    //MARK: - Create UI Elements
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.tintColor = .lightGray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let firstNameField: UITextField = {
        let field = UITextField()
        field.placeholder = "First Name"
        field.autocapitalizationType = .words
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
    
    private let lastNameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Last Name"
        field.autocapitalizationType = .words
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
        field.returnKeyType = .continue
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
    
    private let confirmPasswordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Confirm Password"
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
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .systemGreen
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
        title = "Register"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //        Add Target Buttons
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        
        //        Setting up Delegates
        emailField.delegate = self
        passwordField.delegate = self
        
        //        Add Subviews
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(firstNameField)
        scrollView.addSubview(lastNameField)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(confirmPasswordField)
        scrollView.addSubview(registerButton)
        
//        Add Gesture Recognizers & UserInteractions
        imageView.isUserInteractionEnabled = true
        scrollView.isScrollEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangeProfilePic))
        
        gesture.numberOfTapsRequired = 1
        gesture.numberOfTouchesRequired = 1
        imageView.addGestureRecognizer(gesture)
        
    }
    
    @objc private func didTapChangeProfilePic() {
        print("didTapChangeProfilePic() called")
    }
    
    //MARK: -   Subviews Layouts
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        
        //          Setting Custom Size
        let size = scrollView.width / 3
        
        //        Setting frames for UI Elements
        imageView.frame = CGRect(x: (scrollView.width-size)/2, y: 50, width: size, height: size)
        firstNameField.frame = CGRect(x: 30, y: imageView.bottom+10, width: scrollView.width-60, height: 52)
        lastNameField.frame = CGRect(x: 30, y: firstNameField.bottom+10, width: scrollView.width-60, height: 52)
        emailField.frame = CGRect(x: 30, y: lastNameField.bottom+10, width: scrollView.width-60, height: 52)
        passwordField.frame = CGRect(x: 30, y: emailField.bottom+10, width: scrollView.width-60, height: 52)
        confirmPasswordField.frame = CGRect(x: 30, y: passwordField.bottom+10, width: scrollView.width-60, height: 52)
        registerButton.frame = CGRect(x: 30, y: confirmPasswordField.bottom+10, width: scrollView.width-60, height: 52)
    }
    
    //MARK: - Login Button Functionality
    
    @objc private func registerButtonTapped() {
        
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        confirmPasswordField.resignFirstResponder()
        
        guard let confirmPassword = confirmPasswordField.text, let firstName = firstNameField.text,
              let lastName = lastNameField.text, let email = emailField.text, let password = passwordField.text, !email.isEmpty, !password.isEmpty, password.count >= 6, !confirmPassword.isEmpty, !firstName.isEmpty, !lastName.isEmpty, confirmPassword.count >= 6, confirmPassword == password else {
            alertUserLoginError()
            return
        }
        // Firebase Login`
    }
    //    Alert for Authentication Error
    
    func alertUserLoginError() {
        let alert = UIAlertController(title: "Authentication Error", message: "Enter all Information to Create a New Account.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            registerButtonTapped()
        }
        return true
    }
}
