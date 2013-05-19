//
//  SessionVC.h
//  iOSConf
//
//  Created by Joshua Gretz on 5/18/13.
//  Copyright (c) 2013 TrueFit. All rights reserved.
//

#import "ContentVC.h"
#import "Session.h"

@interface SessionVC : ContentVC

@property (strong) IBOutlet UILabel* titleLabel;
@property (strong) IBOutlet UILabel* speaker;
@property (strong) IBOutlet UILabel* room;
@property (strong) IBOutlet UILabel* time;
@property (strong) IBOutlet UILabel* track;
@property (strong) IBOutlet UITextView* descriptionView;

@property (strong) Session* session;

-(IBAction) viewSpeaker;

@end
