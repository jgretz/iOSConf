//
// Created by Joshua Gretz on 5/18/13.
// Copyright (c) 2013 TrueFit. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "NSDate+String.h"


@implementation NSDate(String)

-(NSString*) timeString {
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat: @"h:mm a"];

    return [formatter stringFromDate: self];
}

@end