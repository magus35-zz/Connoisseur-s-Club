//
//  Server.swift
//  Connoisseur Club Central
//
//  Created by Joeseidon, King of the Joecean on 5/11/17.
//  Copyright © 2017 Joeseidon, King of the Joecean. All rights reserved.
//

import Foundation

//Structure defining a connoisseur's login credentials
struct Credentials {
    var username:String
    var password:String
}


//In-memory "server"
class Server {
    //****
    //MARK: Properties
    //****
    private var allTheInformation:[Credentials:Connoisseur] = [:]
    private var authenticatedUser:Connoisseur?
    private var theBeerList:BeerList
    
    static let sharedInstance = Server()
    
    
    
    //****
    //MARK: Initializers
    //****
    
    
    //Default initializer
    init () {
        theBeerList = BeerList(fromSampleData: true)
    }//init()
    
    
    //****
    //MARK: Accessors
    //****
    
    
    
    //Mock login request
    //Return the Connoisseur object if it was found, otherwise return nil
    //Use this to simulate a login
    func requestConnoisseur(withCredentials creds: Credentials) -> Connoisseur? {
        if let connoisseur = allTheInformation[creds] {
            return connoisseur
        } else {//if
            return nil
        }//else
    }//requestConnoisseur(withCredentials:)
    
    
    //Request the master beer list, containing all of the beers that have been offered
    func requestBeerList() -> BeerList {
        return theBeerList
    }//requestBeerList()
    
    
    //Request a beer from the master beer list
    func requestBeer(withNumber num: Int) -> Beer? {
        return theBeerList.getBeer(withNumber: num)
    }//requestBeer(withNumber:)
    
    
    //Requset the credentials of the "authenticated" connoisseur
    func requestAuthenticatedUser() -> Connoisseur? {
        return authenticatedUser
    }//requestAuthenticatedUser()
    
    
    
    //****
    //MARK: Mutators
    //****
    
    
    
    //Register a new connoisseur with the given credentials
    func registerConnoisseur(withCredentials creds: Credentials) -> Void {
        allTheInformation[creds] = Connoisseur()
    }//registerConnoisseur(withCredentials:)
    
    
    //Attempt to "authenticate" a connoisseur with the given credentials
    func authenticateUser(withCredentials creds: Credentials) -> Void? {
        if let connoisseur = allTheInformation[creds] {
            authenticatedUser = connoisseur
            return ()
        } else { //if
            return nil
        } //else
    }//authenticateUser(withCredentials:)
    
    
    //Log a connoisseur out
    func revokeAuthentication() -> Void {
        authenticatedUser = nil
    }//revokeAuthentication()
}

extension Credentials: Hashable {
    var hashValue: Int {
        return username.hashValue ^ password.hashValue
    }
    
    static func == (lhs: Credentials, rhs: Credentials) -> Bool {
        return lhs.username == rhs.username && lhs.password == rhs.password
    }
}
