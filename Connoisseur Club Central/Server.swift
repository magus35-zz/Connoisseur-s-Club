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
    //
    private var allTheInformation:[Credentials:Connoisseur] = [:]
    private var authenticatedUser:Connoisseur?
    private var theBeerList:BeerList
    
    static let sharedInstance = Server()
    
    
    
    //MARK: Initializers
    //
    
    
    init () {
        theBeerList = BeerList(fromSampleData: true)
    }
    
    
    
    //MARK: Accessors
    //
    func requestConnoisseur(withCredentials creds: Credentials) -> Connoisseur? {
        if let connoisseur = allTheInformation[creds] {
            return connoisseur
        } else {
            return nil
        }
    }
    
    
    func requestBeerList() -> BeerList {
        return theBeerList
    }
    
    
    func requestBeer(withNumber num: Int) -> Beer? {
        return theBeerList.getBeer(withNumber: num)
    }
    
    
    func requestAuthenticatedUser() -> Connoisseur? {
        return authenticatedUser
    }
    
    
    
    //MARK: Mutators
    //
    
    
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
    
    func revokeAuthentication() -> Void {
        authenticatedUser = nil
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
