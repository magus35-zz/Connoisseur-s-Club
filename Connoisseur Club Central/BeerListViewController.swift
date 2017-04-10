//
//  SecondViewController.swift
//  Connoisseur Club Central
//
//  Created by Joeseidon, King of the Joecean on 3/6/17.
//  Copyright © 2017 Joeseidon, King of the Joecean. All rights reserved.
//

import UIKit
import Firebase

class BeerListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var beerListSearchBar: UISearchBar!
    @IBOutlet weak var searchTypeSelector: UISegmentedControl!
    @IBOutlet weak var beerListTable: UITableView!
    
    //Singleton for the whole beer list
    var beerList = TheBeerList.sharedInstance
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.beerList.theBeers.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Get a cell of type BeerListingTableViewCell
        guard let cell = self.beerListTable.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.BeerListing, for: indexPath) as? BeerListingTableViewCell
            else {
                fatalError("The dequeued cell is not an instance of BeerListingTableViewCell")
        }
        
        //Fetch the appropriate beer from the beer list
        let listing = beerList.theBeers[beerList.beerKeys[indexPath.row]]!
        
        
        //Populate the cell
        if listing.beerWasTried == true {
            cell.beerWasTriedLabel.text = "✅"
        } else {
            cell.beerWasTriedLabel.text = ""
        }
        cell.beerNumberLabel.text = "#\(listing.beerNumber!)"
        cell.beerNameLabel.text = listing.beerName
        
        return cell
    }

    //Resign first responder when search bar is tapped
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

}

