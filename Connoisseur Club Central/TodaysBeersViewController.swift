//
//  TodaysBeersViewController.swift
//  Connoisseur Club Central
//
//  Created by Joeseidon, King of the Joecean on 3/30/17.
//  Copyright © 2017 Joeseidon, King of the Joecean. All rights reserved.
//

import UIKit
import WebKit

class TodaysBeersViewController: UIViewController, WKUIDelegate {
    //****
    //MARK: Outlets
    //****
    

    
    @IBOutlet weak var todaysBeersNavigationItem: UINavigationItem!
    @IBOutlet var containerView : UIView! = nil
    
    

    //****
    //MARK: Properties
    //****
    
    
    
    var theServer = Server.sharedInstance
    var webView: WKWebView?
    
    
    
    //****
    //MARK: View Controller Maintenance
    //****
    
    
    
    //Create a webview and set it to a view
    override func loadView() {
        super.loadView()
        
        self.webView = WKWebView()
        self.view = self.webView!
    }
    
    
    //Set up the URL request and have the web view execute web request
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string:"http://www.petesbrassrail.com/FrameSpecials.aspx")
        let req = URLRequest(url:url!)
        self.webView!.load(req as URLRequest)
        
        self.navigationController?.navigationBar.barTintColor = Constants.Colors.navigationItem
    }
}
