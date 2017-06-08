//
//  QSNavCustomButton.h
//  VideoShare
//
//  Created by IOS_Doctor on 14-2-14.
//  Copyright (c) 2014年 juche. All rights reserved.
//

#import "JZNavCustomButtons.h"

@implementation JZNavCustomButtons

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        touchRect = CGRectMake(0, 0, 60, 40);
        self.exclusiveTouch = YES;
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        if (![self isLeftButton]) {
            frame.origin.x += 15.0f;
        }
        else{
            frame.origin.x -= 15.0f;
        }
    }
    else{
        if (![self isLeftButton]) {
            frame.origin.x -= 0.0f;
        }
        else{
            frame.origin.x += 0.0f;
        }
    }
    [super setFrame:frame];
}

- (BOOL)isLeftButton
{
    return self.frame.origin.x < (self.superview.frame.size.width / 2);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *tc = [touches anyObject];
    CGPoint p = [tc locationInView:self];
    if (CGRectContainsPoint(touchRect, p)) {
        [super touchesBegan:touches withEvent:event];
    }
}

@end
