//
//  ViewController.swift
//  SportMoji
//
//  Created by Taylor Perkins on 6/3/15.
//  Copyright (c) 2015 hwrdrpkns. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func goToSettingsClicked(sender: UIButton) {
        let application = UIApplication.sharedApplication()
        application.openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
    }
}

