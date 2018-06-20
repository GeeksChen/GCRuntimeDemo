//
//  Test+AssociatedObject.m
//  GCRuntime
//
//  Created by Geeks_Chen on 2018/6/20.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "Test+AssociatedObject.h"

static char kDynamicAddPro;

@implementation Test (AssociatedObject)

/**
 getter方法

 @return 返回关联属性
 */
- (NSString *)dynamicAddPro{
    return objc_getAssociatedObject(self, &kDynamicAddPro);
}

/**
 setter方法

 @param dynamicAddPro 设置关联属性的值
 */
- (void)setDynamicAddPro:(NSString *)dynamicAddPro{
    
    objc_setAssociatedObject(self, &kDynamicAddPro, dynamicAddPro, OBJC_ASSOCIATION_RETAIN);
    
}
@end
