//
// Created by Joshua Gretz on 5/18/13.
// Copyright (c) 2013 TrueFit. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "SessionRepository.h"
#import "Session.h"

@implementation SessionRepository

-(NSString*) filename {
    return [Path subLibraryCachesDirectory: @"sessions.json"];
}

-(Class) classType {
    return [Session class];
}

-(Session*) sessionById: (NSString*) sessionId {
    return [self.data firstWhere: ^BOOL(Session* evaluatedObject) {
        return [evaluatedObject.id isEqual: sessionId];
    }];
}


@end