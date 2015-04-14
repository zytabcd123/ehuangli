//
//  ZHBlurView.m
//  nvshengpai_2
//
//  Created by 360 on 14-7-26.
//  Copyright (c) 2014年 nvshengpai. All rights reserved.
//

#import "ZHBlurView.h"

@implementation ZHBlurView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    // If we don't clip to bounds the toolbar draws a thin shadow on top
    [self setClipsToBounds:YES];
    
    [self setToolbar:[[UIToolbar alloc] initWithFrame:[self bounds]]];
    self.toolbar.barTintColor = nil;
    self.toolbar.translucent = YES;
    [self.layer insertSublayer:[self.toolbar layer] atIndex:0];
}

- (void) setBlurTintColor:(UIColor *)blurTintColor {
    [self.toolbar setBarTintColor:blurTintColor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.toolbar setFrame:[self bounds]];
}

@end
