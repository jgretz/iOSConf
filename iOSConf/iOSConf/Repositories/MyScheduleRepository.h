//
// Created by Joshua Gretz on 5/19/13.
// Copyright (c) 2013 TrueFit. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "ArrayBasedRepository.h"
#import "Session.h"

@interface MyScheduleRepository : ArrayBasedRepository

-(BOOL) isSessionScheduled: (Session*) session;
-(void) scheduleSession: (Session*) session;
-(void) unscheduleSession: (Session*) session;

@end