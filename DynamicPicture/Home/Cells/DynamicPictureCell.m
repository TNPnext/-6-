//
//  DynamicPictureCell.m
//  DynamicPicture
//
//  Created by Kings Yan on 2016/12/22.
//  Copyright © 2016年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "DynamicPictureCell.h"
#import "DynamicPictureModel.h"

@interface DynamicPictureCell ()

@property (nonatomic, strong) UIView    *mark;
@end

@implementation DynamicPictureCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setSafeBackgroundColor:RGB(242, 243, 244)];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.mark = [[UIView alloc] init];
        self.mark.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.mark];
        
        _title = [[UILabel alloc] init];
        _title.font = [UIFont systemFontOfSize:19];
        _title.textColor = [UIColor blackColor];
        _title.numberOfLines = 0;
        _title.lineBreakMode = NSLineBreakByClipping;
        [self.contentView addSubview:_title];
        
        _backView = [[UIView alloc]init];
        //_backView.backgroundColor = [UIColor grayColor];
        _backView.userInteractionEnabled = YES;
        [self.contentView addSubview:_backView];
        
        _placeImage = [UIImageView new];
        _placeImage.clipsToBounds= NO;
        _placeImage.contentMode = UIViewContentModeScaleAspectFit;
        _placeImage.userInteractionEnabled = YES;
        [_backView addSubview:_placeImage];
        
        _vipView = [UIImageView new];
        _vipView.userInteractionEnabled = YES;
        _vipView.image = [UIImage imageNamed:@"vip"];
        [_backView addSubview:_vipView];
        
        
    
        _pauseOrPlayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _pauseOrPlayBtn.clipsToBounds = YES;
        _pauseOrPlayBtn.layer.cornerRadius = 30;
        [_pauseOrPlayBtn setBackgroundImage:[UIImage imageNamed:@"zanting"] forState:UIControlStateNormal];
        //_pauseOrPlayBtn.backgroundColor = [UIColor redColor];
        [_backView addSubview:_pauseOrPlayBtn];

        _operationView = [[OperationView alloc] initWithFrame:CGRectZero];
        __weak typeof(self) weakSelf = self;
        _operationView.operation = ^ (DynamicPictureCellOperationFlag operationFlag) {
            if (weakSelf.operation) {
                weakSelf.operation(operationFlag);
            }
        };
        [self.contentView addSubview:_operationView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    DynamicPictureModel *dp = (DynamicPictureModel *)self.model;
    
    self.mark.frame = CGRectMake(0, 0, self.contentView.width, self.contentView.height - 40);
    
    _title.frame = CGRectMake(10, 6, self.contentView.width - 20, 60);
    _title.height = [dp.title sizeWithFont:_title.font constrainedToSize:CGSizeMake(_title.width, 1000) lineBreakMode:NSLineBreakByClipping].height + 15;
    
    
    CGFloat imgWidth = [dp.pic_width floatValue];
    CGFloat imgHeight = [dp.pic_height floatValue];
    CGFloat imageW = kMainWidth - 20.f;
    
    CGFloat imageH;
    if(imgWidth <= 0)
    {
        imageH = 250; //默认250的高度
    }else
    {
        imageH =  imageW * imgHeight / imgWidth;
        //计算后的高>原图高 取原图的高
//        if(imageH > imgHeight)
//        {
//            imageH = imgHeight;
//        }
    }
    
    _backView.frame = CGRectMake(10, _title.bottom + 4, imageW, imageH);
    
    _placeImage.frame = _backView.bounds;
    _vipView.frame = CGRectMake(_backView.bounds.size.width-50, 10, 50, 23);
    _pauseOrPlayBtn.frame = CGRectMake((_backView.bounds.size.width-60)/2, (_backView.bounds.size.height-60)/2, 60, 60);
    _operationView.frame = CGRectMake(0, _backView.bottom, kMainWidth, 40);
}

