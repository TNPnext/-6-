//
//  DynamicPictureCell.h
//  DynamicPicture
//
//  Created by Kings Yan on 2016/12/22.
//  Copyright © 2016年 重庆瓦普时代网络科技有限公司. All rights reserved.
//

#import "JZModelCell.h"

#import <UIImageView+WebCache.h>

typedef NS_ENUM(NSInteger, DynamicPictureCellOperationFlag){
    DynamicPictireCellOperationFlagSupport = 0,
    DynamicPictireCellOperationFlagOpposition,
    DynamicPictireCellOperationFlagShare,
    DynamicPictireCellOperationFlagComment
};

@class DynamicPictureCell;
@class DynamicPictureModel;

@protocol DynamaicPictureCellDelegate <NSObject>

- (void)dynamicPictureCell:(DynamicPictureCell *)dynamicPictureCell gifLoadedWithModel:(DynamicPictureModel *)model imageSize:(CGSize)imageSize;

@end

@class OperationView;
@interface DynamicPictureCell : UITableViewCell

@property (nonatomic, strong) UIView *backView;//主背景View
@property (nonatomic, strong) UIImageView *placeImage;//封面图View
@property (nonatomic, strong) UIImageView *vipView;//vip图标
@property (nonatomic, strong) UIButton *pauseOrPlayBtn;//播放暂停按钮
@property (nonatomic, strong) UILabel *title;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (strong, nonatomic) DynamicPictureModel *model;
@property (nonatomic, strong) OperationView *operationView;
@property (nonatomic, copy) void (^operation) (DynamicPictureCellOperationFlag operationFlag);
@property (weak, nonatomic) id<DynamaicPictureCellDelegate> delegate;

@property (nonatomic,strong) NSString *badNum;
@property (nonatomic,strong) NSString *goodNum;

+ (CGFloat)heightWithModel:(JFBaseModel *)model;

@end

@interface OperationView : UIView

@property (nonatomic, strong) UIButton *support;
@property (nonatomic, strong) UIButton *opposition;
@property (strong, nonatomic) UIButton *comment;
@property (nonatomic, strong) UIButton *share;
@property (nonatomic, copy) void (^operation) (DynamicPictureCellOperationFlag operationFlag);

@end
