//
//  Serializer.m
//  iOSConf
//
//  Created by Joshua Gretz on 12/12/11.
//  Copyright (c) 2011 TrueFit Solutions. All rights reserved.
//

#import "Serializer.h"
#import "Reflection.h"
#import "NSData+Base64.h"

@implementation Serializer {
    NSDateFormatter* dateFormatter;
}

-(id) init {
    if ((self = [super init])) {
        // the serializers have issues with dates - we are going to go to string and back as standard
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    
    return self;
}

#pragma mark Serialization
-(NSString*) toString: (id) object {
    return [object description];
}

-(id) toObject:(id)object {    
    // special "value" reference types
    if ([object isKindOfClass: [NSString class]] || [object isKindOfClass: [NSNumber class]] || [object isKindOfClass: [NSValue class]])
        return object;
    
    // array
    if ([object isKindOfClass: [NSArray class]]) {
        NSMutableArray* array = [NSMutableArray array];
        for (id obj in [NSArray arrayWithArray: object])
            [array addObject: [self toObject: obj]];
        
        return array;
    }
    
    // dictionary
    NSMutableDictionary* dictionary = [NSMutableDictionary dictionary];
    if ([object isKindOfClass: [NSDictionary class]]) {
        for (id key in  [object keyEnumerator])
            [dictionary setObject: [self toObject: [object objectForKey: key]] forKey: key];
        return dictionary;
    }
    
    // object
    for (PropertyInfo* propertyInfo in [Reflection propertiesForClass: [object class] includeInheritance: YES]) {
        if ([object conformsToProtocol: @protocol(iSerializable)] && [object respondsToSelector: @selector(serializePropertyWithName:)]) {
            if (![object serializePropertyWithName: propertyInfo.name])
                continue;
        }
        
        id value = [object valueForKey: propertyInfo.name];
        if (!value)
            continue;
        
        // check nscoding
        if ([value isKindOfClass: [NSArray class]])
            value = [self toObject: value];
        else if ([value isKindOfClass: [NSDate class]])
            value = [dateFormatter stringFromDate: value];
        else if ([value isKindOfClass: [NSData class]])
            value = [value base64EncodedString];
        else if ([value conformsToProtocol: @protocol(NSObject)])
            value = [self toObject: value];
        
		[dictionary setValue: value forKey: propertyInfo.name];
	}
	return dictionary;
}

#pragma mark Deserialization
// cant do here
-(id) createArrayOfType: (Class) classType fromString: (NSString*) string {
    return nil;
}

-(void) fillObject: (id) object fromString: (NSString*) string {
}

// can
-(id) create: (Class) classType fromString: (NSString*) string {
    NSArray* array = [self createArrayOfType: classType fromString: string];
    return array.count == 0 ? nil : [array objectAtIndex: 0];
}

-(id) createArrayOfType: (Class) classType fromArray: (NSArray*) rawArray {
    NSMutableArray* array = [NSMutableArray array];
    
    // quick exit
    if (rawArray.count == 0)
        return array;
    
    // sample the object type    
    Class objectType = [[rawArray objectAtIndex: 0] class];        
    if (objectType != [NSDictionary class] && ![objectType isSubclassOfClass: [NSDictionary class]]) {
        for (id obj in rawArray)
            [array addObject: obj];
        return array;
    }
    
    // override so we can actually do it
    if (classType == [NSDictionary class])
        classType = [NSMutableDictionary class];
    
    // deserialize
    for (NSDictionary* dictionary in rawArray) {
        id object = [classType object];
        [self fillObject: object fromDictionary: dictionary];
        
        [array addObject: object];
    }
    
    return array;
}

-(id) create: (Class) classType fromDictionary: (NSDictionary*) dictionary {
    return [[self createArrayOfType: classType fromArray: [NSArray arrayWithObject: dictionary]] objectAtIndex: 0];
}

-(void) fillObject: (id) object fromDictionary: (NSDictionary*) dictionary {    
    // fill dictionary
    if ([object isKindOfClass: [NSMutableDictionary class]]) {
        for (id key in dictionary.keyEnumerator)
            [(NSMutableDictionary*) object setObject: [dictionary objectForKey: key] forKey: key];
        return;
    }
             
    // fill object
    for (PropertyInfo* propertyInfo in [Reflection propertiesForClass: [object class] includeInheritance:YES]) {
        if (propertyInfo.readonly)
            continue;
                
        NSString* valueKey = propertyInfo.name;
        if ([object conformsToProtocol: @protocol(iSerializable)] && [object respondsToSelector: @selector(valueKeyForPropertyName:)])
            valueKey = [object valueKeyForPropertyName: propertyInfo.name];
        
        id value = [dictionary objectForKey: valueKey];
        if (!value || [value isKindOfClass: [NSNull class]])
            continue;
                
		Class propertyClassType = propertyInfo.type;
        
        if (!propertyInfo.valueType) {
            if (propertyClassType == [NSArray class] || [propertyClassType isSubclassOfClass: [NSArray class]]) {
                if ([object conformsToProtocol: @protocol(iSerializable)] && [object respondsToSelector: @selector(classTypeForKey:)]) {
                    Class subClassType = [object classTypeForKey: propertyInfo.name];
                    if (subClassType)
                        value = [self createArrayOfType: subClassType fromArray: value];
                }
            }
            else if (propertyClassType == [NSDictionary class] || [propertyClassType isSubclassOfClass: [NSDictionary class]]) {
                if ([object conformsToProtocol: @protocol(iSerializable)] && [object respondsToSelector: @selector(classTypeForKey:)]) {
                    Class override = [object classTypeForKey: propertyInfo.name];
                    if (override) {
                        propertyClassType = override;
                        
                        NSDictionary* dict = value;
                        value = [NSMutableDictionary dictionary];
                        
                        for (id key in dict) {
                            id storedObj = [dict objectForKey: key];
                            
                            if ([storedObj isKindOfClass: [NSArray class]])
                                storedObj = [self createArrayOfType: propertyClassType fromArray: storedObj];
                            else if ([storedObj isKindOfClass: [NSDictionary class]])
                                storedObj = [self create: propertyClassType fromDictionary: storedObj];
                            else if( propertyClassType == [NSData class] && [value isKindOfClass: [NSString class]] && ((NSString*) value).length > 0)
                                value = [NSData dataFromBase64String: value];
                            else if (propertyClassType == [NSDate class] && [value isKindOfClass: [NSString class]] && ((NSString*) value).length > 0)
                                value = [dateFormatter dateFromString: value];
                            
                            [value setObject: storedObj forKey: key];
                        }
                    }
                }                
            }
            else if ([value isKindOfClass: [NSDictionary class]]) {
                NSDictionary* dict = value;
                if ([object conformsToProtocol: @protocol(iSerializable)] && [object respondsToSelector: @selector(classTypeForKey:)]) {
                    Class override = [object classTypeForKey: propertyInfo.name];
                    if (override)
                        propertyClassType = override;
                }
                
                value = [propertyClassType object];
                [self fillObject: value fromDictionary: dict];
            }
            else if (propertyClassType == [NSDate class] && [value isKindOfClass: [NSString class]] && ((NSString*) value).length > 0) {
                value = [dateFormatter dateFromString: value];
            }
        }
        
        [object setValue: value forKey: propertyInfo.name];
    }
}

@end
