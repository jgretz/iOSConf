//
// Created by Joshua Gretz on 5/18/13.
// Copyright (c) 2013 TrueFit. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "SpeakerRepository.h"
#import "Speaker.h"

@implementation SpeakerRepository

-(NSString*) filename {
    return [Path subLibraryCachesDirectory: @"speakers.json"];
}

-(Class) classType {
    return [Speaker class];
}

-(Speaker*) speakerById: (NSString*) speakerId {
    return [self.data firstWhere: ^BOOL(Speaker* evaluatedObject) {
        return [evaluatedObject.id isEqual: speakerId];
    }];
}


@end