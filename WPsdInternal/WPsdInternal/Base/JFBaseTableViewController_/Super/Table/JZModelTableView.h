//
//  JZModelTableView.h
//  WPsdInternal
//
//  Created by Kings Yan on 16/9/9.
//  Copyright © 2016年 wapushidai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JZModelCell.h"

/**
 *     表格基础类，继承于该类能够比较简单的实现表格的功能，并且简化 cell 和数据模型的实现代码和表格、cell与数据模型三者之间的逻辑关系，
 *   起到让表格控制器的实现代码更简单、cell类的实现代码更简单、模型类的实现代码更简单、代码逻辑更加清晰、代码逻辑与业务分离的作用，实际用处不止这些，
 *   在使用中你会慢慢发现他的优秀之处。
 *   该类作为 UIView 的子类，用于 UIView 继承该类使用
 */
@interface JZModelTableView : UIView <UITableViewDelegate, UITableViewDataSource>


/**
 *     表格控制器对象
 */
@property (nonatomic, strong) UITableView *tableView;

/** All the models should be put in this array. PS: We only support one section tableview currently.
 */
/**
 *     表格数据数组属性
 */
@property (nonatomic, strong) NSMutableArray *models;

/**
 *     用于作为控件时的初始方法，可以不作为默认初始方法使用
 */
- (instancetype)initWithFrame:(CGRect)frame;




/**
 *     复写该方法可以在 cell 设置完成之后改变 cell 的属性
 */
- (void)configureCell:(UITableViewCell<JZModelBinding> *)cell forIndexPath:(NSIndexPath *)indexPath __attribute__((objc_requires_super));

/**
 *     复写该方法用于调用执行 cell class 与模型类 class 的对应关系，和 - (void)registerModelClass:(Class)modelClass mappedCellClass:(Class)cellClass reuseIdentifier:(NSString *)reuseIdentifier 方法配对使用。
 */
- (void)loadCellModelMapping;

/**
 *     注册 cell class 与模型类 class 形成对应关系，和 - (void)loadCellModelMapping 方法配对使用。
 *
 *     @param modelClass      模型类的 class
 *     @param cellClass       cell 类的 class
 *     @param reuseIdentifier 代表对应关系的标识符
 */
- (void)registerModelClass:(Class)modelClass mappedCellClass:(Class)cellClass reuseIdentifier:(NSString *)reuseIdentifier;

/**
 *     返回在表格基础类中已注册的所有模型 class
 *
 *     @return 模型 class 数组
 */
- (NSArray *)registeredModelClasses;




/**
 *     返回与模型类 class 对应的 cell class
 *
 *     @param modelClass 模型类的 class
 *
 *     @return 与模型类对应的 cell class
 */
- (Class)mappedCellClassForModelClass:(Class)modelClass;

/**
 *     返回与模型类 class 注册的代表与 cell 对应关系的标识符
 *
 *     @param modelClass 模型类 class
 *
 *     @return 与模型类 class 注册的代表与 cell 对应关系的标识符
 */
- (NSString *)mappedReuseIdentifierForModelClass:(Class)modelClass;


@end
