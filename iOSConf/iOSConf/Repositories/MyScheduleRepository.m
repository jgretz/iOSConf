//
// Created by Joshua Gretz on 5/19/13.
// Copyright (c) 2013 TrueFit. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "MyScheduleRepository.h"
#import "Scheduled.h"


@implementation MyScheduleRepository

-(NSString*) filename {
    return [Path subLibraryCachesDirectory: @"myschedule.json"];
}

-(Class) classType {
    return [Scheduled class];
}

-(BOOL) isSessionScheduled: (Session*) session {
    return [self scheduledForId: session.id] != nil;
}

-(void) scheduleSession: (Session*) session {
    Scheduled* scheduled = [Scheduled object];
    scheduled.sessionId = session.id;

    [self addObject: scheduled];
}

-(void) unscheduleSession: (Session*) session {
    Scheduled* scheduled = [self scheduledForId: session.id];
    if (scheduled)
        [self removeObject: scheduled];
}

-(Scheduled*) scheduledForId: (NSString*) sessionId {
    @synchronized (self) {
        return [self.data firstWhere: ^BOOL(Scheduled* evaluatedObject) {
            return [evaluatedObject.sessionId isEqual: sessionId];
        }];
    }
}


@end