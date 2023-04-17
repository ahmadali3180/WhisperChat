//
//  DatabaseManager.swift
//  WhisperChat
//
//  Created by M. Ahmad Ali on 17/04/2023.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    static let shared = DatabaseManager()
    private let database = Database.database().reference()
}

//MARK: - Account Management



/// Inserts new users to database
extension DatabaseManager {
    
    public func userExists(with email: String, completion: @escaping ((Bool) -> Void)) {
        database.child(email).observeSingleEvent(of: .value) { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
        }
        completion(true)
    }
    
    public func insertUser(with user: WhisperChatUser) {
        database.child(user.emailAddress).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
        ])
    }
}

struct WhisperChatUser {
    let firstName: String
    let lastName: String
    let emailAddress: String
    //    let profilePicURL: URL
}
