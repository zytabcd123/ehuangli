//
//  AppUpdateSettings.h
//  nvshengpai_2
//
//  Created by 360 on 14-8-20.
//  Copyright (c) 2014年 nvshengpai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppUpdateSettings : NSObject


/**
 *  获取配置文件数据
 */
+ (NSDictionary*)updateSettingsDictionary;

/**
 *  获取当前版本号
 */
+ (NSString*)getAppVersion;

/**
 *  获取检查更新的配置数据
 */
+ (NSDictionary*)getUpdateVersionSetting;

/**
 *  获取发布渠道名称
 */
+ (NSString*)getReleaseChannelName;

/**
 *  获取发布渠道对应的标志位，登录时候用
 */
+ (NSNumber*)getReleaseChannelNumber;

/**
 *  当前是否在测试服，NO表示链接的正式服
 */
+ (BOOL)isTestServer;

/**
 *  返回当前app在AppStore对应的AppleID
 */
+ (NSString*)appleID;

/**
 *  返回登录需要的对应的推送类型：证书类型：0，appstore;1，企业证书；2，测试服
 */
+ (NSNumber*)ckType;

+ (NSString*)uuid;

/**
 *  在用户唤醒的时候缓存用户IP地址，当视频上传失败的时候直接读取缓存IP地址
 */
+ (void)cacheIP;
//获取网络IP地址
+ (void)getLANIPAddressWithCompletion:(void (^)(NSString *IPAddress))completion;
+ (void)getWANIPAddressWithCompletion:(void(^)(NSString *IPAddress))completion;

@end
