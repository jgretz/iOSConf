//
//  iSerializer.h
//  iOSConf
//
//  Created by Joshua Gretz on 6/28/11.
//  Copyright 2011 TrueFit Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol iSerializer <NSObject>

-(NSString*) toString: (id) object;
-(id) toObject: (id) object;

-(id) create: (Class) classType fromString: (NSString*) string;
-(id) create: (Class) classType fromDictionary: (NSDictionary*) dictionary;

-(id) createArrayOfType: (Class) classType fromString: (NSString*) string;
-(id) createArrayOfType: (Class) classType fromArray: (NSArray*) array;

-(void) fillObject: (id) object fromString: (NSString*) string;
-(void) fillObject: (id) object fromDictionary: (NSDictionary*) dictionary;

@end
