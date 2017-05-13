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

    
    //MARK: Outlets & Properties
    //
    //Outlets
    @IBOutlet weak var beerListSearchBar: UISearchBar!
    @IBOutlet weak var beerListTable: UITableView!
    @IBOutlet weak var beerListNavigationItem: UINavigationItem!
    
    //Properties
    var theServer = Server.sharedInstance
    var searchResults:BeerList = BeerList()
    
    
    //MARK: View Controller Methods
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        
        //Default search results to be all beers for testing purposes
        searchResults = theServer.requestBeerList()
    } //viewDidLoad()

    
    
    //MARK: Protocol Required Methods
    //
    
    
    //Set number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.getNumberOfBeers()
    } //tableView(_:numberOfRowsInSection:)
    
    
    //Create a cell for each row in table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Try to get a cell of type SearchResultTableViewCell, otherwise catch the error
        guard let cell = self.beerListTable.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.BeerListing, for: indexPath) as? BeerListingTableViewCell
            else {
                fatalError("The dequeued cell is not an instance of BeerListingTableViewCell")
        } //guard/else
        
        if let beerForCell = searchResults.getAllBeersInList()?[indexPath.row] { //Case that there is a search result for the given indexPath, update the cell accordingly
            
            //If the user has rated the beer in the search result, update the rating label
            if let userRating = theServer.requestAuthenticatedUser()?.getRatingForBeer(withNumber: beerForCell.beerNumber!) {
                cell.updateRatingLabel(withRating: userRating)
            } else {
                cell.updateRatingLabel(withRating: nil)
            }
            
            cell.updateBeerNumberLabel(withNumber: beerForCell.beerNumber)
            cell.updateBeerNameLabel(withName: beerForCell.beerName!, andBrewer: beerForCell.beerBrewer!)
            
        } else { //Case that there is no search result for the given indexPath (no search results), update the cell accordingly
            cell.updateBeerNameLabel(withName: "No search results", andBrewer: "")
            cell.updateRatingLabel(withRating: nil)
            cell.updateBeerNumberLabel(withNumber: nil)
        }
        
        return cell
    } //tableView(_:cellForRowAt:)

    
    //Resign first responder on search bar when search button is tapped
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    } //searchBarSearchButtonClicked(_:)

}

