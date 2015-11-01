//
//  ViewController.swift
//  iOSConf
//
//  Created by Joshua Gretz on 10/31/15.
//  Copyright © 2015 Truefit. All rights reserved.
//

import UIKit
import CoreMeta

class LoadingVC: BaseVC {
    var loader: AppLoadService!

    override func viewDidLoad() {
        super.viewDidLoad()

        loader.loadApp()
    }
}

