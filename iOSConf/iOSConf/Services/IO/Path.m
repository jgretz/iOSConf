//
//  Path.m
//  iOSConf
//
//  Created by Joshua Gretz on 4/28/11.
//  Copyright 2011 TrueFit Solutions. All rights reserved.
//

#import "Path.h"


@implementation Path

+(NSString*) bundle {
	return [[NSBundle mainBundle] bundlePath];
}

+(NSString*) subBundle: (NSString*) subPath {
	return [[Path bundle] stringByAppendingPathComponent: subPath];
}

+(NSString*) documentDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex: 0];
}

+(NSString*) subDocumentDirectory: (NSString*) subPath {
	return [[Path documentDirectory] stringByAppendingPathComponent: subPath];
}

+(NSString*) libraryDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex: 0];
}

+(NSString*) libraryCachesDirectory {
	return [[Path libraryDirectory] stringByAppendingPathComponent: @"Caches"];
}

+(NSString*) subLibraryDirectory: (NSString*) subPath {
	return [[Path libraryDirectory] stringByAppendingPathComponent: subPath];
}

+(NSString*) subLibraryCachesDirectory: (NSString*) subPath {
	return [[[Path libraryDirectory] stringByAppendingPathComponent: @"Caches"] stringByAppendingPathComponent: subPath];
}

@end
