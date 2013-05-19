//
//  BrowserVC.h
//  iOSConf
//
//  Created by Joshua Gretz on 5/19/13.
//  Copyright (c) 2013 TrueFit. All rights reserved.
//

#import "ContentVC.h"

@interface BrowserVC : ContentVC

@property (strong) IBOutlet UIWebView* browser;
@property (strong) IBOutlet UIActivityIndicatorView* activityIndicator;

@property (copy) NSString* url;

@end
