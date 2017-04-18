//
//  TheBeerList.swift
//  Connoisseur Club Central
//
//  Created by Joeseidon, King of the Joecean on 4/7/17.
//  Copyright © 2017 Joeseidon, King of the Joecean. All rights reserved.
//

import Foundation

class TheBeerList {
    var theBeers:[Int:Beer] = [:]
    
    var theBeers2:[String:[String:String]] = [:]
    
    
    
    var beerKeys:[Int] {
        get {
            var theKeys:[Int] = []
            for key in theBeers.keys {
                theKeys.append(key)
            }
            return theKeys
        }
    }
    
    static let sharedInstance = TheBeerList()
    
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
            let currentBeer:Beer = Beer(beerNumber: Int(beerInfo[0])!, beerName: beerInfo[1], beerBrewer: beerInfo[2])
            theBeers[currentBeer.beerNumber!] = currentBeer
        }
    }
}
