//
//  MainHeadCell.m
//  ehuangli
//
//  Created by 张玉庭 on 15/4/12.
//  Copyright (c) 2015年 zyt. All rights reserved.
//

#import "MainHeadCell.h"

@implementation MainHeadCell
@synthesize titleLabel;
@synthesize subTitleLabel;


- (void)setModel:(CalendarModel *)model{

    _model = model;
    
    self.titleLabel.text = model.timeText;
    self.subTitleLabel.text = model.subTimeText;
    
}

- (void)awakeFromNib {
    // Initialization code
}

@end
