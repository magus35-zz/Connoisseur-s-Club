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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Resign first responder when search bar is tapped
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
