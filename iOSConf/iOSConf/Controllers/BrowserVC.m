//
//  BrowserVC.m
//  iOSConf
//
//  Created by Joshua Gretz on 5/19/13.
//  Copyright (c) 2013 TrueFit. All rights reserved.
//

#import "BrowserVC.h"

@interface BrowserVC()

@end

@implementation BrowserVC

-(void) viewDidLoad {
    [super viewDidLoad];

    self.browser.backgroundColor = [UIColor clearColor];
    self.browser.opaque = NO;

    [self performBlockInBackground: ^{
        NSURL* url = [NSURL URLWithString: self.url];
        NSString* html = [NSString stringWithContentsOfURL: url encoding: NSUTF8StringEncoding error: nil];

        [self performBlockInMainThread: ^{
            if (self.activityIndicator.isAnimating)
                [self.activityIndicator stopAnimating];

            [self.browser loadHTMLString: html baseURL: url];
        }];
    }];
}

@end
