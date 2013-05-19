//
//  SpeakerVC.m
//  iOSConf
//
//  Created by Joshua Gretz on 5/19/13.
//  Copyright (c) 2013 TrueFit. All rights reserved.
//

#import "SpeakerVC.h"
#import "BrowserVC.h"

@interface SpeakerVC ()

@end

@implementation SpeakerVC

-(void) viewDidLoad {
    [super viewDidLoad];

    self.name.text = self.speaker.name;
    self.bio.text = self.speaker.bio;

    if (self.speaker.twitter && self.speaker.twitter.length > 0)
        self.twitter.text = [NSString stringWithFormat: [self.speaker.twitter startsWith: @"@"] ? @"Twitter: %@" : @"Twitter: @%@", self.speaker.twitter];

    if (self.speaker.blog && self.speaker.blog.length > 0)
        self.blog.text = self.speaker.blog;

    if (self.speaker.github && self.speaker.github.length > 0)
        self.github.text = [NSString stringWithFormat: @"Github: %@", self.speaker.github];
}

#pragma mark - Actions
-(IBAction) twitterClick {
    [self showBrowser: [NSString stringWithFormat: @"https://www.twitter.com/%@", self.speaker.twitter]];
}

-(IBAction) blogClick {
    [self showBrowser: self.speaker.blog];
}

-(IBAction) githubClick {
    [self showBrowser: [NSString stringWithFormat: @"https://www.github.com/%@", self.speaker.github]];
}

-(void) showBrowser: (NSString*) url {
    if (!url || url.length == 0)
        return;

    BrowserVC* vc = [BrowserVC object];
    vc.url = url;

    [self.navigationController pushViewController: vc animated: YES];
}

@end
