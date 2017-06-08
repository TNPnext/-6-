//
//  JZModelCollectionViewController.h
//  GSJuZhang
//
//  Created by __Qing__ on 15/1/30.
//  Copyright (c) 2015年 __Qing__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZCollectionViewModelCell.h"

NS_CLASS_AVAILABLE_IOS(6_0) @interface JZModelCollectionViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

/** All the models should be put in this array.
 */
@property (nonatomic, strong) NSMutableArray *models;

@property (strong, nonatomic) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewLayout;
/** Use this method to inheritedly confgure cells.*/
- (void)configureCell:(UICollectionViewCell<JZCollectionModelBinding> *)cell forIndexPath:(NSIndexPath *)indexPath __attribute__((objc_requires_super));
- (void)loadCellModelMapping;

- (void)registerModelClass:(Class)modelClass mappedCellClass:(Class)cellClass reuseIdentifier:(NSString *)reuseIdentifier;

- (NSArray *)registeredModelClasses;

- (Class)mappedCellClassForModelClass:(Class)modelClass;
- (NSString *)mappedReuseIdentifierForModelClass:(Class)modelClass;

@end
