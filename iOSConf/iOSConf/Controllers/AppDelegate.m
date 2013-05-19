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
#import "SessionsVC.h"
#import "ScheduleVC.h"
#import "SpeakersVC.h"

@implementation AppDelegate

-(BOOL) application: (UIApplication*) application didFinishLaunchingWithOptions: (NSDictionary*) launchOptions {
    self.window = [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    [[ContainerConfig object] configure];

    SplashVC* vc = [SplashVC object];
    vc.loadComplete = ^{
        UITabBarController* tabBar = [[UITabBarController alloc] init];
        tabBar.viewControllers = @[
                [[UINavigationController alloc] initWithRootViewController: [SessionsVC object]],
                [[UINavigationController alloc] initWithRootViewController: [ScheduleVC object]],
                [[UINavigationController alloc] initWithRootViewController: [SpeakersVC object]]
        ];

        self.window.rootViewController = tabBar;
    };
    self.window.rootViewController = vc;

    [self.window makeKeyAndVisible];
    return YES;
}

@end
