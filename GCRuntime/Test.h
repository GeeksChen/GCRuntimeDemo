//
//  Test.h
//  GCRuntime
//
//  Created by Geeks_Chen on 2018/6/20.
//  Copyright © 2018年 Geeks_Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Test : NSObject<NSCopying,NSCoding>

@property (strong, nonatomic) NSArray *publicPro1;
@property (strong, nonatomic) NSDictionary *publicPro2;

+ (void)classMethod:(NSString *)para;

- (void)method1;

- (void)method1:(NSString *)para1 method2:(NSString *)para2;

@end
