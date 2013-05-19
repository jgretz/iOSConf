//
// Created by Joshua Gretz on 5/18/13.
// Copyright (c) 2013 TrueFit. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>

@interface Session : NSObject

@property (copy) NSString* id;
@property (copy) NSString* title;
@property (copy) NSString* track;
@property (copy) NSDate* time;
@property (copy) NSString* presenterName;
@property (copy) NSString* presenterId;
@property (copy) NSString* description;
@property (copy) NSString* room;
@property BOOL active;

@end