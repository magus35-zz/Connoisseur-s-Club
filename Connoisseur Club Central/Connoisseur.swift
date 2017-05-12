//
//  User.swift
//  Connoisseur Club Central
//
//  Created by Joeseidon, King of the Joecean on 5/10/17.
//  Copyright © 2017 Joeseidon, King of the Joecean. All rights reserved.
//

import Foundation

enum Rating {
    case Meh
    case Good
    case Love
}

enum SortType {
    case ChronologicallyTried
    case Numerically
}

class Connoisseur {
    
    //MARK: Properties
    private var beersTried:[(Int,Rating)] = []
    private var name:String
    private var connoisseurID:Int
    
    static let sharedInstance = Connoisseur()
    
    
    //MARK: Initializers
    init(name: String, connoisseurID: Int) {
        self.name = name
        self.connoisseurID = connoisseurID
    }
    
    init() {
        self.name = ""
        self.connoisseurID = 0
    }
    
    //MARK: Accessors
    
    func getName() -> String {
        return name
    }
    
    func getID() -> Int {
        return connoisseurID
    }
    
    //Return whether th
    func hasTriedBeer(withNumber number: Int) -> Bool {
        for beer in beersTried {
            if beer.0 == number {
                return true
            }
        }
        return false
    }
    
    //Get all beer numbers tried with the selected rating, sorted using the selected sort type
    func getAllBeerNumbersTried(sorted: SortType, withRating rating: Rating?) -> [Int]? {

        //If the connoisseur hasn't tried any beers, return nil
        //Otherwise, get the beers with the selected rating sorted in the selected method
        if beersTried.isEmpty {
            return nil
        } else {
            var beerNumbers:[Int] = []
            
            
            //Get the beers with the selected rating
            //If nil, get all beers
            if rating == nil {
                for beer in beersTried {
                    beerNumbers.append(beer.0)
                }
            } else {
                for beer in beersTried {
                    if beer.1 == rating {
                        beerNumbers.append(beer.0)
                    }
                }
            }
            
            switch sorted {
            case .ChronologicallyTried:
                return beerNumbers
            case .Numerically:
                beerNumbers.sort()
                return beerNumbers
            }
            
        }
    }
    
    //Get all beers tried with their corresponding rating, in the order in which they were tried
    func getAllBeersTriedWithRating() -> [(Int,Rating)]? {
        if beersTried.isEmpty {
            return nil
        } else {
            return beersTried
        }
    }
    
    //MARK: Mutators
    func tryBeer(withNumber number: Int, rating: Rating) -> Bool {
        if self.hasTriedBeer(withNumber: number) {
            return false
        } else {
            beersTried.append((number,rating))
            return true
        }
    }
    
}
