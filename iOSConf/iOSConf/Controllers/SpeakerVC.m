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
    self.twitter.text = [NSString stringWithFormat: @"Twitter: @%@", self.speaker.twitter];
    self.blog.text = self.speaker.blog;
    self.github.text = [NSString stringWithFormat: @"Github: %@", self.speaker.github];
    self.bio.text = self.speaker.bio;
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
    BrowserVC* vc = [BrowserVC object];
    vc.url = url;

    [self.navigationController pushViewController: vc animated: YES];
}

@end
