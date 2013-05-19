//
// Created by Joshua Gretz on 5/18/13.
// Copyright (c) 2013 TrueFit. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface PghTechFestApiSession : NSObject

@property (copy) NSString* id;
@property (copy) NSString* title;
@property (copy) NSString* track;
@property (copy) NSString* timeslot;
@property (copy) NSString* timeslot_id;
@property (copy) NSString* presenter;
@property (copy) NSString* presenter_id;
@property (copy) NSString* description;
@property (copy) NSString* length;
@property (copy) NSString* room;
@property (copy) NSString* notes;
@property (copy) NSString* active;

@end