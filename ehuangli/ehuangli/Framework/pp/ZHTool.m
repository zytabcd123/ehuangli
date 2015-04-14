//
//  ZHTool.m
//  PPFramework
//
//  Created by 张玉庭 on 15/4/7.
//  Copyright (c) 2015年 zyt. All rights reserved.
//


#import "ZHTool.h"
#import <Accelerate/Accelerate.h>
@implementation ZHTools


#pragma mark - 格式化时间相关
+ (NSDateFormatter*)sharedNSDateFormatter{
    
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter *dateFormatter = threadDictionary[@"mydateformatter"];
    
    if(!dateFormatter){
        @synchronized(self){
            if(!dateFormatter){
                dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT+0800"]];
                threadDictionary[@"mydateformatter"] = dateFormatter;
            }
        }
    }
    return dateFormatter;
}


+ (NSCalendar*)sharedNSCalendar{
    
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    NSCalendar *sharedCalendar = threadDictionary[@"myCalendar"];
    if(!sharedCalendar){
        @synchronized(self){
            if(!sharedCalendar){
                
                sharedCalendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierChinese];
                threadDictionary[@"myCalendar"] = sharedCalendar;
            }
        }
    }
    return sharedCalendar;
}

+ (NSString *)getCurrentTimeInterval
{
    NSTimeInterval ct = [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%f",ct];
    return timeString;
}

+ (NSString*)timeFormatterWithTimeInterval:(NSString*)timeInterval{
    
    if ([timeInterval isEqualToString:@""] || timeInterval == nil || [timeInterval isEqualToString:@"0"]) {
        return @"";
    }
    NSDateFormatter *formatter = ZH_SHARED_DATE_FORMATTER;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    //    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"GMT+0800"];
    //    [formatter setTimeZone:timeZone];
    
    //时间戳的值时间戳转时间的方法
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timeInterval longLongValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    
    return confromTimespStr;
}

+ (NSString*)dateFormatterWithDateStr:(NSString*)confromTimespStr{
    
    if ([confromTimespStr isEqualToString:@""] || confromTimespStr == nil || [confromTimespStr isEqualToString:@"0"]) {
        return @"";
    }
    NSCalendar *gregorian = ZH_SHARED_CALENDAR;
    NSUInteger unitFlags = NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateFormatter *format = ZH_SHARED_DATE_FORMATTER;
    
    NSDate *fromdate=[format dateFromString:confromTimespStr];
    NSDate *date = [NSDate date];
    
    NSDateComponents *components1 = [gregorian components:unitFlags fromDate:fromdate];
    NSDateComponents *components2 = [gregorian components:unitFlags fromDate:date];
    //    ZHLOG(@"%@",confromTimespStr);
    if (components1.month == components2.month && components1.day == components2.day) {
        
        [format setDateFormat:@"HH:mm"];
        NSString* timeStr1=[NSString stringWithFormat:@"今天 %@",[format stringFromDate:fromdate]];//今天 11:23
        return timeStr1;
    }else if(components1.month == components2.month && components1.day == components2.day-1){
        
        [format setDateFormat:@"HH:mm"];
        NSString* timeStr2=[NSString stringWithFormat:@"昨天 %@",[format stringFromDate:fromdate]];//昨天 11:23
        return timeStr2;
    }else
        [format setDateFormat:@"yyyy-MM-dd"];
    
    NSString* timeStr3 = [format stringFromDate:fromdate];
    return timeStr3;
}

+ (NSString*)dateFormatterWithDateStr2:(NSString*)confromTimespStr{
    
    if ([confromTimespStr isEqualToString:@""] || confromTimespStr == nil || [confromTimespStr isEqualToString:@"0"]) {
        return @"";
    }
    NSDateFormatter *format = ZH_SHARED_DATE_FORMATTER;
    NSDate *fromdate=[format dateFromString:confromTimespStr];
    
    [format setDateFormat:@"yyyy-MM-dd"];
    NSString* timeStr3 = [format stringFromDate:fromdate];
    return timeStr3;
}

+ (NSDate *)dateFromString:(NSString *)dateString{
    NSDateFormatter *dateFormatter = ZH_SHARED_DATE_FORMATTER;
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    return destDate;
}

+ (NSString*)getCurrentTime{
    
    NSDateFormatter *dateFormatter = ZH_SHARED_DATE_FORMATTER;
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    
    return [dateFormatter stringFromDate:[NSDate date]];
}

+ (NSString*)getCurrentTimeText{
    
    NSDateFormatter *dateFormatter = ZH_SHARED_DATE_FORMATTER;
    dateFormatter.dateStyle = kCFDateFormatterFullStyle;
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];

    return [dateFormatter stringFromDate:[NSDate date]];
}

