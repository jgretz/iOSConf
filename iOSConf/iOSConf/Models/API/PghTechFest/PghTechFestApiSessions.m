//
// Created by Joshua Gretz on 5/18/13.
// Copyright (c) 2013 TrueFit. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "PghTechFestApiSessions.h"
#import "PghTechFestApiSession.h"

@implementation PghTechFestApiSessions

-(Class) classTypeForKey: (NSString*) key {
    if ([key isEqual: SELF_KEYPATH(sessions)])
        return [PghTechFestApiSession class];

    return nil;
}

@end