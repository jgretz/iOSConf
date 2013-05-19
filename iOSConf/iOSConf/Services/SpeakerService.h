//
// Created by Joshua Gretz on 5/18/13.
// Copyright (c) 2013 TrueFit. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "Cerealizer.h"

@interface SpeakerService : NSObject

@property (strong) id<Cerealizer> serializer;

-(void) retrieveSpeakers;

@end