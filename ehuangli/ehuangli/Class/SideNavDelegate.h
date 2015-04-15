//
//  SideNavDelegate.h
//  ehuangli
//
//  Created by 张玉庭 on 15/4/14.
//  Copyright (c) 2015年 zyt. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SideNavDelegate <NSObject>

@optional

- (void)pushTo:(UIViewController*)vc animation:(BOOL)animation;
- (void)presentTo:(UIViewController*)vc animated: (BOOL)flag completion:(void (^)(void))completion;

@end
