//
//  Path.h
//  iOSConf
//
//  Created by Joshua Gretz on 4/28/11.
//  Copyright 2011 TrueFit Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Path : NSObject {
    
}

+(NSString*) bundle;
+(NSString*) subBundle: (NSString*) subPath;

+(NSString*) documentDirectory;
+(NSString*) subDocumentDirectory: (NSString*) subPath;

+(NSString*) libraryDirectory;
+(NSString*) subLibraryDirectory: (NSString*) subPath;

+(NSString*) libraryCachesDirectory;
+(NSString*) subLibraryCachesDirectory: (NSString*) subPath;

@end
