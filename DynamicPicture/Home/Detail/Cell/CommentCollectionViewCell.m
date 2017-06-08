//
//  CommentCollectionViewCell.m
//  DynamicPicture
//
//  Created by wpsd on 2016/12/22.
//  Copyright © 2016年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "CommentCollectionViewCell.h"
#import "CommentTableViewCell.h"
#import "PictureCell.h"
#import "ShareView.h"
#import "HeaderBtn.h"
#import "DynamicPictureModel.h"
#import "DPHttpTool.h"
#import "ADModel.h"
#import "MJExtension.h"
#import "ADTableViewCell.h"
UIKIT_EXTERN NSString *const DetailUserInfoKey;

@interface CommentCollectionViewCell ()<UITableViewDelegate, UITableViewDataSource, PictureCellDelegate, CommentTableViewCellDelegate>
{
    ADModel *_ADModel;
}
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
        NSDictionary *ADdic = [[NSUserDefaults standardUserDefaults]objectForKey:@"ADData"];
        _ADModel = [ADModel mj_objectWithKeyValues:ADdic];
        
    }
    return self;
}

#pragma mark - tableView dataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
            
        case 2:
            if(self.commentModels.count)
            return self.commentModels.count;
            return 1;
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
        PictureFrameModel *frameModel = [PictureFrameModel new];
        frameModel.pictureModel = self.dynamicPictureModel;
        self.picFrame = frameModel;
        cell.picFrameModel = frameModel;
        cell.delegate = self;
     
        if(indexPath.row == 0)
        {
            [self loadPictureCell:cell];
        }
        return cell;
    }
    else if (indexPath.section == 2)
    {
    static NSString *commentID = @"commentTableViewCell";
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:commentID];
    if (!cell) {
        cell = [[CommentTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:commentID];
    }
    CommentFrameModel *frameModel = [CommentFrameModel new];
    if (self.commentModels.count > indexPath.row) {
        frameModel.commentModel = self.commentModels[indexPath.row];
    }
    self.commentFrame = frameModel;
    cell.commentFrameModel = frameModel;
    cell.delegate = self;
    
    if(!self.commentModels.count)
    {
        NoCommentCell *cell = [NoCommentCell cellWithTableView:tableView];
        return cell;
    }else
    {
        return cell;
    }
    }
    else
    {
        //广告
        ADTableViewCell *cell = [ADTableViewCell cellWithTableView:tableView];
        [cell.ADImage sd_setImageWithURL:[NSURL URLWithString:_ADModel.ad_img] placeholderImage:nil];
        return [_ADModel.ad_ios_show boolValue]?cell:[UITableViewCell new];
        
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1)
    {
        if (self.delegate &&[self.delegate respondsToSelector:@selector(ADCellClick)])
        {
            [self.delegate ADCellClick];
        }
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainWidth, 30)];
        titleView.backgroundColor = [UIColor whiteColor];
        
        HeaderBtn *titleBtn = [HeaderBtn buttonWithType:UIButtonTypeCustom];
        [titleBtn setImage:[UIImage imageNamed:@"形状-27"] forState:UIControlStateNormal];
        [titleBtn setTitle:@" 网友评论" forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor hexStringToColor:KNavBarHexColor] forState:UIControlStateNormal];
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
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
   else if (indexPath.section == 2) {
        
        if(!self.commentModels.count)
        {
            return kMainHeight/3.f;
        }else
        {
            return self.commentFrame ? self.commentFrame.commentCellHeight : 0;
        }
    }else
    {
        int height = (kMainWidth/[_ADModel.ad_img_width intValue])*[_ADModel.ad_img_height intValue];
        //广告高
        return [_ADModel.ad_ios_show boolValue]?height:0;
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 65;
    }else if (section == 2)
    {
    return 30;
    }else
    {
        return 0.01;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

#pragma mark - pictureCell delegate

- (void)pictureCell:(PictureCell *)pictureCell toolBarButtonDidClick:(UIButton *)sender {
    switch (sender.tag) {
        case 100: {
            if (sender.isSelected) {
//                sender.enabled = NO;
                return;
            }
            
            [self postUserActionWithType:kTapTypeUp];
            [[NSNotificationCenter defaultCenter] postNotificationName:DETAIL_MODIFY_NOTICE object:nil userInfo:@{DetailNoticeTypeUserInfoKey: @"0",DetailNoticeModelUserInfoKey: @[self.dynamicPictureModel]}];
            sender.selected = YES;
        }
            break;
            
        case 101: {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:DETAIL_MODIFY_NOTICE object:nil userInfo:@{DetailNoticeTypeUserInfoKey: @"1",DetailNoticeModelUserInfoKey: @[self.dynamicPictureModel]}];
        }
            break;
            
        case 102: {
            [[NSNotificationCenter defaultCenter] postNotificationName:DETAIL_MODIFY_NOTICE object:nil userInfo:@{DetailNoticeTypeUserInfoKey: @"10",DetailNoticeModelUserInfoKey: @[self.dynamicPictureModel]}];
        }
            break;
            
        case 103: {
            [self setupShareView:pictureCell];
        }
            break;
        case 105: {
            
        }
            break;
        default:
            break;
    }
}

