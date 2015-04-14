//
//  ZHTool.h
//  PPFramework
//
//  Created by 张玉庭 on 15/4/7.
//  Copyright (c) 2015年 zyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


#define ZH_SHARED_DATE_FORMATTER [ZHTools sharedNSDateFormatter]
#define ZH_SHARED_CALENDAR [ZHTools sharedNSCalendar]

@interface ZHTools : NSObject

#pragma mark - 格式化时间相关
/**
 *  因为NSDateFormatter初始化非常慢，所以对NSDateFormatter实行单例化
 *
 *  @return NSDateFormatter实例化对象
 */
+ (NSDateFormatter*)sharedNSDateFormatter;

/**
 *  因为NSCalendar初始化非常慢，所以对NSCalendar实行单例化
 *
 *  @return NSCalendar实例化对象
 */
+ (NSCalendar*)sharedNSCalendar;
/**
 *  获取当前时间戳
 */
+ (NSString *)getCurrentTimeInterval;

/**
 * 用来把一个Unix时间戳（1366593657）格式化成：2013-4-22 上午9:20 格式
 * @param timeInterval传入一个Unix时间戳格式的时间
 * @return
 */
+ (NSString*)timeFormatterWithTimeInterval:(NSString*)timeInterval;

/**
 * 自定义时间格式化：今天 16：11、昨天 13：22
 * @param confromTimespStr传入一个timeFormatterWithTimeInterval方法格式化后的时间
 * @return
 */
+ (NSString*)dateFormatterWithDateStr:(NSString*)confromTimespStr;

/**
 * 自定义时间格式化：yyyy.MM.dd
 * @param confromTimespStr传入一个timeFormatterWithTimeInterval方法格式化后的时间
 * @return
 */
+ (NSString*)dateFormatterWithDateStr2:(NSString*)confromTimespStr;

/**
 * 输入的日期字符串转为NSDate
 * @param 输入的日期字符串形如：@"1992-05-21"
 * @return
 */
+ (NSDate *)dateFromString:(NSString *)dateString;

+ (NSString*)getCurrentTime;
+ (NSString*)getCurrentTimeText;
+ (NSString*)getChineseCalendarWithDate:(NSDate *)date;

/**
 *  检查是否过期，yes过期
 *
 *  @param eTime   过期时间戳
 *  @param advance 提前多少秒过期
 *
 *  @return 返回YES为过期
 */
+ (BOOL)checkTimeout:(NSString*)eTime advance:(NSTimeInterval)advance;


/**
 *  修复上传图片的时候方向变换问题（目前前置摄像头拍摄的照片无法正常转换）
 *
 *  @param aImage 图片
 *
 *  @return 返回正确方向的图片
 */
+ (UIImage *)fixOrientation:(UIImage *)aImage;

/**
 *  倒计时函数
 *
 *  @param duration 倒计时持续时间
 *  @param timer    dispatch_source_t控制倒计时的暂停恢复和取消倒计时
 *  @param interval 倒计时间隔
 *  @param start    开始倒计时后的回调Block
 *  @param finished 结束倒计时后的回调Block
 */
+ (void)timeCountdownWithDuration:(NSTimeInterval)duration
                         disTimer:(dispatch_source_t)timer
                     timeInterval:(int)interval
                            start:(void (^)(NSTimeInterval time ,NSString *fomatTime))start
                         finished:(void (^)(void))finished;

/**
 *  label高度自适应
 *
 *  @param aSize    label默认size
 *  @param text     显示的text
 *  @param fontSize 系统字体大小
 *  @param minH     最低高度，通常在空字符串的时候返回一个最低高度（建议0）
 *
 *  @return 重新计算label的高度与原label的高度差
 */
+ (CGFloat)getLabelAutoHeightWithLabelSize:(CGSize)aSize
                                      text:(NSString*)text
                                  fontSize:(CGFloat)fontSize
                                      minH:(CGFloat)minH;
/**
 *  给UILabel的内容设置不同颜色
 *
 *  @param sourceStr    要显示的完整内容的字符串
 *  @param theNarkStr   要标记颜色的字符串
 *  @param theMarkColor 标记的颜色
 *  @param theFont      标记的字体
 *
 *  @return NSMutableAttributedString
 */
+ (NSMutableAttributedString*)getAttributedString:(NSString*)sourceStr
                                          markStr:(NSString*)theNarkStr
                                        narkColor:(UIColor*)theMarkColor
                                             font:(UIFont*)theFont;


+ (UIImage *)captureScreen:(UIView *)v;
+ (UIImage *)captureScreenWithoutNav:(UIView *)v;

+ (UIImage *)blurImage:(UIImage *)image
            withRadius:(CGFloat)blurRadius
             tintColor:(UIColor *)tintColor
 saturationDeltaFactor:(CGFloat)saturationDeltaFactor
             maskImage:(UIImage *)maskImage;

/**
 *  读取本地文件地址
 *
 *  @param fileName 文件名
 *  @param type     文件类型
 *
 *  @return 文件地址
 */
+ (NSString*)getPathWithFileName:(NSString*)fileName ofType:(NSString*)type;

/**
 *  清除多余TableView多余的行
 *
 *  @param tableView UITableView
 */
+(void)setExtraCellLineHidden:(UITableView *)tableView;

/**
 *  判断NSString  是否为空
 */
+ (BOOL)isEmptyOrNull:(NSString *)string;

+ (NSArray*)randomizedArrayWithArr:(NSArray*)arr;

+ (BOOL)zh_string:(NSString*)str containsString:(NSString*)cStr;

@end
