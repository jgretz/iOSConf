//
// Created by Joshua Gretz on 5/18/13.
// Copyright (c) 2013 TrueFit. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "BundleContainerConvention.h"

@implementation BundleContainerConvention {
    NSString* prefix;
}

+(BundleContainerConvention*) convention {
    return [[BundleContainerConvention alloc] init];
}

-(id) init {
    if ((self = [super init])) {
        NSString* bundleIdentifier = [NSBundle mainBundle].bundleIdentifier;
        if ([bundleIdentifier isEqual: @"com.truefitsolutions.PghTechFest"]) {
            prefix = @"PghTechFest";
        }
    }

    return self;
}

-(BOOL) respondsToEvent:(enum ContainerConventionEvent)event {
    return event == MapClass;
}

-(Class) mapKey:(NSString *)key {
    if (!key || key.length == 0)
        return nil;
    return NSClassFromString([NSString stringWithFormat: @"%@%@", prefix, key]);
}

@end