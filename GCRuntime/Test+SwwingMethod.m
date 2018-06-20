//
//  Test+SwwingMethod.m
//  GCRuntime
//
//  Created by Geeks_Chen on 2018/6/20.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "Test+SwwingMethod.h"
#import "GCRuntimeKit.h"
@implementation Test (SwwingMethod)

- (void)swwingMethod{
    
    [GCRuntimeKit swwingMethod:[self class] origMethod:@selector(method1) newMethod:@selector(method2)];
    
}

- (void)method2{
   
    [self method2];//实际上执行的是method1
    
    NSLog(@"交换后的方法可以在method1上添加新的功能");
}
@end
