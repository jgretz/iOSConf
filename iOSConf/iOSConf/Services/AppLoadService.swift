//
// Created by Joshua Gretz on 11/1/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import Foundation

class AppLoadService: NSObject {
    var sessionService:SessionService?

    func loadApp() {
        sessionService!.loadAll()
    }
}
