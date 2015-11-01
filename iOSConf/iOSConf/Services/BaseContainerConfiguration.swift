//
//  BaseContainerConfiguration.swift
//  iOSConf
//
//  Created by Joshua Gretz on 11/1/15.
//  Copyright © 2015 Truefit. All rights reserved.
//

import Foundation
import CoreMeta

class BaseContainerConfiguration {
    class func configure() {
        AppLoadService.register()

        BaseContainerConfiguration.loadConfigurations()
    }

    class func loadConfigurations() {
        let configs = CMBundleIntrospector().classesThatConformToProtocol(ContainerConfiguration.self)
        for config:NSObject.Type in configs {
            let c:ContainerConfiguration = config.object() as! ContainerConfiguration
            c.configure()
        }
    }
}
