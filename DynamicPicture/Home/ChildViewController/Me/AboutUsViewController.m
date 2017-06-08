//
//  AboutUsViewController.m
//  Jest
//
//  Created by 段振伟 on 16/4/17.
//  Copyright © 2016年 段振伟. All rights reserved.
//

#import "AboutUsViewController.h"
#import "Common.h"
@interface AboutUsViewController ()
@property (nonatomic, weak) UIImageView *logoImage;
@property (nonatomic, weak) UIView *infoView;

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KColor(241, 241, 241);
    self.title = @"关于我们";
    [self setupLogoImageView];
    [self setupInformationView];
    [self setupVersionLabel];
}

- (void)setupLogoImageView{
    UIImageView *logoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"120-120.png"]];
    CGFloat logoW = 80;
    CGFloat logoH = 80;
    CGFloat logoX = (kMainWidth - logoW) / 2;
    CGFloat logoY = 50;
    logoImage.frame = CGRectMake(logoX, logoY, logoW, logoH);
    [self.view addSubview:logoImage];
    self.logoImage = logoImage;
}
- (void)setupInformationView{
    
    UIView *infoView = [[UIView alloc] init];
    infoView.frame = CGRectMake(0 , CGRectGetMaxY(self.logoImage.frame) + 50, kMainWidth, 122);
    [self.view addSubview:infoView];
    self.infoView = infoView;
    
    CGFloat labelH = (self.infoView.frame.size.height - 2) / 3;
    CGFloat labelW = self.infoView.frame.size.width / 3.5;
    CGFloat label1W = kMainWidth - self.infoView.frame.size.width / 4 ;
    
    UILabel *website = [[UILabel alloc] init];
    website.font = [UIFont systemFontOfSize:14];
    website.textColor = [UIColor lightGrayColor];
    website.backgroundColor = [UIColor whiteColor];
    website.text = @"    官方网站:";
    website.frame = CGRectMake(0 , 0, labelW, labelH);
    [self.infoView addSubview:website];
    
    UILabel *website1 = [[UILabel alloc] init];
    website1.font = [UIFont systemFontOfSize:14];
    website1.text = @"http://www.c6.com";
    website1.backgroundColor = [UIColor whiteColor];
    website1.frame = CGRectMake(CGRectGetMaxX(website.frame) , 0, label1W, labelH);
    [self.infoView addSubview:website1];
    
    UILabel *wechat = [[UILabel alloc] init];
    wechat.font = [UIFont systemFontOfSize:14];
    wechat.textColor = [UIColor lightGrayColor];
    wechat.backgroundColor = [UIColor whiteColor];
    wechat.text = @"    微信公众号:";
    wechat.frame = CGRectMake(0 , CGRectGetMaxY(website.frame) + 1, labelW, labelH);
    [self.infoView addSubview:wechat];
    
    UILabel *wechat1 = [[UILabel alloc] init];
    wechat1.font = [UIFont systemFontOfSize:14];
    wechat1.text = @"彩6彩票";
    wechat1.backgroundColor = [UIColor whiteColor];
    wechat1.frame = CGRectMake(CGRectGetMaxX(wechat.frame) , CGRectGetMaxY(website1.frame) + 1, label1W, labelH);
    [self.infoView addSubview:wechat1];
    
    UILabel *contact = [[UILabel alloc] init];
    contact.font = [UIFont systemFontOfSize:14];
    contact.textColor = [UIColor lightGrayColor];
    contact.backgroundColor = [UIColor whiteColor];
    contact.text = @"    联系我们:";
    contact.frame = CGRectMake(0 , CGRectGetMaxY(wechat.frame) + 1, labelW, labelH);
    [self.infoView addSubview:contact];
    
    UILabel *contact1 = [[UILabel alloc] init];
    contact1.font = [UIFont systemFontOfSize:14];
    contact1.backgroundColor = [UIColor whiteColor];
    contact1.numberOfLines=2;
    contact1.text = @"客服QQ:6964830";
    contact1.frame = CGRectMake(CGRectGetMaxX(contact.frame) , CGRectGetMaxY(wechat1.frame) + 1, kMainWidth-CGRectGetMaxX(contact.frame), labelH);
    [self.infoView addSubview:contact1];
    
    
}
- (void)setupVersionLabel{
    UILabel *version = [[UILabel alloc] init];
    version.text = [NSString stringWithFormat:@"V%@",[[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleShortVersionString"]];
    version.textColor = [UIColor lightGrayColor];
    
    CGFloat versionH = 30;
    NSMutableAttributedString *vText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",version.text]];
    [vText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, vText.length)];
    CGFloat maxLabelWidth = 100;
    CGRect versionRect = [vText boundingRectWithSize:CGSizeMake(maxLabelWidth, versionH) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    version.attributedText = vText;
    CGFloat versionW = versionRect.size.width;
    CGFloat versionX = (kMainWidth - versionW) / 2;
    //CGFloat versionY = kMainWidth - versionH - 30;
    version.frame = CGRectMake(versionX, kMainHeight-150, versionW, versionH);
    [self.view addSubview:version];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
