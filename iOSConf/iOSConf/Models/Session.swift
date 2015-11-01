//
// Created by Joshua Gretz on 11/1/15.
// Copyright (c) 2015 Truefit. All rights reserved.
//

import Foundation

class Session : NSObject {
    var abstract:String?
    var category:String?
    var id:Int?
    var sessionType:String?
    var speaker:Speaker?
    var tags:Array<String>?
}
