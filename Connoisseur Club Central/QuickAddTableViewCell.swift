//
//  QuickAddTableViewCell.swift
//  Connoisseur Club Central
//
//  Created by Joeseidon, King of the Joecean on 5/21/17.
//  Copyright © 2017 Joeseidon, King of the Joecean. All rights reserved.
//

import UIKit

class QuickAddTableViewCell: BeerListingTableViewCell {
    //****
    //MARK: Properties
    //****
    
    
    var beerNumber:Int?
    var ratingAction: ((BeerListingTableViewCell, Rating) -> Void)?
    @IBOutlet weak var buttonStack: UIStackView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func userTappedRating(_ sender: UIButton!) {
        
        if let title = sender.currentTitle { //Extra validation to make sure that the correct action is being performed
            switch title {
            case "☹️":
                print(title)
                ratingAction?(self, .Bad)
                break
            case "😕":
                print(title)
                ratingAction?(self, .Meh)
                break
            case "🙂":
                print(title)
                ratingAction?(self, .Good)
                break
            case "😍":
                print(title)
                ratingAction?(self, .Love)
                break
            default:
                break
            }
        }
        
    }
    
}
