//
//  Server.swift
//  Connoisseur Club Central
//
//  Created by Joeseidon, King of the Joecean on 5/11/17.
//  Copyright © 2017 Joeseidon, King of the Joecean. All rights reserved.
//

import Foundation

struct Credentials {
    var username:String
    var password:String
}

class Server {
    //MARK: Properties
    private var allTheInformation:[Credentials:Connoisseur] = [:]
    private var authenticatedUser:Connoisseur?
    
    
    static let sharedInstance = Server()
    
    
    //MARK: Accessors
    func requestConnoisseur(withCredentials creds: Credentials) -> Connoisseur? {
        if let connoisseur = allTheInformation[creds] {
            return connoisseur
        } else {
            return nil
        }
    }
    
    
    //MARK: Mutators
    func registerConnoisseur(withCredentials creds: Credentials) -> Void {
        allTheInformation[creds] = Connoisseur()
    }
    
    func authenticateUser(withCredentials creds: Credentials) -> Void? {
        if let connoisseur = allTheInformation[creds] {
            authenticatedUser = connoisseur
            return ()
        } else {
            return nil
        }
    }
}

extension Credentials: Hashable {
    var hashValue: Int {
        return username.hashValue ^ password.hashValue
    }
    
    static func == (lhs: Credentials, rhs: Credentials) -> Bool {
        return lhs.username == rhs.username && lhs.password == rhs.password
    }
}
