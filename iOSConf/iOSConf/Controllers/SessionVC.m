//
//  SessionVC.m
//  iOSConf
//
//  Created by Joshua Gretz on 5/18/13.
//  Copyright (c) 2013 TrueFit. All rights reserved.
//

#import "SessionVC.h"
#import "NSDate+String.h"
#import "MyScheduleRepository.h"

@interface SessionVC()

@property (strong) MyScheduleRepository* myScheduleRepository;

@end

@implementation SessionVC

-(void) viewDidLoad {
    [super viewDidLoad];

    self.titleLabel.text = self.session.title;
    self.speaker.text = self.session.presenterName;
    self.room.text = self.session.room;
    self.time.text = self.session.time.timeString;
    self.track.text = self.session.track;
    self.descriptionView.text = self.session.description;

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle: @"" style: UIBarButtonItemStylePlain target: self action: @selector(toggleScheduled)];
    [self setScheduleButtonText];
}

-(void) setScheduleButtonText {
    self.navigationItem.rightBarButtonItem.title = [self.myScheduleRepository isSessionScheduled: self.session] ? @"Remove From Schedule" : @"Add To Schedule";
}

#pragma mark - Actions
-(IBAction) viewSpeaker {

}

-(void) toggleScheduled {
    if ([self.myScheduleRepository isSessionScheduled: self.session])
        [self.myScheduleRepository unscheduleSession: self.session];
    else
        [self.myScheduleRepository scheduleSession: self.session];
    [self.myScheduleRepository saveData];

    [self setScheduleButtonText];
}

@end
