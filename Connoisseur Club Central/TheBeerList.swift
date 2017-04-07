//
//  TheBeerList.swift
//  Connoisseur Club Central
//
//  Created by Joeseidon, King of the Joecean on 4/7/17.
//  Copyright © 2017 Joeseidon, King of the Joecean. All rights reserved.
//

import Foundation

class TheBeerList {
    var theBeers:[Beer]
    
    
    
    init (){
        var arrayOfStrings:[String]?
        do {
            if let path = Bundle.main.path(forResource: "TheBeerList", ofType: "csv") {
                let data = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                arrayOfStrings = data.components(separatedBy: "\n")
            }
        } catch let err as NSError {
            print(err)
        }
        for beer in arrayOfStrings! {
            let beerInfo = beer.components(separatedBy: ",")
            
        }
    }
}
