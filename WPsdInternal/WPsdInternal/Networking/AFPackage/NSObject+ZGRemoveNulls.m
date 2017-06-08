//
//  NSObject+ZGRemoveNulls.m
//  AppChatroom
//
//  Created by Kings Yan on 13-10-19.
//  Copyright (c) 2013年 juche. All rights reserved.
//

#import "NSObject+ZGRemoveNulls.h"

@implementation NSObject (ZGRemoveNulls)

- (void)removeNulls
{
    //do nothing
}

- (id)exchangeToMutableObj
{
    return self;
}

@end


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation NSMutableArray (ZGRemoveNulls)

- (id)exchangeToMutableObj
{
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:self];
    return array;
}

- (void)removeNulls
{
    [self removeObject:[NSNull null]];
    NSMutableArray *source = [NSMutableArray new];
    for (NSObject *child in self) {
        
       NSObject *obj = [child exchangeToMutableObj];
        [obj removeNulls];
        [source addObject:obj];
    }
    [self removeAllObjects];
    [self addObjectsFromArray:source];
}

@end


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation NSMutableDictionary (ZGRemoveNulls)

- (id)exchangeToMutableObj
{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithDictionary:self];
    return dictionary;
}

- (void)removeNulls
{
    NSNull *null = [NSNull null];
    NSMutableArray *nulls = [NSMutableArray new];
    for (NSObject *key in self.allKeys) {
        NSObject *value = self[key];
        if (value == null) {
            [nulls addObject:key];
        }
        else{
            value = [value exchangeToMutableObj];
            [value removeNulls];
        }
    }
    for (NSString *key in nulls) {
        [self removeObjectForKey:key];
    }
}

@end



