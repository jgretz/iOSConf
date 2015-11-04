//
// Created by Joshua Gretz on 11/1/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import Foundation
import Alamofire
import Cereal

class CodeMashSessionService : NSObject, SessionService {
    var serializer:JsonCerealizer?

    func loadAll() {
        Alamofire.request(.GET, "https://cmprod-speakers.azurewebsites.net/api/sessionsdata").responseString { (response) in
            if (!response.result.isSuccess) {
                return
            }

            let json = response.result.value!
            let sessions = self.serializer!.create(Session.self, fromString: json) as! Array<Session>

            for session in sessions {
                debugPrint(session.abstract)
            }
        }
    }
}
