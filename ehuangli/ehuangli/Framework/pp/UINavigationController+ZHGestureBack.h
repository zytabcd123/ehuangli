//
//  UINavigationController+ZHGestureBack.h
//  nvshengpai_2
//
//  Created by 360 on 14/12/6.
//  Copyright (c) 2014年 nvshengpai. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BackGestureOffsetXToBack 80//
typedef void(^goBackBlock)();

@protocol ZHGestureBackDelegate <NSObject>
@optional

- (void)gestureBack:(UIViewController*)currentVc;

@end


@interface UINavigationController (ZHGestureBack)<UIGestureRecognizerDelegate>

@property (assign,nonatomic) BOOL enableBackGesture;
@property (assign,nonatomic) id<ZHGestureBackDelegate> backDelegate;
@property (copy,nonatomic) goBackBlock backBlock;


@end
