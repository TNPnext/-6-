//
//  XBBadgeView.m
//  fangli
//
//  Created by Kings Yan on 14-2-13.
//  Copyright (c) 2014年 ethan. All rights reserved.
//

#import "XBBadgeView.h"
#import "UIView+Category.h"

@interface XBBadgeView()

@property (nonatomic, strong) UILabel *label;

@end

@implementation XBBadgeView

- (id)init {
    self = [super init];
    if (self) {

    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.image = [[UIImage imageNamed:@"tab_icon_bubble"] stretchableImageWithLeftCapWidth:16/2.0f topCapHeight:14/2.0f];
        self.deltaY = 2;
        self.deltaX = 0;
        self.font = [UIFont boldSystemFontOfSize:14.0f];
        self.backgroundColor = [UIColor clearColor];
        self.label = [[UILabel alloc] init];
        self.label.textColor = [UIColor whiteColor];
        self.label.backgroundColor = [UIColor clearColor];
        self.label.font = self.font;
        [self addSubview:self.label];
    }
    return self;
}

- (void)setBadgeString:(NSString *)badgeString {
    if (_badgeString != badgeString) {
        _badgeString = [badgeString copy];
        
        self.label.text = _badgeString;
        if (_badgeString.length > 0) {
            self.image = [[UIImage imageNamed:@"tab_icon_bubble"] stretchableImageWithLeftCapWidth:16/2.0f topCapHeight:14/2.0f];
            [self.label sizeToFit];
            CGFloat maxHeight = MAX(self.image.size.height, self.label.height + 3);
            CGFloat maxWidth = MAX(self.label.width+8, self.image.size.width + 3);
            self.height = maxHeight;
            self.width = maxWidth;
        } else {
            self.image = [[UIImage imageNamed:@"gen_notification"] stretchableImageWithLeftCapWidth:9/2.0f topCapHeight:9/2.0f];
            self.height = self.image.size.height;
            self.width = self.image.size.width;
            self.label.frame = self.bounds;
        }
        self.label.left = self.width/2 - self.label.width/2 - self.deltaX/2;
        self.label.top = self.height/2 - self.label.height/2 - self.deltaY/2;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
