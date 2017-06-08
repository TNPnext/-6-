//
//  DetailViewController.m
//  DynamicPicture
//
//  Created by wpsd on 2016/12/22.
//  Copyright © 2016年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "DetailViewController.h"
#import "DPToolBar.h"
#import "DynamicPictureCell.h"
#import "CommentTableViewCell.h"
#import "CommentCollectionViewCell.h"
#import "WEInformationNavBar.h"
#import "DynamicPictureModel.h"
#import "DPHttpTool.h"
#import <Public_h.h>
#import "DPCommentTool.h"
#import "HTPlayer.h"
#import "PictureCell.h"
#import "ADWebViewController.h"
#import "MJExtension.h"
#import "MLoginView.h"
@interface DetailViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate, DPToolBarDelegate, CommentCollectionViewCellDelegate,HTPlayerDelegate>
{
  BOOL _isPlayerEnd;//播放结束
    PictureCell *_playingCell;
}

@property (strong, nonatomic) HTPlayer *htPlayer;
@property (strong, nonatomic) DPToolBar *toolBar;
@property (strong, nonatomic) DynamicPictureModel *picCellModel;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (assign, nonatomic) NSInteger currentIndex;
@property (strong, nonatomic) UITableView *currentTableView;
@property (strong, nonatomic) NSMutableArray *commetModels;

@end

@implementation DetailViewController
{
    WEInformationNavBar *_navBar; //导航栏
}

static NSString *collectionCellID = @"collectionCellID";

- (NSMutableArray *)commetModels {
    if (!_commetModels) {
        _commetModels = [NSMutableArray array];
    }
    return _commetModels;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = [UIScreen mainScreen].bounds.size;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.bounces = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[CommentCollectionViewCell class] forCellWithReuseIdentifier:collectionCellID];
    }
    return _collectionView;
}

- (void)commectCollectionDetailPictureCell:(PictureCell *)cell
{
    [self stopPlayer];
    [cell.pauseOrPlayBtn addTarget:self action:@selector(videoPlay:) forControlEvents:(UIControlEventTouchUpInside)];
}
#pragma mark 开始播放视频
-(void)videoPlay:(UIButton *)sender
{
    PictureCell *cell = (PictureCell *)sender.superview.superview.superview;
    _playingCell = cell;
    DynamicPictureModel *model = cell.picFrameModel.pictureModel;
    if ([model.is_ad boolValue])
    {
        ADWebViewController *ADVC = [ADWebViewController new];
        ADVC.urls = model.ad_url;
        ADVC.titles = model.title;
        [ADVC setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:ADVC animated:YES];
        return;
    }
    else if ([cell.picFrameModel.pictureModel.price intValue]>0)
    {
        [self AlerShowLoginOrPayView:cell];
    }
    else
    {
    cell.placeImage.image = nil;
    if (_htPlayer)
    {
        [_htPlayer releaseWMPlayer];
        _htPlayer = [[HTPlayer alloc]initWithFrame:cell.backView.bounds videoURLStr:model.v_aimurl];
        
        _htPlayer.pDelegate = self;
        _htPlayer.bgImageView.image = cell.placeImage.image;
        [cell.backView addSubview:_htPlayer];
        [cell bringSubviewToFront:cell.pauseOrPlayBtn];
    }else
    {
        _htPlayer = [[HTPlayer alloc]initWithFrame:cell.backView.bounds videoURLStr:model.v_aimurl];
        _htPlayer.pDelegate = self;
        _htPlayer.bgImageView.image = cell.placeImage.image;
        [cell.backView addSubview:_htPlayer];
        [cell bringSubviewToFront:cell.pauseOrPlayBtn];
    }
    _isPlayerEnd = NO;
    }
}
#pragma mark 结束播放视频
-(void)stopPlayer
{
    PictureCell *cell =(PictureCell *)_htPlayer.superview.superview.superview;
    if (cell) {
        [cell.placeImage sd_setImageWithURL:[NSURL URLWithString:cell.picFrameModel.pictureModel.pic_url] placeholderImage:nil];
    }
    [_htPlayer releaseWMPlayer];
}
//视频播放完成
-(void)closeButtonClick{
    
    if (!_isPlayerEnd) {
        _isPlayerEnd = YES;
        if (_htPlayer.screenType == UIHTPlayerSizeFullScreenType){
            [[UIApplication sharedApplication] setStatusBarHidden:NO];
        }
        [UIView animateWithDuration:0.5 animations:^{
            _htPlayer.alpha = 0;
            [self toCell];
        } completion:^(BOOL finished) {
            [self stopPlayer];
        }];
    }
    
    
}
-(void)toCell{
    [_htPlayer reductionWithInterfaceOrientation:_playingCell.backView];
    
}
-(void)closeTheVideo:(NSNotification *)obj{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self toCell];
}
-(void)toFullScreenWithInterfaceOrientation:(UIInterfaceOrientation )interfaceOrientation{
    
    [_htPlayer toFullScreenWithInterfaceOrientation:interfaceOrientation];
}
//全屏按钮点击
-(void)fullButtonClick:(UIButton *)sender{
    
    if (sender.isSelected) {//全屏显示
        //_htPlayer.backgroundColor = [UIColor blackColor];
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        [self toFullScreenWithInterfaceOrientation:UIInterfaceOrientationLandscapeRight];
    }else{
        //_htPlayer.backgroundColor = [UIColor whiteColor];
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        [self toCell];
        
    }
}
- (DPToolBar *)toolBar {
    if (!_toolBar) {
        _toolBar = [[DPToolBar alloc] init];
        _toolBar.textField.delegate = self;
        _toolBar.delegate = self;
    }
    return _toolBar;
}

