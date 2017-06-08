//
//  JFRefreshView.h
//  WAF
//
//  Created by Kings Yan on 15/9/28.
//  Copyright © 2015年 西安交大捷普网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *     微信样式的刷新控件，由表格基础类调用
 */
@interface JFRefresh : UIView

@property (nonatomic, copy) void (^beginRefresh)();

- (void)stopRfresh;

- (void)scrollDidScroll:(UIScrollView *)scrollView;

- (void)scrollDidEndDragging:(UIScrollView *)scrollView;

@end
