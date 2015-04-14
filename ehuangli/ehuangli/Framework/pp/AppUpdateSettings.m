//
//  AppUpdateSettings.m
//  nvshengpai_2
//
//  Created by 360 on 14-8-20.
//  Copyright (c) 2014年 nvshengpai. All rights reserved.
//

#import "AppUpdateSettings.h"
#import "ZHTool.h"
#import "KeyChainManager.h"
#include <ifaddrs.h>
#include <arpa/inet.h>

@implementation AppUpdateSettings

/**
 *  获取配置文件数据
 */
+ (NSDictionary*)updateSettingsDictionary{

    NSDictionary *data = [[NSDictionary alloc]initWithContentsOfFile:[ZHTools getPathWithFileName:@"updateSettings" ofType:@"plist"]];
    return data;
}

/**
 *  获取当前版本号
 */
+ (NSString*)getAppVersion{

    NSDictionary *appInfo = [[NSBundle mainBundle] infoDictionary];
//    CFShow((__bridge CFTypeRef)(appInfo));

    return [appInfo objectForKey:@"CFBundleShortVersionString"];
}

/**
 *  获取检查更新的配置数据
 */
+ (NSDictionary*)getUpdateVersionSetting{

    NSDictionary *settings = [AppUpdateSettings updateSettingsDictionary];

    return settings[@"checkUpdateSettings"];
}

/**
 *  获取发布渠道名称
 */
+ (NSString*)getReleaseChannelName{

    NSDictionary *settings = [AppUpdateSettings updateSettingsDictionary];
    NSArray *channels = settings[@"channels"];
    NSInteger channelIndex = [settings[@"channelIndex"] integerValue];
    return channels[channelIndex][@"name"];
}

+ (NSNumber*)getReleaseChannelNumber{
    
    NSDictionary *settings = [AppUpdateSettings updateSettingsDictionary];
    NSArray *channels = settings[@"channels"];
    NSInteger channelIndex = [settings[@"channelIndex"] integerValue];
    return channels[channelIndex][@"channelId"];
}

/**
 *  当前是否在测试服，NO表示链接的正式服
 */
+ (BOOL)isTestServer{

    NSDictionary *settings = [AppUpdateSettings updateSettingsDictionary];
    return [settings[@"isTestServer"] boolValue];
}

/**
 *  返回当前app在AppStore对应的AppleID
 */
+ (NSString*)appleID{

    NSDictionary *settings = [AppUpdateSettings updateSettingsDictionary];
    return settings[@"appID"];
}

/**
 *  返回登录需要的对应的推送类型：证书类型：0，appstore;1，企业证书；2，测试服
 */
+ (NSNumber*)ckType{

#ifdef TM_CERTIFICATION
#define CK_TYPE         YES
#else
#define CK_TYPE         NO
#endif
    
#ifdef TEST_CERTIFICATION
#define Mode_type         YES
#else
#define Mode_type         NO
#endif
    
    NSNumber *ck_type = @(0);
    
    if (CK_TYPE) {//调用企业证书
        ck_type = @(1);
    }else if (Mode_type){
        ck_type = @(2);
    }
    return ck_type;
}

+ (NSString*)uuid{
    
    if ([KeyChainManager getUUID]) {
        
        return [KeyChainManager getUUID];
    }
    
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString *result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    
    [KeyChainManager saveUUID:result];
    
    return result;
}


#pragma 获取网络IP
+ (void)cacheIP{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"user_lan_ip_address_cache"]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"error" forKey:@"user_lan_ip_address_cache"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"user_wan_ip_address_cache"]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"error" forKey:@"user_wan_ip_address_cache"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    [[self class] getLANIPAddressWithCompletion:^(NSString *IPAddress) {
        
        [[NSUserDefaults standardUserDefaults] setObject:IPAddress forKey:@"user_lan_ip_address_cache"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }];
    [[self class] getWANIPAddressWithCompletion:^(NSString *IPAddress) {
        
        [[NSUserDefaults standardUserDefaults] setObject:IPAddress forKey:@"user_wan_ip_address_cache"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }];
}

+ (void)getLANIPAddressWithCompletion:(void (^)(NSString *IPAddress))completion
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *IP = [self getIPAddress];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                completion(IP);
            }
            NSLog(@"LANIP:%@",IP);
        });
    });
}

+ (void)getWANIPAddressWithCompletion:(void(^)(NSString *IPAddress))completion
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *IP = @"0.0.0.0";
        NSURL *url = [NSURL URLWithString:@"http://ifconfig.me/ip"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:8.0];
        
        NSURLResponse *response = nil;
        NSError *error = nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        if (error) {
            NSLog(@"Failed to get WAN IP Address!\n%@", error);
//            [[[UIAlertView alloc] initWithTitle:@"获取外网 IP 地址失败" message:[error localizedFailureReason] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        } else {
            NSString *responseStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            IP = responseStr;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(IP);
            NSLog(@"WANIP:%@",IP);
        });
    });
}

#pragma mark -
// http://zachwaugh.me/posts/programmatically-retrieving-ip-address-of-iphone/
+ (NSString *)getIPAddress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
    
    return address;
}
@end
