//
// Created by Joshua Gretz on 5/18/13.
// Copyright (c) 2013 TrueFit. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "PghTechFestSpeakerService.h"
#import "AFJSONRequestOperation.h"
#import "PghTechFestApiSpeakers.h"
#import "SpeakerRepository.h"
#import "Speaker.h"
#import "Session.h"
#import "ObjectMapper.h"
#import "PghTechFestApiSpeaker.h"

@interface PghTechFestSpeakerService()

@property (strong) SpeakerRepository* speakerRepository;

@end

@implementation PghTechFestSpeakerService

-(void) retrieveSpeakers {
    [super retrieveSpeakers];

    NSURLRequest* request = [NSURLRequest requestWithURL: [NSURL URLWithString: @"http://pghtechfest.com/presenters.json"]];
    AFJSONRequestOperation* operation = [AFJSONRequestOperation
            JSONRequestOperationWithRequest: request
                                    success: ^(NSURLRequest* request, NSHTTPURLResponse* response, id JSON) {
                                        PghTechFestApiSpeakers* list = [self.serializer create: [PghTechFestApiSpeakers class] fromDictionary: JSON];
                                        [self updateSpeaker: list.presenters];
                                    }
                                    failure: ^(NSURLRequest* request, NSHTTPURLResponse* response, NSError* error, id JSON) {
                                        if (self.speakerRepository.data.count == 0) {
                                            NSString* json = [NSString stringWithContentsOfFile: [Path subBundle:@"pghtechfestspeakers.json"] encoding: NSUTF8StringEncoding error: nil];
                                            
                                            PghTechFestApiSpeakers* list = [self.serializer create: [PghTechFestApiSpeakers class] fromString: json];
                                            [self updateSpeaker: list.presenters];
                                        }
                                    }];
    [operation start];
}

-(void) updateSpeaker: (NSArray*) speakers {
    NSMutableArray* newSpeakers = [NSMutableArray array];
    for (PghTechFestApiSpeaker* serverSpeaker in speakers) {
        Speaker* session = [self.speakerRepository.data firstWhere: ^BOOL(Speaker* evaluatedObject) {
            return [evaluatedObject.id isEqual: serverSpeaker.id];
        }];

        if (session)
            [ObjectMapper map: serverSpeaker into: session];
        else
            [newSpeakers addObject: [ObjectMapper create: [Speaker class] from: serverSpeaker]];
    }

    [self.speakerRepository addObjects: newSpeakers];
    [self.speakerRepository saveData];
}

@end