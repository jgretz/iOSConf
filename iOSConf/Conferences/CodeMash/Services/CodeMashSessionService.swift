//
// Created by Joshua Gretz on 11/1/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import Foundation
import Alamofire

class CodeMashSessionService : NSObject, SessionService {
    func getAll() -> Array<Session> {
        Alamofire.request(.GET, "https://cmprod-speakers.azurewebsites.net/api/sessionsdata").responseJSON { response in debugPrint(response) }

        return []
    }
}
