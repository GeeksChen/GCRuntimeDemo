//
//  GCRuntimeKit.h
//  GCRuntime
//
//  Created by Geeks_Chen on 2018/6/20.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>

@interface GCRuntimeKit : NSObject

/**
 获取类名

 @param className 相应类名
 @return 类名
 */
+ (NSString *)fetchClassName:(Class)className;

/**
 获取成员变量

 @param className 相应类名
 @return 成员变量数组
 */
+ (NSArray *)fetchIvarList:(Class)className;

/**
 获取类的属性列表

 @param className 类名
 @return 属性列表
 */
+ (NSArray *)fetchPropertyList:(Class)className;

/**
 获取对象方法列表，getter，setter，对象方法，不包含类方法

 @param className 类名
 @return 对象方法列表
 */
+ (NSArray *)fetchMethodList:(Class)className;

/**
 获取协议列表

 @param className 类名
 @return 协议列表
 */
+ (NSArray *)fetchProtocolList:(Class)className;

/**
 添加方法

 @param className 被添加方法的类
 @param methodSel SEL
 @param methodSelImpl 提供IMP的SEL
 */
+ (void)addMethod:(Class)className method:(SEL)methodSel method:(SEL)methodSelImpl;

/**
 交换方法

 @param className 类名
 @param origSel 原始方法
 @param newSel 新方法
 */
+ (void)swwingMethod:(Class)className origMethod:(SEL)origSel newMethod:(SEL)newSel;

@end
