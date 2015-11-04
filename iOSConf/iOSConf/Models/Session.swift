//
// Created by Joshua Gretz on 11/1/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import Foundation
import Cereal

class Session: NSObject, Cerealizable {
    var abstract: String?
    var category: String?
    var id: Int?
    var sessionType: String?
    var speakers: Array<Speaker>?
    var tags: Array<String>?

    //***************
    // Serialization
    //***************

    func shouldSerializeProperty(propertyName: String) -> Bool {
        return true
    }

    func overrideSerializeProperty(propertyName: String) -> Bool {
        return false
    }

    func serializeProperty(propertyName: String) -> AnyObject? {
        return nil
    }

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
        return false
    }

    func deserializeProperty(propertyName: String, value: AnyObject?) {
    }
}
