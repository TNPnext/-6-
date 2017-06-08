//
//  QSNavCustomButton.h
//  VideoShare
//
//  Created by Kings Yan on 14-2-14.
//  Copyright (c) 2014年 juche. All rights reserved.
//

#import "YNavCustomButtons.h"

@interface YNavCustomButtons ()

@property (nonatomic, assign, readwrite) JZNavCustomButtonPosition position;

@end

@implementation YNavCustomButtons

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        touchRect = CGRectMake(0, 0, 60, 40);
        self.exclusiveTouch = YES;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.clipsToBounds         = YES;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame position:(JZNavCustomButtonPosition)position
{
    if (self = [self initWithFrame:frame]) {
        self.position = position;
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
    return _position == JZNavCustomButtonLeft;
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
