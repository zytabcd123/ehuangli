//
//  CalendarModel.m
//  huangli
//
//  Created by 张玉庭 on 15/4/2.
//  Copyright (c) 2015年 zhangyuting. All rights reserved.
//

#import "CalendarModel.h"

@implementation SuitInfoModel
@synthesize title;
@synthesize subTitle;

@end

@implementation CalendarModel
@synthesize type;
@synthesize timeText;
@synthesize subTimeText;
@synthesize model1;
@synthesize model2;
@synthesize model3;

+ (CalendarModel*)parse:(NSDictionary*)dic type:(int)type{
    
    CalendarModel *model = [[CalendarModel alloc]init];
    
    model.type = type;
    model.timeText = [ZHTools getCurrentTimeText];
    model.subTimeText = [ZHTools getChineseCalendarWithDate:[NSDate date]];
    model.model1 = [[SuitInfoModel alloc]init];
    model.model2 = [[SuitInfoModel alloc]init];
    model.model3 = [[SuitInfoModel alloc]init];

    if (type == 1) {
        
        model.model1.title = dic[@"sco1"];
        model.model1.subTitle = dic[@"scd1"];
        model.model2.title = dic[@"sco2"];
        model.model2.subTitle = dic[@"scd2"];
        model.model3.title = dic[@"sco3"];
        model.model3.subTitle = dic[@"scd3"];
    }else{
        
        model.model1.title = dic[@"usco1"];
        model.model1.subTitle = dic[@"uscd1"];
        model.model2.title = dic[@"usco2"];
        model.model2.subTitle = dic[@"uscd2"];
        model.model3.title = dic[@"usco3"];
        model.model3.subTitle = dic[@"uscd3"];
    }
    
    return model;
}

@end
