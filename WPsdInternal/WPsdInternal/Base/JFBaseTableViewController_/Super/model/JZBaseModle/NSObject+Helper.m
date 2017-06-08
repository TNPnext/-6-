//
//  NSObject+Helper.m
//  GSJuZhang
//
//  Created by Kings Yan on 15/1/15.
//  Copyright (c) 2015年 __Qing__. All rights reserved.
//

#import "NSObject+Helper.h"
#import <objc/runtime.h>

@implementation NSObject (Helper)
//对象转字典
- (NSDictionary *)properties_aps
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    
    for (i = 0; i < outCount; i++) {
        
        objc_property_t property = properties[i];
        const char *propertyName_c = property_getName(property);
        const char *attDes = property_getAttributes(property);
        NSString *classDes = [NSString stringWithUTF8String:attDes];
        NSArray *tempArray = [classDes componentsSeparatedByString:@"\""];
        NSString *nameForClass = nil;
        @try {
            if (tempArray && tempArray.count > 1) {
                
                nameForClass = [tempArray objectAtIndex:1];
                if ([nameForClass rangeOfString:@"<"].location != NSNotFound) {
                    nameForClass = [nameForClass substringToIndex:[nameForClass rangeOfString:@"<"].location];
                }
            }
        }
        @catch (NSException *exception) {
#if DEBUG
            NSLog(@"Exception:%@",exception.description);
#endif
            continue;
        }
        @finally {
            
        }
        
        Class myClass = NSClassFromString(nameForClass);
        
        if ([myClass isSubclassOfClass:[UIImage class]] ||
           [myClass isSubclassOfClass:[UIView class]] ||
           [myClass isSubclassOfClass:[UIViewController class]] ||
           [myClass isSubclassOfClass:[UIControl class]]) {
            continue;
        }
        
        NSString *propertyName = [NSString stringWithUTF8String:propertyName_c];
        id propertyValue = [self valueForKey:propertyName];
        
        if (propertyValue) {
            
            if ([myClass isSubclassOfClass:[NSString class]] || [myClass isSubclassOfClass:[NSNumber class]]) {
                [props setObject:propertyValue forKey:propertyName];
            }
            else if ([myClass isSubclassOfClass:[NSArray class]] || [myClass isSubclassOfClass:[NSDictionary class]]) {
                
                NSMutableArray *ary = [[NSMutableArray alloc] init];
                for (id subValue in propertyValue) {
                    
                    NSDictionary *subDic = [subValue properties_aps];
                    [ary addObject:subDic];
                }
                if (ary.count > 0) {
                    [props setValue:ary forKey: propertyName];
                }
            }
            else{
                NSDictionary *proDictionary = [propertyValue properties_aps];
                if (proDictionary) {
                    [props setObject:proDictionary forKey:propertyName];
                }
                else{
//                    [props setObject:[NSNull null] forKey:propertyName];
                }
            }
        }
        else{
//            [props setObject:[NSNull null] forKey:propertyName];
        }
    }
    free(properties);
    return props;
}

@end
