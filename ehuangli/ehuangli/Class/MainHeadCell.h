//
//  MainHeadCell.h
//  ehuangli
//
//  Created by 张玉庭 on 15/4/12.
//  Copyright (c) 2015年 zyt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarModel.h"

@interface MainHeadCell : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@property (strong, nonatomic) CalendarModel *model;

@end
