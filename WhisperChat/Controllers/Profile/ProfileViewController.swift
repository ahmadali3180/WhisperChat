//
//  ProfileViewController.swift
//  WhisperChat
//
//  Created by M. Ahmad Ali on 16/04/2023.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet var tableView: UITableView!
    
    
    //MARK: - Create UI Elemests
    var pData = ["Log Out"]
    
    
    //MARK: - Defined Properties
    
    
    
    //MARK: - viewDidLayoutSubviews
    
    override func viewDidLayoutSubviews() {
        //        let customFrame = view.bounds
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
}

//MARK: - TableView Delegate Methods

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var contentConfig = cell.defaultContentConfiguration()
        contentConfig.text = pData[indexPath.row]
        contentConfig.textProperties.alignment = .center
        contentConfig.textProperties.color = .red
        cell.contentConfiguration = contentConfig
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        actionSheet(title: "Log Out", message: "Do you really want to logout?", style: .destructive)
        
    }
    
    func actionSheet(title: String, message: String, style: UIAlertAction.Style) {
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "Log Out", style: .destructive) { [weak self]_ in
            guard let strongSelf = self else { return }
            let vc = LoginViewController()
            let nc = UINavigationController(rootViewController: vc)
            nc.modalPresentationStyle = .fullScreen
            strongSelf.present(nc, animated: true)
        }
        let action2 = UIAlertAction(title: "Cancel", style: .cancel)
        actionSheet.addAction(action1)
        actionSheet.addAction(action2)
        present(actionSheet, animated: true)
    }
    
}
