//
// Created by Joshua Gretz on 5/14/13.
// Copyright (c) 2013 TrueFit. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "SplashVC.h"
#import "AppLoad.h"

@implementation SplashVC {
    NSDate* start;
}

-(void) viewDidAppear: (BOOL) animated {
    [super viewDidAppear: animated];

    start = [NSDate now];
    [self performBlockInBackground: ^{
        [[AppLoad object] loadApp];

        [self performSelectorOnMainThread: @selector(complete) withObject: nil waitUntilDone: NO];
    }];
}

-(void) complete {
#if DEBUG
    int waitTime = 0;
#else
    int waitTime = 3;
#endif


    NSTimeInterval wait = [NSDate.now timeIntervalSinceDate: start];
    if (wait < waitTime) {
        [self performSelector: @selector(complete) withObject: nil afterDelay: wait];
        return;
    }
    
    self.loadComplete();
}

@end