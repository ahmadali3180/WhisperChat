//
//  ViewController.swift
//  WhisperChat
//
//  Created by M. Ahmad Ali on 16/04/2023.
//

import UIKit

class ChatViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .link
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let isLoggedIn = UserDefaults.standard.bool(forKey: "loggedIn")
        
        if !isLoggedIn {
            let vc = LoginViewController()
            let nc = UINavigationController(rootViewController: vc)
            nc.modalPresentationStyle = .fullScreen
            present(nc, animated: false)
            
        }
    }

}

