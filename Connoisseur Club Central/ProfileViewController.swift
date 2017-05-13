//
//  ProfileViewController.swift
//  Connoisseur Club Central
//
//  Created by Joeseidon, King of the Joecean on 3/30/17.
//  Copyright © 2017 Joeseidon, King of the Joecean. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    //MARK: Outlets & Properties
    //
    
    
    //Outlets
    @IBOutlet weak var profileNavigationItem: UINavigationItem!
    @IBOutlet weak var connoisseurIDLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var beersTriedLabel: UILabel!
    
    //Properties
    var theServer = Server.sharedInstance
    
    var authenticatedUser:Connoisseur = Connoisseur()
    
    
    
    //MARK: View Controller Maintenance
    //
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        
        authenticatedUser = theServer.requestAuthenticatedUser()!
        
        updateIDLabelText(newID: String(authenticatedUser.getID()))
        updateNameLabelText(firstName: authenticatedUser.getFirstName(), lastName: authenticatedUser.getLastName())
        updateBeersTriedLabelText(newNumberTried: authenticatedUser.getNumberOfBeersTried())
    }
    
    
    //MARK: Actions
    //
    
    
    //Navigate to My Beers View
    @IBAction func userDidPressMyBeers(_ sender: Any) {
        performSegue(withIdentifier: Constants.Segues.MyBeers, sender: nil)
    }
    
    
    
    //MARK: Label Modifiers
    //
    
    
    func updateIDLabelText(newID id: String) {
        let idLength = id.characters.count
        let idString = NSMutableAttributedString(string: "Connoisseur #\(id)")
        let idRange = NSRange(location: 13, length: idLength)
        
        idString.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: idRange)
        idString.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: idRange)
        
        connoisseurIDLabel.attributedText = idString
    }
    
    
    func updateNameLabelText(firstName: String, lastName: String) {
        nameLabel.text = lastName + ", " + firstName
    }
    
    
    func updateBeersTriedLabelText(newNumberTried num: Int) {
        let numLength = String(num).characters.count
        let beerString = NSMutableAttributedString(string: "Beers: \(String(num))")
        let numRange = NSRange(location: 7, length: numLength)
        
        beerString.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: numRange)
        
        beersTriedLabel.attributedText = beerString
    }
}
