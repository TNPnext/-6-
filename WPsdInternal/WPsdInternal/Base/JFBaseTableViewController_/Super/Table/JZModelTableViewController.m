//
//  JZModelTableViewController.m
//  GSJuZhang
//
//  Created by Kings Yan on 15/1/15.
//  Copyright (c) 2015年 __Qing__. All rights reserved.
//

#import "JZModelTableViewController.h"

@interface JZModelTableViewController ()
{
    UITableViewStyle _style;
}

@property (nonatomic, strong) NSMutableDictionary *modelCellClassMap;
@property (nonatomic, strong) NSMutableDictionary *modelReuseIdentifierMap;

@end

@implementation JZModelTableViewController

- (void)dealloc
{
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
}

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

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self = [super init]) {
        _style = style;
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

#pragma mark - UIViewController Methods

- (void)loadView
{
    [super loadView];
    
    [self loadCellModelMapping];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.view.bounds.size.height) style:_style];
    self.tableView.clipsToBounds = NO;
    self.view.clipsToBounds = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.separatorColor = RGB(226, 226, 226);
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.modelReuseIdentifierMap enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString *resuseIdentifier = obj;
        NSString *resourcePath = [[NSBundle mainBundle] pathForResource:resuseIdentifier ofType:@"nib"];
        if (resourcePath) {
           [self.tableView registerNib:[UINib nibWithNibName:resuseIdentifier bundle:nil] forCellReuseIdentifier:resuseIdentifier];
        }
    }];
    
    [self.view addSubview:self.tableView];
    [self setExtraCellLineHidden:self.tableView];
}

- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

#pragma mark - APIs

- (void)configureCell:(UITableViewCell<JZModelBinding> *)cell forIndexPath:(NSIndexPath *)indexPath
{
    // should be implemented by subclass
}

- (void)loadCellModelMapping
{
    // should be implemented by subclass
}

- (void)registerModelClass:(Class)modelClass mappedCellClass:(Class)cellClass reuseIdentifier:(NSString *)reuseIdentifier
{
    if (![cellClass isSubclassOfClass:[UITableViewCell class]] || reuseIdentifier.length == 0) {
#if DEBUG
        NSLog(@"Failed to register model and cell classes to ModelTableViewController. %@ is not the subclass of JZBaseModel or %@ is illegal.", modelClass, reuseIdentifier);
#endif
        return;
    }
    if (![cellClass conformsToProtocol:@protocol(JZModelBinding)]) {
#if DEBUG
        NSLog(@"Failed to register model and cell classes. %@ doesn't conform to JZModelBinding protocol", cellClass);
#endif
        return;
    }
    
    NSString *modelClassString = NSStringFromClass(modelClass);
    self.modelCellClassMap[modelClassString] = NSStringFromClass(cellClass);
    self.modelReuseIdentifierMap[modelClassString] = reuseIdentifier;
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //We only support one section tableview currently.
    return self.models.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject *model = self.models[indexPath.row];
    Class cellClass = [self mappedCellClassForModelClass:model.class];
    return [cellClass heightWithModel:(JFBaseModel *)model];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSObject *model = self.models[indexPath.row];
    NSString *cellIdentifier = [self mappedReuseIdentifierForModelClass:model.class];
    UITableViewCell<JZModelBinding> *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        Class cellClass = [self mappedCellClassForModelClass:model.class];
        cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.model = (JFBaseModel *)model;
    [self configureCell:cell forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // should be implemented by subclass
}

@end
