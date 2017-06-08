//
//  NSArrayToJsonArray.m
//  JZ_DEMO
//
//  Created by John Duan on 15/1/5.
//  Copyright (c) 2015年 JohnDuan. All rights reserved.
//

#import "WriteJson.h"

@implementation WriteJson

+ (NSString *)resourceWithArray:(NSArray *)array//传入数组形式是[{},{}];
{
    NSMutableString *string = [[NSMutableString alloc]init];
    NSMutableString *jsonString = [[NSMutableString alloc]init];
    NSMutableString *string2;
    for (int i = 0; i < array.count; i++) {
        NSArray *keyArray = [array[i] allKeys];
        for (int j = 0 ; j < keyArray.count; j++) {
            string2 = [NSMutableString stringWithFormat:@"\"%@\":\"%@\",",keyArray[j],[array[i] objectForKey:keyArray[j]]];
            [string appendString:string2];
            if (j == keyArray.count - 1) {
                [string insertString:@"{" atIndex:0];
                NSUInteger location = [string length]-1;
                NSRange range       = NSMakeRange(location, 1);
                [string replaceCharactersInRange:range withString:@"}"];
            }
        }
        NSUInteger location = 0;
        NSRange range = NSMakeRange(location, string.length);
        [jsonString appendString:@","];
        [jsonString appendString:string];
        [string deleteCharactersInRange:range];
    }
    NSUInteger location = 0;
    NSRange range = NSMakeRange(location, 1);
    [jsonString replaceCharactersInRange:range withString:@"["];
    [jsonString insertString:@"]" atIndex:jsonString.length];
    return jsonString;
}

@end
