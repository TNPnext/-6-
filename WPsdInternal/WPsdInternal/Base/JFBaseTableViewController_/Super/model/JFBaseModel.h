//
//  JFBaseModel.h
//  WAF
//
//  Created by Kings Yan on 15/9/14.
//  Copyright (c) 2015年 西安交大捷普网络科技有限公司. All rights reserved.
//

#import "JZBaseModle.h"


/**
 *     表格基础类使用的数据模型基础类，与 cell 基础类形成对应关系，提供给 cell 数据进行显示，并且运用面向对象语言设计多态的原理：一个模型基础类的子类对应一个 cell 基础类的子类，形成对应关系，在表格基础类中完成传递什么模型子类给表格控制器就会找到对应的 cell 子类来进行显示出来在表格控制器中，形成映射对应效果。
 ＊     该类还继承于 JZBaseModel（自动解析 json 数据类协议）实现一键解析 JSON 数据到该类本身的属性，使其可以快速得到网络数据，并提供给与之对应的 cell 子类进行展示。
 */
@interface JFBaseModel : JZBaseModle

@end
