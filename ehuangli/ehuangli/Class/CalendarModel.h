//
//  CalendarModel.h
//  huangli
//
//  Created by 张玉庭 on 15/4/2.
//  Copyright (c) 2015年 zhangyuting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SuitInfoModel : NSObject

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *subTitle;


@end

@interface CalendarModel : NSObject

@property (assign, nonatomic) int type;

@property (copy, nonatomic) NSString *timeText;
@property (copy, nonatomic) NSString *subTimeText;

@property (strong, nonatomic) SuitInfoModel *model1;
@property (strong, nonatomic) SuitInfoModel *model2;
@property (strong, nonatomic) SuitInfoModel *model3;

+ (CalendarModel*)parse:(NSDictionary*)dic type:(int)type;


@end
