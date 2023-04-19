//
//  LoginViewController.swift
//  WhisperChat
//
//  Created by M. Ahmad Ali on 16/04/2023.
//

import UIKit
import Foundation
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import FBSDKLoginKit

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
    
    private let facebookLoginButton: FBLoginButton = {
        let button = FBLoginButton()
        button.permissions = ["public_profile", "email"]
        button.setTitle("Login With Facebook", for: .normal)
        button.backgroundColor = .link
        button.tintColor = .white
        button.layer.cornerRadius = 12
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        button.layer.borderWidth = 0.5
        return button
    }()
    
    private let googleLoginButton: GIDSignInButton = {
        let button = GIDSignInButton()
        button.style = .standard
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white.withAlphaComponent(0.95 )
        title = "Log In"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done, target: self, action: #selector(didTapRegister))
        
        //        Add Target Buttons
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        googleLoginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        
        //        Setting up Delegates
        emailField.delegate = self
        passwordField.delegate = self
        facebookLoginButton.delegate = self
        
        //        Add Subviews
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(loginButton)
        scrollView.addSubview(facebookLoginButton)
        scrollView.addSubview(googleLoginButton)
        
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
        facebookLoginButton.frame = CGRect(x: 30, y: loginButton.bottom+10, width: scrollView.width-60, height: 52)
        googleLoginButton.frame = CGRect(x: 30, y: facebookLoginButton.bottom+40, width: scrollView.width-60, height: 52)
        facebookLoginButton.center = scrollView.center
        
        
    }
    
    //MARK: - Login Button Functionality
    
    @objc private func loginButtonTapped() {
        
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let email = emailField.text, let password = passwordField.text, !email.isEmpty, !password.isEmpty, password.count >= 6 else {
            alertUserLoginError()
            return
            
        }
        /// `Firebase` Login
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            guard let result = authResult, error == nil else {
                strongSelf.alertUserLoginError()
                return
            }
            let _ = result.user
            strongSelf.navigationController?.dismiss(animated: true, completion: nil)
        }
        
    }
    //    Alert for Authentication Error
    
    func alertUserLoginError(title: String = "Authentication Error", message: String = "Enter Valid Credentials") {
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
//MARK: - LoginVC - UITextFieldDelegate

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

//MARK: - LoginVC - Facebook - LoginButtonDelegate
extension LoginViewController: LoginButtonDelegate {
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginKit.FBLoginButton) {
        // no operation
    }
    
    func loginButton(_ loginButton: FBSDKLoginKit.FBLoginButton, didCompleteWith result: FBSDKLoginKit.LoginManagerLoginResult?, error: Error?) {
        //        getting Token From result
        guard let token = result?.token?.tokenString else {
            print("Failed to Login with Facebook. Error From: loginButton(didCompleteWith result:)")
            return
        }
        
        //        Checking For ErrorString(describing: !)
        guard error == nil else  {
            print("Error: \(String(describing: error))")
            return
        }
        
        //        Facebook Graph Request
        let facebookRequest = FBSDKLoginKit.GraphRequest(
            graphPath: "me",
            parameters: ["fields": "email, name"],
            tokenString: token,
            version: nil,
            httpMethod: .get
        )
        
        facebookRequest.start { _, result, error in
            guard let result = result as? [String: Any], error == nil else {
                print("Facebook Graph Requesr Failed!")
                return
            }
            //            print(result)
            //            Getting User's Name & Email
            guard let userName = result["name"] as? String, let email = result["email"] as? String else {
                print("Couldn't get User's Name & Email from Graph Request")
                return
            }
            
            
            let nameComponents = userName.components(separatedBy: " ")
            let startRange = 2
            let endRange = 3
            let range = startRange...endRange
            
            guard range.contains(nameComponents.count) else {
                print("Error here")
                return
            }
            
            var firstName: String = ""
            var lastName: String = ""
            
            if nameComponents.count == 2 {
                firstName = nameComponents[0]
                lastName = nameComponents[1]
            } else {
                firstName = "\(nameComponents[0]) \(nameComponents[1])"
                lastName = nameComponents[2]
            }
            
            
            //            Checking For existing email
            DatabaseManager.shared.userExists(with: email) { exists in
                if !exists {
                    DatabaseManager.shared.insertUser(with: WhisperChatUser(
                        firstName: firstName,
                        lastName: lastName,
                        emailAddress: email)
                    )
                    print("User Added")
                }
                
                return
            }
            
            //        Get Credentials
            let credential = FacebookAuthProvider.credential(withAccessToken: token)
            
            //        Signing In With Credentials
            FirebaseAuth.Auth.auth().signIn(with: credential) { [weak self] authResult, error in
                guard let strongSelf = self else { return }
                guard authResult != nil, error == nil else {
                    print("Failed to Login with Credentials. 2FA May be Needed. Error from: FirebaseAuth SignIn with AuthCredential: \(String(describing: error))")
                    return
                }
                print("Log In Successfully completed!")
                strongSelf.navigationController?.dismiss(animated: true, completion: nil)
            }
            
        }
        
    }
}

//MARK: - LoginVC - Google - LoginButtonDelegate
extension LoginViewController {
    
    @objc func login() {
        //    Get Client Id
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        //     Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [weak self] result, error in
//            guard let strongSelf = self else { return }
            guard result != nil, error == nil else {
                print("Google Login Error 1: \(String(describing: error))")
                return
            }
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                print("Google Login Error 2")
                return
            }
            
            //        Getting Credentials of Google Account
            let credential = GoogleAuthProvider.credential(
                withIDToken: idToken,
                accessToken: user.accessToken.tokenString)
            
//            getting Email and Fullname from google
            guard let email = user.profile?.email, let fullName = user.profile?.name else {
                print("Email and Name couldn't be found!")
                return
            }
            
//            Getting First and Last Name
            let nameComponents = fullName.components(separatedBy: " ")
            let startRange = 2
            let endRange = 3
            let range = startRange...endRange
            
            guard range.contains(nameComponents.count) else {
                print("Error here")
                return
            }
            
            var firstName: String = ""
            var lastName: String = ""
            
            if nameComponents.count == 2 {
                firstName = nameComponents[0]
                lastName = nameComponents[1]
            } else {
                firstName = "\(nameComponents[0]) \(nameComponents[1])"
                lastName = nameComponents[2]
            }
            
//            print("firstname: \(firstName) | lastname: \(lastName)")
            
            
            //            Checking For existing email
            DatabaseManager.shared.userExists(with: email) { exists in
                if !exists {
                    DatabaseManager.shared.insertUser(with: WhisperChatUser(
                        firstName: firstName,
                        lastName: lastName,
                        emailAddress: email)
                    )
                    print("User Added")
                }
                
                return
            }
            
            Auth.auth().signIn(with: credential) { [weak self] authResult, error in
                guard let strongSelf = self else { return }
                guard authResult != nil, error == nil else {
                    print("Failed to Login with Credentials from Google: \(String(describing: error))")
                    return
                }
                print("Log In Successfully completed!")
                strongSelf.navigationController?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func googleLoginButton(sender: GIDSignInButton) {
        login()
    }
    

}
