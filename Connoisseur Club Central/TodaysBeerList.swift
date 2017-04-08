//
//  TodaysBeerList.swift
//  Connoisseur Club Central
//
//  Created by Joeseidon, King of the Joecean on 4/7/17.
//  Copyright © 2017 Joeseidon, King of the Joecean. All rights reserved.
//

import Foundation

class TodaysBeerList {
    var todaysBeers:[Int] = []
    
    static let sharedInstance = TodaysBeerList()
    
    init(todaysBeers: [Int]) {
        self.todaysBeers = todaysBeers
    }
    
    init() {
        self.todaysBeers = [13,50,960,1337,1782,1931,2745,2940]
    }
}
