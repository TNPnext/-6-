//
//  MFindViewController.h
//  MoivePlace
//
//  Created by hewenxue on 17/2/13.
//  Copyright © 2017年 cxmx. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "MFind_N_CollectionViewCell.h"
#import "MFind_T_CollectionViewCell.h"
#import "MFindHeadView.h"
#import "UIView+Category.h"
#import <WPsdInternal.h>

typedef NS_ENUM(NSInteger, MFindCellType)
{
    MFindCellType_LinF = 0, //@"行四个"
    MFindCellType_LinT = 1, //@"行两个"
};

@protocol MMoiveDataSource <NSObject>
@optional
/*设置cell 值*/
- (void)moiveCell:(id)cell
        indexPath:(id)indexPath;
/*设置title 值*/
- (void)moiveHeaderView:(id)headerView
              indexPath:(NSIndexPath *)indexPath;
@end

@protocol MMovieSearchDelegate <NSObject>

@optional
- (void)movieSearchValue:(NSString *)value;
@end


@interface MFindBaseViewController : UIViewController
@property(nonatomic,strong)UICollectionView *m_CollectionView;
@property(nonatomic,assign)MFindCellType cellType;//表格类型
@property(nonatomic,assign)BOOL searchShow;//是否添加搜索

/*继承
 numberOfSectionsInCollectionView
 numberOfItemsInSection 函数*/
@property (nonatomic,weak)id<UICollectionViewDataSource> m_dataSource;
/* 继承
 didSelectItemAtIndexPath 函数
 */
@property (nonatomic,weak)id<UICollectionViewDelegate> m_delegate;
@property (nonatomic,weak)id<MMoiveDataSource> m_cellDataSource;
@property (nonatomic,weak)id<MFindHeadViewDelegate> findHeadViewDelegate;

@end
