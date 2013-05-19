//
// Created by Joshua Gretz on 5/14/13.
// Copyright (c) 2013 TrueFit. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "ContainerConfig.h"
#import "Container.h"
#import "SessionRepository.h"
#import "SpeakerRepository.h"
#import "BundleContainerConvention.h"
#import "SessionService.h"
#import "SpeakerService.h"
#import "JsonCerealizer.h"
#import "MyScheduleRepository.h"
#import "SessionDisplayService.h"


@implementation ContainerConfig

-(void) configure {
    Container* container = [Container sharedContainer];

    // conventions
    [container addConvention: [BundleContainerConvention convention]];

    // repositories
    [container registerClass: [SpeakerRepository class] cache: YES];
    [container registerClass: [SessionRepository class] cache: YES];
    [container registerClass: [MyScheduleRepository class] cache: YES];

    // Services
    [container registerClass: [SessionDisplayService class]];
    [container registerClass: [JsonCerealizer class] forProtocol: @protocol(Cerealizer)];
}

@end