//
// Created by Joshua Gretz on 5/19/13.
// Copyright (c) 2013 TrueFit. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "MyScheduledSessionDisplayService.h"
#import "MyScheduleRepository.h"

@interface MyScheduledSessionDisplayService()

@property (strong) MyScheduleRepository* myScheduleRepository;

@end

@implementation MyScheduledSessionDisplayService

-(NSArray*) source {
    return [self.sessionRepository.data where: ^BOOL(Session* evaluatedObject) {
        return [self.myScheduleRepository isSessionScheduled: evaluatedObject];
    }];
}

@end