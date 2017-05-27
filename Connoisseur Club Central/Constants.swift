//
//  Constants.swift
//  Connoisseur Club Central
//
//  Created by Joeseidon, King of the Joecean on 4/10/17.
//  Copyright © 2017 Joeseidon, King of the Joecean. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    struct CellIdentifiers {
        static let BeerListing = "BeerListingTableViewCell"
        static let QuickAdd = "QuickAddTableViewCell"
        static let FailedSearch = "SearchFailedTableViewCell"
        
    }
    struct Segues {
        static let MyBeers = "showMyBeersSegue"
        static let login = "loginSegue"
    }
    struct Colors {
        static let navigationItem = UIColor(red: CGFloat(0.47), green: CGFloat(0.72), blue: CGFloat(0.67), alpha: 1)//UIColor(colorLiteralRed: Float(120), green: Float(184), blue: Float(171), alpha: 1)
        static let loginLabel = UIColor(colorLiteralRed: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        
    }
}

enum Rating:String {
    case Bad
    case Meh
    case Good
    case Love
}

enum SortType {
    case Chronologically
    case Numerically
}
