//
//  JZModelCollectionViewController.m
//  GSJuZhang
//
//  Created by __Qing__ on 15/1/30.
//  Copyright (c) 2015年 __Qing__. All rights reserved.
//

#import "JZModelCollectionViewController.h"
#import "UIView+Category.h"

@interface JZModelCollectionViewController ()

@property (nonatomic, strong) NSMutableDictionary *modelCellClassMap;
@property (nonatomic, strong) NSMutableDictionary *modelReuseIdentifierMap;

@end

@implementation JZModelCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
        {
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.extendedLayoutIncludesOpaqueBars = NO;
            self.modalPresentationCapturesStatusBarAppearance = NO;
        }
#endif
    }
    return self;
}

- (NSMutableDictionary *)modelCellClassMap
{
    if (_modelCellClassMap == nil) {
        _modelCellClassMap = [[NSMutableDictionary alloc] init];
    }
    return _modelCellClassMap;
}

- (NSMutableDictionary *)modelReuseIdentifierMap
{
    if (_modelReuseIdentifierMap == nil) {
        _modelReuseIdentifierMap = [[NSMutableDictionary alloc] init];
    }
    return _modelReuseIdentifierMap;
}

- (NSMutableArray *)models
{
    if (_models == nil) {
        _models = [[NSMutableArray alloc] init];
    }
    return _models;
}

- (NSArray *)registeredModelClasses
{
    return self.modelCellClassMap.allKeys;
}

- (void)loadView
{
    [super loadView];
    // Do any additional setup after loading the view from its nib.
    
    self.collectionViewLayout = [[UICollectionViewFlowLayout alloc] init];
    [self.collectionViewLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionViewLayout.minimumInteritemSpacing = 4;
    self.collectionViewLayout.minimumLineSpacing = 4;
    self.collectionViewLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) collectionViewLayout:self.collectionViewLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.0];
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.collectionView];
    
    // should implection after self.collectionView instanced.
    [self loadCellModelMapping];
}

#pragma mark - APIs

- (void)configureCell:(UICollectionViewCell<JZCollectionModelBinding> *)cell forIndexPath:(NSIndexPath *)indexPath
{
    // should be implemented by subclass
}

- (void)loadCellModelMapping
{
    // should be implemented by subclass
}

- (void)registerModelClass:(Class)modelClass mappedCellClass:(Class)cellClass reuseIdentifier:(NSString *)reuseIdentifier
{
    if (![cellClass isSubclassOfClass:[UICollectionViewCell class]] || reuseIdentifier.length == 0) {
#if DEBUG
        NSLog(@"Failed to register model and cell classes to ModelCollectionViewController. %@ is not the subclass of JZBaseModel or %@ is illegal.", modelClass, reuseIdentifier);
#endif
        return;
    }
    if (![cellClass conformsToProtocol:@protocol(JZCollectionModelBinding)]) {
#if DEBUG
        NSLog(@"Failed to register model and cell classes. %@ doesn't conform to JZCollectionModelBinding protocol", cellClass);
#endif
        return;
    }
    [_collectionView registerClass:cellClass forCellWithReuseIdentifier:reuseIdentifier];
    
    NSString *modelClassString = NSStringFromClass(modelClass);
    self.modelCellClassMap[modelClassString] = NSStringFromClass(cellClass);
    self.modelReuseIdentifierMap[modelClassString] = reuseIdentifier;
    
    [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:NSStringFromClass(cellClass)];
}

- (Class)mappedCellClassForModelClass:(Class)modelClass
{
    NSString *cellClassName = self.modelCellClassMap[NSStringFromClass(modelClass)];
    if (cellClassName == nil) {
#if DEBUG
        NSLog(@"%@ not registered with a cellClass", modelClass);
#endif
    }
    return NSClassFromString(cellClassName);
}

- (NSString *)mappedReuseIdentifierForModelClass:(Class)modelClass
{
    NSString *reuseIdentifier = self.modelReuseIdentifierMap[NSStringFromClass(modelClass)];
    if (reuseIdentifier == nil) {
#if DEBUG
        NSLog(@"%@ not registered with a reuseIdentifier", modelClass);
#endif
    }
    return reuseIdentifier;
}

#pragma mark - Collection View Delegate And DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.models.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject *model = self.models[indexPath.row];
    NSString *cellIdentifier = [self mappedReuseIdentifierForModelClass:model.class];
    UICollectionViewCell<JZCollectionModelBinding> *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.model = (JZBaseModle *)self.models[indexPath.row];
    [self configureCell:cell forIndexPath:indexPath];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject *model = self.models[indexPath.row];
    Class cellClass = [self mappedCellClassForModelClass:model.class];
    return [cellClass sizeForItemWithModel:self.models[indexPath.row]];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // should be implemented by subclass
}

@end