- (void)loadView
{
    [super loadView];
    _isPlayerEnd = NO;
    _collectionView.top += _navBar.bottom;
    _collectionView.height -= _navBar.bottom + self.toolBar.height;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.toolBar];
    self.collectionView.contentOffset = CGPointMake(self.gifCellIndex * kMainWidth, 0);
    self.currentIndex = 10000;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupNavBar];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detailModify:) name:DETAIL_MODIFY_NOTICE object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self stopPlayer];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
    if (self.isCommentBtnClick) {
        [self.toolBar.textField becomeFirstResponder];
    }
}
//点击广告链接
- (void)ADCellClick
{
    [self.navigationController pushViewController:[ADWebViewController new] animated:YES];
}
- (void)setupNavBar
{
    _navBar = [[WEInformationNavBar alloc] init];
    _navBar.backTintColor = [UIColor blackColor];
    _navBar.titleColor = [UIColor blackColor];
    _navBar.lineColor = RGB(200, 199, 204);
    _navBar.titleView.text = @"详情";
    _navBar.frame = CGRectMake(0, 20, self.view.width, KWENavBarH);
    [_navBar.rightBtn setImage:nil forState:UIControlStateNormal];
//    [_navBar.rightBtn setTitle:@"  " forState:UIControlStateNormal];
    [_navBar.rightBtn setTitleColor:RGB(26, 28, 30) forState:UIControlStateNormal];
    [_navBar.leftBtn setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    __weak __typeof(self) weakSelf = self;
    _navBar.leftBlock = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    UIView *mark = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _navBar.width, _navBar.bottom)];
    mark.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:mark];
    [self.view addSubview:_navBar];
}

- (void)popToMainViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 获取评论列表

