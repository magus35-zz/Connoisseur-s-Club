//
//  BeerListingTableViewCell.swift
//  Connoisseur Club Central
//
//  Created by Joeseidon, King of the Joecean on 3/6/17.
//  Copyright © 2017 Joeseidon, King of the Joecean. All rights reserved.
//

import UIKit

class BeerListingTableViewCell: UITableViewCell {
    //****
    //MARK: Outlets
    //****
    
    
    
    @IBOutlet weak var beerNumberLabel: UILabel!
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var beerRatingLabel: UILabel!
    
    
    
    //****
    //MARK: View Maintenance
    //****
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    //****
    //MARK: Mutators
    //****
    
    
    
    //Update all of the labels of the cell
    func updateLabels(forBeer beer: Beer, withRating rating: Rating?) -> Void {
        updateBeerNumberLabel(withNumber: beer.beerNumber)
        updateBeerNameLabel(withName: beer.beerName!, andBrewer: beer.beerBrewer!)
        updateRatingLabel(withRating: rating)
    }//updateLabels(forBeer:withRating:)
    
    
    //If the connoisseur has rated the beer, add the rating to the cell. Otherwise, don't.
    func updateRatingLabel(withRating rating: Rating?) -> Void {
        if let userRating = rating {
            switch userRating {
            case .Bad:
                beerRatingLabel.text = "☹️"
            case .Meh:
                beerRatingLabel.text = "😕"
            case .Good:
                beerRatingLabel.text = "🙂"
            case .Love:
                beerRatingLabel.text = "😍"
            }
        } else {
            beerRatingLabel.text = ""
        }
        
    }
    
    func updateBeerNumberLabel(withNumber num: Int?) -> Void {
        if num != nil {
            beerNumberLabel.text = "\(num!)"
        } else {
            beerNumberLabel.text = ""
        }
    }
    
    func updateBeerNameLabel(withName name:String, andBrewer brewer:String) -> Void {
        beerNameLabel.text = brewer + " " + name
    }
}
