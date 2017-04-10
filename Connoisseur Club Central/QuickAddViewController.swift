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

    //MARK: Properties
    @IBOutlet weak var quickAddSearchBar: UISearchBar!
    @IBOutlet weak var quickAddTable: UITableView!
    
    
    //Contain the searchResults of the user's search
    var searchResults:[Beer] = []
    
    
    //MARK: ViewController Maintenance
    override func viewDidLoad() {
        super.viewDidLoad()
        //Sample data for #testing
        searchResults.append(Beer(beerWasTried: true, beerNumber: 1234, beerName: "good beer", beerBrewer: ""))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    //MARK: Protocol Required Methods
    
    //Set number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    //Create a cell for each row in table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Try to set the cell, otherwise catch the error
        guard let cell = self.quickAddTable.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.SearchResult, for: indexPath) as? SearchResultTableViewCell
            else {
                fatalError("The dequeued cell is not an instance of \(Constants.CellIdentifiers.SearchResult)")
        }
        
        //Format cell
        let theBeer = searchResults[indexPath.row]
        cell.searchResultLabel.text = "\(theBeer.beerName!), \(theBeer.beerNumber!), \(theBeer.beerWasTried!)"
        
        return cell
    }
    
    //Resign first responder on search bar when search button is tapped
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

