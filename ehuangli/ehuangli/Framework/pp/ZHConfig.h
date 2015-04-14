//
//  ZHConfig.h
//  ZHFilterCamera
//
//  Created by 360 on 13-9-24.
//  Copyright (c) 2013年 nvshengpai. All rights reserved.
//

#ifndef ZHFilterCamera_ZHConfig_h
#define ZHFilterCamera_ZHConfig_h

#endif

#import "ZHHeader.h"
//#import "UserInfo.h"


//非XIB屏幕高度，用来在代码中计算屏幕宽高的
#define kWidth  [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

// View 坐标(x,y)和宽高(width,height)
#define ZHX(v)                    (v).frame.origin.x
#define ZHY(v)                    (v).frame.origin.y
#define ZHWIDTH(v)                (v).frame.size.width
#define ZHHEIGHT(v)               (v).frame.size.height

#define ZHMinX(v)                 CGRectGetMinX((v).frame)
#define ZHMinY(v)                 CGRectGetMinY((v).frame)

#define ZHMidX(v)                 CGRectGetMidX((v).frame)
#define ZHMidY(v)                 CGRectGetMidY((v).frame)

#define ZHMaxX(v)                 CGRectGetMaxX((v).frame)
#define ZHMaxY(v)                 CGRectGetMaxY((v).frame)



#define RGBA(r,g,b,a)           [UIColor colorWithRed:((r)/255.0) green:((g)/255.0) blue:((b)/255.0) alpha:(a)]
// RGB颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue)\
                                \
                                [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                                green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
                                blue:((float)(rgbValue & 0xFF))/255.0 \
                                alpha:1.0]
// 常用色
#define ZHColorWithBlack        RGBA(43,36,39,1)//文本色，黑色
#define ZHColorWithDarkGrey     RGBA(149,145,147,1)//深灰色
#define ZHColorWithMiddleGrey   RGBA(132,132,132,1)//中灰色
#define ZHColorWithLightGrey    RGBA(213,211,212,1)//浅灰色

#define ZHColorWithCutLineGrey      RGBA(229,230,233)//灰色分割线
#define ZHColorWithBackgroundGrey   RGBA(244,244,244,1)//背景灰
#define ZHColorWithPink             RGBA(255,59,96,1)//主题色
#define ZHColorWithGreen            RGBA(90,232,183)//辅助色

#define ZHColorWithName            RGBA(52,9,55)//女生昵称颜色
#define ZHColorWithDiamond         RGBA(147,38,128)//钻石数值颜色
#define ZHColorWithGold            RGBA(189,154,107)//金币数值色

#define ZHColorWithBlue         RGBA(79,178,255,1)//蓝色
#define ZHColorWithRed          RGBA(255,54,54,1)//红色



//方法调用相关
#define USER_DEFAULT            [NSUserDefaults standardUserDefaults]

#define NOTIFICATION_CENTER     [NSNotificationCenter defaultCenter]

//#define HUD_SHARED              [HUD sharedHUD]
//
//#define USER_INFO               [UserInfo sharedUserInfo]

//appid
#define APP_ID 759743957

