//
//  MainCollectionViewController.m
//  ehuangli
//
//  Created by 张玉庭 on 15/4/12.
//  Copyright (c) 2015年 zyt. All rights reserved.
//

#import "MainCollectionViewController.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "MainHeadCell.h"
#import "MainViewCell.h"
#import "CalendarModel.h"
#import "MainFoodCell.h"
#import "UMSocial.h"
#import "SideViewController.h"
#import "UMFeedback.h"
#import <iAd/iAd.h>

static NSString *headCellID = @"headCellID";
static NSString *cellID = @"cellID";
static NSString *foodCellID = @"foodCellID";

@interface MainCollectionViewController ()<CHTCollectionViewDelegateWaterfallLayout,UICollectionViewDataSource,UICollectionViewDelegate,UMSocialDataDelegate,UMSocialUIDelegate,SideNavDelegate,ADBannerViewDelegate>{
    
    NSMutableArray *myDataSource;
    SideViewController *svc;
}

@end

@implementation MainCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    CHTCollectionViewWaterfallLayout *layouts = [[CHTCollectionViewWaterfallLayout alloc] init];
    layouts.columnCount = 1;
    layouts.minimumInteritemSpacing = 0;
    layouts.sectionInset = UIEdgeInsetsMake(0, 0,0, 0);
    layouts.headerHeight = 64;

    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
    self.collectionView.alwaysBounceVertical = YES;
    [self.collectionView setCollectionViewLayout:layouts];
    [self.collectionView registerNib:[UINib nibWithNibName:@"MainHeadCell" bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader withReuseIdentifier:headCellID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"MainViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:cellID];

    myDataSource = [[NSMutableArray alloc]initWithCapacity:0];
    [self loadDataSource];
    
    if (kHeight > 480) {
        
        UIView *vv = [[UIView alloc]initWithFrame:CGRectMake(0, kHeight-64, kWidth, 64)];
        [self.view addSubview:vv];
        
        UILabel *tLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, kWidth, 21)];
        tLabel.font = [UIFont systemFontOfSize:16];
        tLabel.textAlignment = NSTextAlignmentCenter;
        tLabel.text = @"商务合作";
        [vv addSubview:tLabel];
        
        UILabel *eLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 35, kWidth, 21)];
        eLabel.textColor = [UIColor darkGrayColor];
        eLabel.font = [UIFont fontWithName:@"Iowan Old Style Roman 14.0" size:14];
        eLabel.textAlignment = NSTextAlignmentCenter;
        eLabel.text = @"ehuangli@ehuangli.com";
        [vv addSubview:eLabel];
    }

    [self loadSideView];
    
    ADBannerView *adView = [[ADBannerView alloc]initWithAdType:ADAdTypeBanner];
    adView.frame = CGRectMake(0, kHeight - 50, kWidth, 50);
    adView.delegate = self;
    [self.view addSubview:adView];
    adView.hidden = YES;
}

- (void)loadSideView{
    
    UITapGestureRecognizer *tap= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handeTap:)];
    [tap setNumberOfTapsRequired:1];
    [self.navigationController.view addGestureRecognizer:tap];
    
    svc = [[SideViewController alloc]init];
    svc.delegate = self;
    svc.view.frame = [UIScreen mainScreen].bounds;
    
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:svc];
    [[UIApplication sharedApplication].keyWindow insertSubview:svc.view atIndex:0];
}

- (void)loadDataSource{

    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://121.40.29.7:8080/huangli/app/calendarInfo/query.htm?date=%@",[ZHTools getCurrentTime]]]];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError || !data) {
            return ;
        }
        NSError *error;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if (!error && json && [json isKindOfClass:[NSDictionary class]] && [json[@"resultStatus"] intValue] == 1) {
            
            CalendarModel *model1 = [CalendarModel parse:json[@"suitInfo"] type:1];
            CalendarModel *model2 = [CalendarModel parse:json[@"unSuitInfo"] type:0];

            [myDataSource addObject:model1];
            [myDataSource addObject:model2];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.collectionView reloadData];
            });
        }
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return myDataSource.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(kWidth, 160);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    MainViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    cell.model = myDataSource[indexPath.item];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
        MainHeadCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader withReuseIdentifier:headCellID forIndexPath:indexPath];
        
        cell.model = [myDataSource firstObject];
        return cell;
}


