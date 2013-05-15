//
//  iSerializable.h
//  iOSConf
//
//  Created by Joshua Gretz on 6/28/11.
//  Copyright 2011 TrueFit Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol iSerializable <NSObject>

@optional

-(Class) classTypeForKey: (NSString*) key;
-(BOOL) serializePropertyWithName: (NSString*) name;
-(NSString*) valueKeyForPropertyName: (NSString*) name;

@end
