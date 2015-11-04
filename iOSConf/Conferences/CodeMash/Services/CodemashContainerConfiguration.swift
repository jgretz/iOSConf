//
// Created by Joshua Gretz on 11/1/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import Foundation
import Cereal

class CodemashContainerConfiguration: NSObject, ContainerConfiguration {
    func configure() {
        CodeMashSessionService.registerClassAsProtocol(SessionService.self)

        JsonCerealizer.register()
    }
}
