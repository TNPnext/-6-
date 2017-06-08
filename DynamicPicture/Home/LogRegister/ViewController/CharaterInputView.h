//
//  CharaterInputView.h
//  Jest
//
//  Created by 段振伟 on 16/4/8.
//  Copyright © 2016年 段振伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CharaterInputView : UITextView
/**
 *  暗文
 */
@property (nonatomic, copy) NSString *placeholder;
/**
 *  暗文标签
 */
@property (nonatomic, weak) UILabel *placeholderLabel;
//@property (nonatomic, assign) NSInteger maxLength;

@end
