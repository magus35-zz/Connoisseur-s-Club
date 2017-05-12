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
    @IBOutlet weak var profileNavigationItem: UINavigationItem!
    
    
    //MARK: ViewController Maintenance
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        profileNavigationItem.title = "Profile"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //MARK: Actions
    //
    
    //Navigate to My Beers View
    @IBAction func userDidPressMyBeers(_ sender: Any) {
        performSegue(withIdentifier: Constants.Segues.MyBeers, sender: nil)
    }
}
