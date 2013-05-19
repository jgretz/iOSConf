//
// Created by Joshua Gretz on 5/18/13.
// Copyright (c) 2013 TrueFit. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "PghTechFestSessionService.h"
#import "AFJSONRequestOperation.h"
#import "PghTechFestApiSessions.h"
#import "PghTechFestApiSession.h"
#import "Session.h"
#import "ObjectMapper.h"
#import "SessionRepository.h"

@interface PghTechFestSessionService()

@property (strong) SessionRepository* sessionRepository;

@end

@implementation PghTechFestSessionService

-(void) retrieveSessions {
    [super retrieveSessions];

    NSURLRequest* request = [NSURLRequest requestWithURL: [NSURL URLWithString: @"http://pghtechfest.com/session_list.json"]];
    AFJSONRequestOperation* operation = [AFJSONRequestOperation
            JSONRequestOperationWithRequest: request
                                    success: ^(NSURLRequest* request, NSHTTPURLResponse* response, id JSON) {
                                        PghTechFestApiSessions* list = [self.serializer create: [PghTechFestApiSessions class] fromDictionary: JSON];
                                        [self updateSessions: list.sessions];
                                    }
                                    failure: ^(NSURLRequest* request, NSHTTPURLResponse* response, NSError* error, id JSON) {
                                        [self performBlockInMainThread: ^{
                                            [[[UIAlertView alloc] initWithTitle: @"Error Retrieving Sesssion Data"
                                                                        message: [NSString stringWithFormat: @"%@", error]
                                                                       delegate: nil
                                                              cancelButtonTitle: @"OK" otherButtonTitles: nil] show];
                                        }];
                                    }];
    [operation start];
}

-(void) updateSessions: (NSArray*) sessions {
    NSMutableArray* newSessions = [NSMutableArray array];
    for (PghTechFestApiSession* serverSession in sessions) {
        Session* session = [self.sessionRepository.data firstWhere: ^BOOL(Session* evaluatedObject) {
            return [evaluatedObject.id isEqual: serverSession.id];
        }];

        if (session)
            [ObjectMapper map: serverSession into: session];
        else
            [newSessions addObject: [ObjectMapper create: [Session class] from: serverSession]];
    }

    [self.sessionRepository addObjects: newSessions];
    [self.sessionRepository saveData];
}

@end