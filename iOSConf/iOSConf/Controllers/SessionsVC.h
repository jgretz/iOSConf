//
// Created by Joshua Gretz on 5/14/13.
// Copyright (c) 2013 TrueFit. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//

#import "ContentVC.h"

@class SessionRepository;
@class SessionDisplayService;

@interface SessionsVC : ContentVC

@property (strong) IBOutlet UITableView* sessionsTable;
@property (strong) IBOutlet UIActivityIndicatorView* activityIndicator;

@property (strong) SessionRepository* sessionRepository;
@property (strong) SessionDisplayService* sessionDisplayService;

-(void) sortSessions;
@end