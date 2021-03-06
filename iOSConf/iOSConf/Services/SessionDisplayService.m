//
// Created by Joshua Gretz on 5/18/13.
// Copyright (c) 2013 TrueFit. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "SessionDisplayService.h"
#import "NSDate+String.h"

@interface SessionDisplayService()
@end

@implementation SessionDisplayService

-(NSArray*) source {
    return self.sessionRepository.data;
}

-(void) fillAndSortSectionTitles: (NSArray**) sectionTitles andSessions: (NSDictionary**) sessions forGrouping: (SessionGrouping) grouping {
    NSMutableSet* runningTitles = [NSMutableSet set];
    NSMutableDictionary* runningSessions = [NSMutableDictionary dictionary];

    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"h:mm a"];

    for (Session* session in self.source) {
        NSString* title = nil;
        switch (grouping) {
            case SessionGroupingTime:
                title = [dateFormatter stringFromDate: session.time];
                break;

            case SessionGroupingTrack:
                title = session.track;
                break;

            default:
                break;
        }

        if (!title)
            title = @"";

        [runningTitles addObject: title];

        NSMutableArray* array = runningSessions[title];
        if (!array)
            runningSessions[title] = array = [NSMutableArray array];
        [array addObject: session];
    }

    // sort titles
    NSComparator sort = nil;
    switch (grouping) {
        case SessionGroupingTime: {
            sort = ^NSComparisonResult(NSString* obj1, NSString* obj2) {
                return [[dateFormatter dateFromString: obj1] compare: [dateFormatter dateFromString: obj2]];
            };
        }
            break;

        case SessionGroupingTrack:
            sort = ^NSComparisonResult(NSString* obj1, NSString* obj2) {
                return [obj1 compare: obj2];
            };
            break;

        case SessionGroupingName:
            break;
    }

    *sectionTitles = sort ? [runningTitles.allObjects sortedArrayUsingComparator: sort] : runningTitles.allObjects;

    // sort sessions
    for (NSString* key in runningSessions.keyEnumerator) {
        [runningSessions[key] sortUsingComparator: ^NSComparisonResult(Session* obj1, Session* obj2) {
            return [obj1.title compare: obj2.title];
        }];
    }

    *sessions = runningSessions;
}

-(NSString*) buildDetailForSession: (Session*) session forGrouping: (SessionGrouping) grouping {
    NSString*(^appendString)(NSString*,NSString*) = ^(NSString* original, NSString* value) {
        if (value)
            return [original stringByAppendingFormat: @"\n%@", value];
        return original;
    };

    NSString* detail = session.speakerName ? session.speakerName : @"";
    detail = appendString(detail, session.room);

    switch (grouping) {
        case SessionGroupingTime:
            detail = appendString(detail, session.track);
            break;

        case SessionGroupingTrack:
            detail = appendString(detail, session.time.timeString);
            break;

        case SessionGroupingName:
            detail = appendString(detail, session.track);
            detail = appendString(detail, session.time.timeString);
            break;
    }

    return detail;
}


@end