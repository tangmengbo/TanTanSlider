//
//  AnchorFunctionListViewController.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2019/3/1.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "TanLiao_AnchorFunctionListViewController.h"

@interface TanLiao_AnchorFunctionListViewController ()

@end

@implementation TanLiao_AnchorFunctionListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.titleLale.text = @"视频探聊";
    [self setTabBarHidden];
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navView.frame.size.height+self.navView.frame.origin.y, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.size.height+self.navView.frame.origin.y))];
    [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, VIEW_HEIGHT+20)];
    self.mainScrollView.backgroundColor = UIColorFromRGB(0xEFEFEF);
    [self.view addSubview:self.mainScrollView];

    UIImageView * topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 140*BILI)];
    topImageView.image = [UIImage imageNamed:@"shipin_pic_bg"];
    [self.mainScrollView addSubview:topImageView];
    
    UIImageView * headerBottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-98*BILI)/2, 10*BILI, 96*BILI, 96*BILI)];
    headerBottomImageView.image = [UIImage imageNamed:@"shipin_pic_touxiangkuang"];
    [self.mainScrollView addSubview:headerBottomImageView];
    
    
    TanLiaoCustomImageView * userHeaderImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-67*BILI)/2, 30*BILI, 67*BILI, 67*BILI)];
    userHeaderImageView.urlPath = [TanLiao_Common getCurrentAvatarpath];
    userHeaderImageView.contentMode = UIViewContentModeScaleAspectFill;
    userHeaderImageView.autoresizingMask = UIViewAutoresizingNone;
    userHeaderImageView.clipsToBounds = YES;
    userHeaderImageView.imgType = IMAGEVIEW_TYPE_CENTER;
    [self.mainScrollView addSubview:userHeaderImageView];
    
    UILabel * nickLable = [[UILabel alloc] initWithFrame:CGRectMake(0, headerBottomImageView.frame.origin.y+headerBottomImageView.frame.size.height+10*BILI, VIEW_WIDTH, 14*BILI)];
    nickLable.font = [UIFont systemFontOfSize:14*BILI];
    nickLable.textColor = [UIColor whiteColor];
    nickLable.textAlignment = NSTextAlignmentCenter;
    nickLable.text = [TanLiao_Common getCurrentUserName];
    [self.mainScrollView addSubview:nickLable];
    
    UIButton * acountButton = [[UIButton alloc] initWithFrame:CGRectMake(0, topImageView.frame.size.height+topImageView.frame.origin.y, VIEW_WIDTH, 60*BILI)];
    acountButton.backgroundColor = [UIColor whiteColor];
    [self.mainScrollView addSubview:acountButton];
    
    ////////主播我的秀场
    UIButton * woDeXiuChangButton = [[UIButton alloc] initWithFrame:CGRectMake(0, acountButton.frame.origin.y, VIEW_WIDTH, 60*BILI)];
    woDeXiuChangButton.backgroundColor = [UIColor whiteColor];
    [woDeXiuChangButton addTarget:self action:@selector(woDeXiuChangButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:woDeXiuChangButton];
    
    UIImageView *xiuChangImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15*BILI, (60*BILI-20*BILI)/2, 20*BILI, 20*BILI)];
    xiuChangImageView.image = [UIImage imageNamed:@"shipin_icon"];
    [woDeXiuChangButton addSubview:xiuChangImageView];
    
    UILabel * xiuChangLable = [[UILabel alloc] initWithFrame:CGRectMake(52*BILI, (60*BILI-15*BILI)/2, 15*BILI*4.5, 15*BILI)];
    xiuChangLable.font = [UIFont systemFontOfSize:15*BILI];
    xiuChangLable.textColor = UIColorFromRGB(0x333333);
    xiuChangLable.text = @"我的秀场";
    [woDeXiuChangButton addSubview:xiuChangLable];
    
    UIImageView * xiuChangLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(12+18)*BILI, (60*BILI-18*BILI)/2, 18*BILI, 18*BILI)];
    xiuChangLeftImageView.image = [UIImage imageNamed:@"btn_back_nr_n"];
    [woDeXiuChangButton addSubview:xiuChangLeftImageView];
    
    //        ////我的守护
    
    UIButton * woDeShouHuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, woDeXiuChangButton.frame.origin.y+woDeXiuChangButton.frame.size.height+1, VIEW_WIDTH, 60*BILI)];
    woDeShouHuButton.backgroundColor = [UIColor whiteColor];
    [woDeShouHuButton addTarget:self action:@selector(woDeSgouHuButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:woDeShouHuButton];
    
    UIImageView *shouHuImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15*BILI, (60*BILI-20*BILI)/2, 20*BILI, 20*BILI)];
    shouHuImageView.image = [UIImage imageNamed:@"owner_icon_sh"];
    [woDeShouHuButton addSubview:shouHuImageView];
    
    UILabel * shouHuLable = [[UILabel alloc] initWithFrame:CGRectMake(52*BILI, (60*BILI-15*BILI)/2, 15*BILI*4.5, 15*BILI)];
    shouHuLable.font = [UIFont systemFontOfSize:15*BILI];
    shouHuLable.textColor =UIColorFromRGB(0x333333);
    shouHuLable.text = @"我的守护";
    [woDeShouHuButton addSubview:shouHuLable];
    
    UIImageView * shouHuLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(12+18)*BILI, (60*BILI-18*BILI)/2, 18*BILI, 18*BILI)];
    shouHuLeftImageView.image = [UIImage imageNamed:@"btn_back_nr_n"];
    [woDeShouHuButton addSubview:shouHuLeftImageView];
    
    //        //////////每日任务
    UIButton * meiRiTaskButton = [[UIButton alloc] initWithFrame:CGRectMake(0, woDeShouHuButton.frame.origin.y+woDeShouHuButton.frame.size.height+1, VIEW_WIDTH, 60*BILI)];
    meiRiTaskButton.backgroundColor = [UIColor whiteColor];
    [meiRiTaskButton addTarget:self action:@selector(meiRiTaskButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:meiRiTaskButton];
    
    UIImageView *meiRiTaskImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15*BILI, (60*BILI-20*BILI)/2, 20*BILI, 20*BILI)];
    meiRiTaskImageView.image = [UIImage imageNamed:@"icon_mrrw"];
    [meiRiTaskButton addSubview:meiRiTaskImageView];
    
    UILabel * meiRitaskLable = [[UILabel alloc] initWithFrame:CGRectMake(52*BILI, (60*BILI-15*BILI)/2, 15*BILI*4.5, 15*BILI)];
    meiRitaskLable.font = [UIFont systemFontOfSize:15*BILI];
    meiRitaskLable.textColor = UIColorFromRGB(0x333333);
    meiRitaskLable.text = @"我的任务";
    [meiRiTaskButton addSubview:meiRitaskLable];
    
    UIImageView * meiRiTaskLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(12+18)*BILI, (60*BILI-18*BILI)/2, 18*BILI, 18*BILI)];
    meiRiTaskLeftImageView.image = [UIImage imageNamed:@"btn_back_nr_n"];
    [meiRiTaskButton addSubview:meiRiTaskLeftImageView];
    
   
    //        ////互动问题
    //
    UIButton * huDongWenTiButton = [[UIButton alloc] initWithFrame:CGRectMake(0, meiRiTaskButton.frame.origin.y+meiRiTaskButton.frame.size.height+1, VIEW_WIDTH, 60*BILI)];
    huDongWenTiButton.backgroundColor = [UIColor whiteColor];
    [huDongWenTiButton addTarget:self action:@selector(huDongWenTiButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:huDongWenTiButton];
    
    UIImageView *huDongImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15*BILI, (60*BILI-20*BILI)/2, 20*BILI, 20*BILI)];
    huDongImageView.image = [UIImage imageNamed:@"owner_icon_hd"];
    [huDongWenTiButton addSubview:huDongImageView];
    
    UILabel * huDongLable = [[UILabel alloc] initWithFrame:CGRectMake(52*BILI, (60*BILI-15*BILI)/2, 15*BILI*4.5, 15*BILI)];
    huDongLable.font = [UIFont systemFontOfSize:15*BILI];
    huDongLable.textColor = [UIColor blackColor];
    huDongLable.alpha = 0.9;
    huDongLable.text = @"我的互动";
    [huDongWenTiButton addSubview:huDongLable];
    
    UIImageView * huDongLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(12+18)*BILI, (60*BILI-18*BILI)/2, 18*BILI, 18*BILI)];
    huDongLeftImageView.image = [UIImage imageNamed:@"btn_back_nr_n"];
    [huDongWenTiButton addSubview:huDongLeftImageView];
    
    //
    //        ////////主播我的礼物
    UIButton * woDeLiWuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, huDongWenTiButton.frame.origin.y+huDongWenTiButton.frame.size.height+1, VIEW_WIDTH, 60*BILI)];
    woDeLiWuButton.backgroundColor = [UIColor whiteColor];
    [woDeLiWuButton addTarget:self action:@selector(woDeGiftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:woDeLiWuButton];
    
    UIImageView * liWuImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15*BILI, (60*BILI-20*BILI)/2, 20*BILI, 20*BILI)];
    liWuImageView.image = [UIImage imageNamed:@"icon_wodegift"];
    [woDeLiWuButton addSubview:liWuImageView];
    
    UILabel * liWuLable = [[UILabel alloc] initWithFrame:CGRectMake(52*BILI, (60*BILI-15*BILI)/2, 15*BILI*4.5, 15*BILI)];
    liWuLable.font = [UIFont systemFontOfSize:15*BILI];
    liWuLable.textColor = UIColorFromRGB(0x333333);
    liWuLable.alpha = 0.9;
    liWuLable.text = @"我的礼物";
    [woDeLiWuButton addSubview:liWuLable];
    
    UIImageView * liWuLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(12+18)*BILI, (60*BILI-18*BILI)/2, 18*BILI, 18*BILI)];
    liWuLeftImageView.image = [UIImage imageNamed:@"btn_back_nr_n"];
    [woDeLiWuButton addSubview:liWuLeftImageView];
    
    self.mainScrollView.contentSize = CGSizeMake(VIEW_WIDTH, woDeLiWuButton.frame.origin.y+woDeLiWuButton.frame.size.height);
}
-(void)woDeSgouHuButtonClick
{
    TanLiaoLiao_AnchorShouHuListViewController * vc = [[TanLiaoLiao_AnchorShouHuListViewController alloc] init];
    vc.userId = [TanLiao_Common getNowUserID];
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)huDongWenTiButtonClick
{
    TanLiao_HuDongQuestionSetViewController * vc = [[TanLiao_HuDongQuestionSetViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)meiRiTaskButtonClick
{
    TanLiaoLiao_TaskSystemViewController  * blackListVC = [[TanLiaoLiao_TaskSystemViewController alloc] init];
    [self.navigationController pushViewController:blackListVC animated:YES];
    
}
-(void)woDeGiftButtonClick
{
    TanLiao_MyGiftViewController * myGiftVC = [[TanLiao_MyGiftViewController alloc] init];
    myGiftVC.giftArray = [self.userInformation objectForKey:@"items"];
    [self.navigationController pushViewController:myGiftVC animated:YES];
}
-(void)woDeXiuChangButtonClick
{
    TanLiao_UploadImagesAndVideoViewController * vc = [[TanLiao_UploadImagesAndVideoViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
