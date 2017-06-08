//
//  ShareTypeButton.m
//  Jest
//
//  Created by 段振伟 on 16/4/19.
//  Copyright © 2016年 段振伟. All rights reserved.
//

#import "ShareTypeButton.h"

@interface ShareTypeButton()
//@property (nonatomic, strong) UIFont *titleFont;
@end
@implementation ShareTypeButton

+ (instancetype)buttonWithImage:(NSString *)imageName Title:(NSString *)title{
    
    ShareTypeButton *button = [self buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    //[button setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    return button;
}
- (void)setButtonWithImage:(NSString *)imageName Title:(NSString *)title{
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    //[self setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
    [self setTitle:title forState:UIControlStateNormal];
}
/**
 *  从文件中解析一个对象的时候就会调用这个方法
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder]) {
        [self setup];
    }
    return self;
}

/**
 *  通过代码创建控件的时候就会调用
 */
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

/**
 *  初始化
 */
- (void)setup
{
//    self.titleFont = [UIFont systemFontOfSize:14];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    self.titleLabel.textColor = [UIColor blackColor];
    
    // 图标居中
    self.imageView.contentMode = UIViewContentModeCenter;
    //self.imageView.userInteractionEnabled = YES;
}


/**
 *  控制器内部label的frame
 *  contentRect : 按钮自己的边框
 */
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:12]};
    CGFloat titleW;
    titleW = [self.currentTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
    CGFloat titleH = contentRect.size.height;
    CGFloat titleX = (contentRect.size.width - titleW) / 2;
    CGFloat titleY = contentRect.size.height - self.imageView.frame.size.height;
    if (IS_IPHONE_5 || IS_IPHONE_4) {
      return CGRectMake(titleX, titleY+25, titleW, titleH);
    }
    else
    {
      return CGRectMake(titleX, titleY+15, titleW, titleH);
    }
    
}

/**
 *  控制器内部imageView的frame
 */
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = self.currentImage.size.width;
    CGFloat imageX = (contentRect.size.width - imageW) / 2;
    CGFloat imageY = 0;
    CGFloat imageH = self.currentImage.size.height;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

@end