+(NSString*)getChineseCalendarWithDate:(NSDate *)date{
    
    NSArray *chineseYears = [NSArray arrayWithObjects:
                             @"甲子", @"乙丑", @"丙寅", @"丁卯",  @"戊辰",  @"己巳",  @"庚午",  @"辛未",  @"壬申",  @"癸酉",
                             @"甲戌",   @"乙亥",  @"丙子",  @"丁丑", @"戊寅",   @"己卯",  @"庚辰",  @"辛己",  @"壬午",  @"癸未",
                             @"甲申",   @"乙酉",  @"丙戌",  @"丁亥",  @"戊子",  @"己丑",  @"庚寅",  @"辛卯",  @"壬辰",  @"癸巳",
                             @"甲午",   @"乙未",  @"丙申",  @"丁酉",  @"戊戌",  @"己亥",  @"庚子",  @"辛丑",  @"壬寅",  @"癸丑",
                             @"甲辰",   @"乙巳",  @"丙午",  @"丁未",  @"戊申",  @"己酉",  @"庚戌",  @"辛亥",  @"壬子",  @"癸丑",
                             @"甲寅",   @"乙卯",  @"丙辰",  @"丁巳",  @"戊午",  @"己未",  @"庚申",  @"辛酉",  @"壬戌",  @"癸亥", nil];
    
    NSArray *chineseMonths=[NSArray arrayWithObjects:
                            @"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",
                            @"九月", @"十月", @"冬月", @"腊月", nil];
    
    
    NSArray *chineseDays=[NSArray arrayWithObjects:
                          @"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",
                          @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",
                          @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十",  nil];
    
    
    NSCalendar *localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:date];
    
    NSString *y_str = [chineseYears objectAtIndex:localeComp.year-1];
    NSString *m_str = [chineseMonths objectAtIndex:localeComp.month-1];
    NSString *d_str = [chineseDays objectAtIndex:localeComp.day-1];
    
    NSString *chineseCal_str =[NSString stringWithFormat: @"%@年 %@ %@",y_str,m_str,d_str];
    
    
    return chineseCal_str;  
}

+ (NSTimeInterval)countdownWithExpiresIn:(NSString*)theExpiresIn{
    
    NSDateFormatter *formatter = ZH_SHARED_DATE_FORMATTER;
    
    NSDate *date1 = [NSDate date];
    NSDate *date2 = [formatter dateFromString:[ZHTools timeFormatterWithTimeInterval:theExpiresIn]];
    
    NSTimeInterval time = [date2 timeIntervalSinceDate:date1];
    
    return time;
}


+ (BOOL)checkTimeout:(NSString*)eTime advance:(NSTimeInterval)advance{
    
    NSTimeInterval ct = [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970];
    if (([eTime longLongValue] - ct) < advance) {//提前5分钟过期
        
        return YES;
    }
    return NO;
}


+ (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}



+ (void)timeCountdownWithDuration:(NSTimeInterval)duration
                         disTimer:(dispatch_source_t)timer
                     timeInterval:(int)interval
                            start:(void (^)(NSTimeInterval time ,NSString *fomatTime))start
                         finished:(void (^)(void))finished{
    
    __block long long timeout = duration;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(timer,dispatch_walltime(NULL, 0),interval*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(timer, ^{
        
        if (timeout <= 0) {//倒计时结束
            
            dispatch_source_cancel(timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                finished();
            });
            
        }else{
            
            long long hours = timeout / 60 / 60;
            long long minutes = (timeout / 60) % 60;
            long long seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%lld:%lld:%lld",hours, minutes, seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                start(timeout,strTime);
            });
            timeout--;
        }
    });
    dispatch_resume(timer);
}



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
                                      minH:(CGFloat)minH{
    
    if (!text || text.length <= 0) {
        
        return minH;
    }
    
    CGSize size = [ZHTools constrainedToSize:CGSizeMake(aSize.width, MAXFLOAT) content:text fontSize:fontSize];
//    CGSize size = [text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]}];
    if (size.height > aSize.height) {
        
        return size.height - aSize.height;
    }
    
    return 0;
}

