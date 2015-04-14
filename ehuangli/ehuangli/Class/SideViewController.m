//
//  SideViewController.m
//  huangli
//
//  Created by 张玉庭 on 15/4/2.
//  Copyright (c) 2015年 zhangyuting. All rights reserved.
//

#import "SideViewController.h"
#import "UMFeedback.h"

@interface SideViewController ()

@property (weak, nonatomic) IBOutlet UILabel *versionLabel;

@end

@implementation SideViewController
@synthesize delegate;
@synthesize versionLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.versionLabel.text = [AppUpdateSettings getAppVersion];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)buttonInViewClick:(id)sender{

//    //软件版本
//    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
//    //手机系统版本
//    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
//    //手机型号
//    NSString* phoneModel = [[UIDevice currentDevice] model];
//    
//    NSDictionary *datas = @{@"app_version": version,
//                            @"phone_model": phoneModel,
//                            @"system_version": phoneVersion,
//                            @"content": @"0000000"
//                            };
//    
//    [[UMFeedback sharedInstance] post:datas];
    
    
//    [self presentViewController:[UMFeedback feedbackModalViewController] animated:YES completion:nil];
//    [self.navigationController pushViewController:[UMFeedback feedbackViewController] animated:YES];
    if ([self.delegate respondsToSelector:@selector(pushTo:)]) {
        
        [self.delegate pushTo:[UMFeedback feedbackViewController]];
    }
}

@end
