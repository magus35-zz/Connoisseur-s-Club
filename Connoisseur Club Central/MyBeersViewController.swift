//
//  MyBeersViewController.swift
//  Connoisseur Club Central
//
//  Created by Joeseidon, King of the Joecean on 4/3/17.
//  Copyright © 2017 Joeseidon, King of the Joecean. All rights reserved.
//

import UIKit

class MyBeersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //****
    //MARK: Outlets
    //****
    
    
    
    @IBOutlet weak var myBeersTable: UITableView!
    
    
    
    //****
    //Properties
    //****
    
    
    
    var theServer = Server.sharedInstance
    var authenticatedUser:Connoisseur = Connoisseur()
    var beersTried:[Int]!
    
    
    
    //****
    //MARK: ViewController Maintenance
    //****
    
    
    
    //Get the beers tried by the connoisseur and set up visuals
    override func viewDidLoad() {
        super.viewDidLoad()
        //Set up model
        authenticatedUser = theServer.requestAuthenticatedUser()!
        beersTried = authenticatedUser.getAllBeerNumbersTried(sorted: .Chronologically, withRating: nil)
        
        //Set up beer table
        myBeersTable.separatorColor = view.backgroundColor
        self.tabBarController?.automaticallyAdjustsScrollViewInsets = false
    }
    
    
    //Set up different visuals
    func viewWillAppear() {
        super.viewWillAppear(true)
        
        //Set up navigation item
        self.tabBarController?.navigationItem.title = "My Beers"
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.tabBarController?.navigationController?.isNavigationBarHidden = false
    }
    
    
    
    //****
    //MARK: Table View Methods
    //****
    
    
    
    //Return one section, for all beers tried
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }//numberOfSections(in:)
    
    
    //Return number of beers tried for section 0
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: //Currently only section - return number of beers tried
            if let numberOfBeersTried = beersTried?.count {
                return numberOfBeersTried
            } else { //if
                return 0
            } //else
        default:
            return 0
        }//switch
    }//tableView(_:numberOfRowsInSection:)
    
    
    //Format a cell for each beer tried
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = myBeersTable.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.BeerListing, for: indexPath) as? BeerListingTableViewCell
            else {
                fatalError("shit happened")
        }//guard-else
        
        let beerNumberForCell:Int = beersTried[indexPath.row]
        let beerForCell:Beer = theServer.requestBeer(withNumber: beerNumberForCell)!
        let beerRatingForCell:Rating = authenticatedUser.getRatingForBeer(withNumber: beerNumberForCell)!
        
        cell.selectionStyle = .none
        cell.updateLabels(forBeer: beerForCell, withRating: beerRatingForCell)
        
        return cell
    }//tableView(_:cellForRowAt:indexPath:)
}
