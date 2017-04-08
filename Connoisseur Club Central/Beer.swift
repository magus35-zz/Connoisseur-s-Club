//
//  BeerListing.swift
//  Connoisseur Club Central
//
//  Created by Joeseidon, King of the Joecean on 3/6/17.
//  Copyright © 2017 Joeseidon, King of the Joecean. All rights reserved.
//

import Foundation

class Beer {
    var beerWasTried:Bool?
    var beerNumber:Int?
    var beerName:String?
    var beerBrewer:String?
    
    init(beerWasTried: Bool, beerNumber: Int, beerName: String, beerBrewer: String) {
        self.beerWasTried = beerWasTried
        self.beerNumber = beerNumber
        self.beerName = beerName
        self.beerBrewer = beerBrewer
    }
}
