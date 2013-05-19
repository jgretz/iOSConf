//
// Created by Joshua Gretz on 5/18/13.
// Copyright (c) 2013 TrueFit. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "PghTechFestSessionToSessionMap.h"

@implementation PghTechFestSessionToSessionMap

-(void) map: (PghTechFestApiSession*) source into: (Session*) target {
    [super map: source into: target];

    target.active = [source.active isEqual: @"1"];
    target.presenterId = source.presenter_id;
    target.presenterName = source.presenter;

    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"hh:mm a"];

    NSArray* split = [source.timeslot componentsSeparatedByString: @" "];
    NSString* start = split[0];
    if (start.length < 5)
        start = [NSString stringWithFormat: @"0%@", start];

    int hour = [start substring: 2 start: 0].intValue;
    start = [start stringByAppendingString: (hour >= 9 && hour < 12) ? @" AM" : @" PM"];

    target.time = [dateFormatter dateFromString: start];
}

@end