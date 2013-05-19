//
// Created by Joshua Gretz on 5/18/13.
// Copyright (c) 2013 TrueFit. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "PghTechFestMappingConfiguration.h"
#import "ObjectMapper.h"
#import "PghTechFestSessionToSessionMap.h"
#import "PghTechFestSpeakerToSpeakerMap.h"

@implementation PghTechFestMappingConfiguration

-(void) configure {
    [ObjectMapper registerMap: [PghTechFestSessionToSessionMap class] forClass: [PghTechFestApiSession class] toClass: [Session class]];
    [ObjectMapper registerMap: [PghTechFestSpeakerToSpeakerMap class] forClass: [PghTechFestApiSpeaker class] toClass: [Speaker class]];
}

@end