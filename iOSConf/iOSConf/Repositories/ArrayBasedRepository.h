//
//  RepositoryPattern.h
//  iOSConf
//
//  Created by Joshua Gretz on 4/10/12.
//  Copyright (c) 2012 TrueFit Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cerealizer.h"

@interface ArrayBasedRepository : NSObject

@property (retain) id<Cerealizer> cerealizer;
@property (retain) NSMutableArray* data;

@property (readonly) NSString* filename;
@property (readonly) Class classType;
@property (retain) NSDate* lastUpdated;

-(void) loadData;
-(void) saveData;
-(void) clearData;

-(void) addObject: (id) obj;
-(void) addObjects: (NSArray*) array;
-(void) removeObject: (id) obj;

-(int) count;
-(id) objectAtIndex: (int) index;
-(id) objectAtIndexedSubscript: (NSUInteger) index;
-(void) setObject: (id) object atIndexedSubscript: (NSUInteger) index;

@end
