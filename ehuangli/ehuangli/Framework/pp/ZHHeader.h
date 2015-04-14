//
//  ZHHeader.h
//  nvshengpai_2
//
//  Created by 360 on 13-10-21.
//  Copyright (c) 2013年 nvshengpai. All rights reserved.
//

#import "ZHTool.h"
#import "ZHBlock.h"
#import "ZHBlurView.h"

#import "AppUpdateSettings.h"
#import "ZHFileManager.h"
#import "UIResponder+Router.h"
#import "NSNull+ZHNatural.h"

#import "CHTCollectionViewWaterfallLayout.h"
#import "UINavigationController+ZHGestureBack.h"
#import "NSInvocation+SimpleCreation.h"
#import "ALAssetsLibrary+ZHExpand.h"
#import "KeyChainManager.h"
#import "AppUpdateSettings.h"


/**
 *  ARC模式下的单例模板
 *
 */
#define ZH_ARC_SYNTHESIZE_SINGLETON_FOR_HEADER(className) \
\
+ (className *)shared##className;

#define ZH_ARC_SYNTHESIZE_SINGLETON_FOR_CLASS(className) \
\
+ (className *)shared##className { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}



/**
 *  格式化输出日志
 *
 */
#define DEBUGLOG
#ifdef DEBUGLOG
#define ZHLOG( s, ... ) NSLog( @"<类名：%@ 位置：%d>  类方法：%s 输出：%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, __PRETTY_FUNCTION__, [NSString stringWithFormat:(s), ##__VA_ARGS__])
#else
#define ZHLOG( s, ... ) do {} while (0)
#endif