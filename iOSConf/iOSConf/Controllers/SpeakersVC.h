//
//  SpeakersVC.h
//  iOSConf
//
//  Created by Joshua Gretz on 5/18/13.
//  Copyright (c) 2013 TrueFit. All rights reserved.
//

#import "ContentVC.h"

@interface SpeakersVC : ContentVC

@property (strong) IBOutlet UITableView* speakersTable;
@property (strong) IBOutlet UIActivityIndicatorView* activityIndicator;

@end
