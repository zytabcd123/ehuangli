//
//  UIResponder+Router.m
//  nvshengpai_2
//
//  Created by 360 on 15/1/15.
//  Copyright (c) 2015年 nvshengpai. All rights reserved.
//

#import "UIResponder+Router.h"

@implementation UIResponder (Router)

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    [[self nextResponder] routerEventWithName:eventName userInfo:userInfo];
}


@end
