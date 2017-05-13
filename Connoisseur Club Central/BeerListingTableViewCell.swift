//
//  BeerListingTableViewCell.swift
//  Connoisseur Club Central
//
//  Created by Joeseidon, King of the Joecean on 3/6/17.
//  Copyright © 2017 Joeseidon, King of the Joecean. All rights reserved.
//

import UIKit

class BeerListingTableViewCell: UITableViewCell {

    @IBOutlet weak var beerNumberLabel: UILabel!
    @IBOutlet weak var beerNameLabel: UILabel!
    @IBOutlet weak var beerRatingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateRatingLabel(withRating rating: Rating?) -> Void {
        if let userRating = rating {
            switch userRating {
            case .Bad:
                beerRatingLabel.textColor = .red
            case .Meh:
                beerRatingLabel.textColor = .yellow
            case .Good:
                beerRatingLabel.textColor = .blue
            case .Love:
                beerRatingLabel.textColor = .green
            }
            beerRatingLabel.text = userRating.rawValue
        } else {
            beerRatingLabel.textColor = .white
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
