//
//  TodaysBeersViewController.swift
//  Connoisseur Club Central
//
//  Created by Joeseidon, King of the Joecean on 3/30/17.
//  Copyright © 2017 Joeseidon, King of the Joecean. All rights reserved.
//

import UIKit
import Firebase

class TodaysBeersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: Properties
    @IBOutlet weak var beerTable: UITableView!
    
    var allTheBeers = TheBeerList.sharedInstance
    var todaysBeers = TodaysBeerList.sharedInstance
    
    //Daaaa beers (of the day)
    var daBeers = [Beer]()

    
    //MARK: ViewController Maintenance
    override func viewDidLoad() {
        super.viewDidLoad()
        for beerNumber in todaysBeers.todaysBeers {
            daBeers.append(allTheBeers.theBeers[beerNumber]!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //MARK: Protocol Required Methods
    
    //Set number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.daBeers.count
    }
    
    //Create a cell for each row in table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Try to get a cell of type SearchResultTableViewCell, otherwise catch the error
        guard let cell = self.beerTable.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.BeerListing, for: indexPath) as? BeerListingTableViewCell
            else {
                fatalError("The dequeued cell is not an instance of BeerListingTableViewCell")
        }
        
        //Fetch appropriate beer and populate cell with data
        let listing = daBeers[indexPath.row]
        
        
        //Populate cell with data
        if listing.beerWasTried == true {
            cell.beerWasTriedLabel.text = "✅"
        } else {
            cell.beerWasTriedLabel.text = ""
        }
        cell.beerNumberLabel.text = "#\(listing.beerNumber!)"
        cell.beerNameLabel.text = listing.beerName
        
        return cell
    }
}
