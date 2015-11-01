//
// Created by Joshua Gretz on 11/1/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import UIKit
import CoreMeta

class BaseVC : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.inject()
    }
}
