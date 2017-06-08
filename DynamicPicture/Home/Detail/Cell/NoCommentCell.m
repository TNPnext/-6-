//
//  NoCommentCell.m
//  Jest
//
//  Created by TNP on 16/11/11.
//  Copyright © 2016年 WPSD. All rights reserved.
//

#import "NoCommentCell.h"

@implementation NoCommentCell
+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *NoCommentID = @"NoCommentCell";
    NoCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:NoCommentID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NoCommentID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        UIImage *img = [UIImage imageNamed:(@"qiangshafa")];
        UIImageView *placeImg = [[UIImageView alloc]initWithFrame:CGRectMake((kMainWidth-img.size.width)/2, (kMainHeight/3-img.size.height)/2-10, img.size.width, img.size.height)];
        placeImg.image = img;
        [self.contentView addSubview:placeImg];
        
        UILabel *_title = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(placeImg.frame), CGRectGetMaxY(placeImg.frame)+10, img.size.width, 20)];
        _title.text = @"快来抢沙发!";
        _title.textAlignment = NSTextAlignmentCenter;
        _title.adjustsFontSizeToFitWidth = YES;
        _title.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_title];
    }
    return  self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
