//
//  COModelCell.m
//  GSJuZhang
//
//  Created by Kings Yan on 15/1/15.
//  Copyright (c) 2015年 __Qing__. All rights reserved.
//

#import "JZModelCell.h"

@implementation JZModelCell
@synthesize model    = _model,
idx                  = _idx,
separatorViewLeft    = _separatorViewLeft,
sectionIdx           = _sectionIdx,
separatorView        = _separatorView;

//- (void)dealloc
//{
//#if DEBUG
//    NSLog(@"<<<%@>>>", self);
//#endif
//}

- (void)setIsApearSeparatorView:(BOOL)isApearSeparatorView
{
    self.separatorView.hidden = !isApearSeparatorView;
}

- (void)setSeparatorViewColor:(UIColor *)separatorViewColor
{
    self.separatorView.backgroundColor = separatorViewColor;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.clipsToBounds = YES;
        self.clipsToBounds             = YES;
        self.separatorViewLeft         = 0;
        self.separatorViewHeight       = 0.7;
        
//        self.separatorView = [[UIImageView alloc] init];
//        self.separatorView.backgroundColor = RGB(230, 230, 230);
//        self.separatorView.image = [UIImage imageNamed:@"gen_list_line"];
//        [self.contentView addSubview:self.separatorView];
        
        self.isApearSeparatorView = NO; // < default set.
    }
    return self;
}

//- (void)drawRect:(CGRect)rect { CGContextRef context = UIGraphicsGetCurrentContext(); CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor); CGContextFillRect(context, rect); //上分割线，
//    CGContextSetStrokeColorWithColor(context, [UIColor colorWithHexString:@"ffffff"].CGColor); CGContextStrokeRect(context, CGRectMake(5, -1, rect.size.width - 10, 1)); //下分割线
//    CGContextSetStrokeColorWithColor(context, [UIColor colorWithHexString:@"e2e2e2"].CGColor); CGContextStrokeRect(context, CGRectMake(5, rect.size.height, rect.size.width - 10, 1));
//}

- (void)layoutSubviews
{
    [super layoutSubviews];
//     self.separatorView.frame = CGRectMake(self.separatorViewLeft, self.contentView.height - self.separatorViewHeight - self.separatorViewLeft, self.contentView.width, self.separatorViewHeight);
}

- (void)setModel:(JFBaseModel *)model
{
    _model = model;
    // could be implement be subviews...
}

+ (CGFloat)heightWithModel:(JFBaseModel *)model
{
    // could subController implement ...
    return 60; // < default return 60.
}

@end