- (void)getCommentListWithCellRow:(NSInteger)cellRow {
    
    NSMutableArray *modifiedCommentLists = [DPCommentTool shareInstance].modifiedCommentLists;
    
    DynamicPictureModel *dynamicPictureModel = self.dynamicPictureModels[cellRow];
    NSString *itemid = dynamicPictureModel.base_id.length ? dynamicPictureModel.base_id : @"";
    [DPHttpTool getCommentListWithItemID:itemid progress:^(NSProgress *progress) {
    } success:^(NSURLSessionDataTask *task, id responceObject) {
//        DLog(@"%@",responceObject);
        NSArray *dataArr = responceObject[@"data"];
        NSMutableArray *tmpArr = [NSMutableArray array];
        if (self.commetModels.count) {
            [self.commetModels removeAllObjects];
        }
        if (dataArr.count) {
            for (NSDictionary *dict in dataArr) {
                CommentModel *commentModel = [CommentModel commentWithDict:dict];
                [tmpArr addObject:commentModel];
            }
            BOOL isContained = NO;
            NSInteger index = 0;
            if (modifiedCommentLists.count) {
                for (NSMutableArray *modifiedModelList in modifiedCommentLists) {
                    if ([[modifiedModelList.firstObject itemid] isEqualToString:[tmpArr.firstObject itemid]]) {
                        isContained = YES;
                        index = [modifiedCommentLists indexOfObject:modifiedModelList];
                    }
                }
            }
            NSInteger tmpArrIndex = 0;
            if (isContained) {
                for (CommentModel *model in modifiedCommentLists[index]) {
                    CommentModel *newModel = tmpArr[tmpArrIndex];
                    newModel.supportSeleted = model.supportSeleted;
                    newModel.goodnum = model.goodnum;
                    tmpArr[tmpArrIndex] = newModel;
                    tmpArrIndex += 1;
                }
            }
            [self.commetModels addObjectsFromArray:tmpArr];
        }
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:cellRow inSection:0];
        NSMutableArray *indexPaths = [NSMutableArray new];
        if(indexPath)
        {
            [indexPaths addObject:indexPath];
        }
        
        if(indexPaths.count && indexPaths != nil)
        {
            if(indexPaths != nil)
            {
                [self.collectionView reloadItemsAtIndexPaths:indexPaths];
            }
        }
       
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        DLog(@"%@", error);
    }];
}

- (void)detailModify:(NSNotification *)noti{
    NSString *type = noti.userInfo[DetailNoticeTypeUserInfoKey];
    DynamicPictureModel *dynamicPictureModel = [noti.userInfo[DetailNoticeModelUserInfoKey] firstObject];
    NSInteger index = [self.dynamicPictureModels indexOfObject:dynamicPictureModel];
    switch ([type integerValue]) {
        case 0: {
            dynamicPictureModel.supported = YES;
            dynamicPictureModel.goodnum = [NSString stringWithFormat:@"%d", [dynamicPictureModel.goodnum intValue] + 1];
        }
            break;
            
        case 1:
        {
            
            [self.toolBar.textField becomeFirstResponder];
            //dynamicPictureModel.commented = YES;
        }
            break;
            
        case 2: {
            
        }
            break;
            
        case 3: {
            dynamicPictureModel.shared = YES;
        }
            break;
        case 10: {
            dynamicPictureModel.commented = YES;
            NSArray *dicArr = [[NSUserDefaults standardUserDefaults]objectForKey:@"cllectionMovie"];
            NSMutableArray *arrar = [NSMutableArray array];
            if (dicArr.count>0)
            {
                NSMutableArray *baseIdArr = [NSMutableArray array];
                arrar = [DynamicPictureModel mj_objectArrayWithKeyValuesArray:dicArr];
                [arrar enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    DynamicPictureModel *mm = obj;
                    [baseIdArr addObject:mm.base_id];
                }];
                if (![baseIdArr containsObject:dynamicPictureModel.base_id]) {
                    [arrar insertObject:dynamicPictureModel atIndex:0];
                }
                
            }else
            {
                [arrar addObject:dynamicPictureModel];
            }
            [[NSUserDefaults standardUserDefaults]setObject:[DynamicPictureModel mj_keyValuesArrayWithObjectArray:arrar] forKey:@"cllectionMovie"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [MBProgressHUD showSuccess:@"已成功加入收藏列表"];
        }
            
        default:
            break;
    }
    self.dynamicPictureModels[index] = dynamicPictureModel;
    //if ([type integerValue] < 4) {
        [self.collectionView reloadData];
    //}
}

- (void)keyboardWillShow:(NSNotification *)noti {
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGFloat kbH = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    [UIView animateWithDuration:duration animations:^{
        self.toolBar.transform = CGAffineTransformMakeTranslation(0, -kbH);
    }];
}

