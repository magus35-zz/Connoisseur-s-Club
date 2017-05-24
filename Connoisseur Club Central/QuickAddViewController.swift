//
//  FirstViewController.swift
//  Connoisseur Club Central
//
//  Created by Joeseidon, King of the Joecean on 3/6/17.
//  Copyright © 2017 Joeseidon, King of the Joecean. All rights reserved.
//

import UIKit
import Firebase


class QuickAddViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    //****
    //MARK: Outlets
    //****
    
    
    
    @IBOutlet weak var quickAddSearchBar: UISearchBar!
    @IBOutlet weak var quickAddTable: UITableView!
    @IBOutlet weak var quickAddNavigationItem: UINavigationItem!
    
    
    
    //****
    //MARK: Properties
    //****
    
    
    
    var theServer = Server.sharedInstance
    
    //Contain the searchResults of the user's search
    var searchResults:[Beer?] = []
    
    
    
    //****
    //MARK: ViewController Maintenance
    //****
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quickAddSearchBar.keyboardType = .numberPad
        addSearchToolbar(toSearchBar: quickAddSearchBar)
        quickAddNavigationItem.title = "Quick Add"
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationController?.navigationBar.barTintColor = Constants.Colors.navigationItem
    }
    
    
    
    //****
    //MARK: Table View Methods
    //****
    
    
    
    //Set number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    
    //Create a cell for each row in table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //See if there is a search result at the index path
        if let searchResult = searchResults[indexPath.row] {
            quickAddTable.rowHeight = CGFloat(88)
            //Try to get a cell of type SearchResultTableViewCell, otherwise catch the error
            guard let cell = self.quickAddTable.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.QuickAdd, for: indexPath) as? QuickAddTableViewCell
                else {
                    fatalError("The dequeued cell is not an instance of \(Constants.CellIdentifiers.BeerListing)")
            }
            
            let userRating = theServer.requestAuthenticatedUser()?.getRatingForBeer(withNumber: searchResult.beerNumber!)
            
            cell.updateLabels(forBeer: searchResult, withRating: userRating)

            cell.ratingAction = { (cell, rating) in
                self.rateBeer(beerNumber: searchResult.beerNumber!, userRating: rating)
                let alert = UIAlertController(title: "Beer Rated!", message: nil, preferredStyle: .alert)
                let cellIndexPath = self.quickAddTable.indexPath(for: cell)
                alert.addAction(UIAlertAction(title: "Cheers!", style: .default, handler: { (action) in
                    self.searchResults.remove(at: (cellIndexPath?.row)!)
                    DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                        var pathsToUpdate:[IndexPath] = []
                        pathsToUpdate.append(cellIndexPath!)
                        self.quickAddTable.beginUpdates()
                        self.quickAddTable.deleteRows(at: pathsToUpdate, with: .right)
                        self.quickAddTable.endUpdates()
                    })
                }))
                self.present(alert, animated: true, completion: nil)
            }
            
            return cell
        } else { //If there isn't, display a message in the table
            quickAddTable.rowHeight = CGFloat(44)
            let cell = self.quickAddTable.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.FailedSearch, for: indexPath)
            cell.textLabel?.text = "No results found!"
            return cell
        }
    }
    
    
    
    //****
    //MARK: Search Toolbar Methods
    //****
    
    
    
    //Dismiss keyboard when user taps the Done button on the search field's keyboard toolbar
    func userDidPressDoneButton() -> Void {
        quickAddSearchBar.resignFirstResponder()
    }
    
    
    //Dismiss keyboard when user taps the Search button on the search field's keyboard toolbar
    func userDidPressSearchButton() -> Void {
        searchResults.removeAll()
        searchResults.append(theServer.requestBeer(withNumber: Int(quickAddSearchBar.text!)!))
        quickAddTable.reloadData()
        quickAddSearchBar.resignFirstResponder()
    }
    
    
    //Adds a search toolbar to a UISearchBar with a Done and Search button
    func addSearchToolbar(toSearchBar bar: UISearchBar) -> Void {
        let screenWidth = view.frame.width
        
        //Toolbar and its components
        let doneToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 50))
        let toolbarFlexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(QuickAddViewController.userDidPressDoneButton))
        let searchButton = UIBarButtonItem(title: "Search", style: .done, target: self, action: #selector(QuickAddViewController.userDidPressSearchButton))
        
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
    
    
    
    //****
    //MARK: Helper Functions
    //****
    
    
    
    func rateBeer(beerNumber number: Int, userRating rating: Rating) -> Void {
        let authenticatedUser = theServer.requestAuthenticatedUser()
        authenticatedUser?.tryBeer(withNumber: number, rating: rating)
    }
}

