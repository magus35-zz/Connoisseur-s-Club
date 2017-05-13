//
//  LoginViewController.swift
//  Connoisseur Club Central
//
//  Created by Joeseidon, King of the Joecean on 5/11/17.
//  Copyright © 2017 Joeseidon, King of the Joecean. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    //MARK: Outlets
    //
    
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    
    
    //MARK: Properties
    //
    
    
    var theServer = Server.sharedInstance
    
    
    
    //MARK: View Controller methods
    //
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerSampleUsers()
    }
    
    
    
    //MARK: Actions
    //
    
    
    @IBAction func userDidTapLogin(_ sender: UIButton) {
        if inputIsValid() {
            let connoisseurCredentials = Credentials(username: usernameField.text!, password: passwordField.text!)
            if let _ = theServer.authenticateUser(withCredentials: connoisseurCredentials) {
                performSegue(withIdentifier: Constants.Segues.login, sender: nil)
            } else {
                statusLabel.text = "Please enter valid credentials"
            }
        } else {
            statusLabel.text = "Please enter username and password"
        }
        
    }
    
    
    //MARK: Helper functions
    //
    
    
    func inputIsValid() -> Bool {
        if usernameField.text == "" || passwordField.text == "" {
            return false
        } else {
            return true
        }
    }
    
    
    func registerSampleUsers() -> Void {
        var sampleCredentials:[Credentials] = []
        sampleCredentials.append(Credentials(username: "admin", password: "pass"))
        sampleCredentials.append(Credentials(username: "joeseidon", password: "notpass"))
        
        for creds in sampleCredentials {
            theServer.registerConnoisseur(withCredentials: creds)
        }
        
        let conn1 = theServer.requestConnoisseur(withCredentials: sampleCredentials[0])
        conn1?.setConnoisseurID(newID: 1000)
        conn1?.setName(newFirstName: "John", newLastName: "Smith")
        conn1?.tryBeer(withNumber: 50, rating: .Meh)
        conn1?.tryBeer(withNumber: 432, rating: .Good)
        conn1?.tryBeer(withNumber: 1111, rating: .Bad)
        conn1?.tryBeer(withNumber: 2500, rating: .Good)
    }
}