- (void)keyboardWillHide:(NSNotification *)noti {
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:duration animations:^{
        self.toolBar.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark - collectionView dataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dynamicPictureModels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CommentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    cell.dynamicPictureModel = self.dynamicPictureModels[indexPath.row];
    cell.commentModels = self.commetModels;
    self.currentTableView = cell.tableView;
    _playingCell = [self.currentTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [_playingCell.pauseOrPlayBtn addTarget:self action:@selector(videoPlay:) forControlEvents:(UIControlEventTouchUpInside)];
    cell.delegate = self;
    [cell.tableView reloadData];
   
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.currentIndex == indexPath.row) {
        return;
    }
    self.currentIndex = indexPath.row;
//    DLog(@"nextIndex -> %lu", indexPath.row);
    [self getCommentListWithCellRow:indexPath.row];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.toolBar.textField resignFirstResponder];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

#pragma mark - textField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.toolBar.textField resignFirstResponder];
    return YES;
}

#pragma mark - DPToolBarDelegate

- (void)toolBar:(DPToolBar *)toolBar commentBtnClick:(UIButton *)commentBtn {
    if (self.currentIndex < 0) {
        self.currentIndex = 0;
    }
    DynamicPictureModel *currentModel = self.dynamicPictureModels[self.currentIndex];
    if (!self.toolBar.textField.text.length) {
        [MBProgressHUD showError:@"评论内容不能为空"];
        return;
    }
    [DPHttpTool postCommentWithDynamicPictureModel:currentModel message:self.toolBar.textField.text progress:^(NSProgress *progress) {
    } success:^(NSURLSessionDataTask *task, id responceObject) {
//        DLog(@"%@", responceObject);
        NSString *userName = responceObject[@"data"][@"username"];
        if (userName.length && !((NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:userNameKey]).length) {
            [[NSUserDefaults standardUserDefaults] setObject:userName forKey:userNameKey];
        }
        [self getCommentListWithCellRow:self.currentIndex];
        //currentModel.commented = YES;
        self.dynamicPictureModels[self.currentIndex] = currentModel;
        [[NSNotificationCenter defaultCenter] postNotificationName:DETAIL_MODIFY_NOTICE object:nil userInfo:@{DetailNoticeTypeUserInfoKey: @"2",DetailNoticeModelUserInfoKey: @[currentModel]}];
        self.toolBar.textField.text = @"";
        [self.toolBar.textField resignFirstResponder];
        [MBProgressHUD showSuccess:@"评论成功"];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD showError:@"评论失败"];
        self.toolBar.textField.text = @"";
        [self.toolBar.textField resignFirstResponder];
        DLog(@"%@", error);
    }];
}

#pragma mark - CommentCollectionViewCell delegate

- (void)commentCollectionViewCell:(CommentCollectionViewCell *)commentCollectionViewCell supportBtnClick:(UIButton *)supportBtn commentModels:(NSMutableArray *)commentModels {
    
    NSMutableArray *modifiedCommentLists = [DPCommentTool shareInstance].modifiedCommentLists;
    
    NSInteger modelIndex = 0;
    BOOL isContained = NO;
    if (modifiedCommentLists.count) {
        for (NSMutableArray *modelList in modifiedCommentLists) {
            if ([[modelList.firstObject itemid] isEqualToString:[commentModels.firstObject itemid]]) {
                isContained = YES;
                break;
            }
            modelIndex += 1;
        }
        if (isContained) {
            modifiedCommentLists[modelIndex] = commentModels;
        }
    }
    if (!isContained) {
        [modifiedCommentLists addObject:commentModels];
    }
}

- (void)commentCollectionViewCell:(CommentCollectionViewCell *)commentCollectionViewCell GIFLoaded:(DynamicPictureModel *)model imageSize:(CGSize)imageSize {
//    NSInteger modelIndex = [self.dynamicPictureModels indexOfObject:model];
//    model.imageSize = imageSize;
//    if (modelIndex < self.dynamicPictureModels.count) {
//        self.dynamicPictureModels[modelIndex] = model;
//        for (CommentCollectionViewCell *cell in self.collectionView.visibleCells) {
//            if ([cell isEqual:commentCollectionViewCell]) {
//                [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:modelIndex inSection:0]]];
//            }
//        }
//    }
}