- (void)pictureCell:(PictureCell *)pictureCell GIFLoaded:(DynamicPictureModel *)model imageSize:(CGSize)imageSize {

}

- (void)postUserActionWithType:(TapType)tapType {
    NSString *pictureID = self.dynamicPictureModel.base_id.length ? self.dynamicPictureModel.base_id : @"";
    NSString *type = [NSString stringWithFormat:@"%lu", tapType];
    [DPHttpTool postUserActionWithPictureID:pictureID type:type success:^(NSURLSessionDataTask *task, id responceObject) {

    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        DLog(@"%@", error);
    }];
}

// 弹出shareView
- (void)setupShareView:(PictureCell *)pictureCell
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:_ADModel.share_url];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"链接已复制到粘贴板" message:@"请到QQ、微信、浏览器等粘贴即可" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)loadPictureCell:(PictureCell *)cell;
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(commectCollectionDetailPictureCell:)])
    {
        [self.delegate commectCollectionDetailPictureCell:cell];
    }
}

#pragma mark - commentTableViewCell delegate

- (void)commentTableViewCell:(CommentTableViewCell *)commentTableViewCell supportButtonDidClick:(UIButton *)sender {
    if (sender.isSelected) {
        sender.userInteractionEnabled = NO;
        return;
    }
    NSIndexPath *indexPath = [self.tableView indexPathForCell:commentTableViewCell];
    [self postCommentUpWithIndex:indexPath.row supportBtn:sender];
    sender.selected = YES;
}

- (void)commentTableViewCell:(CommentTableViewCell *)commentTableViewCell reportButtonDidClick:(UIButton *)sender {
    if (sender.isSelected) {
        sender.enabled = NO;
        return;
    }
    NSIndexPath *indexPath = [self.tableView indexPathForCell:commentTableViewCell];
    [self reportWithIndex:indexPath.row];
    sender.selected = YES;
}

- (void)postCommentUpWithIndex:(NSInteger)cellRow supportBtn:(UIButton *)supportBtn{
    if (self.commentModels.count <= cellRow) {
        return;
    }
    CommentModel *currentModel = self.commentModels[cellRow];
    NSString *itemID = currentModel.itemid.length ? currentModel.itemid : @"";
    [DPHttpTool postCommentUpWithItemID:itemID success:^(NSURLSessionDataTask *task, id responceObject) {
        //        DLog(@"%@", responceObject);
        currentModel.goodnum = [NSString stringWithFormat:@"%d", [currentModel.goodnum intValue] + 1];
        currentModel.supportSeleted = YES;
        self.commentModels[cellRow] = currentModel;
        [self.tableView reloadData];
        if ([self.delegate respondsToSelector:@selector(commentCollectionViewCell:supportBtnClick:commentModels:)]) {
            supportBtn.tag = cellRow;
            [self.delegate commentCollectionViewCell:self supportBtnClick:supportBtn commentModels:[self.commentModels mutableCopy]];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        DLog(@"%@", error);
    }];
}

- (void)reportWithIndex:(NSInteger)cellRow {
    CommentModel *currentModel = self.commentModels[cellRow];
    NSString *itemID = currentModel.itemid.length ? currentModel.itemid : @"";
    [DPHttpTool postCommentReportWithItemID:itemID success:^(NSURLSessionDataTask *task, id responceObject) {
//        DLog(@"%@", responceObject);
        [MBProgressHUD showSuccess:@"举报成功"];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        DLog(@"%@", error);
    }];
}

@end
