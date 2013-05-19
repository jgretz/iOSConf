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
    vc.loadComplete = ^{ [self loadComplete]; };
    self.window.rootViewController = vc;

    [self.window makeKeyAndVisible];
    return YES;
}

-(void) loadComplete {
    UINavigationController*(^makeNav)(UIViewController*, UIImage*) = ^(UIViewController* root, UIImage* image) {
        UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController: root];

        nav.tabBarItem.image = image;
        [nav.tabBarItem setTitleTextAttributes: @{ UITextAttributeTextColor : [UIColor whiteColor] } forState: UIControlStateNormal];
        [nav.tabBarItem setTitleTextAttributes: @{ UITextAttributeTextColor : [UIColor blackColor] } forState: UIControlStateSelected];

        return nav;
    };

    UITabBarController* tabBar = [[UITabBarController alloc] init];
    tabBar.viewControllers = @[
            makeNav([SessionsVC object], [UIImage imageNamed: @"sessions.png"]),
            makeNav([ScheduleVC object], [UIImage imageNamed: @"schedule.png"]),
            makeNav([SpeakersVC object], [UIImage imageNamed: @"speakers.png"])
    ];

    self.window.rootViewController = tabBar;
}

@end
