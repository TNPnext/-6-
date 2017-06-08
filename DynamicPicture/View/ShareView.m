//
//  ShareView.m
//  Jest
//
//  Created by 段振伟 on 16/7/29.
//  Copyright © 2016年 段振伟. All rights reserved.
//

#import "ShareView.h"
#import "ShareTypeButton.h"
#import "DynamicPictureModel.h"

@interface ShareView ()
{
    CGFloat _height;
}
@property (nonatomic, strong) UIView *backView;
@end

@implementation ShareView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame ];
    if(self)
    {
        [self setUpView];
    }
    return self;
}

- (void)setUpView
{
    self.backgroundColor = [UIColor whiteColor];
    self.backView = [[UIView alloc] init];
    _backView.backgroundColor = [UIColor whiteColor];
    _backView.userInteractionEnabled = YES;
    [self addSubview:_backView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 50, kMainWidth, 1)];
    lineView.backgroundColor = [UIColor hexStringToColor:@"#E3E3E3"];
    [self.backView addSubview:lineView];
    
    UIButton *closeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.bounds.size.height-50, kMainWidth, 50)];
    [closeButton addTarget:self action:@selector(shareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [closeButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [closeButton setTitle:@"取消" forState:(UIControlStateNormal)];
    closeButton.tag = 5;
    [self.backView addSubview:closeButton];
    
    NSArray *imgArr = @[@"wechat",@"pengyouquan",@"qq",@"qqzone",@"xinlangweibo"];
    NSArray *titArr = @[@"微信",@"微信朋友圈",@"QQ",@"QQ空间",@"微博"];
    for (int i = 0; i<5; i++)
    {
        ShareTypeButton *shareButton = [ShareTypeButton buttonWithImage:imgArr[i] Title:titArr[i]];
        shareButton.tag = i;
        shareButton.frame = CGRectMake(10+(kMainWidth-20)/5*i, 30, (kMainWidth-20)/5, (kMainWidth-20)/5);
        [shareButton addTarget:self action:@selector(shareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        //shareButton.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
        [self.backView addSubview:shareButton];
    }
   
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.backView.frame = self.bounds;
    [self setUpView];
}
- (void)shareButtonClick:(UIButton *)sender{
    self.shareblock(sender.tag);
}

- (void)shareWithDynamicPictureModel:(DynamicPictureModel *)picModel shareType:(SSDKPlatformType)type success:(void (^)())success{
    //创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    NSMutableArray *imageArray = [NSMutableArray array];
    NSString *shareText=@"史上动图蕞全的APP，历害了，word哥！";
    NSString *titleText=@"动啦";
    if (picModel.pic_url.length) {
        [imageArray addObject:picModel.pic_url];
    }
    [shareParams SSDKEnableUseClientShare];
    
    if (type == SSDKPlatformTypeSinaWeibo) {
        [shareParams SSDKSetupSinaWeiboShareParamsByText:shareText title:titleText image:picModel.pic_url url:[NSURL URLWithString:picModel.pic_url] latitude:0 longitude:0 objectID:nil type:SSDKContentTypeAuto];
    }else {
        [shareParams SSDKSetupShareParamsByText:shareText
                                         images:imageArray
                                            url:nil
                                          title:titleText
                                           type:SSDKContentTypeAuto];
    }
    //进行分享
    [ShareSDK share:type
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error)
     {
         switch (state) {
             case SSDKResponseStateSuccess:
             {
                 if (success) {
                     success();
                 }
                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                     message:nil
                                                                    delegate:nil
                                                           cancelButtonTitle:nil
                                                           otherButtonTitles:nil];
                 [alertView show];
                 [alertView dismissWithClickedButtonIndex:0 animated:YES];
             }
                 break;
             case SSDKResponseStateFail:
             {
                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                     message:[NSString stringWithFormat:@"%@", error]
                                                                    delegate:nil
                                                           cancelButtonTitle:nil
                                                           otherButtonTitles:nil];
                 [alertView show];
                 [alertView dismissWithClickedButtonIndex:0 animated:YES];
             }
                 break;
             case SSDKResponseStateCancel:
             {
                 
             }
                 break;
                 
             default:
                 break;
         }
     }];
}

@end
