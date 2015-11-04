//
// Created by Joshua Gretz on 11/1/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import Foundation
import Cereal

class Session: NSObject, Decerealizable {
    var abstract: String?
    var category: String?
    var id: Int?
    var sessionType: String?
    var speakers: Array<Speaker>?
    var tags: Array<String>?
    var sessionTime: NSDate?
    var sessionStartTime: NSDate?
    var sessionEndTime: NSDate?

    //*****************
    // Deserialization
    //*****************

    func typeFor(propertyName: String, value: AnyObject?) -> AnyClass {
        switch propertyName {
        case "speakers":
            return Speaker.self
        default:
            if (value != nil) {
                return value!.dynamicType
            }
            return NSObject.self
        }
    }

    func shouldDeserializeProperty(propertyName: String) -> Bool {
        return true
    }

    func overrideDeserializeProperty(propertyName: String, value: AnyObject?) -> Bool {
        return [ "sessionTime", "sessionStartTime", "sessionEndTime" ].any({$0 == propertyName})
    }

    func deserializeProperty(propertyName: String, value: AnyObject?) {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-dd-mm HH:mm:ss"

        let cleanString = (value as! String).stringByReplacingOccurrencesOfString("T", withString: " ")
        let time = formatter.dateFromString(cleanString)

        if (time != nil) {
            self.setValue(time, forKey: propertyName)
        }
    }
}
