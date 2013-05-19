//
//  ScheduleVC.m
//  iOSConf
//
//  Created by Joshua Gretz on 5/18/13.
//  Copyright (c) 2013 TrueFit. All rights reserved.
//

#import "ScheduleVC.h"
#import "MyScheduledSessionDisplayService.h"
#import "MyScheduleRepository.h"

@interface ScheduleVC()

@property (strong) MyScheduleRepository* myScheduleRepository;

@end

@implementation ScheduleVC

-(id) init {
    if ((self = [super init])) {
        self.title = @"My Schedule";
    }

    return self;
}

-(void) viewDidLoad {
    self.sessionDisplayService = [MyScheduledSessionDisplayService object];

    [super viewDidLoad];

    [self.myScheduleRepository when: CLASS_KEYPATH(MyScheduleRepository, lastUpdated) changes: ^{
        [self performBlockInBackground: ^{
            [self sortSessions];
        }];
    }];
}

-(void) dealloc {
    [self.myScheduleRepository clearKVOForPath: CLASS_KEYPATH(MyScheduleRepository, lastUpdated)];
}

@end
