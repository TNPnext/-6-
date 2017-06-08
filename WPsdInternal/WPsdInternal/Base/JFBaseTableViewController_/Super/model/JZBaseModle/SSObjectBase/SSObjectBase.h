//
//  SSObjectBase.h
//  GSJuZhang
//
//  Created by Kings Yan on 15/1/15.
//  Copyright (c) 2015年 __Qing__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSObjectBase : NSObject <NSCoding>

@property (nonatomic, assign) NSInteger tag;

+ (id)create;
- (BOOL)saveToFile:(NSString *)path;
+ (id)loadFromFile:(NSString *)path;

- (id)initWithCoder:(NSCoder *)aDecoder;

@end
