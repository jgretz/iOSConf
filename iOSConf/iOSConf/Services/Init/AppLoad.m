//
// Created by Joshua Gretz on 5/14/13.
// Copyright (c) 2013 TrueFit. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "AppLoad.h"
#import "SessionRepository.h"
#import "SpeakerRepository.h"
#import "SessionService.h"
#import "SpeakerService.h"
#import "MappingConfiguration.h"
#import "MyScheduleRepository.h"

@implementation AppLoad
-(void) loadApp {
    [[MappingConfiguration object] configure];

    [[SessionRepository object] loadData];
    [[SpeakerRepository object] loadData];
    [[MyScheduleRepository object] loadData];

    [self performBlockInMainThread: ^{
        [[SessionService object] retrieveSessions];
        [[SpeakerService object] retrieveSpeakers];
    }];
}

@end