- (IBAction)buttonInViewClick:(id)sender{

    UIButton *bt = (UIButton*)sender;
    
    switch (bt.tag) {
        case 101:
        {
            [self showLeftView];
//            [self.navigationController pushViewController:[UMFeedback feedbackViewController]
//                                                 animated:YES];
        }
            break;
        case 102:
        {
        
            NSData *data = UIImageJPEGRepresentation([ZHTools captureScreenWithoutNav:self.navigationController.view], 1.0f);
            
            
            //微信联系人
            [UMSocialData defaultData].extConfig.wechatSessionData.shareImage = data;
            
            //朋友圈
            [UMSocialData defaultData].extConfig.wechatTimelineData.shareImage = data;
            [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeImage;
            
            //新浪微博
            [UMSocialData defaultData].extConfig.sinaData.shareImage = data;
            
            [UMSocialSnsService presentSnsIconSheetView:self
                                                 appKey:UMAppKey
                                              shareText:nil
                                             shareImage:nil
                                        shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatTimeline,UMShareToWechatSession, nil]
                                               delegate:self];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark UM UMSocialDataDelegate
-(void)didFinishGetUMSocialDataResponse:(UMSocialResponseEntity *)response{
    
}
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response{


}


#pragma mark - 单击手势
-(void)handeTap:(UITapGestureRecognizer *)tap{
    
    if (tap.state == UIGestureRecognizerStateEnded) {
        [UIView beginAnimations:nil context:nil];
        tap.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
        tap.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/2);
        [UIView commitAnimations];
//        scalef = 0;
    }
}

#pragma mark - 修改视图位置
//恢复位置
-(void)showMainView{
    [UIView beginAnimations:nil context:nil];
    self.navigationController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    self.navigationController.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height/2);
    [UIView commitAnimations];
}

//显示左视图
-(void)showLeftView{
    [UIView beginAnimations:nil context:nil];
    self.navigationController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.8,0.8);
    self.navigationController.view.center = CGPointMake(340,[UIScreen mainScreen].bounds.size.height/2);
    [UIView commitAnimations];
    
}

- (void)pushTo:(UIViewController *)vc{
    
    [self showMainView];
    [self.navigationController pushViewController:vc animated:YES];
}










// 广告读取过程中出现错误

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError * )error{
    
    // 切换ADBannerView表示状态，显示→隐藏
    
    banner.hidden = YES;
    ZHLOG(@"%@",error);
}



// 成功读取广告

- (void)bannerViewDidLoadAd:(ADBannerView *)banner{
    
    // 切换ADBannerView表示状态，隐藏→显示
    ZHLOG(@"");
    banner.hidden = NO;
//    banner.frame = CGRectMake(0, kHeight - ZHHEIGHT(banner), kWidth, ZHHEIGHT(banner));
}



// 用户点击广告是响应，返回值BOOL指定广告是否打开

// 参数willLeaveApplication是指是否用其他的程序打开该广告

// 一般在该函数内让当前View停止，以及准备全画面表示广告

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave {
    
    NSLog(@"bannerViewActionShouldBegin:willLeaveApplication: is called.");
    return YES;
}



// 全画面的广告表示完了后，调用该接口

// 该接口被调用之后，当前程序一般会作为后台程序运行

// 该接口中需要回复之前被中断的处理（如果有的话）

- (void)bannerViewActionDidFinish:(ADBannerView *)banner {
    
    NSLog(@"bannerViewActionDidFinish: is called.");
    
}


@end
