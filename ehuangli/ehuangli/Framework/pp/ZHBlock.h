//
//  ZHBlock.h
//  PPFramework
//
//  Created by 张玉庭 on 15/4/7.
//  Copyright (c) 2015年 zyt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHBlock : NSObject

+ (void)dispatchOnMainThread:(void (^)())block;

+ (void)dispatchAfter:(NSTimeInterval)delay onMainThread:(void (^)())block;

+ (void)dispatchOnSynchronousQueue:(void (^)())block;

+ (void)dispatchOnSynchronousFileQueue:(void (^)())block;

+ (void)dispatchOnDefaultPriorityConcurrentQueue:(void (^)())block;
+ (void)dispatchOnLowPriorityConcurrentQueue:(void (^)())block;
+ (void)dispatchOnHighPriorityConcurrentQueue:(void (^)())block;

@end
