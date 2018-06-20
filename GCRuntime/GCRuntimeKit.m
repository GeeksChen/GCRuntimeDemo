//
//  GCRuntimeKit.m
//  GCRuntime
//
//  Created by Geeks_Chen on 2018/6/20.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "GCRuntimeKit.h"

@implementation GCRuntimeKit
/**
 获取类名
 
 @param className 相应类名
 @return 类名
 */
+ (NSString *)fetchClassName:(Class)className{
    
    const char *classN = class_getName(className);
    return [NSString stringWithUTF8String:classN];
    
}

/**
 获取成员变量
 
 @param className 相应类名
 @return 成员变量数组
 */
+ (NSArray *)fetchIvarList:(Class)className{
    
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList(className, &count);
    
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    
    for (unsigned int i = 0; i < count; i++) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:2];
        const char *ivarName = ivar_getName(ivarList[i]);
        const char *ivarType = ivar_getTypeEncoding(ivarList[i]);
        dic[@"type"] = [NSString stringWithUTF8String:ivarType];
        dic[@"ivarName"] = [NSString stringWithUTF8String:ivarName];
        
        [mutableList addObject:dic];
    }
    free(ivarList);
    
    return [NSArray arrayWithArray:mutableList];
}

/**
 获取类的属性列表
 
 @param className 类名
 @return 属性列表
 */
+ (NSArray *)fetchPropertyList:(Class)className{
    
    unsigned int count = 0;
    objc_property_t *propertyList = class_copyPropertyList(className, &count);
    
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    
    for (unsigned int i = 0; i < count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        [mutableList addObject:[NSString stringWithUTF8String:propertyName]];
    }
    free(propertyList);
    return [NSArray arrayWithArray:mutableList];
}

/**
 获取对象方法列表，getter，setter，对象方法，不包含类方法
 
 @param className 类名
 @return 对象方法列表
 */
+ (NSArray *)fetchMethodList:(Class)className{
    
    unsigned int count = 0;
    Method *methodList = class_copyMethodList(className,&count);
    
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++) {
        Method method = methodList[i];
        SEL methodName = method_getName(method);
        [mutableList addObject:NSStringFromSelector(methodName)];
    }
    free(methodList);
    return [NSArray arrayWithArray:mutableList];
}

/**
 获取协议列表
 
 @param className 类名
 @return 协议列表
 */
+ (NSArray *)fetchProtocolList:(Class)className{
    
    unsigned int count = 0;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList(className, &count);
    
    NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:count];
    for (unsigned int i = 0; i < count; i++) {
        Protocol *protocol = protocolList[i];
        const char *protocolName = protocol_getName(protocol);
        [mutableList addObject:[NSString stringWithUTF8String:protocolName]];
    }
    
    return [NSArray arrayWithArray:mutableList];
}

/**
 添加方法
 
 @param className 被添加方法的类
 @param methodSel SEL
 @param methodSelImpl 提供IMP的SEL
 */
+ (void)addMethod:(Class)className method:(SEL)methodSel method:(SEL)methodSelImpl{
    
    Method method = class_getInstanceMethod(className, methodSelImpl);
    IMP methodIMP = method_getImplementation(method);
    const char *types = method_getTypeEncoding(method);
    class_addMethod(className, methodSel, methodIMP, types);
    
}

/**
 交换方法
 
 @param className 类名
 @param origSel 原始方法
 @param newSel 新方法
 */
+ (void)swwingMethod:(Class)className origMethod:(SEL)origSel newMethod:(SEL)newSel{
    
    Method origMethod = class_getInstanceMethod(className, origSel);
    Method newMethod = class_getInstanceMethod(className, newSel);
    method_exchangeImplementations(origMethod, newMethod);
    
}
@end
