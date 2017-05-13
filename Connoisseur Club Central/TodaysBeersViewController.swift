//
//  TodaysBeersViewController.swift
//  Connoisseur Club Central
//
//  Created by Joeseidon, King of the Joecean on 3/30/17.
//  Copyright © 2017 Joeseidon, King of the Joecean. All rights reserved.
//

import UIKit
import Firebase
import WebKit

class TodaysBeersViewController: UIViewController, WKUIDelegate {

    //MARK: Outlets & Properties
    //
    //Outlets
    @IBOutlet weak var todaysBeersNavigationItem: UINavigationItem!
    
    //Properties
    var theServer = Server.sharedInstance
    
    
    //MARK: ViewController Methods
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let theURL = URL(string:"http://www.petesbrassrail.com/FrameSpecials.aspx")
        
        //Set up and execute web request
        //let theURL = URL(string: "https://feheroes.wiki/Main_Page")
 
    }
    
    func setUpPetesView() {
    }
    
    
}
