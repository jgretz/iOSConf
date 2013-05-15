//
//  JsonSerializer.m
//  iOSConf
//
//  Created by Joshua Gretz on 6/27/11.
//  Copyright 2011 TrueFit Solutions. All rights reserved.
//

#import "JsonSerializer.h"
#import "iSerializable.h"

@implementation JsonSerializer

#pragma mark Serialize
-(NSString*) toString: (id) object {
    if (object == nil)
        return @"";
    
    id jsonObject = [self toObject: object];
    if (![NSJSONSerialization isValidJSONObject: jsonObject]) {
        NSLog(@"!!! Error Writing JSON: Object unable to be serialized to JSON");
        return nil;
    }
    
    NSError* error;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject: jsonObject options: NSJSONWritingPrettyPrinted error: &error];
    if (error) {
        NSLog(@"!!! Error Writing JSON: %@", error);
        return nil;
    }
    
    return [[NSString alloc] initWithData: jsonData encoding: NSUTF8StringEncoding];
}

#pragma mark Deserialize
-(id) createArrayOfType: (Class) classType fromString: (NSString*) json {
    if (!json || json.length == 0)
        return nil;
    
    id jsonObj = [self JSONValue: json];
    if ([jsonObj isKindOfClass: [NSDictionary class]])
        jsonObj = [NSArray arrayWithObject: jsonObj];
    
    if (![jsonObj isKindOfClass: [NSArray class]])
        return nil;
    
    return [self createArrayOfType: classType fromArray: jsonObj];    
}

-(void) fillObject: (id) object fromString: (NSString*) json {
    id jsonObj = [self JSONValue: json];
    if (![jsonObj isKindOfClass: [NSDictionary class]])
        return;
    
    [self fillObject: object fromDictionary: jsonObj];
}

-(id) JSONValue: (NSString*) json {
    NSData* jsonData = [json dataUsingEncoding: NSUTF8StringEncoding];
    NSError* error;
    id jsonObj = [NSJSONSerialization JSONObjectWithData: jsonData options: NSJSONReadingAllowFragments error: &error];
    if (error) {
        NSLog(@"!!! Error Reading JSON: %@", error);
        return nil;
    }
    
    return jsonObj;
}

@end
