//
//  RepositoryPattern.m
//  iOSConf
//
//  Created by Joshua Gretz on 4/10/12.
//  Copyright (c) 2012 TrueFit Solutions. All rights reserved.
//

#import "ArrayBasedRepository.h"

@implementation ArrayBasedRepository

@synthesize serializer, data, lastUpdated;

#pragma mark - To Override
-(NSString*) filename {
    return nil;
}

-(Class) classType{
    return nil;
}

#pragma mark - Load / Save
-(void) loadData {
    @synchronized(self) {
        self.data = [self arrayFromFile: self.filename forType: self.classType];
        self.lastUpdated = [NSDate date];
    }
}

-(void) saveData {
    @synchronized(self) {
        [self array: self.data toFile: self.filename];
    }
}

-(void) clearData {
    @synchronized(self) {
        [self clearArray: self.data forFile: self.filename];
        self.lastUpdated = [NSDate date];
    }
}

#pragma mark - Add / Remove
-(void) addObject: (id) obj {
    @synchronized(self) {
        [self.data addObject: obj];
        self.lastUpdated = [NSDate date];
    }
}

-(void) addObjects: (NSArray*) array {
    @synchronized(self) {
        [self.data addObjectsFromArray: array];
        self.lastUpdated = [NSDate date];
    }
}

-(void) removeObject: (id) obj {
    @synchronized(self) {
        [self.data removeObject: obj];
        self.lastUpdated = [NSDate date];
    }
}

#pragma Indexers
-(int) count {
    return self.data.count;
}

-(id) objectAtIndex:(int)index {
    return [self.data objectAtIndex: index];
}

-(id) objectAtIndexedSubscript:(NSUInteger)index {
    return [self objectAtIndex: index];
}

-(void) setObject:(id)object atIndexedSubscript:(NSUInteger)index {
    self.data[index] = object;
}

#pragma mark - Helpers
-(NSMutableArray*) arrayFromFile:(NSString *)fileName forType:(Class)classType {
    NSString* stringData = [NSString stringWithContentsOfFile: fileName encoding: NSUTF8StringEncoding error: nil];
    
    NSMutableArray* array = nil;
    if (stringData)
        array = [self.serializer createArrayOfType: classType fromString: stringData];
    if (!array)
        array = [NSMutableArray array];
    
    return array;
}

-(void) array: (NSArray*) array toFile: (NSString*) fileName {
    NSString* stringData = [self.serializer toString: array];
    [stringData writeToFile: fileName atomically: NO encoding: NSUTF8StringEncoding error: nil];
}

-(void) clearArray: (NSMutableArray*) array forFile: (NSString*) fileName {
    if ([[NSFileManager defaultManager] fileExistsAtPath: fileName])
        [[NSFileManager defaultManager] removeItemAtPath: fileName error: nil];
    
    [array removeAllObjects];
}

@end
