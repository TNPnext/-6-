//
//  NSString+JFResourceTranscoding.m
//  WAF
//
//  Created by Kings Yan on 15/11/25.
//  Copyright © 2015年 西安交大捷普网络科技有限公司. All rights reserved.
//

#import "NSString+JFResourceTranscoding.h"

@implementation NSString (JFResourceTranscoding)

- (BOOL)isContainChinese
{
    for (int i = 0; i < self.length; i++) {
        
        int a = [self characterAtIndex:i];
        if ( a > 0x4e00 && a < 0x9fff) {
            return YES;
        }
    }
    return NO;
}

@end
