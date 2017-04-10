//
//  FirstViewController.swift
//  Connoisseur Club Central
//
//  Created by Joeseidon, King of the Joecean on 3/6/17.
//  Copyright © 2017 Joeseidon, King of the Joecean. All rights reserved.
//

import UIKit

class QuickAddViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var quickAddSearchBar: UISearchBar!
    @IBOutlet weak var quickAddTable: UITableView!
    
    
    var searchResults:[Beer] = []
    
    
    let cellReuseIdentifier = "SearchResultTableViewCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchResults.append(Beer(beerWasTried: true, beerNumber: 1234, beerName: "good beer", beerBrewer: ""))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let cell = self.quickAddTable.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? SearchResultTableViewCell
            else {
                fatalError("The dequeued cell is not an instance of SearchResultTableViewCell")
        }
        
        let theBeer = searchResults[indexPath.row]
        cell.searchResultLabel.text = "\(theBeer.beerName!), \(theBeer.beerNumber!), \(theBeer.beerWasTried!)"
        
        return cell
    }
    
    //Resign first responder on search barwhen search bar is tapped
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

