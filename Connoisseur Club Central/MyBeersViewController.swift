//
//  MyBeersViewController.swift
//  Connoisseur Club Central
//
//  Created by Joeseidon, King of the Joecean on 4/3/17.
//  Copyright © 2017 Joeseidon, King of the Joecean. All rights reserved.
//

import UIKit
import Firebase

class MyBeersViewController: UIViewController, UISearchBarDelegate {

    //Outlets & Properties
    //
    //Outlets
    
    //Properties
    var theServer = Server.sharedInstance
    
    //MARK: ViewController Maintenance
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //MARK: Actions
    
    //Resign first responder when search bar is tapped
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
}
