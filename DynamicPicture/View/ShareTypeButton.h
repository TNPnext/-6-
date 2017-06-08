//
//  ShareTypeButton.h
//  Jest
//
//  Created by 段振伟 on 16/4/19.
//  Copyright © 2016年 段振伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareTypeButton : UIButton
+ (instancetype)buttonWithImage:(NSString *)imageName Title:(NSString *)title;
- (void)setButtonWithImage:(NSString *)imageName Title:(NSString *)title;
@end
