//
//  CommentCollectionViewCell.m
//  DynamicPicture
//
//  Created by wpsd on 2016/12/22.
//  Copyright © 2016年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "CommentCollectionViewCell.h"
#import "DynamicPictureCell.h"
#import "CommentTableViewCell.h"
#import "PictureCell.h"
//#import "WPAdTool.h"
#import "ShareView.h"

@interface CommentCollectionViewCell ()<UITableViewDelegate, UITableViewDataSource, PictureCellDelegate, CommentTableViewCellDelegate>

@property (strong, nonatomic) UIButton *cover;
@property (strong, nonatomic) CommentFrameModel *commentFrame;
@property (strong, nonatomic) PictureFrameModel *picFrame;

@end

@implementation CommentCollectionViewCell


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainWidth, kMainHeight - 50) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor hexStringToColor:@"F3F3F3"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.tableView];
       // [[WPAdTool shareInstance] addAdToTableView:self.tableView row:1 adType:kAdTypeIFBanner];
    }
    return self;
}

#pragma mark - tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
            
        case 1:
            return 3;
            break;
            
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString *dynamicID = @"dynamicCell";
        PictureCell *cell = [tableView dequeueReusableCellWithIdentifier:dynamicID];
        if (!cell) {
            cell = [[PictureCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:dynamicID];
        }
//        PictureFrameModel *frameModel = [PictureFrameModel new];
//        DynamicPictureCellModel *model = [DynamicPictureCellModel new];
//        model.title = @"这条大狗我给100分";
//        model.image = @"IMG_4930.jpg";
//        model.support = @"100";
//        model.opposition = @"123";
//        model.share = @"233";
//        frameModel.pictureModel = model;
//        self.picFrame = frameModel;
//        cell.picFrameModel = frameModel;
//        cell.delegate = self;
        return cell;
    }
    static NSString *dynamicID = @"dynamicCell";
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dynamicID];
    if (!cell) {
        cell = [[CommentTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:dynamicID];
        CommentFrameModel *frameModel = [CommentFrameModel new];
        CommentModel *commentModel = [CommentModel new];
//        commentModel.title = @"重庆网友";
//        commentModel.content = @"对不起，昨晚又梦游到你老公房间里了对不起，昨晚又梦游到你老公房间里了";
//        commentModel.time = @"12-15 10:36";
//        commentModel.supportCount = @"122";
//        frameModel.commentModel = commentModel;
//        self.commentFrame = frameModel;
//        cell.commentFrameModel = frameModel;
//        cell.delegate = self;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainWidth, 30)];
        titleView.backgroundColor = [UIColor whiteColor];
        
        UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [titleBtn setImage:[UIImage imageNamed:@"形状-27"] forState:UIControlStateNormal];
        [titleBtn setTitle:@"网友评论" forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor hexStringToColor:@"#D43D3D"] forState:UIControlStateNormal];
        [titleBtn sizeToFit];
        titleBtn.frame = CGRectMake(15, (titleView.height - titleBtn.height) / 2, titleBtn.width, titleBtn.height);
        [titleView addSubview:titleBtn];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, titleView.height - 1, kMainWidth, 1)];
        lineView.backgroundColor = [UIColor hexStringToColor:@"#E3E3E3"];
        [titleView addSubview:lineView];
        
        return titleView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return self.picFrame.cellHeight;
    }
    if (indexPath.section == 1) {
        return self.commentFrame.commentCellHeight;
    }
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (!section) {
        return 68;
    }
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

#pragma mark - pictureCell delegate

- (void)pictureCell:(PictureCell *)pictureCell toolBarButtonDidClick:(UIButton *)sender {
    switch (sender.tag) {
        case 100: {
            if (sender.isSelected) {
                return;
            }
            sender.selected = YES;
        }
            break;
            
        case 101:
            if (sender.isSelected) {
                return;
            }
            sender.selected = YES;
            break;
            
        case 102:
            [self setupShareView];
            break;
            
        default:
            break;
    }
}

// 弹出shareView
- (void)setupShareView{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIButton *cover =[ UIButton buttonWithType:UIButtonTypeCustom];
    cover.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    cover.frame = window.bounds;
    //    cover.tag = 20000;
    [cover addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
    [window addSubview:cover];
    self.cover = cover;
    CGFloat shareHeight = 190;
    ShareView *shareView = [[ShareView alloc] initWithFrame:CGRectMake(0,kMainHeight+ kMainHeight / 2, kMainWidth, shareHeight)];
    [self.cover addSubview:shareView];
    [UIView animateWithDuration:0.3 animations:^{
        shareView.top = kMainHeight - shareHeight;
    }];
    shareView.shareblock = ^(ShareType type){
        switch (type) {
            case shareWeixinfriend:{
                NSLog(@"点击了shareWeixinfriend");
                
                [self coverClick];
            }
                break;
            case shareMoment:{
                
                NSLog(@"点击了shareMoment");
                
                [self coverClick];
            }
                break;
            case shareQQ:{
                
                NSLog(@"点击了shareQQ");
                
                [self coverClick];
            }
                break;
            case shareQZone:{
                
                NSLog(@"点击了shareQZone");
                
                [self coverClick];
            }
                break;
            case shareSina:{
                
                NSLog(@"点击了shareSina");
                
                [self coverClick];
            }
                break;
            case shareClose:
                NSLog(@"点击了shareClose");
                [self coverClick];
                break;
                
            default:
                break;
        }
        
        
    };
}

//收起shareView
-(void)coverClick
{
    __block  UIButton *cover = self.cover;
    cover.alpha = 0;
    [cover removeFromSuperview];
    
}

#pragma mark - commentTableViewCell delegate

- (void)commentTableViewCell:(CommentTableViewCell *)commentTableViewCell supportButtonDidClick:(UIButton *)sender {
    if (sender.isSelected) {
        return;
    }
    sender.selected = YES;
}


@end
