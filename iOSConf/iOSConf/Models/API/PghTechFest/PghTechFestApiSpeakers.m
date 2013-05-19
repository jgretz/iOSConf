//
// Created by Joshua Gretz on 5/18/13.
// Copyright (c) 2013 TrueFit. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "PghTechFestApiSpeakers.h"
#import "PghTechFestApiSpeaker.h"


@implementation PghTechFestApiSpeakers

-(Class) classTypeForKey: (NSString*) key {
    if ([key isEqual: SELF_KEYPATH(presenters)])
        return [PghTechFestApiSpeaker class];

    return nil;
}

@end