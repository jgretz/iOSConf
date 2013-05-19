//
// Created by Joshua Gretz on 5/18/13.
// Copyright (c) 2013 TrueFit. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>


@interface PghTechFestApiSpeaker : NSObject

@property (strong) NSString* id;
@property (strong) NSString* name;
@property (copy) NSString* email;
@property (copy) NSString* twitter;
@property (copy) NSString* blog_url;
@property (copy) NSString* github_id;
@property (copy) NSString* bio;

@end