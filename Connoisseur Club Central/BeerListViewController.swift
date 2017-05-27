//
//  SecondViewController.swift
//  Connoisseur Club Central
//
//  Created by Joeseidon, King of the Joecean on 3/6/17.
//  Copyright © 2017 Joeseidon, King of the Joecean. All rights reserved.
//

import UIKit

class BeerListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    //****
    //MARK: Outlets
    //****
    
    
    
    @IBOutlet weak var beerListSearchBar: UISearchBar!
    @IBOutlet weak var beerListTable: UITableView!
    @IBOutlet var tapRecognizer: UITapGestureRecognizer!
    
    
    
    //****
    //MARK: Properties
    //****
    
    
    
    var theServer = Server.sharedInstance
    var searchResults:BeerList = BeerList()
    let fullBeerList:BeerList = BeerList(fromSampleData: true)
    var selectedSearchMethod:((String) -> Void)! = nil
    /*var ratingAlertCompletionHandler:((UIAlertAction) -> Void) = { (alert) in
        self.theServer.requestAuthenticatedUser()?.tryBeer(withNumber: (beer?.beerNumber)!, rating: .Bad)
        tableView.reloadRows(at: indexPathsToUpdate, with: .none)
        tableView.deselectRow(at: indexPath, animated: false)
    }*/
    
    
    
    //****
    //MARK: View Controller Methods
    //****
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeSearchBar()
        
        //Set up table display properties
        beerListTable.estimatedRowHeight = 44.0
        beerListTable.rowHeight = UITableViewAutomaticDimension
        beerListTable.separatorColor = view.backgroundColor
    
        self.automaticallyAdjustsScrollViewInsets = true
    } //viewDidLoad()

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        //Set up navigation item
        self.tabBarController?.navigationItem.title = "Beer List"
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.tabBarController?.navigationController?.isNavigationBarHidden = false
        
        //Set up beer table
        beerListTable.reloadData()
    }//viewDidAppear()
    
    
    
    //****
    //MARK: Table View Methods
    //****
    
    
    
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
        
        cell.selectionStyle = .none
        
        
        if let beerForCell = searchResults.getAllBeersInList()?[indexPath.row] { //Case that there is a search result for the given indexPath, update the cell accordingly
            
            //If the user has rated the beer in the search result, update the rating label
            let userRating = theServer.requestAuthenticatedUser()?.getRatingForBeer(withNumber: beerForCell.beerNumber!)
            
            cell.updateLabels(forBeer: beerForCell, withRating: userRating)
            
        } else { //Case that there is no search result for the given indexPath (no search results), update the cell accordingly
            cell.updateBeerNameLabel(withName: "No search results", andBrewer: "")
            cell.updateRatingLabel(withRating: nil)
            cell.updateBeerNumberLabel(withNumber: nil)
        }
        
        return cell
    } //tableView(_:cellForRowAt:)
    
    
    
    //****
    //MARK: Search Bar Methods
    //****
    
    
    
    //Resign first responder on search bar when search button is tapped
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    } //searchBarSearchButtonClicked(_:)

    
    //Add the search toolbar to the keyboard when the scope == 0 (search by beer number), otherwise use the default search bar keyboard.
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0: //User selected number
            searchBar.keyboardType = .numberPad
            addSearchToolbar(toSearchBar: searchBar)
            searchBar.reloadInputViews()
        case 1: //User selected brewer
            searchBar.keyboardType = .default
            removeSearchToolbar(fromSearchBar: searchBar)
            selectedSearchMethod = {(brewer) in
                self.searchByBeerBrewer(beerBrewer: brewer)
            }
            searchBar.reloadInputViews()
        case 2: //User selected name
            searchBar.keyboardType = .default
            selectedSearchMethod = {(query) in
                self.searchByBeerName(beerName: query)
            }
            removeSearchToolbar(fromSearchBar: searchBar)
            searchBar.reloadInputViews()
        default:
            break
        }
    }
    

    //Sets the search bar to an appropriate default state
    func initializeSearchBar() -> Void {
        beerListSearchBar.selectedScopeButtonIndex = 0
        beerListSearchBar.keyboardType = .numberPad
        addSearchToolbar(toSearchBar: beerListSearchBar)
        beerListSearchBar.reloadInputViews()
    }
    
    
    
    //****
    //MARK: Search Toolbar Methods
    //****
    
    
    
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
        //let doneButton = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(BeerListViewController.userDidPressDoneButton))
        let searchButton = UIBarButtonItem(title: "Search", style: .done, target: self, action: #selector(BeerListViewController.userDidPressSearchButton))
        
        //Put toolbar items together into array
        var toolbarItems = [UIBarButtonItem]()
        //toolbarItems.append(doneButton)
        toolbarItems.append(toolbarFlexSpace)
        toolbarItems.append(searchButton)
        
        //Put the toolbar items in the toolbar and make sure it is sized appropriately
        doneToolbar.items = toolbarItems
        doneToolbar.sizeToFit()
        
        //Add the toolbar to the searchbar
        bar.inputAccessoryView = doneToolbar
    }//addSearchToolbar(toSearchBar:)
    
    
    //Remove any toolbar from a search bar
    func removeSearchToolbar(fromSearchBar bar: UISearchBar) -> Void {
        bar.inputAccessoryView = nil
    }//removeSearchToolbar(fromSearchBar:)
    
    
    
    //****
    //MARK: Search Bar Delegate Methods
    //****
    
    
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        beerListSearchBar.showsScopeBar = false
        beerListSearchBar.showsCancelButton = false
        if beerListSearchBar.selectedScopeButtonIndex != 0 && beerListSearchBar.text != "" {
            selectedSearchMethod(searchBar.text!)
        }
        //tapRecognizer = nil
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //let newRecognizer = UITapGestureRecognizer(target: self.view, action: #selector(BeerListViewController.resignFirstResponderOnTap))
        //tapRecognizer = newRecognizer
        beerListSearchBar.showsScopeBar = true
        beerListSearchBar.showsCancelButton = true

    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        beerListSearchBar.text = ""
        beerListSearchBar.resignFirstResponder()
        beerListTable.reloadData()
    }
    
    
    
    //****
    //MARK: Search Methods
    //****
    
    
    
    func searchByBeerName(beerName: String) -> Void {
        searchResults.clearList()
        let allBeerNumbers = fullBeerList.beerKeys
        
        for number in allBeerNumbers {
            let resultCandidate = fullBeerList.getBeer(withNumber: number)
            let resultCandidateName = (resultCandidate?.beerName?.uppercased())!
            if resultCandidateName.contains(beerName.uppercased()) {
                searchResults.addBeer((number,resultCandidate!))
            }
        }
        beerListTable.reloadData()
    }
    
    func searchByBeerBrewer(beerBrewer: String) -> Void {
        searchResults.clearList()
        let allBeerNumbers = fullBeerList.beerKeys
        
        for number in allBeerNumbers {
            let resultCandidate = fullBeerList.getBeer(withNumber: number)
            let resultCandidateName = (resultCandidate?.beerBrewer?.uppercased())!
            if resultCandidateName.contains(beerBrewer.uppercased()) {
                searchResults.addBeer((number,resultCandidate!))
            }
        }
        beerListTable.reloadData()
    }
    
    
    
    //****
    //MARK: Other Actions
    //****
    
    
    
    //Resign first responder on tap
    @IBAction func userDidTap(_ sender: UITapGestureRecognizer) {
        if beerListSearchBar.isFirstResponder { //If the search bar is first responder, resign it from being first responder
            beerListSearchBar.resignFirstResponder()
        } else if searchResults.getNumberOfBeers() != 0 { //If the search bar is not first responder and there are search results, try to figure out which cell was tapped
            let tapLocation = sender.location(in: beerListTable)
            if let tappedIndexPath = beerListTable.indexPathForRow(at: tapLocation) {
                let beer = self.searchResults.getAllBeersInList()?[tappedIndexPath.row]
                var indexPathsToUpdate:[IndexPath] = []
                indexPathsToUpdate.append(tappedIndexPath)
                
                let alert = UIAlertController(title: "Rate \((beer?.beerBrewer)!) \((beer?.beerName)!)", message: nil, preferredStyle: .actionSheet)
                
                alert.addAction(UIAlertAction(title: "Love 😍", style: .default, handler: { (alert) in
                    self.theServer.requestAuthenticatedUser()?.tryBeer(withNumber: (beer?.beerNumber)!, rating: .Love)
                    self.beerListTable.reloadRows(at: indexPathsToUpdate, with: .none)
                }))
                alert.addAction(UIAlertAction(title: "Good 🙂", style: .default, handler: { (alert) in
                    self.theServer.requestAuthenticatedUser()?.tryBeer(withNumber: (beer?.beerNumber)!, rating: .Good)
                    self.beerListTable.reloadRows(at: indexPathsToUpdate, with: .none)
                    
                }))
                alert.addAction(UIAlertAction(title: "Meh 😕", style: .default, handler: { (alert) in
                    self.theServer.requestAuthenticatedUser()?.tryBeer(withNumber: (beer?.beerNumber)!, rating: .Meh)
                    self.beerListTable.reloadRows(at: indexPathsToUpdate, with: .none)
                    
                }))
                alert.addAction(UIAlertAction(title: "Bad ☹️", style: .default, handler: { (alert) in
                    self.theServer.requestAuthenticatedUser()?.tryBeer(withNumber: (beer?.beerNumber)!, rating: .Bad)
                    self.beerListTable.reloadRows(at: indexPathsToUpdate, with: .none)
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                
                
                present(alert, animated: true, completion: nil)
            }
        }
    }
}

