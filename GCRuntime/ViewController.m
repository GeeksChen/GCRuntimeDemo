//
//  ViewController.m
//  GCRuntime
//
//  Created by Geeks_Chen on 2018/6/20.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import "ViewController.h"
#import "Test.h"

#import "GCRuntimeKit.h"
#import "Test+SwwingMethod.h"
#import "Test+Category.h"
#import "Test+AssociatedObject.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UILabel *tip = [[UILabel alloc] initWithFrame:CGRectMake(20, 200, self.view.frame.size.width - 40, 90)];
    tip.textAlignment = NSTextAlignmentCenter;
    tip.textColor = [UIColor redColor];
    tip.numberOfLines = 0;
    tip.font = [UIFont fontWithName:@"PingFang-SC-Light" size:20];
    tip.text = @"当你能把Runtime用在实际的场景中，你才可以说你知道Runtime!";
    [self.view addSubview:tip];
    
    [self testRuntime];
    
}
-(void)testRuntime{
    //获取类名
    NSString *className = [GCRuntimeKit fetchClassName:[Test class]];
    NSLog(@"获取类名:%@",className);
    
    //获取成员变量
    NSArray *ivarList = [GCRuntimeKit fetchIvarList:[Test class]];
    NSLog(@"获取类成员变量：%@",ivarList);
    
    //获取属性列表
    NSArray *proList = [GCRuntimeKit fetchPropertyList:[Test class]];
    NSLog(@"获取属性列表：%@",proList);
    
    //获取方法列表
    NSArray *methodList = [GCRuntimeKit fetchMethodList:[Test class]];
    NSLog(@"获取实例方法：%@",methodList);
    
    //获取协议列表
    NSArray *protocolList = [GCRuntimeKit fetchProtocolList:[Test class]];
    NSLog(@"获取协议列表：%@",protocolList);
    
    //动态添加属性
    Test *test = [Test new];
    test.dynamicAddPro = @"动态添加属性";
    
    //动态添加方法
    [test performSelector:@selector(addMethod:) withObject:@"实例方法参数"];
    
    //交换方法
    [test swwingMethod];
    [test method1];
    
}
@end
