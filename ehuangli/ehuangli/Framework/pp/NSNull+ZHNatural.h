//
//  NSNull+ZHNatural.h
//  nvshengpai_2
//
//  Created by 360 on 15/2/11.
//  Copyright (c) 2015年 nvshengpai. All rights reserved.
//
//  导入.pch头文件作为全局引用，可以避免null数据导致的程序崩溃
#import <Foundation/Foundation.h>

@interface NSNull (ZHNatural)

- (void)forwardInvocation:(NSInvocation *)anInvocation;

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector;

@end
