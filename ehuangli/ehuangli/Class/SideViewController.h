//
//  SideViewController.h
//  huangli
//
//  Created by 张玉庭 on 15/4/2.
//  Copyright (c) 2015年 zhangyuting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SideNavDelegate.h"

@interface SideViewController : UIViewController


@property (assign, nonatomic) id<SideNavDelegate> delegate;

@end
