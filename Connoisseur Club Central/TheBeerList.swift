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
    
    
    init() {
    }
    

    

    
    
}
