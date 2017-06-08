//
//  JZBaseModle.m
//  GSJuZhang
//
//  Created by Kings Yan on 15/1/15.
//  Copyright (c) 2015年 __Qing__. All rights reserved.
//

#import "JZBaseModle.h"
#import <objc/message.h>

@implementation JZBaseModle

- (id)init:(NSDictionary *)data
{
    if (self = [super init]) {
        [self setAttributes:data];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    id bmodel = [[self.class allocWithZone:zone] init];
    return bmodel;
}

- (void)loadData:(NSDictionary*)data
{
    [self setAttributes:data];
}

- (NSDictionary *)attributeMapDictionary
{
    NSMutableDictionary *propertyDict = [[NSMutableDictionary alloc] init];
    unsigned int outCount = 0;
    objc_property_t *properties = class_copyPropertyList(self.class, &outCount);
    
    for (int i = 0; i < outCount; i++) {
        
        objc_property_t property = properties[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(property)];
        const char *typeName = property_getAttributes(property);
        NSString *properyTypeName = [[NSString alloc] initWithCString:typeName encoding:NSUTF8StringEncoding];
        if (propName && properyTypeName) {
            propertyDict[propName] = properyTypeName;
        }
    }
    properties = nil;
    return propertyDict;
}

- (void)setAttributes:(NSDictionary *)data
{
    if (![data isKindOfClass:[NSDictionary class]]) {
        return;
    }
    NSDictionary *propertys = [self attributeMapDictionary];
    if (!propertys) {
        return;
    }
    for (NSString *attributeName in [propertys allKeys]) {
        
        SEL setter = [self getSetterAttributeName:attributeName];
        if (setter && [self respondsToSelector:setter]) {
            
            if (attributeName && [attributeName isKindOfClass:[NSString class]] && [@"base_id" isEqualToString:attributeName]) {
                
                id value = data[@"id"];
                if (value) {
                    if ([value isKindOfClass:[NSString class]]) {
                        [self performSelectorOnMainThread:setter withObject:value waitUntilDone:YES];
                    }
                    else if ([value isKindOfClass:[NSNumber class]]) {
                        
                        NSString *strValue = [NSString stringWithFormat:@"%d" , [value intValue]];
                        [self performSelectorOnMainThread:setter withObject:strValue waitUntilDone:YES];
                    }
                }
                continue;
            }
            if (attributeName && [attributeName isKindOfClass:[NSString class]] && [@"base_default" isEqualToString:attributeName]) {
                
                id value = data[@"default"];
                if (value) {
                    if ([value isKindOfClass:[NSString class]]) {
                        [self performSelectorOnMainThread:setter withObject:value waitUntilDone:YES];
                    }
                    else if ([value isKindOfClass:[NSNumber class]]) {
                        
                        NSString *strValue = [NSString stringWithFormat:@"%d", [value intValue]];
                        [self performSelectorOnMainThread:setter withObject:strValue waitUntilDone:YES];
                    }
                }
                continue;
            }
            
            if (attributeName && [attributeName isKindOfClass:[NSString class]]) {
                
                id value = data[attributeName];
                if (value) {
                    
                    NSString *className = [self className:propertys[attributeName]];
                    if ([value isKindOfClass:[NSDictionary class]]) {
                        
                        NSString *classString = [self classString:propertys[attributeName]];
                        if ([className isEqualToString:@"NSDictionary"] || [className isEqualToString:@"NSMutableDictionary"]) {
                            [self performSelectorOnMainThread:setter withObject:value waitUntilDone:YES];
                        }
                        else if (![classString hasPrefix:@"NS"]) {
                            
                            id subObject = [[NSClassFromString(className) alloc] init:value];
                            [self performSelectorOnMainThread:setter withObject: subObject waitUntilDone:YES];
                        }
                        continue;
                    }
                    if ([value isKindOfClass:[NSArray class]]) {
                        
                        if ([className isEqualToString:@"NSArray"] || [className isEqualToString:@"NSMutableArray"] || [className isEqualToString:@"NSString"] || [className isEqualToString:@"NSNumber"] || [className isEqualToString:@"NSDictionary"] || [className isEqualToString:@"NSMutableDictionary"]) {
                            continue;
                        }
                        NSMutableArray *dataArray = [[NSMutableArray alloc] init];
                        for (id dateItem in value) {
                            
                            id subObject = [[NSClassFromString(className) alloc] init:dateItem];
                            [dataArray addObject:subObject];
                        }
                        [self performSelectorOnMainThread:setter withObject:dataArray waitUntilDone:YES];
                        continue;
                    }
                    [self performSelectorOnMainThread:setter withObject:value waitUntilDone:YES];
                }
            }
        }
    }
    propertys = nil;
}

- (NSString *)className:(NSString *)propertyTypeName
{
    NSArray *propertes = [propertyTypeName componentsSeparatedByString:@","];
    if (propertes && propertes.count > 0) {
        
        NSString *name = [propertes objectAtIndex:0];
        if (name && name.length > 4) {
            
            NSString *cName = [[name substringToIndex:[name length] - 1] substringFromIndex:3];
            if ([cName rangeOfString:@"<"].location != NSNotFound) {
                
                NSString *subName = [cName substringFromIndex:[cName rangeOfString:@"<"].location + 1];
                return [subName substringToIndex:[subName length] - 1];
            }
            return cName;
        }
    }
    return nil;
}

- (NSString *)classString:(NSString *)propertyTypeName
{
    NSArray *propertes = [propertyTypeName componentsSeparatedByString:@","];
    if (propertes && propertes.count > 0) {
        
        NSString *name = [propertes objectAtIndex:0];
        if (name && name.length > 4) {
            
            NSString *cName = [[name substringToIndex:[name length] - 1] substringFromIndex:3];
            if ([cName rangeOfString:@"<"].location != NSNotFound) {
                
                NSString *subName = [cName substringToIndex:[cName rangeOfString:@"<"].location + 1];
                return [subName substringToIndex:[subName length] - 1];
            }
            return cName;
        }
    }
    return nil;
}


- (SEL)getSetterAttributeName:(NSString *)attributeName
{
    if (attributeName.length > 0) {
        
        NSString *capital = [[attributeName substringToIndex:1] uppercaseString];
        NSString *setterSelStr = [NSString stringWithFormat:@"set%@%@:",capital,[attributeName substringFromIndex:1]];
        return NSSelectorFromString(setterSelStr);
    }
    return nil;
}

- (NSDictionary *)getObjDictionary
{
    return [self properties_aps];
}

- (NSString *)getObjJsonStr
{
    return [NSJSONSerialization JSONObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:[self getObjDictionary]] options:NSJSONReadingAllowFragments error:nil];
}

@end
