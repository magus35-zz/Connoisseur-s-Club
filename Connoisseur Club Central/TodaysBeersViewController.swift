//
//  TodaysBeersViewController.swift
//  Connoisseur Club Central
//
//  Created by Joeseidon, King of the Joecean on 3/30/17.
//  Copyright © 2017 Joeseidon, King of the Joecean. All rights reserved.
//

import UIKit

class TodaysBeersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //Outlet for the Table View
    @IBOutlet weak var beerTable: UITableView!
    
    //Beer List Singleton
    var allTheBeers = TheBeerList.sharedInstance
    var todaysBeers = TodaysBeerList.sharedInstance
    
    
    //List of today's beers
    var daBeers = [Beer]()

    
    //This is a change
    
    //Reuse cell ID constant
    let cellReuseIdentifier = "BeerListingTableViewCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for beerNumber in todaysBeers.todaysBeers {
            daBeers.append(allTheBeers.theBeers[beerNumber]!)
        }
        
        loadSampleBeerListings()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.daBeers.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        guard let cell = self.beerTable.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? BeerListingTableViewCell
            else {
                fatalError("The dequeued cell is not an instance of BeerListingTableViewCell")
        }
        
        
        let listing = daBeers[indexPath.row]
        // Configure the cell...
        if listing.beerWasTried == true {
            cell.beerWasTriedLabel.text = "✅"
        } else {
            cell.beerWasTriedLabel.text = ""
        }
        cell.beerNumberLabel.text = "#\(listing.beerNumber!)"
        cell.beerNameLabel.text = listing.beerName
        
        return cell
    }
    
    /*
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    private func loadSampleBeerListings() {
        let listing1 = Beer(beerWasTried: true, beerNumber: 1, beerName: "Beer Name", beerBrewer: "")
        let listing2 = Beer(beerWasTried: false, beerNumber: 9999, beerName: "This is a longer beer name", beerBrewer: "")
        
        daBeers += [listing1,listing2]
    }


}