#pragma mark=======点击付费视频时候处理逻辑
-(void)AlerShowLoginOrPayView:(PictureCell *)cell
{
    UserModel *Umodel = [M_Tool getUserInfo];
    if ([M_Tool isLogin])
    {
        if ([Umodel.vip_level boolValue])
        {
            cell.placeImage.image = nil;
            if (_htPlayer)
            {
                [_htPlayer releaseWMPlayer];
                _htPlayer = [[HTPlayer alloc]initWithFrame:cell.backView.bounds videoURLStr:cell.picFrameModel.pictureModel.v_aimurl];
                
                _htPlayer.pDelegate = self;
                _htPlayer.bgImageView.image = cell.placeImage.image;
                [cell.backView addSubview:_htPlayer];
                [cell bringSubviewToFront:cell.pauseOrPlayBtn];
            }else
            {
                _htPlayer = [[HTPlayer alloc]initWithFrame:cell.backView.bounds videoURLStr:cell.picFrameModel.pictureModel.v_aimurl];
                _htPlayer.pDelegate = self;
                _htPlayer.bgImageView.image = cell.placeImage.image;
                [cell.backView addSubview:_htPlayer];
                [cell bringSubviewToFront:cell.pauseOrPlayBtn];
            }
            _isPlayerEnd = NO;
 
        }else
        {
            AlertViewSimp *AlertV =  [[AlertViewSimp alloc]initWithTitle:@"提示" tips:@"本视频仅供会员观看" buttonT1:@"取消" buttonT2:@"加入会员"];
            AlertV.sureblock = ^{
                //不是会员
                PayView *changeView = [[PayView alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, kMainHeight)];
                changeView.type = NO;
                changeView.chooseTypeBlock = ^(NSString *type){
                    //包年
                    if ([type boolValue])
                    {
                        
                    }
                    else
                    {
                        //包月
                    }
                    //支付方式
                    PayView *ppView = [[PayView alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, kMainHeight)];
                    ppView.type = YES;
                    ppView.chooseTypeBlock = ^(NSString *type){
                        //微信支付
                        if (![type boolValue])
                        {
                            
                        }
                        else
                        {
                            //支付宝支付
                        }
                        
                    };
                    [ppView show];
                    
                };
                [changeView show];
            };
            [AlertV show];
            
        }
    }
    else
    {
        AlertViewSimp *AlertV =  [[AlertViewSimp alloc]initWithTitle:@"提示" tips:@"本视频仅供会员观看" buttonT1:@"取消" buttonT2:@"加入会员"];
        AlertV.sureblock = ^{
            MLoginView *loginView = [[MLoginView alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, kMainHeight)];
            //loginView.type = NO;
            //点击登录成功以后回调
            loginView.loginBlock = ^(BOOL success){
                if (success)
                {
                    [M_Tool setLoginStaute:YES];
                    UserModel *Umodel = [M_Tool getUserInfo];
                    if (![Umodel.vip_level boolValue])
                    {
                        //不是会员
                        PayView *changeView = [[PayView alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, kMainHeight)];
                        changeView.type = NO;
                        changeView.chooseTypeBlock = ^(NSString *type){
                            //包年
                            if ([type boolValue])
                            {
                                
                            }
                            else
                            {
                                //包月
                            }
                            //支付方式
                            PayView *ppView = [[PayView alloc]initWithFrame:CGRectMake(0, 0, kMainWidth, kMainHeight)];
                            ppView.type = YES;
                            ppView.chooseTypeBlock = ^(NSString *type){
                                //微信支付
                                if (![type boolValue])
                                {
                                    
                                }
                                else
                                {
                                    //支付宝支付
                                }
                                
                            };
                            [ppView show];
                            
                        };
                        [changeView show];
                    }
                }
            };
            //点击取消以后回调
            loginView.cancelLoginBlock = ^{
                
                
            };
            [loginView show];
        };
        [AlertV show];
    }
}
@end
