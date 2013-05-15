//
//  AppDelegate.m
//  iOSConf
//
//  Created by Joshua Gretz on 5/14/13.
//  Copyright (c) 2013 TrueFit. All rights reserved.
//

#import "AppDelegate.h"
#import "ContainerConfig.h"
#import "SplashVC.h"
#import "MainVC.h"

@implementation AppDelegate

-(BOOL) application: (UIApplication*) application didFinishLaunchingWithOptions: (NSDictionary*) launchOptions {
    self.window = [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    [[ContainerConfig object] configure];

    SplashVC* vc = [SplashVC object];
    vc.loadComplete = ^{
        self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController: [MainVC object]];
    };
    self.window.rootViewController = vc;

    [self.window makeKeyAndVisible];
    return YES;
}

@end
