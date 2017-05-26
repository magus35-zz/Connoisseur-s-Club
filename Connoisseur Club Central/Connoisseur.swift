//
//  User.swift
//  Connoisseur Club Central
//
//  Created by Joeseidon, King of the Joecean on 5/10/17.
//  Copyright © 2017 Joeseidon, King of the Joecean. All rights reserved.
//

import Foundation

class Connoisseur {
    //MARK: Properties
    //
    
    
    private var beersTried:[(Int,Rating)] = []
    private var firstName:String
    private var lastName:String
    private var connoisseurID:Int
    
    static let sharedInstance = Connoisseur()
    
    
    
    //MARK: Initializers
    //
    
    
    //Initialize with name and ID
    init(firstName: String, lastName: String, connoisseurID: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.connoisseurID = connoisseurID
    } //init(name:connoisseurID:)
    
    
    //Default initializer
    init() {
        self.firstName = ""
        self.lastName = ""
        self.connoisseurID = 0
    } //init()
    
    
    
    //MARK: Accessors
    //
    
    
    //Return connoiseur's name
    func getFirstName() -> String {
        return firstName
    } //getFirstName()
    
    
    func getLastName() -> String {
        return lastName
    } //getLastName()
    
    
    //Return connoisseur's ID
    func getID() -> Int {
        return connoisseurID
    } //getID()
    
    
    //Return the number of beers the Connoisseur has tried
    func getNumberOfBeersTried() -> Int {
        return beersTried.count
    }//getNumberOfBeersTried()
    
    
    //Return whether the connoisseur has tried the beer or not
    func hasTriedBeer(withNumber number: Int) -> Bool {
        for beer in beersTried {
            if beer.0 == number {
                return true
            } //if
        } //for
        return false
    } //hasTriedBeer(withNumber:)
    
    
    //Return all beer numbers tried with the selected rating, sorted using the selected sort type
    //If rating is nil, return beers tried of all ratings
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
                } //for
            } else {
                for beer in beersTried {
                    if beer.1 == rating {
                        beerNumbers.append(beer.0)
                    } //if
                } //for
            } //if/else
            
            switch sorted {
            case .Chronologically:
                return beerNumbers
            case .Numerically:
                beerNumbers.sort()
                return beerNumbers
            } //switch
        } //if/else
    } //getAllBeerNumbersTried(sorted:withRating:)
    
    
    //Return the rating for the beer if it has been tried. If it hasn't, return nil
    func getRatingForBeer(withNumber number: Int) -> Rating? {
        for beer in beersTried {
            if beer.0 == number {
                return beer.1
            } //if
        } //for
        return nil
    } //getRatingForBeer(withNumber:)
    
    
    //Get all beers tried with their corresponding rating, in the order in which they were tried
    func getAllBeersTriedWithRating() -> [(Int,Rating)]? {
        if beersTried.isEmpty {
            return nil
        } else {
            return beersTried
        } //if/else
    } //getAllBeersTriedWithRating()
    
    
    
    //MARK: Mutators
    //
    
    
    func setName(newFirstName: String, newLastName: String) {
        firstName = newFirstName
        lastName = newLastName
    } //setName(newFirstName:newLastName:)
    
    
    func setConnoisseurID(newID: Int) {
        connoisseurID = newID
    } //setConnoisseurID(newID:)
    
    
    func tryBeer(withNumber number: Int, rating: Rating) -> Void {
        if self.hasTriedBeer(withNumber: number) {
            var loopCounter = 0
            while loopCounter < getNumberOfBeersTried() {
                if beersTried[loopCounter].0 == number {
                    beersTried[loopCounter].1 = rating
                    break
                }
                loopCounter += 1
            }
        } else {
            beersTried.append((number,rating))
        } //if/else
    } //tryBeer(withNumber:rating:)
    
}
