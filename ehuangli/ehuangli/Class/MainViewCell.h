//
//  MainViewCell.h
//  huangli
//
//  Created by 张玉庭 on 15/4/2.
//  Copyright (c) 2015年 zhangyuting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarModel.h"

@interface MainViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel1;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel1;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel2;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel2;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel3;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel3;

@property (strong, nonatomic) CalendarModel *model;

@end
