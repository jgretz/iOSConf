//
// Created by Joshua Gretz on 5/18/13.
// Copyright (c) 2013 TrueFit. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import "SessionRepository.h"

@class Session;

typedef enum {
    SessionGroupingTime,
    SessionGroupingTrack,
    SessionGroupingName,
} SessionGrouping;

@interface SessionDisplayService : NSObject

@property (readonly) NSArray* source;
@property (strong) SessionRepository* sessionRepository;

-(void) fillAndSortSectionTitles: (NSArray**) sectionTitles andSessions: (NSDictionary**) sessions forGrouping: (SessionGrouping) grouping;
-(NSString*) buildDetailForSession: (Session*) session forGrouping: (SessionGrouping) grouping;

@end