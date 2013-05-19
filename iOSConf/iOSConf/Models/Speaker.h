//
// Created by Joshua Gretz on 5/18/13.
// Copyright (c) 2013 TrueFit. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface Speaker : NSObject

@property (strong) NSString* id;
@property (strong) NSString* name;
@property (copy) NSString* email;
@property (copy) NSString* twitter;
@property (copy) NSString* blog;
@property (copy) NSString* github;
@property (copy) NSString* bio;

@end