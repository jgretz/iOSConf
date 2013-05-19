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

    UIView* arrows = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 50, 20)];
    arrows.backgroundColor = [UIColor clearColor];

    UIButton* back = [UIButton buttonWithType: UIButtonTypeCustom];
    back.frame = CGRectMake(0, 1, 15, 18);
    [back setImage: [UIImage imageNamed: @"back.png"] forState: UIControlStateNormal];
    [back addTarget: self action: @selector(back) forControlEvents: UIControlEventTouchUpInside];
    [arrows addSubview: back];

    UIButton* forward = [UIButton buttonWithType: UIButtonTypeCustom];
    forward.frame = CGRectMake(30, 1, 15, 18);
    [forward addTarget: self action: @selector(forward) forControlEvents: UIControlEventTouchUpInside];
    [forward setImage: [UIImage imageNamed: @"frwd.png"] forState: UIControlStateNormal];
    [arrows addSubview: forward];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView: arrows];

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

-(void) back {
    [self.browser goBack];
}

-(void) forward {
    [self.browser goForward];
}

@end