+ (CGSize)constrainedToSize:(CGSize)size  content:(NSString *)content fontSize:(float)fontSize{
    if (!content || [content isEqualToString:@""] || [content isEqual:[NSNull null]]) {
        return CGSizeZero;
    }
    CGSize contentSize = [content sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    return contentSize;
}

+ (NSMutableAttributedString*)getAttributedString:(NSString*)sourceStr
                                          markStr:(NSString*)theNarkStr
                                        narkColor:(UIColor*)theMarkColor
                                             font:(UIFont*)theFont{
    
    NSRange range = [sourceStr rangeOfString:theNarkStr];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:sourceStr];
    [attributeStr setAttributes:@{NSForegroundColorAttributeName: theMarkColor,
                                  NSFontAttributeName: theFont}
                          range:range];
    return attributeStr;
}

/**
 *  屏幕截取方法
 *
 *  @param v 父视图
 *
 *  @return 返回屏幕截图
 */
+ (UIImage *)captureScreen:(UIView *)v
{
    CGSize size = v.bounds.size;
    
    CGFloat scale = [UIScreen mainScreen].scale;
    size.width *= scale;
    size.height *= scale;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    if ([v respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
    {
        [v drawViewHierarchyInRect:(CGRect){.origin = CGPointZero, .size = size} afterScreenUpdates:YES];
    }
    else
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        CGContextScaleCTM(ctx, scale, scale);
        
        [v.layer renderInContext:ctx];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 *  屏幕截取方法（去掉导航部分）
 *
 *  @param v 父视图
 *
 *  @return 返回去掉导航栏部分的屏幕截图
 */
+ (UIImage *)captureScreenWithoutNav:(UIView *)v
{
    CGSize size = v.frame.size;
    
    CGFloat scale = [UIScreen mainScreen].scale;
    size.width *= scale;
    size.height *= scale;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    if ([v respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
    {
        [v drawViewHierarchyInRect:(CGRect){.origin = CGPointZero, .size = size} afterScreenUpdates:YES];
    }
    else
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        CGContextScaleCTM(ctx, scale, scale);
        
        [v.layer renderInContext:ctx];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGRect actualCropRect = CGRectMake(
                                       roundf(0),
                                       roundf(64*scale*scale),
                                       roundf(size.width * scale),
                                       roundf(size.height * scale)
                                       );
    UIImage *outputImage = nil;
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, actualCropRect);
    outputImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return outputImage;
}

+ (UIImage *)blurImage:(UIImage *)image withRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage
{
    // Check pre-conditions.
    if (image.size.width < 1 || image.size.height < 1) {
        NSLog (@"*** error: invalid size: (%.2f x %.2f). Both dimensions must be >= 1: %@", image.size.width, image.size.height, image);
        return nil;
    }
    if (!image.CGImage) {
        NSLog (@"*** error: image must be backed by a CGImage: %@", image);
        return nil;
    }
    if (maskImage && !maskImage.CGImage) {
        NSLog (@"*** error: maskImage must be backed by a CGImage: %@", maskImage);
        return nil;
    }
    
    CGRect imageRect = { CGPointZero, image.size };
    UIImage *effectImage = image;
    
    BOOL hasBlur = blurRadius > __FLT_EPSILON__;
    BOOL hasSaturationChange = fabs(saturationDeltaFactor - 1.) > __FLT_EPSILON__;
    if (hasBlur || hasSaturationChange) {
        UIGraphicsBeginImageContextWithOptions(image.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectInContext = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(effectInContext, 1.0, -1.0);
        CGContextTranslateCTM(effectInContext, 0, -image.size.height);
        CGContextDrawImage(effectInContext, imageRect, image.CGImage);
        
        vImage_Buffer effectInBuffer;
        effectInBuffer.data     = CGBitmapContextGetData(effectInContext);
        effectInBuffer.width    = CGBitmapContextGetWidth(effectInContext);
        effectInBuffer.height   = CGBitmapContextGetHeight(effectInContext);
        effectInBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectInContext);
        
        UIGraphicsBeginImageContextWithOptions(image.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectOutContext = UIGraphicsGetCurrentContext();
        vImage_Buffer effectOutBuffer;
        effectOutBuffer.data     = CGBitmapContextGetData(effectOutContext);
        effectOutBuffer.width    = CGBitmapContextGetWidth(effectOutContext);
        effectOutBuffer.height   = CGBitmapContextGetHeight(effectOutContext);
        effectOutBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectOutContext);
        
        if (hasBlur) {
            // A description of how to compute the box kernel width from the Gaussian
            // radius (aka standard deviation) appears in the SVG spec:
            // http://www.w3.org/TR/SVG/filters.html#feGaussianBlurElement
            //
            // For larger values of 's' (s >= 2.0), an approximation can be used: Three
            // successive box-blurs build a piece-wise quadratic convolution kernel, which
            // approximates the Gaussian kernel to within roughly 3%.
            //
            // let d = floor(s * 3*sqrt(2*pi)/4 + 0.5)
            //
            // ... if d is odd, use three box-blurs of size 'd', centered on the output pixel.
            //
            CGFloat inputRadius = blurRadius * [[UIScreen mainScreen] scale];
            int radius = floor(inputRadius * 3. * sqrt(2 * M_PI) / 4 + 0.5);
            if (radius % 2 != 1) {
                radius += 1; // force radius to be odd so that the three box-blur methodology works.
            }
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
        }
        BOOL effectImageBuffersAreSwapped = NO;
        if (hasSaturationChange) {
            CGFloat s = saturationDeltaFactor;
            CGFloat floatingPointSaturationMatrix[] = {
                0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0,
                0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0,
                0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0,
                0,                    0,                    0,  1,
            };
            const int32_t divisor = 256;
            NSUInteger matrixSize = sizeof(floatingPointSaturationMatrix)/sizeof(floatingPointSaturationMatrix[0]);
            int16_t saturationMatrix[matrixSize];
            for (NSUInteger i = 0; i < matrixSize; ++i) {
                saturationMatrix[i] = (int16_t)roundf(floatingPointSaturationMatrix[i] * divisor);
            }
            if (hasBlur) {
                vImageMatrixMultiply_ARGB8888(&effectOutBuffer, &effectInBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
                effectImageBuffersAreSwapped = YES;
            }
            else {
                vImageMatrixMultiply_ARGB8888(&effectInBuffer, &effectOutBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
            }
        }
        if (!effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        if (effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    // Set up output context.
    UIGraphicsBeginImageContextWithOptions(image.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef outputContext = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(outputContext, 1.0, -1.0);
    CGContextTranslateCTM(outputContext, 0, -image.size.height);
    
    // Draw base image.
    CGContextDrawImage(outputContext, imageRect, image.CGImage);
    
    // Draw effect image.
    if (hasBlur) {
        CGContextSaveGState(outputContext);
        if (maskImage) {
            CGContextClipToMask(outputContext, imageRect, maskImage.CGImage);
        }
        CGContextDrawImage(outputContext, imageRect, effectImage.CGImage);
        CGContextRestoreGState(outputContext);
    }
    
    // Add in color tint.
    if (tintColor) {
        CGContextSaveGState(outputContext);
        CGContextSetFillColorWithColor(outputContext, tintColor.CGColor);
        CGContextFillRect(outputContext, imageRect);
        CGContextRestoreGState(outputContext);
    }
    
    // Output image is ready.
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outputImage;
}


+ (NSString*)getPathWithFileName:(NSString*)fileName ofType:(NSString*)type{
    
    return [[NSBundle mainBundle]pathForResource:fileName ofType:type];
}

+(void)setExtraCellLineHidden:(UITableView *)tableView{
    UIView* view= [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

+ (BOOL)isEmptyOrNull:(NSString *)string{
    if (!string) {
        return YES;
    }
    if ([string isEqualToString:@""]) {
        return YES;
    }
    if (string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}


+ (NSArray*)randomizedArrayWithArr:(NSArray*)arr{
    
    NSMutableArray *results = [NSMutableArray arrayWithArray:arr];
    
    NSUInteger i = arr.count;
    while (-- i > 0) {
        
        int j = rand() % (i + 1);
        
        [results exchangeObjectAtIndex:i withObjectAtIndex:j];
    }
    return results;
}


+ (BOOL)zh_string:(NSString*)str containsString:(NSString*)cStr{
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        
        if ([str containsString:cStr]) {
            return YES;
        }else{
            return NO;
        }
    }else{
        
        NSRange foundObj=[str rangeOfString:cStr options:NSCaseInsensitiveSearch];
        if (foundObj.length > 0) {
            return YES;
        }else{
            return NO;
        }
    }
}
@end
