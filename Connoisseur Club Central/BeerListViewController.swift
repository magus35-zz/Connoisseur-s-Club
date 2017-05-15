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
        
        initializeSearchBar()
        //Default search results to be all beers for testing purposes
        searchResults = theServer.requestBeerList()
    } //viewDidLoad()

    
    
    //MARK: Table View Methods
    //
    
    
    //Set number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchResults.getNumberOfBeers() == 0 { //If there are no search results, there will only be one "no search results found" cell
            return 1
        } else { //If there are search results, there will be as many cells as there are search results
            return searchResults.getNumberOfBeers()
        }
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

    
    
    //MARK: Search Bar Methods
    //
    
    
    //Resign first responder on search bar when search button is tapped
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    } //searchBarSearchButtonClicked(_:)

    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0: //User selected number
            searchBar.keyboardType = .numberPad
            addSearchToolbar(toSearchBar: searchBar)
            searchBar.reloadInputViews()
        case 1: //User selected brewer
            searchBar.keyboardType = .default
            removeSearchToolbar(fromSearchBar: searchBar)
            searchBar.reloadInputViews()
        case 2: //User selected name
            searchBar.keyboardType = .default
            removeSearchToolbar(fromSearchBar: searchBar)
            searchBar.reloadInputViews()
        default:
            break
        }
    }
    
    
    func initializeSearchBar() -> Void {
        beerListSearchBar.selectedScopeButtonIndex = 0
        beerListSearchBar.keyboardType = .numberPad
        addSearchToolbar(toSearchBar: beerListSearchBar)
        beerListSearchBar.reloadInputViews()
    }
    
    
    //MARK: Search Toolbar Methods
    //
    
    
    //Dismiss keyboard when user taps the Done button on the search field's keyboard toolbar
    func userDidPressDoneButton() -> Void {
        beerListSearchBar.resignFirstResponder()
    }
    
    
    //Dismiss keyboard when user taps the Search button on the search field's keyboard toolbar
    func userDidPressSearchButton() -> Void {
        searchResults.clearList()
        if let searchResult = theServer.requestBeer(withNumber: Int(beerListSearchBar.text!)!) {
            searchResults.addBeer((searchResult.beerNumber!, searchResult))
        }
        beerListTable.reloadData()
        beerListSearchBar.resignFirstResponder()
    }
    
    
    //Adds a search toolbar to a UISearchBar with a Done and Search button
    func addSearchToolbar(toSearchBar bar: UISearchBar) -> Void {
        let screenWidth = view.frame.width
        
        //Toolbar and its components
        let doneToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 50))
        let toolbarFlexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(BeerListViewController.userDidPressDoneButton))
        let searchButton = UIBarButtonItem(title: "Search", style: .done, target: self, action: #selector(BeerListViewController.userDidPressSearchButton))
        
        //Put toolbar items together into array
        var toolbarItems = [UIBarButtonItem]()
        toolbarItems.append(doneButton)
        toolbarItems.append(toolbarFlexSpace)
        toolbarItems.append(searchButton)
        
        //Put the toolbar items in the toolbar and make sure it is sized appropriately
        doneToolbar.items = toolbarItems
        doneToolbar.sizeToFit()
        
        //Add the toolbar to the searchbar
        bar.inputAccessoryView = doneToolbar
    }//addSearchToolbar(toSearchBar:)
    
    func removeSearchToolbar(fromSearchBar bar: UISearchBar) -> Void {
        bar.inputAccessoryView = nil
    }
}