+ (CGFloat)heightWithModel:(DynamicPictureModel *)model
{
    CGFloat imgWidth = [model.pic_width floatValue];
    CGFloat imgHeight = [model.pic_height floatValue];
    CGFloat imageW = kMainWidth - 20.f;
    
    CGFloat imageH;
    if(imgWidth <= 0)
    {
        imageH = 250 + 40; //默认250的高度+ 工具栏高度40
    }else
    {
        imageH =  imageW * imgHeight / imgWidth;
        //计算后的高>原图高 取原图的高
//        if(imageH > imgHeight)
//        {
//            imageH = imgHeight;
//        }
        imageH += 40; //工具栏高度40
    }
    CGFloat height = 0;
    height += imageH;
    height += [model.title sizeWithFont:[UIFont systemFontOfSize:19] constrainedToSize:CGSizeMake(imageW, 1000) lineBreakMode:NSLineBreakByClipping].height + 30;
    
    return height;
}
- (void)setGoodNum:(NSString *)goodNum
{
    if([_goodNum isEqualToString:goodNum])
        return;
    _goodNum = goodNum;
    
    [_operationView.support setTitle:(_goodNum)? [NSString stringWithFormat:@"   %@", _goodNum] : @"" forState:UIControlStateNormal];
    _operationView.support.selected = YES;
    _operationView.opposition.enabled = NO;
}

- (void)setBadNum:(NSString *)badNum
{
    if([_badNum isEqualToString:badNum])
        return;
    _badNum = badNum;
    
    [_operationView.opposition setTitle:(_badNum)? [NSString stringWithFormat:@"   %@", _badNum] : @"" forState:UIControlStateNormal];
    _operationView.opposition.selected = YES;
    _operationView.support.enabled = NO;
}


- (void)setModel:(DynamicPictureModel *)model
{
//    if(_model == model)
//        return;
    
    _model = model;
    _title.text = (model.title)? model.title : @"";
    [_placeImage sd_setImageWithURL:[NSURL URLWithString:_model.pic_url] placeholderImage:nil];
    _vipView.alpha = [_model.price boolValue];
    [_operationView.support setTitle:(model.goodnum)? [NSString stringWithFormat:@"   %@", model.goodnum] : @"" forState:UIControlStateNormal];
    _operationView.support.selected = model.supported;
    //_operationView.opposition.enabled = !model.supported;
    [_operationView.opposition setTitle:(model.commentnum)? [NSString stringWithFormat:@"   %@", model.commentnum] : @"" forState:UIControlStateNormal];
    _operationView.opposition.selected = model.oppositioned;
    _operationView.support.enabled = !model.oppositioned;
    [_operationView.comment setTitle:(model.commentnum)? [NSString stringWithFormat:@"   %@", model.commentnum] : @"" forState:UIControlStateNormal];
    _operationView.comment.selected = model.commented;
    [_operationView.share setTitle:(model.downnum)? [NSString stringWithFormat:@"   %@", model.favnum] : @"" forState:UIControlStateNormal];
    _operationView.share.selected = model.shared;
}

- (void)handleImageLoadWithModel:(DynamicPictureModel *)model imageSize:(CGSize)imageSize {
    if ([self.delegate respondsToSelector:@selector(dynamicPictureCell:gifLoadedWithModel:imageSize:)]) {
        [self.delegate dynamicPictureCell:self gifLoadedWithModel:model imageSize:imageSize];
    }
}

@end

