//
// Created by Joshua Gretz on 5/18/13.
// Copyright (c) 2013 TrueFit. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "PghTechFestSpeakerToSpeakerMap.h"

@implementation PghTechFestSpeakerToSpeakerMap

-(void) map: (PghTechFestApiSpeaker*) source into: (Speaker*) target {
    [super map: source into: target];

    target.blog = source.blog_url;
    target.github = source.github_id;
}

@end