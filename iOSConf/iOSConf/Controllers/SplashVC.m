//
// Created by Joshua Gretz on 5/14/13.
// Copyright (c) 2013 TrueFit. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "SplashVC.h"
#import "AppLoad.h"


@implementation SplashVC

-(void) viewDidAppear: (BOOL) animated {
    [super viewDidAppear: animated];

    [self performBlockInBackground: ^{
        [[AppLoad object] loadApp];

        [self performBlockInMainThread: self.loadComplete];
    }];
}

@end