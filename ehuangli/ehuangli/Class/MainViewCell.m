//
//  MainViewCell.m
//  huangli
//
//  Created by 张玉庭 on 15/4/2.
//  Copyright (c) 2015年 zhangyuting. All rights reserved.
//

#import "MainViewCell.h"

@implementation MainViewCell
@synthesize typeLabel;
@synthesize titleLabel1;
@synthesize titleLabel2;
@synthesize titleLabel3;
@synthesize subTitleLabel1;
@synthesize subTitleLabel2;
@synthesize subTitleLabel3;


- (void)setModel:(CalendarModel *)model{
    
    _model = model;
    
    self.titleLabel1.text = _model.model1.title;
    self.subTitleLabel1.text = _model.model1.subTitle;
    
    self.titleLabel2.text = _model.model2.title;
    self.subTitleLabel2.text = _model.model2.subTitle;
    
    self.titleLabel3.text = _model.model3.title;
    self.subTitleLabel3.text = _model.model3.subTitle;
    if (_model.type == 1) {//宜
        
        self.typeLabel.backgroundColor = RGBA(245, 172, 26, 1);
        self.contentView.backgroundColor = RGBA(254, 195, 107, 1);
        self.typeLabel.text = @"宜";
    }else{
        
        self.typeLabel.backgroundColor = RGBA(208, 0, 10, 1);
        self.contentView.backgroundColor = RGBA(226, 130, 123, 1);
        self.typeLabel.text = @"忌";
    }
}

- (void)awakeFromNib {
    // Initialization code
}



@end
