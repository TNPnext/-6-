//
//  CharaterInputView.m
//  Jest
//
//  Created by 段振伟 on 16/4/8.
//  Copyright © 2016年 段振伟. All rights reserved.
//

#import "CharaterInputView.h"

@implementation CharaterInputView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupPlaceholderLabel];
        self.font = [UIFont systemFontOfSize:14];
        // 设置内容容器的内边距，适应光标位置
        self.textContainerInset = UIEdgeInsetsMake(10, 0, 10, 0);
//        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)setupPlaceholderLabel{
    UILabel *placeholderLabel = [[UILabel alloc] init];
    placeholderLabel.textColor = [UIColor lightGrayColor];
    placeholderLabel.hidden = YES;
    placeholderLabel.font = [UIFont systemFontOfSize:14];
    placeholderLabel.textAlignment = NSTextAlignmentLeft;
    placeholderLabel.numberOfLines = 0;
    placeholderLabel.backgroundColor = [UIColor clearColor];
    placeholderLabel.frame = CGRectMake(7, 0, self.frame.size.width - 14, 30);
    [self insertSubview:placeholderLabel atIndex:0];
    self.placeholderLabel = placeholderLabel;
    // 监听文字的输入
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    
}

- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = [placeholder copy];
    self.placeholderLabel.text = placeholder;
    
    if (placeholder.length) {
        self.placeholderLabel.hidden = NO;
    } else {
        self.placeholderLabel.hidden = YES;
    }
}
/**
 *  有文字输入就会隐藏暗文标签
 */
- (void)textDidChange {
    self.placeholderLabel.hidden = (self.text.length != 0);
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
