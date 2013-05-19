//
//  SpeakerVC.h
//  iOSConf
//
//  Created by Joshua Gretz on 5/19/13.
//  Copyright (c) 2013 TrueFit. All rights reserved.
//

#import "ContentVC.h"
#import "Speaker.h"

@interface SpeakerVC : ContentVC

@property (strong) IBOutlet UILabel* name;
@property (strong) IBOutlet UILabel* twitter;
@property (strong) IBOutlet UILabel* blog;
@property (strong) IBOutlet UILabel* github;
@property (strong) IBOutlet UITextView* bio;

@property (strong) Speaker* speaker;

-(IBAction) twitterClick;
-(IBAction) blogClick;
-(IBAction) githubClick;

@end
