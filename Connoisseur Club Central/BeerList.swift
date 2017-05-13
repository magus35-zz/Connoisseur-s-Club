//
//  BeerList.swift
//  Connoisseur Club Central
//
//  Created by Joeseidon, King of the Joecean on 5/10/17.
//  Copyright © 2017 Joeseidon, King of the Joecean. All rights reserved.
//

import Foundation

class BeerList {
    
    //MARK: Properties
    //Store the beers in a dictionary with the beer number as the key
    private var theBeers:[Int:Beer] = [:] {
        didSet { //If theBeers has been changed, update allBeersInList
            if theBeers.isEmpty {
                allBeersInList = nil
            } else {
                var newBeerList:[Beer]? = []
                for key in beerKeys {
                    newBeerList?.append(theBeers[key]!)
                }
                allBeersInList = newBeerList
            }
        }
    }
    
    private var allBeersInList:[Beer]? = []

    
    //Flag denoting whether the list has read from the CSV
    var hasReadFromCSV:Bool = false
    
    //Get the keys from the master beer list
    var beerKeys:[Int] {
        get {
            var theKeys:[Int] = []
            for key in theBeers.keys {
                theKeys.append(key)
            }
            return theKeys
        }
    }
    
    
    //MARK: Initializers
    
    //Initialize the beer list with the beers from TheBeerList.csv
    init (fromBeerList: Bool){
        readBeerFromCSV()
    }
    
    //Default initializer
    init() {
    }
    
    
    //MARK: Accessors
    //
    //Attempt to get a beer with the passed beer number
    //Returns the beer or nil if no beer is found with the beer number
    func getBeer(withNumber number: Int) -> Beer? {
        return theBeers[number]
    }
    
    //Attempt to get all beers with the passed beer numbers
    //Returns an array with results corresponding to the passed beer numbers (beer if beer is found for the number, nil if beer is not found for the number)
    func getBeers(withNumbers numbers: [Int]) -> [Beer?] {
        var beers:[Beer?] = []
        
        for number in numbers {
            beers.append(theBeers[number])
        }

        return beers
    }
    
    //Return nil if no beers in list or an array of the beers in the list
    func getAllBeersInList() -> [Beer]? {
        if theBeers.isEmpty {
            return nil
        } else {
            return allBeersInList
        }
    }

    //Return number of beers in list
    func getNumberOfBeers() -> Int {
        return theBeers.count
    }
    
    
    //MARK: Mutators:
    //
    //Clears the beer list and resets the hasReadFromCSV flag
    func clearList() -> Void {
        theBeers.removeAll()
        hasReadFromCSV = false
    }
    
    
    //MARK: Helper Functions
    
    //Reads the list of beers from TheBeerList.csv and populates them as Beer objects. Sets hasReadFromCSV flag
    func readBeerFromCSV() -> Void {
        var arrayOfStrings:[String]?
        do { //Try to get the contents of TheBeerList.csv
            if let path = Bundle.main.path(forResource: "TheBeerList", ofType: "csv") {
                let data = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                arrayOfStrings = data.components(separatedBy: "\n")
                hasReadFromCSV = true
            }
        } catch let err as NSError {
            print(err)
        }
        for beer in arrayOfStrings! { //Add the beers to the beer list
            let beerInfo = beer.components(separatedBy: ",")
            let currentBeer:Beer = Beer(beerNumber: Int(beerInfo[0])!, beerName: beerInfo[1], beerBrewer: beerInfo[2])
            theBeers[currentBeer.beerNumber!] = currentBeer
        }
    }
    
    
}