@implementation OperationView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.height = 40;
        self.width = currentScreenWidth();
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat leftMargin = 20;
        CGFloat btnWidth = 50;
        NSInteger btnCount = 4;
        CGFloat margin = (self.width - leftMargin * 2 - btnWidth * btnCount) / (btnCount - 1);
        
        _support = [[UIButton alloc] initWithFrame:CGRectMake(leftMargin, 0, btnWidth, self.height)];
        _support.titleLabel.font = [UIFont systemFontOfSize:kPicToolBarFontSize];
        [_support setTitleColor:RGB(152, 153, 154) forState:UIControlStateNormal];
        [_support setImage:[UIImage imageNamed:@"dianzan---no"] forState:UIControlStateNormal];
        [_support setImage:[UIImage imageNamed:@"dianzan"] forState:UIControlStateSelected];
        [_support addTarget:self action:@selector(sipportTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_support];
        
        _opposition = [[UIButton alloc] initWithFrame:CGRectMake(_support.right + margin, 0, btnWidth, self.height)];
        _opposition.titleLabel.font = [UIFont systemFontOfSize:kPicToolBarFontSize];
        [_opposition setImage:[UIImage imageNamed:@"comment-gray-"] forState:UIControlStateNormal];
        [_opposition setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateSelected];
        [_opposition setTitleColor:RGB(152, 153, 154) forState:UIControlStateNormal];
        [_opposition addTarget:self action:@selector(oppositionTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_opposition];
        
        CGFloat lineH = 15;
        CGFloat lineY = (self.height - lineH) / 2;
        UIView *centerLineView = [[UIView alloc] initWithFrame:CGRectMake(self.centerX, lineY, 1, lineH)];
        centerLineView.backgroundColor = [UIColor hexStringToColor:@"#F3F3F3"];
        [self addSubview:centerLineView];
        
        UIView *leftLineView = [[UIView alloc] initWithFrame:CGRectMake(self.centerX - btnWidth - margin, lineY, 1, lineH)];
        leftLineView.backgroundColor = [UIColor hexStringToColor:@"#F3F3F3"];
        [self addSubview:leftLineView];
        
        UIView *rightLineView = [[UIView alloc] initWithFrame:CGRectMake(self.centerX + btnWidth + margin, lineY, 1, lineH)];
        rightLineView.backgroundColor = [UIColor hexStringToColor:@"#F3F3F3"];
        [self addSubview:rightLineView];
        
        _comment = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, btnWidth, self.height)];
        _comment.left = _opposition.right + margin;
        [_comment setImage:[UIImage imageNamed:@"shoucang_hui"] forState:UIControlStateNormal];
        [_comment setImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateSelected];
        _comment.titleLabel.font = [UIFont systemFontOfSize:kPicToolBarFontSize];
        [_comment setTitleColor:RGB(152, 153, 154) forState:UIControlStateNormal];
        [_comment addTarget:self action:@selector(commentTapped:) forControlEvents:UIControlEventTouchUpInside];
        [_comment setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:_comment];
        
        _share = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, btnWidth, self.height)];
        _share.left = _comment.right + margin;
        [_share setImage:[UIImage imageNamed:@"share---no"] forState:UIControlStateNormal];
        [_share setImage:[UIImage imageNamed:@"share"] forState:UIControlStateSelected];
        _share.titleLabel.font = [UIFont systemFontOfSize:kPicToolBarFontSize];
        [_share setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_share addTarget:self action:@selector(shareTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_share];
        
    }
    return self;
}

- (void)sipportTapped:(UIButton *)sender
{
    _opposition.enabled = NO;
    if (self.operation) {
        
        sender.selected = YES;
        self.operation(DynamicPictireCellOperationFlagSupport);
    }
}

- (void)oppositionTapped:(UIButton *)sender
{
    //_support.enabled = NO;
    if (self.operation) {
        
        sender.selected = YES;
        self.operation(DynamicPictireCellOperationFlagOpposition);
    }
}

- (void)commentTapped:(UIButton *)sender {
    if (self.operation) {
        sender.selected = YES;
        self.operation(DynamicPictireCellOperationFlagComment);
    }
}

- (void)shareTapped:(UIButton *)sender
{
    if (self.operation) {
        
//        sender.selected = YES;
        self.operation(DynamicPictireCellOperationFlagShare);
    }
}

@end

