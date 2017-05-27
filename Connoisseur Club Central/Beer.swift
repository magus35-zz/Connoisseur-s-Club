//
//  BeerListing.swift
//  Connoisseur Club Central
//
//  Created by Joeseidon, King of the Joecean on 3/6/17.
//  Copyright © 2017 Joeseidon, King of the Joecean. All rights reserved.
//

import Foundation

//Defines the properties of each beer
struct Beer {
    var beerNumber:Int?
    var beerName:String?
    var beerBrewer:String?
    
    init(beerNumber: Int, beerName: String, beerBrewer: String) {
        self.beerNumber = beerNumber
        self.beerName = beerName
        self.beerBrewer = beerBrewer
    }
}
