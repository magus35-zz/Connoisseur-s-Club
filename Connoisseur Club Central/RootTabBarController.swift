//
//  RootTabBarController.swift
//  Connoisseur Club Central
//
//  Created by Joeseidon, King of the Joecean on 5/12/17.
//  Copyright © 2017 Joeseidon, King of the Joecean. All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers?[0].navigationItem.title = "Quick Add"
        viewControllers?[1].navigationItem.title = "Beer List"
        viewControllers?[2].navigationItem.title = "Today's Beers"
        viewControllers?[3].navigationItem.title = "Profile"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
