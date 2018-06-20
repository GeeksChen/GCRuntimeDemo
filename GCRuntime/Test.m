//
//  Test.m
//  GCRuntime
//
//  Created by Geeks_Chen on 2018/6/20.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "Test.h"
#import "AddMethod.h"
#import "GCRuntimeKit.h"

@interface Test(){
    NSUInteger _var1;
    int _var2;
    BOOL _var3;
    double _var4;
    float _var5;
}

@property (strong, nonatomic) NSMutableArray *privatePro1;
@property (strong, nonatomic) NSNumber *privatePro2;
@property (strong, nonatomic) NSDictionary *privatePro3;

@end

@implementation Test

+ (void)classMethod:(NSString *)para{
    NSLog(@"公开方法 classMethod:(NSString *)para");
}

- (void)method1{
    NSLog(@"公开方法 method1");
}

- (void)method1:(NSString *)para1 method2:(NSString *)para2{
    NSLog(@"公开方法 method1:(NSString *)para1 method2:(NSString *)para2");
}

- (void)privateTestMethod1 {
    NSLog(@"私有方法 privateTestMethod1");
}

- (void)privateTestMethod2 {
    NSLog(@"私有方法 privateTestMethod2");
}

//运行时方法拦截
- (void)dynamicAddMethod: (NSString *) value {
    NSLog(@"OC替换的方法：%@", value);
}

/**
 没有找到SEL的IML实现时会执行下方的方法
 
 @param sel 当前对象调用并且找不到IML的SEL
 @return 找到其他的执行方法，并返回yes
 */
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    return NO;    //当返回NO时，会接着执行forwordingTargetForSelector:方法，
    [GCRuntimeKit addMethod:[self class] method:sel method:@selector(dynamicAddMethod:)];
    return YES;
}


/**
 将当前对象不存在的SEL传给其他存在该SEL的对象
 
 @param aSelector 当前类中不存在的SEL
 @return 存在该SEL的对象
 */
- (id)forwardingTargetForSelector:(SEL)aSelector {
    return self;
    return [AddMethod new];   //让AddMethod中相应的SEL去执行该方法
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    //查找父类的方法签名
    NSMethodSignature *signature = [super methodSignatureForSelector:selector];
    if(signature == nil) {
        signature = [NSMethodSignature signatureWithObjCTypes:"@@:"];
        
    }
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    AddMethod * forwardClass = [AddMethod new];
    SEL sel = invocation.selector;
    if ([forwardClass respondsToSelector:sel]) {
        [invocation invokeWithTarget:forwardClass];
    } else {
        [self doesNotRecognizeSelector:sel];
    }
}

@end
