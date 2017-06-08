//
//  QSNavCustomButton.h
//  VideoShare
//
//  Created by Kings Yan on 14-2-14.
//  Copyright (c) 2014年 juche. All rights reserved.
//

#import "YNavCustomButton.h"
#import "JZDevice.h"
#import "UIView+Category.h"


@interface YNavCustomButton ()

@property (nonatomic, assign) dispatch_once_t __once__;
@property (nonatomic, assign, readwrite) JZNavCustomButtonPosition position;

@end

@implementation YNavCustomButton

@synthesize __once__ = ___once__;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        touchRect = CGRectMake(0, 0, currentScreenWidth() / 2, 44);
        self.exclusiveTouch        = YES;
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
        if ([self isLeftButton]) {
            frame.origin.x -= 7.0f;
        }
        else{
            frame = CGRectMake(self.superview.width - (frame.size.width + 9), 4, frame.size.width, 36);
        }
    }
    else{
        if ([self isLeftButton]) {
            frame.origin.x -= -6.0f;
        }
        else{
            frame.origin.x += -6.0f;
        }
    }
//    CGFloat imgOffset   = 5;
//    CGFloat titleOffset = 10;
//        [self setImageEdgeInsets:UIEdgeInsetsMake(10.0, -imgOffset, 10.0, imgOffset)];
//        [self setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -titleOffset, 0.0, titleOffset)];
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
