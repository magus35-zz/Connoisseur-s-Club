//
//  LoginViewController.swift
//  Connoisseur Club Central
//
//  Created by Joeseidon, King of the Joecean on 5/11/17.
//  Copyright © 2017 Joeseidon, King of the Joecean. All rights reserved.
//

import UIKit
import Firebase

//Define a notification name used for listening to logout requests
extension Notification.Name {
    static let requestLogout = Notification.Name("RequestLogOut")
}


class LoginViewController: UIViewController, UITextFieldDelegate {
    //****
    //MARK: Outlets
    //****
    
    
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    
    
    
    
    //****
    //MARK: Properties
    //****
    
    
    
    var ref: DatabaseReference!
    var theServer = Server.sharedInstance
    
    
    
    //****
    //MARK: View Controller Methods
    //****
    
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerSampleUsers()
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveRequestForLogout(notification:)), name: .requestLogout, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.navigationBar.barTintColor = Constants.Colors.navigationItem
    }
    
    
    
    //****
    //MARK: Text Field Methods
    //****
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            if inputIsValid() {
                let connoisseurCredentials = Credentials(username: usernameField.text!, password: passwordField.text!)
                if let _ = theServer.authenticateUser(withCredentials: connoisseurCredentials) {
                    statusLabel.text = ""
                    statusLabel.backgroundColor = UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0)
                    performSegue(withIdentifier: Constants.Segues.login, sender: nil)
                } else {
                    statusLabel.text = "Please enter valid credentials"
                    statusLabel.backgroundColor = Constants.Colors.loginLabel
                }
            } else {
                statusLabel.text = "Please enter username and password"
                statusLabel.backgroundColor = Constants.Colors.loginLabel
            }
        }
        textField.resignFirstResponder()
        return true
    }
    
    
    
    //****
    //MARK: Actions
    //****
    
    
    
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
    
    
    @IBAction func userDidThing(_ sender: Any) {
        let username = usernameField.text!
        self.ref.child("users").child(username).setValue("value")
    }
    
    
    
    //****
    //MARK: Helper functions
    //****
    
    
    
    func inputIsValid() -> Bool {
        if usernameField.text == "" || passwordField.text == "" {
            return false
        } else {
            return true
        }
    }
    
    func didReceiveRequestForLogout(notification: Notification) -> Void {
        navigationController?.popToRootViewController(animated: true)
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
        conn1?.tryBeer(withNumber: 1734, rating: .Love)
    }
}
