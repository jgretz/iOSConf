//
// Created by Joshua Gretz on 5/18/13.
// Copyright (c) 2013 TrueFit. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "Cerealizable.h"


@interface PghTechFestApiSpeakers : NSObject<Cerealizable>

@property (strong) NSArray* presenters;

@end