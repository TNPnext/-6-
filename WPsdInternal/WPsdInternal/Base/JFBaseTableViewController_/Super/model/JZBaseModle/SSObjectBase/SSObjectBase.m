//
//  SSObjectBase.m
//  GSJuZhang
//
//  Created by Kings Yan on 15/1/15.
//  Copyright (c) 2015年 __Qing__. All rights reserved.
//

#import "SSObjectBase.h"
#import "objc/runtime.h"

@implementation SSObjectBase

+ (id)create
{
    return [[[self class] alloc] init];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        
        unsigned int outCount = 0;
        objc_property_t *properties = class_copyPropertyList([self class], &outCount);
        
        @try {
            for (int i = 0; i < outCount; i++) {
                
                objc_property_t property = properties[i];
                NSString *key = [[NSString alloc] initWithCString:property_getName(property)
                                                       encoding:NSUTF8StringEncoding];
                if (key) {
                    
                    id value = [aDecoder decodeObjectForKey:key];
                    if (value) {
                        [self setValue:value forKey:key];
                    }
                }
            }
        }
        @catch (NSException *exception) {
#if DEBUG
            NSLog(@"Exception: %@", exception);
#endif
            return nil;
        }
        @finally {
            
        }
        
        free(properties);
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    unsigned int outCount = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (int i = 0; i < outCount; i++) {
        
        objc_property_t property = properties[i];
        NSString *key = [[NSString alloc] initWithCString:property_getName(property)
                                               encoding:NSUTF8StringEncoding];
        
        if (key) {
            
            id value = [self valueForKey:key];
            if (value) {
                if ([value isKindOfClass:[NSObject class]]) {
                    [aCoder encodeObject:value forKey:key];
                }
                else{
                    NSNumber * v = [NSNumber numberWithInt:(int)value];
                    [aCoder encodeObject:v forKey:key];
                }
            }
        }
    }
    free(properties);
    properties = NULL;
    
//        NSString *propertyType = [NSString stringWithCString: property_getAttributes(property) encoding:NSUTF8StringEncoding];
//        NSLog(@"...... %@", propertyType);
//        
//        id value = [self valueForKey:key];
//        if (value==nil) {
//            continue;
//        }
//        if ([propertyType hasPrefix:@"T@"]) {
//            //对象
////            NSString * objName = [propertyType substringWithRange:NSMakeRange(3, [propertyType rangeOfString:@","].location-4)];
////            NSLog(@"%@", objName);
//            [aCoder encodeObject:value forKey:key];
//        } else if([propertyType hasPrefix:@"T{"]) {
//            //
////            NSString * objName = [propertyType substringWithRange:NSMakeRange(2, [propertyType rangeOfString:@"="].location-2)];
////            NSLog(@"%@", objName);
//            [aCoder encodeObject:value forKey:key];
//        } else {
//            
//            [aCoder encodeInt:(int)value forKey:key];
//            
//            //基本类型
//            propertyType = [propertyType lowercaseString];
//            if ([propertyType hasPrefix:@"ti"]) {
//                //int
//                [aCoder encodeInt:(int)value forKey:key];
//            } else if ([propertyType hasPrefix:@"tf"]) {
//                //float
//                [aCoder encodeFloat:(NSInteger)value forKey:key];
//            } else if([propertyType hasPrefix:@"td"]) {
//                //double
//                [aCoder encodeFloat:(NSInteger)value forKey:key];
//            } else if([propertyType hasPrefix:@"tl"]) {
//                //long
//                [aCoder encodeFloat:(NSInteger)value forKey:key];
//            } else if ([propertyType hasPrefix:@"tc"]) {
//                //char
//                [aCoder encodeFloat:(NSInteger)value forKey:key];
//            } else if([propertyType hasPrefix:@"ts"]) {
//                //short
//                [aCoder encodeFloat:(NSInteger)value forKey:key];
//            } else {
//                //NSString
//                [aCoder encodeObject:value forKey:key];
//            }
//        }
    
}

- (BOOL)saveToFile:(NSString *)path
{
    return [NSKeyedArchiver archiveRootObject:self toFile:path];
}

+ (id)loadFromFile:(NSString *)path
{
    id obj = nil;
    @try {
        obj = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    }
    @catch (NSException *exception) {
        obj = nil;
#if DEBUG
        NSLog(@"Exception : %@", exception);
#endif
    }
    @finally {
        
    }
    return obj;
}

@end
