//
//  NSInvocation+SimpleCreation.h
//  nvshengpai_2
//
//  Created by 360 on 14/9/29.
//  Copyright (c) 2014年 nvshengpai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSInvocation (SimpleCreation)

+ (NSInvocation*)zh_invocationWithTarget:(id)target andSelector:(SEL)selector;
+ (NSInvocation*)zh_invocationWithTarget:(id)target selector:(SEL)selector andArguments:(NSArray*)arguments;

@end
