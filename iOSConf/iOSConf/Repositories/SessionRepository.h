//
// Created by Joshua Gretz on 5/18/13.
// Copyright (c) 2013 TrueFit. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "ArrayBasedRepository.h"
#import "Session.h"

@interface SessionRepository : ArrayBasedRepository

-(Session*) sessionById: (NSString*) sessionId;

@end