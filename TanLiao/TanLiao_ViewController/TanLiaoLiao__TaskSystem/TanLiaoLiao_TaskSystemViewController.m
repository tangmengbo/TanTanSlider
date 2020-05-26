//
//  TaskSystemViewController.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2017/12/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiaoLiao_TaskSystemViewController.h"
#import "TanLiao_UploadImagesAndVideoViewController.h"

@interface TanLiaoLiao_TaskSystemViewController ()

@end

@implementation TanLiaoLiao_TaskSystemViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLale.text = @"每日任务";
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];


    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height))];
    [self.view addSubview:self.mainScrollView];


    
    [self.cloudClient getGiftList:@"8019"
                         delegate:self
                         selector:@selector(getGiftListSuccess:)
                    errorSelector:@selector(getGiftListError:)];
   
   
    [self meiRiTaskDetails];

}




-(void)getGiftListSuccess:(NSArray *)info
{
    NSLog(@"%@",[info objectAtIndex:0]);
    self.giftArray = [NSArray arrayWithArray:info];
}


-(void)getGiftListError:(NSDictionary *)info
{
    
}
-(void)meiRiTaskDetails
{
    [self.cloudClient meiRiTask:@"8901"
                       delegate:self
                       selector:@selector(getTaskDetailSuccess:)
                  errorSelector:@selector(getTaskDetailError:)];
}


-(void)getTaskDetailSuccess:(NSDictionary *)info
{
    
    self.messageInfo = info;
    [self initJiChuTaskView];



    [self searchSuoYaoStatus];



}


-(void)searchSuoYaoStatus
{
    [self.cloudClient searchSuoYaoStatus:@"8110"
                                delegate:self
                                selector:@selector(getStatusSuccess:)
                           errorSelector:@selector(getTaskDetailError:)];
}
//查看索要状态


-(void)getStatusSuccess:(NSDictionary *)info
{
    self.suoYaoInfo =info;
    [self initQunFaTaskView];


}


-(void)getTaskDetailError:(NSDictionary *)info
{
    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];

}


-(void)initJiChuTaskView
{
    
    [self.renWuBottomView removeAllSubviews];



    
    self.renWuBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 0)];
    self.renWuBottomView.backgroundColor = [UIColor whiteColor];


    [self.mainScrollView addSubview:self.renWuBottomView];

    
    UIImageView * topBannerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 130*BILI)];
    topBannerImageView.image = [UIImage imageNamed:@"taskSystem_banner"];
    [self.renWuBottomView addSubview:topBannerImageView];
    
    NSString *  todayLength = [self.messageInfo objectForKey:@"todayLength"];
    NSString *  totalLength = [self.messageInfo objectForKey:@"totalLength"];
    NSString *  videoAward = [self.messageInfo objectForKey:@"videoAward"];
    NSString * updateAward =   [self.messageInfo objectForKey:@"updateAward"];
    NSString * todayGift = [self.messageInfo objectForKey:@"todayGift"];
    NSString * totalGift = [self.messageInfo objectForKey:@"totalGift"];
    NSString * giftAward = [self.messageInfo objectForKey:@"giftAward"];
    NSString * unreceivedAwards = [self.messageInfo objectForKey:@"unreceivedAwards"];
    NSNumber * refreshTimeNumger = [self.messageInfo objectForKey:@"refreshTime"];
    
    
    NSNumber * isVerifiedNumber =  [self.messageInfo objectForKey:@"isVerified"];
    
    
    int todayAward = 0;
    if (todayLength.intValue>=totalLength.intValue)
    {
        todayAward = todayAward+videoAward.intValue/100;
    }
    if (1==isVerifiedNumber.intValue)
    {
        todayAward = todayAward+updateAward.intValue/100;
    }
    if (todayGift.intValue>=totalGift.intValue)
    {
        todayAward = todayAward+giftAward.intValue/100;
    }
    
    UILabel * taskTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI, 130*BILI, VIEW_WIDTH, 39*BILI)];
    taskTitleLable.font = [UIFont systemFontOfSize:15*BILI];
    taskTitleLable.text = @"任务收益";
    taskTitleLable.alpha = 0.9;
    taskTitleLable.textColor = UIColorFromRGB(0x333333);
    [self.renWuBottomView addSubview:taskTitleLable];
    UIView * jiangLiJinBiBottomView = [[UIView alloc] initWithFrame:CGRectMake(12*BILI, taskTitleLable.frame.origin.y+taskTitleLable.frame.size.height, VIEW_WIDTH-24*BILI, 60*BILI)];
    jiangLiJinBiBottomView.alpha = 0.05;
    jiangLiJinBiBottomView.backgroundColor = UIColorFromRGB(0x000000);
    jiangLiJinBiBottomView.layer.cornerRadius = 4*BILI;
    jiangLiJinBiBottomView.layer.masksToBounds = YES;
    [self.renWuBottomView addSubview:jiangLiJinBiBottomView];

    
    UIView * jiangLiJinBiView = [[UIView alloc] initWithFrame:jiangLiJinBiBottomView.frame];

    [self.renWuBottomView addSubview:jiangLiJinBiView];


    
    UIImageView * jinBiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10*BILI, 11*BILI, 36*BILI, 36*BILI)];
    jinBiImageView.image = [UIImage imageNamed:@"task_icon_qianbao"];
    [jiangLiJinBiView addSubview:jinBiImageView];


    
    UILabel * jinRiJiangLiLable = [[UILabel alloc] initWithFrame:CGRectMake(jinBiImageView.frame.origin.x+jinBiImageView.frame.size.width+10*BILI, jinBiImageView.frame.origin.y, 80*BILI, 12*BILI)];
    jinRiJiangLiLable.font = [UIFont systemFontOfSize:12*BILI];
    jinRiJiangLiLable.text = @"今日奖励";
    jinRiJiangLiLable.textColor = [UIColor blackColor];
    jinRiJiangLiLable.alpha = 0.5;
    [jiangLiJinBiView addSubview:jinRiJiangLiLable];

    self.jinRiJiangLiLable = [[UILabel alloc] initWithFrame:CGRectMake(jinRiJiangLiLable.frame.origin.x, jinRiJiangLiLable.frame.origin.y+jinRiJiangLiLable.frame.size.height+15*BILI/2, jinRiJiangLiLable.frame.size.width, 18*BILI)];
    self.jinRiJiangLiLable.textColor = UIColorFromRGB(0xF6A623);
    self.jinRiJiangLiLable.font = [UIFont systemFontOfSize:12*BILI];
    self.jinRiJiangLiLable.adjustsFontSizeToFitWidth = YES;
    [jiangLiJinBiView addSubview:self.jinRiJiangLiLable];


    
    NSString * jinRiJiangLiStr = [NSString stringWithFormat:@"%d金币",todayAward];//@"8000金币";
    NSAttributedString * str1 = [[NSAttributedString alloc] initWithString:jinRiJiangLiStr];


    NSMutableAttributedString * text1 = [[NSMutableAttributedString alloc] initWithAttributedString:str1];
     [text1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial" size:18.0*BILI] range:NSMakeRange(0, jinRiJiangLiStr.length-2)]; //设置字体字号和字体类别

    self.jinRiJiangLiLable.attributedText = text1;

    
    UILabel * weiLingQuJiangLiLable = [[UILabel alloc] initWithFrame:CGRectMake(jinBiImageView.frame.origin.x+jinBiImageView.frame.size.width+103*BILI, jinBiImageView.frame.origin.y, 90*BILI, 12*BILI)];
    weiLingQuJiangLiLable.font = [UIFont systemFontOfSize:12*BILI];
    weiLingQuJiangLiLable.text = @"未领取奖励";
    weiLingQuJiangLiLable.textColor = [UIColor blackColor];

    weiLingQuJiangLiLable.alpha = 0.5;
    [jiangLiJinBiView addSubview:weiLingQuJiangLiLable];


    
    self.weiLingQuJiangLiLable = [[UILabel alloc] initWithFrame:CGRectMake(weiLingQuJiangLiLable.frame.origin.x, weiLingQuJiangLiLable.frame.origin.y+weiLingQuJiangLiLable.frame.size.height+15*BILI/2, weiLingQuJiangLiLable.frame.size.width, 18*BILI)];
    self.weiLingQuJiangLiLable.textColor = UIColorFromRGB(0xF6A623);
    self.weiLingQuJiangLiLable.font = [UIFont systemFontOfSize:12*BILI];
    self.weiLingQuJiangLiLable.adjustsFontSizeToFitWidth = YES;
    [jiangLiJinBiView addSubview:self.weiLingQuJiangLiLable];


    
   
    NSString * weiLingQuJiangLiStr = [NSString stringWithFormat:@"%d金币", unreceivedAwards.intValue/100] ;
    str1 = [[NSAttributedString alloc] initWithString:weiLingQuJiangLiStr];


    text1 = [[NSMutableAttributedString alloc] initWithAttributedString:str1];
    [text1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial" size:18.0*BILI] range:NSMakeRange(0, weiLingQuJiangLiStr.length-2)]; //设置字体字号和字体类别
    self.weiLingQuJiangLiLable.attributedText = text1;

    
    UIButton * lingQuShouYiButton = [[UIButton alloc] initWithFrame:CGRectMake(550*BILI/2, 15*BILI, 132*BILI/2, 30*BILI)];
    lingQuShouYiButton.layer.cornerRadius = 15*BILI;
    lingQuShouYiButton.backgroundColor = UIColorFromRGB(0xF85BA3);
    [lingQuShouYiButton setTitle:@"领取收益" forState:UIControlStateNormal];
    [lingQuShouYiButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    lingQuShouYiButton.titleLabel.font = [UIFont systemFontOfSize:12*BILI];
    [lingQuShouYiButton addTarget:self action:@selector(ligQuShouYi) forControlEvents:UIControlEventTouchUpInside];


    [jiangLiJinBiView addSubview:lingQuShouYiButton];
    
    
    UILabel * jiChuRenWuTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI, jiangLiJinBiView.frame.origin.y+jiangLiJinBiView.frame.size.height, VIEW_WIDTH, 39*BILI)];
    jiChuRenWuTitleLable.font = [UIFont systemFontOfSize:15*BILI];
    jiChuRenWuTitleLable.text = @"基础任务";
    jiChuRenWuTitleLable.alpha = 0.9;
    jiChuRenWuTitleLable.textColor = UIColorFromRGB(0x333333);
    [self.renWuBottomView addSubview:jiChuRenWuTitleLable];


    
    UILabel * jiChuRenWuTipLable = [[UILabel alloc] initWithFrame:CGRectMake(168*BILI/2, jiangLiJinBiView.frame.origin.y+jiangLiJinBiView.frame.size.height+29*BILI/2, VIEW_WIDTH, 12*BILI)];
    jiChuRenWuTipLable.alpha = 0.5;
    jiChuRenWuTipLable.textColor = [UIColor blackColor];



    jiChuRenWuTipLable.text = [NSString stringWithFormat:@"( 每日任务刷新时间为%d:00 )",refreshTimeNumger.intValue];


    jiChuRenWuTipLable.font = [UIFont systemFontOfSize:12*BILI];
    [self.renWuBottomView addSubview:jiChuRenWuTipLable];

    
    /* 视频时长任务*/
    UIView * videoLengthBottomView = [[UIView alloc] initWithFrame:CGRectMake(12*BILI, jiChuRenWuTitleLable.frame.origin.y+jiChuRenWuTitleLable.frame.size.height, VIEW_WIDTH-24*BILI, 60*BILI)];
    videoLengthBottomView.alpha = 0.05;
    videoLengthBottomView.backgroundColor = UIColorFromRGB(0x000000);
    videoLengthBottomView.layer.cornerRadius = 4*BILI;
    videoLengthBottomView.layer.masksToBounds = YES;
    [self.renWuBottomView addSubview:videoLengthBottomView];

    
    UIView * videoLengthView = [[UIView alloc] initWithFrame:videoLengthBottomView.frame];

    [self.renWuBottomView addSubview:videoLengthView];

    
    UIImageView * videoLengthImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10*BILI, 12*BILI, 36*BILI, 36*BILI)];
    videoLengthImageView.image = [UIImage imageNamed:@"pic_rw_time"];
    [videoLengthView addSubview:videoLengthImageView];

    
    
   
    
    NSString * videoLengthMessageStr = [NSString stringWithFormat:@"%@分钟／需完成%@分钟",todayLength,totalLength];
    CGSize videoLengthMessageSize = [TanLiao_Common setSize:videoLengthMessageStr withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_WIDTH) withFontSize:12*BILI];
    
    UILabel * videoLengthMessageLable = [[UILabel alloc] initWithFrame:CGRectMake(videoLengthImageView.frame.origin.x+videoLengthImageView.frame.size.width+10*BILI, 8*BILI, videoLengthMessageSize.width, 12*BILI)];
    videoLengthMessageLable.font = [UIFont systemFontOfSize:12*BILI];
    videoLengthMessageLable.text = videoLengthMessageStr;
    videoLengthMessageLable.textColor = [UIColor blackColor];//UIColorFromRGB(0xF6A623);
    videoLengthMessageLable.alpha = 0.5;
    [videoLengthView addSubview:videoLengthMessageLable];

    UILabel * videoLengthMessageLable1 = [[UILabel alloc] initWithFrame:CGRectMake(videoLengthMessageLable.frame.origin.x+videoLengthMessageLable.frame.size.width, 8*BILI, videoLengthMessageSize.width, 12*BILI)];
    videoLengthMessageLable1.font = [UIFont systemFontOfSize:12*BILI];
    videoLengthMessageLable1.text = [NSString stringWithFormat:@"(奖励￥%d)",videoAward.intValue/100] ;
    videoLengthMessageLable1.textColor = UIColorFromRGB(0xF6A623);
    [videoLengthView addSubview:videoLengthMessageLable1];
    
    
    UIView * videoLengthJinDu = [[UIView alloc] initWithFrame:CGRectMake(videoLengthMessageLable.frame.origin.x, videoLengthMessageLable.frame.origin.y+videoLengthMessageLable.frame.size.height+5*BILI, 221*BILI, 10*BILI)];
    videoLengthJinDu.layer.masksToBounds = YES;
    videoLengthJinDu.layer.cornerRadius = 5*BILI;
    videoLengthJinDu.backgroundColor = [UIColor blackColor];// UIColorFromRGB(0x4990E2);



    videoLengthJinDu.alpha = 0.05;
    [videoLengthView addSubview:videoLengthJinDu];
    
    float videoFinishJinDuLength;
    if (todayLength.intValue>=totalLength.intValue) {
        
        videoFinishJinDuLength = 221*BILI;
    }
    else
    {
        videoFinishJinDuLength = 221*BILI*todayLength.intValue/totalLength.intValue;
    }
    
    UIView * finishedVideoLengthJinDu = [[UIView alloc] initWithFrame:CGRectMake(videoLengthMessageLable.frame.origin.x, videoLengthMessageLable.frame.origin.y+videoLengthMessageLable.frame.size.height+5*BILI, videoFinishJinDuLength, 10*BILI)];
    finishedVideoLengthJinDu.layer.masksToBounds = YES;
    finishedVideoLengthJinDu.layer.cornerRadius = 5*BILI;
    finishedVideoLengthJinDu.backgroundColor = UIColorFromRGB(0x4990E2);
    [videoLengthView addSubview:finishedVideoLengthJinDu];
    
    UIButton * videoLengthButton = [[UIButton alloc] initWithFrame:CGRectMake(574*BILI/2, 15*BILI, 54*BILI, 30*BILI)];
    videoLengthButton.layer.cornerRadius = 15*BILI;
    [videoLengthButton setTitle:@"去完成" forState:UIControlStateNormal];
    videoLengthButton.backgroundColor = UIColorFromRGB(0xF85BA3);
    [videoLengthButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    videoLengthButton.titleLabel.font = [UIFont systemFontOfSize:12*BILI];
    [videoLengthView addSubview:videoLengthButton];
     [videoLengthButton addTarget:self action:@selector(goToQiangBoListVC) forControlEvents:UIControlEventTouchUpInside];


    if (todayLength.intValue>=totalLength.intValue)
    {
        [videoLengthButton setTitle:@"已完成" forState:UIControlStateNormal];
        videoLengthButton.backgroundColor = UIColorFromRGB(0xdbdbdb);
        videoLengthButton.enabled = NO;
    }
    
    UILabel * videoLengthBottomLable = [[UILabel alloc] initWithFrame:CGRectMake(videoLengthImageView.frame.origin.x+videoLengthImageView.frame.size.width+10*BILI, videoLengthJinDu.frame.origin.y+videoLengthJinDu.frame.size.height+5*BILI, VIEW_WIDTH, 12*BILI)];
    videoLengthBottomLable.font = [UIFont systemFontOfSize:12*BILI];
    videoLengthBottomLable.text = @"视频时长任务";
    videoLengthBottomLable.textColor = [UIColor blackColor];//UIColorFromRGB(0xF6A623);

    videoLengthBottomLable.alpha = 0.5;
    [videoLengthView addSubview:videoLengthBottomLable];

    /*资料更新任务*/
    UIView * updateMessageBottomView = [[UIView alloc] initWithFrame:CGRectMake(12*BILI, videoLengthView.frame.origin.y+videoLengthView.frame.size.height+12*BILI, VIEW_WIDTH-24*BILI, 60*BILI)];
    updateMessageBottomView.alpha = 0.05;
    updateMessageBottomView.backgroundColor = UIColorFromRGB(0x000000);
    updateMessageBottomView.layer.cornerRadius = 4*BILI;
    updateMessageBottomView.layer.masksToBounds = YES;
    [self.renWuBottomView addSubview:updateMessageBottomView];

    
    UIView * updateMessageView = [[UIView alloc] initWithFrame:updateMessageBottomView.frame];

    [self.renWuBottomView addSubview:updateMessageView];

    
    UIImageView * updateMessageImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10*BILI, 12*BILI, 36*BILI, 36*BILI)];
    updateMessageImageView.image = [UIImage imageNamed:@"pic_rw_sx"];
    [updateMessageView addSubview:updateMessageImageView];
    
//    NSString * updateMessageStr = @"";
//    CGSize updateMessageSize = [Common setSize:updateMessageStr withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_WIDTH) withFontSize:12*BILI];
//
    UILabel * updateMessageLable = [[UILabel alloc] initWithFrame:CGRectMake(videoLengthImageView.frame.origin.x+videoLengthImageView.frame.size.width+10*BILI, 8*BILI, videoLengthMessageSize.width, 12*BILI)];
    updateMessageLable.font = [UIFont systemFontOfSize:12*BILI];
    updateMessageLable.text = @"";
    updateMessageLable.textColor = [UIColor blackColor];//UIColorFromRGB(0xF6A623);
    updateMessageLable.alpha = 0.5;
    [updateMessageView addSubview:updateMessageLable];

    
  
    UILabel * updateMessageLable1 = [[UILabel alloc] initWithFrame:CGRectMake(updateMessageImageView.frame.origin.x+updateMessageImageView.frame.size.width+10*BILI, 8*BILI, 100*BILI, 12*BILI)];
    updateMessageLable1.font = [UIFont systemFontOfSize:12*BILI];
    updateMessageLable1.text = [NSString stringWithFormat:@"（奖励￥%d）",updateAward.intValue/100];//@"（奖励￥10）";
    updateMessageLable1.textColor = UIColorFromRGB(0xF6A623);
    [updateMessageView addSubview:updateMessageLable1];
    
    
    UIView * updateMessageJinDu = [[UIView alloc] initWithFrame:CGRectMake(updateMessageLable.frame.origin.x, updateMessageLable.frame.origin.y+updateMessageLable.frame.size.height+5*BILI, 221*BILI, 10*BILI)];
    updateMessageJinDu.layer.masksToBounds = YES;
    updateMessageJinDu.layer.cornerRadius = 5*BILI;
    updateMessageJinDu.backgroundColor = UIColorFromRGB(0x4990E2);
    [updateMessageView addSubview:updateMessageJinDu];
   
    
    UIButton * updateMessageButton = [[UIButton alloc] initWithFrame:CGRectMake(574*BILI/2, 15*BILI, 54*BILI, 30*BILI)];
    updateMessageButton.layer.cornerRadius = 15*BILI;
    [updateMessageButton setTitle:@"去完成" forState:UIControlStateNormal];
    updateMessageButton.backgroundColor = UIColorFromRGB(0xF85BA3);
    [updateMessageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    updateMessageButton.titleLabel.font = [UIFont systemFontOfSize:12*BILI];
     [updateMessageButton addTarget:self action:@selector(goToWoDeXiuChangVC) forControlEvents:UIControlEventTouchUpInside];
    [updateMessageView addSubview:updateMessageButton];
    
    if (1==isVerifiedNumber.intValue)
    {
        updateMessageJinDu.backgroundColor = UIColorFromRGB(0x4990E2);
        [updateMessageButton setTitle:@"已完成" forState:UIControlStateNormal];
        updateMessageButton.backgroundColor = UIColorFromRGB(0xdbdbdb);
        updateMessageButton.enabled = NO;
    }
    else
    {
        updateMessageJinDu.backgroundColor = [UIColor blackColor];
        updateMessageJinDu.alpha = 0.05;
    }
    
    UILabel * updateMessageBottomLable = [[UILabel alloc] initWithFrame:CGRectMake(updateMessageImageView.frame.origin.x+updateMessageImageView.frame.size.width+10*BILI, updateMessageJinDu.frame.origin.y+updateMessageJinDu.frame.size.height+5*BILI, VIEW_WIDTH, 12*BILI)];
    updateMessageBottomLable.font = [UIFont systemFontOfSize:12*BILI];
    updateMessageBottomLable.text = @"资料更新任务";
    updateMessageBottomLable.textColor = [UIColor blackColor];//UIColorFromRGB(0xF6A623);
    updateMessageBottomLable.alpha = 0.5;
    [updateMessageView addSubview:updateMessageBottomLable];
/*礼物任务*/
    UIView * giftTaskBottomView = [[UIView alloc] initWithFrame:CGRectMake(12*BILI, updateMessageView.frame.origin.y+updateMessageView.frame.size.height+12*BILI, VIEW_WIDTH-24*BILI, 60*BILI)];
    giftTaskBottomView.alpha = 0.05;
    giftTaskBottomView.backgroundColor = UIColorFromRGB(0x000000);
    giftTaskBottomView.layer.cornerRadius = 4*BILI;
    giftTaskBottomView.layer.masksToBounds = YES;
    [self.renWuBottomView addSubview:giftTaskBottomView];

    
    UIView * giftTaskView = [[UIView alloc] initWithFrame:giftTaskBottomView.frame];
    [self.renWuBottomView addSubview:giftTaskView];

    UIImageView * giftTaskImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10*BILI, 12*BILI, 36*BILI, 36*BILI)];
    giftTaskImageView.image = [UIImage imageNamed:@"pic_rw_lw"];
    [giftTaskView addSubview:giftTaskImageView];

    
    NSString * giftTaskStr = [NSString stringWithFormat:@"%d金币／需完成%d金币",todayGift.intValue/100,totalGift.intValue/100];
    CGSize giftTaskSize = [TanLiao_Common setSize:giftTaskStr withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_WIDTH) withFontSize:12*BILI];
    
    UILabel * giftTaskLable = [[UILabel alloc] initWithFrame:CGRectMake(giftTaskImageView.frame.origin.x+giftTaskImageView.frame.size.width+10*BILI, 8*BILI, giftTaskSize.width, 12*BILI)];
    giftTaskLable.font = [UIFont systemFontOfSize:12*BILI];
    giftTaskLable.text = giftTaskStr;
    giftTaskLable.textColor = [UIColor blackColor];//UIColorFromRGB(0xF6A623);
    giftTaskLable.alpha = 0.5;
    [giftTaskView addSubview:giftTaskLable];

    UILabel * giftTaskLable1 = [[UILabel alloc] initWithFrame:CGRectMake(giftTaskLable.frame.origin.x+giftTaskLable.frame.size.width, 8*BILI, giftTaskSize.width, 12*BILI)];
    giftTaskLable1.font = [UIFont systemFontOfSize:12*BILI];
    giftTaskLable1.text = [NSString stringWithFormat:@"(奖励￥%d)",giftAward.intValue/100];//@"（奖励￥10）";
    giftTaskLable1.textColor = UIColorFromRGB(0xF6A623);
    [giftTaskView addSubview:giftTaskLable1];
    
    
    UIView * giftTaskJinDu = [[UIView alloc] initWithFrame:CGRectMake(giftTaskLable.frame.origin.x, giftTaskLable.frame.origin.y+giftTaskLable.frame.size.height+5*BILI, 221*BILI, 10*BILI)];
    giftTaskJinDu.layer.masksToBounds = YES;
    giftTaskJinDu.layer.cornerRadius = 5*BILI;
    giftTaskJinDu.backgroundColor = [UIColor blackColor];// UIColorFromRGB(0x4990E2);
    giftTaskJinDu.alpha = 0.05;
    [giftTaskView addSubview:giftTaskJinDu];
    
    float giftFinishJinDuLength;
    if (todayGift.intValue/totalGift.intValue>=1) {
        
        giftFinishJinDuLength = 221*BILI;
    }
    else
    {
        giftFinishJinDuLength = 221*BILI*todayGift.intValue/totalGift.intValue;
    }
    UIView * giftFisishedTaskJinDu = [[UIView alloc] initWithFrame:CGRectMake(giftTaskLable.frame.origin.x, giftTaskLable.frame.origin.y+giftTaskLable.frame.size.height+5*BILI, giftFinishJinDuLength, 10*BILI)];
    giftFisishedTaskJinDu.layer.masksToBounds = YES;
    giftFisishedTaskJinDu.layer.cornerRadius = 5*BILI;
    giftFisishedTaskJinDu.backgroundColor = UIColorFromRGB(0x4990E2);
    [giftTaskView addSubview:giftFisishedTaskJinDu];
    
    UIButton * giftTaskButton = [[UIButton alloc] initWithFrame:CGRectMake(574*BILI/2, 15*BILI, 54*BILI, 30*BILI)];
    giftTaskButton.layer.cornerRadius = 15*BILI;
    [giftTaskButton setTitle:@"去完成" forState:UIControlStateNormal];
    giftTaskButton.backgroundColor = UIColorFromRGB(0xF85BA3);
    [giftTaskButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    giftTaskButton.titleLabel.font = [UIFont systemFontOfSize:12*BILI];
    [giftTaskButton addTarget:self action:@selector(goToQiangBoListVC) forControlEvents:UIControlEventTouchUpInside];
    [giftTaskView addSubview:giftTaskButton];
    
    if (todayGift.intValue>=totalGift.intValue)
    {
        
        [giftTaskButton setTitle:@"已完成" forState:UIControlStateNormal];
        giftTaskButton.backgroundColor = UIColorFromRGB(0xdbdbdb);
        giftTaskButton.enabled = NO;
    }
    
    
    UILabel * giftTaskBottomLable = [[UILabel alloc] initWithFrame:CGRectMake(giftTaskImageView.frame.origin.x+giftTaskImageView.frame.size.width+10*BILI, giftTaskJinDu.frame.origin.y+giftTaskJinDu.frame.size.height+5*BILI, VIEW_WIDTH, 12*BILI)];
    giftTaskBottomLable.font = [UIFont systemFontOfSize:12*BILI];
    giftTaskBottomLable.text = @"所收礼物任务";
    giftTaskBottomLable.textColor = [UIColor blackColor];//UIColorFromRGB(0xF6A623);
    giftTaskBottomLable.alpha = 0.5;
    [giftTaskView addSubview:giftTaskBottomLable];


    self.renWuBottomView.frame = CGRectMake(self.renWuBottomView.frame.origin.x, self.renWuBottomView.frame.origin.y, self.renWuBottomView.frame.size.width, giftTaskView.frame.origin.y+giftTaskView.frame.size.height);
    
}


-(void)initQunFaTaskView
{
    
    [self.qunFaBottomView removeAllSubviews];


    
    self.qunFaBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.renWuBottomView.frame.origin.y+self.renWuBottomView.frame.size.height, VIEW_WIDTH, 0)];
    self.qunFaBottomView.backgroundColor = [UIColor whiteColor];
    [self.mainScrollView addSubview:self.qunFaBottomView];

    
    UILabel * qunFaTaskTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI, 0, VIEW_WIDTH, 39*BILI)];
    qunFaTaskTitleLable.font = [UIFont systemFontOfSize:15*BILI];
    qunFaTaskTitleLable.text = @"群发任务";
    qunFaTaskTitleLable.alpha = 0.9;
    qunFaTaskTitleLable.textColor = UIColorFromRGB(0x333333);
    [self.qunFaBottomView addSubview:qunFaTaskTitleLable];


    
    /*群发礼物 */
    UIView * qunFaGiftBottomView = [[UIView alloc] initWithFrame:CGRectMake(12*BILI, qunFaTaskTitleLable.frame.origin.y+qunFaTaskTitleLable.frame.size.height, VIEW_WIDTH-24*BILI, 60*BILI)];
    qunFaGiftBottomView.alpha = 0.05;
    qunFaGiftBottomView.backgroundColor = UIColorFromRGB(0x000000);
    qunFaGiftBottomView.layer.cornerRadius = 4*BILI;
    qunFaGiftBottomView.layer.masksToBounds = YES;
    [self.qunFaBottomView addSubview:qunFaGiftBottomView];


    
    UIView * qunFaGiftView = [[UIView alloc] initWithFrame:qunFaGiftBottomView.frame];
    [self.qunFaBottomView addSubview:qunFaGiftView];

    UIImageView * qunFaGiftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10*BILI, 12*BILI, 36*BILI, 36*BILI)];
    qunFaGiftImageView.image = [UIImage imageNamed:@"qunFa_liwu"];
    [qunFaGiftView addSubview:qunFaGiftImageView];

    
    
    UILabel * qunFaGiftLable = [[UILabel alloc] initWithFrame:CGRectMake(qunFaGiftImageView.frame.origin.x+qunFaGiftImageView.frame.size.width+10*BILI, 13*BILI, 200*BILI, 15*BILI)];
    qunFaGiftLable.font = [UIFont systemFontOfSize:15*BILI];
    qunFaGiftLable.text = @"拼魅力 得礼物";
    qunFaGiftLable.textColor = UIColorFromRGB(0xF85BA3);
    [qunFaGiftView addSubview:qunFaGiftLable];

    
    
    
    UIButton * qunFaGiftButton = [[UIButton alloc] initWithFrame:CGRectMake(542*BILI/2, 15*BILI, 70*BILI, 30*BILI)];
    qunFaGiftButton.layer.cornerRadius = 15*BILI;
    [qunFaGiftButton setTitle:@"索要礼物" forState:UIControlStateNormal];
    qunFaGiftButton.backgroundColor = UIColorFromRGB(0xF85BA3);
    [qunFaGiftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    qunFaGiftButton.titleLabel.font = [UIFont systemFontOfSize:12*BILI];
    [qunFaGiftButton addTarget:self action:@selector(initQunFaGiftView) forControlEvents:UIControlEventTouchUpInside];
    [qunFaGiftView addSubview:qunFaGiftButton];
    
    UILabel * qunFaGiftBottomLable = [[UILabel alloc] initWithFrame:CGRectMake(qunFaGiftImageView.frame.origin.x+qunFaGiftImageView.frame.size.width+10*BILI, qunFaGiftLable.frame.origin.y+qunFaGiftLable.frame.size.height+7*BILI, VIEW_WIDTH, 12*BILI)];
    qunFaGiftBottomLable.font = [UIFont systemFontOfSize:12*BILI];
    qunFaGiftBottomLable.text = @"颜值越高 收礼越多";
    qunFaGiftBottomLable.textColor = [UIColor blackColor];//UIColorFromRGB(0xF6A623);
    qunFaGiftBottomLable.alpha = 0.3;
    [qunFaGiftView addSubview:qunFaGiftBottomLable];


    
    NSNumber * number = [self.suoYaoInfo objectForKey:@"gift_status"];
    if (1 == number.intValue) {
        qunFaGiftLable.textColor = [UIColor blackColor];
        qunFaGiftLable.alpha = 0.3;
        qunFaGiftButton.hidden = YES;
        
        UILabel * numberTipLable = [[UILabel alloc] initWithFrame:CGRectMake(281*BILI, 10*BILI, 60*BILI, 15*BILI)];
        numberTipLable.font = [UIFont systemFontOfSize:15*BILI];
        numberTipLable.text = @"累计收到";
        numberTipLable.textColor = [UIColor blackColor];
        numberTipLable.adjustsFontSizeToFitWidth = YES;
        numberTipLable.alpha = 0.3;
        [qunFaGiftView addSubview:numberTipLable];
        qunFaGiftBottomLable.hidden = YES;
        
        
        CGSize size = [TanLiao_Common setSize:@"今日礼物" withCGSize: CGSizeMake(VIEW_WIDTH, VIEW_WIDTH) withFontSize:12*BILI];
        
        UILabel * giftLable1 = [[UILabel alloc] initWithFrame:CGRectMake(qunFaGiftImageView.frame.origin.x+qunFaGiftImageView.frame.size.width+10*BILI, qunFaGiftLable.frame.origin.y+qunFaGiftLable.frame.size.height+7*BILI, size.width, 12*BILI)];
        giftLable1.font = [UIFont systemFontOfSize:12*BILI];
        giftLable1.text = @"今日礼物";
        giftLable1.textColor = [UIColor blackColor];//UIColorFromRGB(0xF6A623);
        giftLable1.alpha = 0.3;
        [qunFaGiftView addSubview:giftLable1];
       
        UILabel * giftLable2 = [[UILabel alloc] initWithFrame:CGRectMake(giftLable1.frame.origin.x+giftLable1.frame.size.width, qunFaGiftLable.frame.origin.y+qunFaGiftLable.frame.size.height+7*BILI, 100, 12*BILI)];
        giftLable2.font = [UIFont systemFontOfSize:12*BILI];
        giftLable2.text = @"已索要";
        giftLable2.textColor = UIColorFromRGB(0xF85BA3);
        [qunFaGiftView addSubview:giftLable2];
        
        number = [self.suoYaoInfo objectForKey:@"gift_totalMoney"];
        UILabel * numberLable = [[UILabel alloc] initWithFrame:CGRectMake(526*BILI/2, numberTipLable.frame.origin.y+numberTipLable.frame.size.height+6*BILI, 156*BILI/2, 15*BILI)];
        numberLable.font = [UIFont systemFontOfSize:15*BILI];
        numberLable.text =  [NSString stringWithFormat:@"%.2f金币",number.floatValue/100];
        numberLable.textColor = UIColorFromRGB(0xF6A623);
        numberLable.adjustsFontSizeToFitWidth = YES;
        numberLable.textAlignment = NSTextAlignmentRight;
        [qunFaGiftView addSubview:numberLable];

    }
 
    
    /*群发声音*/
    UIView * qunFaVoiceBottomView = [[UIView alloc] initWithFrame:CGRectMake(12*BILI, qunFaGiftView.frame.origin.y+qunFaGiftView.frame.size.height+12*BILI, VIEW_WIDTH-24*BILI, 60*BILI)];
    qunFaVoiceBottomView.alpha = 0.05;
    qunFaVoiceBottomView.backgroundColor = UIColorFromRGB(0x000000);
    qunFaVoiceBottomView.layer.cornerRadius = 4*BILI;
    qunFaVoiceBottomView.layer.masksToBounds = YES;
    [self.qunFaBottomView addSubview:qunFaVoiceBottomView];

    
    UIView * qunFaVoiceView = [[UIView alloc] initWithFrame:qunFaVoiceBottomView.frame];



    [self.qunFaBottomView addSubview:qunFaVoiceView];


    
    UIImageView * qunFaVoiceImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10*BILI, 12*BILI, 36*BILI, 36*BILI)];
    qunFaVoiceImageView.image = [UIImage imageNamed:@"qunFa_yuyin"];
    [qunFaVoiceView addSubview:qunFaVoiceImageView];

    
    UILabel * qunFaVoiceLable = [[UILabel alloc] initWithFrame:CGRectMake(qunFaVoiceImageView.frame.origin.x+qunFaVoiceImageView.frame.size.width+10*BILI, 13*BILI, 200*BILI, 15*BILI)];
    qunFaVoiceLable.font = [UIFont systemFontOfSize:15*BILI];
    qunFaVoiceLable.text = @"你的声音 他的心";
    qunFaVoiceLable.textColor = UIColorFromRGB(0xF85BA3);
    [qunFaVoiceView addSubview:qunFaVoiceLable];

    
    
    
    UIButton * qunFaVoiceButton = [[UIButton alloc] initWithFrame:CGRectMake(542*BILI/2, 15*BILI, 70*BILI, 30*BILI)];
    qunFaVoiceButton.layer.cornerRadius = 15*BILI;
    [qunFaVoiceButton setTitle:@"私密语音" forState:UIControlStateNormal];
    qunFaVoiceButton.backgroundColor = UIColorFromRGB(0xF85BA3);
    [qunFaVoiceButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    qunFaVoiceButton.titleLabel.font = [UIFont systemFontOfSize:12*BILI];
    [qunFaVoiceButton addTarget:self action:@selector(initRecordAndUploadVoiceView) forControlEvents:UIControlEventTouchUpInside];



    [qunFaVoiceView addSubview:qunFaVoiceButton];
    
    UILabel * qunFaVoiceBottomLable = [[UILabel alloc] initWithFrame:CGRectMake(qunFaGiftImageView.frame.origin.x+qunFaGiftImageView.frame.size.width+10*BILI, qunFaGiftLable.frame.origin.y+qunFaGiftLable.frame.size.height+7*BILI, VIEW_WIDTH, 12*BILI)];
    qunFaVoiceBottomLable.font = [UIFont systemFontOfSize:12*BILI];
    qunFaVoiceBottomLable.text = @"付费解锁你的心声";
    qunFaVoiceBottomLable.textColor = [UIColor blackColor];
    qunFaVoiceBottomLable.alpha = 0.3;
    [qunFaVoiceView addSubview:qunFaVoiceBottomLable];


    
    number = [self.suoYaoInfo objectForKey:@"voice_status"];
    if (2==number.intValue) {
        qunFaVoiceLable.textColor = [UIColor blackColor];

        qunFaVoiceLable.alpha = 0.3;
        qunFaVoiceBottomLable.hidden = YES;
        
        UILabel * numberTipLable = [[UILabel alloc] initWithFrame:CGRectMake(281*BILI, 10*BILI, 60*BILI, 15*BILI)];
        numberTipLable.font = [UIFont systemFontOfSize:15*BILI];
        numberTipLable.text = @"累计收益";
        numberTipLable.textColor = [UIColor blackColor];


        numberTipLable.adjustsFontSizeToFitWidth = YES;
        numberTipLable.alpha = 0.3;
        [qunFaVoiceView addSubview:numberTipLable];

        qunFaVoiceButton.hidden = YES;
        
        
        CGSize size = [TanLiao_Common setSize:@"今日私密语音" withCGSize: CGSizeMake(VIEW_WIDTH, VIEW_WIDTH) withFontSize:12*BILI];
        
        UILabel * giftLable1 = [[UILabel alloc] initWithFrame:CGRectMake(qunFaGiftImageView.frame.origin.x+qunFaGiftImageView.frame.size.width+10*BILI, qunFaGiftLable.frame.origin.y+qunFaGiftLable.frame.size.height+7*BILI, size.width, 12*BILI)];
        giftLable1.font = [UIFont systemFontOfSize:12*BILI];
        giftLable1.text = @"今日私密语音";
        giftLable1.textColor = [UIColor blackColor];//UIColorFromRGB(0xF6A623);
        giftLable1.alpha = 0.3;
        [qunFaVoiceView addSubview:giftLable1];
        
        UILabel * giftLable2 = [[UILabel alloc] initWithFrame:CGRectMake(giftLable1.frame.origin.x+giftLable1.frame.size.width, qunFaGiftLable.frame.origin.y+qunFaGiftLable.frame.size.height+7*BILI, 100, 12*BILI)];
        giftLable2.font = [UIFont systemFontOfSize:12*BILI];
        giftLable2.text = @"已发出";
        giftLable2.textColor = UIColorFromRGB(0xF85BA3);
        [qunFaVoiceView addSubview:giftLable2];
        
        number = [self.suoYaoInfo objectForKey:@"voice_totalMoney"];
        
        UILabel * numberLable = [[UILabel alloc] initWithFrame:CGRectMake(526*BILI/2, numberTipLable.frame.origin.y+numberTipLable.frame.size.height+6*BILI, 156*BILI/2, 15*BILI)];
        numberLable.font = [UIFont systemFontOfSize:15*BILI];
        numberLable.text =  [NSString stringWithFormat:@"%.2f金币",number.floatValue/100];
        numberLable.textColor = UIColorFromRGB(0xF6A623);
        numberLable.adjustsFontSizeToFitWidth = YES;
        numberLable.textAlignment = NSTextAlignmentRight;
        [qunFaVoiceView addSubview:numberLable];

    }
    if(1==number.intValue)
    {
        [qunFaVoiceButton setBackgroundColor:UIColorFromRGB(0xD8D8D8)];
        [qunFaVoiceButton setTitle:@"审核中" forState:UIControlStateNormal];
    }
    /*群发照片*/
    UIView * qunFaPhotoBottomView = [[UIView alloc] initWithFrame:CGRectMake(12*BILI, qunFaVoiceView.frame.origin.y+qunFaVoiceView.frame.size.height+12*BILI, VIEW_WIDTH-24*BILI, 60*BILI)];
    qunFaPhotoBottomView.alpha = 0.05;
    qunFaPhotoBottomView.backgroundColor = UIColorFromRGB(0x000000);
    qunFaPhotoBottomView.layer.cornerRadius = 4*BILI;
    qunFaPhotoBottomView.layer.masksToBounds = YES;
    [self.qunFaBottomView addSubview:qunFaPhotoBottomView];


    
    UIView * qunFaPhotoView = [[UIView alloc] initWithFrame:qunFaPhotoBottomView.frame];

    [self.qunFaBottomView addSubview:qunFaPhotoView];

    
    UIImageView * qunFaPhotoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10*BILI, 12*BILI, 36*BILI, 36*BILI)];
    qunFaPhotoImageView.image = [UIImage imageNamed:@"qunFa_tupian"];
    [qunFaPhotoView addSubview:qunFaPhotoImageView];

    
    
    UILabel * qunFaPhotoLable = [[UILabel alloc] initWithFrame:CGRectMake(qunFaVoiceImageView.frame.origin.x+qunFaVoiceImageView.frame.size.width+10*BILI, 13*BILI, 200*BILI, 15*BILI)];
    qunFaPhotoLable.font = [UIFont systemFontOfSize:15*BILI];
    qunFaPhotoLable.text = @"分享私房照 捕获TA的心";
    qunFaPhotoLable.textColor = UIColorFromRGB(0xF85BA3);
    [qunFaPhotoView addSubview:qunFaPhotoLable];


    
    UIButton * qunFaPhotoButton = [[UIButton alloc] initWithFrame:CGRectMake(542*BILI/2, 15*BILI, 70*BILI, 30*BILI)];
    qunFaPhotoButton.layer.cornerRadius = 15*BILI;
    [qunFaPhotoButton setTitle:@"私密照片" forState:UIControlStateNormal];
    qunFaPhotoButton.backgroundColor = UIColorFromRGB(0xF85BA3);
    [qunFaPhotoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    qunFaPhotoButton.titleLabel.font = [UIFont systemFontOfSize:12*BILI];
    qunFaPhotoButton.tag =1;
    [qunFaPhotoButton addTarget:self action:@selector(initShangChuanVideoOrPhotoView:) forControlEvents:UIControlEventTouchUpInside];


    [qunFaPhotoView addSubview:qunFaPhotoButton];
    
    UILabel * qunFaPhotoBottomLable = [[UILabel alloc] initWithFrame:CGRectMake(qunFaPhotoImageView.frame.origin.x+qunFaPhotoImageView.frame.size.width+10*BILI, qunFaPhotoLable.frame.origin.y+qunFaPhotoLable.frame.size.height+7*BILI, VIEW_WIDTH, 12*BILI)];
    qunFaPhotoBottomLable.font = [UIFont systemFontOfSize:12*BILI];
    qunFaPhotoBottomLable.text = @"付费解锁你的私密照片";
    qunFaPhotoBottomLable.textColor = [UIColor blackColor];//UIColorFromRGB(0xF6A623);


    qunFaPhotoBottomLable.alpha = 0.3;
    [qunFaPhotoView addSubview:qunFaPhotoBottomLable];




    
    number = [self.suoYaoInfo objectForKey:@"photo_status"];
    if (2==number.intValue) {
        qunFaPhotoLable.textColor = [UIColor blackColor];
        qunFaPhotoLable.alpha = 0.3;
        qunFaPhotoBottomLable.hidden = YES;
        
        UILabel * numberTipLable = [[UILabel alloc] initWithFrame:CGRectMake(281*BILI, 10*BILI, 60*BILI, 15*BILI)];
        numberTipLable.font = [UIFont systemFontOfSize:15*BILI];
        numberTipLable.text = @"累计收益";
        numberTipLable.textColor = [UIColor blackColor];
        numberTipLable.adjustsFontSizeToFitWidth = YES;
        numberTipLable.alpha = 0.3;
        [qunFaPhotoView addSubview:numberTipLable];
        qunFaPhotoButton.hidden = YES;
        
        
        CGSize size = [TanLiao_Common setSize:@"今日私房照" withCGSize: CGSizeMake(VIEW_WIDTH, VIEW_WIDTH) withFontSize:12*BILI];
        
        UILabel * giftLable1 = [[UILabel alloc] initWithFrame:CGRectMake(qunFaGiftImageView.frame.origin.x+qunFaGiftImageView.frame.size.width+10*BILI, qunFaGiftLable.frame.origin.y+qunFaGiftLable.frame.size.height+7*BILI, size.width, 12*BILI)];
        giftLable1.font = [UIFont systemFontOfSize:12*BILI];
        giftLable1.text = @"今日私房照";
        giftLable1.textColor = [UIColor blackColor];//UIColorFromRGB(0xF6A623);
        giftLable1.alpha = 0.3;
        [qunFaPhotoView addSubview:giftLable1];
        
        UILabel * giftLable2 = [[UILabel alloc] initWithFrame:CGRectMake(giftLable1.frame.origin.x+giftLable1.frame.size.width, qunFaGiftLable.frame.origin.y+qunFaGiftLable.frame.size.height+7*BILI, 100, 12*BILI)];
        giftLable2.font = [UIFont systemFontOfSize:12*BILI];
        giftLable2.text = @"已发出";
        giftLable2.textColor = UIColorFromRGB(0xF85BA3);
        [qunFaPhotoView addSubview:giftLable2];
        
        number = [self.suoYaoInfo objectForKey:@"photo_totalMoney"];
        UILabel * numberLable = [[UILabel alloc] initWithFrame:CGRectMake(526*BILI/2, numberTipLable.frame.origin.y+numberTipLable.frame.size.height+6*BILI, 156*BILI/2, 15*BILI)];
        numberLable.font = [UIFont systemFontOfSize:15*BILI];
        numberLable.text = [NSString stringWithFormat:@"%.2f金币",number.floatValue/100];
        numberLable.textColor = UIColorFromRGB(0xF6A623);
        numberLable.adjustsFontSizeToFitWidth = YES;
        numberLable.textAlignment = NSTextAlignmentRight;
        [qunFaPhotoView addSubview:numberLable];
    }
    if(1==number.intValue)
    {
        [qunFaPhotoButton setBackgroundColor:UIColorFromRGB(0xD8D8D8)];
        [qunFaPhotoButton setTitle:@"审核中" forState:UIControlStateNormal];
    }
    /*群发视频*/
    UIView * qunFaVideoBottomView = [[UIView alloc] initWithFrame:CGRectMake(12*BILI, qunFaPhotoView.frame.origin.y+qunFaPhotoView.frame.size.height+12*BILI, VIEW_WIDTH-24*BILI, 60*BILI)];
    qunFaVideoBottomView.alpha = 0.05;
    qunFaVideoBottomView.backgroundColor = UIColorFromRGB(0x000000);
    qunFaVideoBottomView.layer.cornerRadius = 4*BILI;
    qunFaVideoBottomView.layer.masksToBounds = YES;
    [self.qunFaBottomView addSubview:qunFaVideoBottomView];
    
    UIView * qunFaVideoView = [[UIView alloc] initWithFrame:qunFaVideoBottomView.frame];
    [self.qunFaBottomView addSubview:qunFaVideoView];


    UIImageView * qunFaVideoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10*BILI, 12*BILI, 36*BILI, 36*BILI)];
    qunFaVideoImageView.image = [UIImage imageNamed:@"qunFa_shipin"];
    [qunFaVideoView addSubview:qunFaVideoImageView];


    
    UILabel * qunFaVideoLable = [[UILabel alloc] initWithFrame:CGRectMake(qunFaVoiceImageView.frame.origin.x+qunFaVoiceImageView.frame.size.width+10*BILI, 13*BILI, 200*BILI, 15*BILI)];
    qunFaVideoLable.font = [UIFont systemFontOfSize:15*BILI];
    qunFaVideoLable.text = @"分享私密视频 收益拿到不停";
    qunFaVideoLable.textColor = UIColorFromRGB(0xF85BA3);
    [qunFaVideoView addSubview:qunFaVideoLable];


    UIButton * qunFaVideoButton = [[UIButton alloc] initWithFrame:CGRectMake(542*BILI/2, 15*BILI, 70*BILI, 30*BILI)];
    qunFaVideoButton.layer.cornerRadius = 15*BILI;
    [qunFaVideoButton setTitle:@"私密视频" forState:UIControlStateNormal];
    qunFaVideoButton.backgroundColor = UIColorFromRGB(0xF85BA3);
    [qunFaVideoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    qunFaVideoButton.titleLabel.font = [UIFont systemFontOfSize:12*BILI];
    [qunFaVideoButton addTarget:self action:@selector(initShangChuanVideoOrPhotoView:) forControlEvents:UIControlEventTouchUpInside];


    qunFaVideoButton.tag =0;
    [qunFaVideoView addSubview:qunFaVideoButton];
    
    UILabel * qunFaVideoBottomLable = [[UILabel alloc] initWithFrame:CGRectMake(qunFaVideoImageView.frame.origin.x+qunFaVideoImageView.frame.size.width+10*BILI, qunFaVideoLable.frame.origin.y+qunFaVideoLable.frame.size.height+7*BILI, VIEW_WIDTH, 12*BILI)];
    qunFaVideoBottomLable.font = [UIFont systemFontOfSize:12*BILI];
    qunFaVideoBottomLable.text = @"付费解锁你的私密视频";
    qunFaVideoBottomLable.textColor = [UIColor blackColor];//UIColorFromRGB(0xF6A623);


    qunFaVideoBottomLable.alpha = 0.3;
    [qunFaVideoView addSubview:qunFaVideoBottomLable];


    
    number = [self.suoYaoInfo objectForKey:@"video_status"];
    if (2==number.intValue) {
        qunFaVideoLable.textColor = [UIColor blackColor];


        qunFaVideoLable.alpha = 0.3;
        qunFaVideoBottomLable.hidden = YES;
        
        UILabel * numberTipLable = [[UILabel alloc] initWithFrame:CGRectMake(281*BILI, 10*BILI, 60*BILI, 15*BILI)];
        numberTipLable.font = [UIFont systemFontOfSize:15*BILI];
        numberTipLable.text = @"累计收益";
        numberTipLable.textColor = [UIColor blackColor];



        numberTipLable.adjustsFontSizeToFitWidth = YES;
        numberTipLable.alpha = 0.3;
        [qunFaVideoView addSubview:numberTipLable];

        
        qunFaVideoButton.hidden = YES;
        
        
        CGSize size = [TanLiao_Common setSize:@"今日私密视频" withCGSize: CGSizeMake(VIEW_WIDTH, VIEW_WIDTH) withFontSize:12*BILI];
        
        UILabel * giftLable1 = [[UILabel alloc] initWithFrame:CGRectMake(qunFaGiftImageView.frame.origin.x+qunFaGiftImageView.frame.size.width+10*BILI, qunFaGiftLable.frame.origin.y+qunFaGiftLable.frame.size.height+7*BILI, size.width, 12*BILI)];
        giftLable1.font = [UIFont systemFontOfSize:12*BILI];
        giftLable1.text = @"今日私密视频";
        giftLable1.textColor = [UIColor blackColor];//UIColorFromRGB(0xF6A623);


        giftLable1.alpha = 0.3;
        [qunFaVideoView addSubview:giftLable1];
        
        UILabel * giftLable2 = [[UILabel alloc] initWithFrame:CGRectMake(giftLable1.frame.origin.x+giftLable1.frame.size.width, qunFaGiftLable.frame.origin.y+qunFaGiftLable.frame.size.height+7*BILI, 100, 12*BILI)];
        giftLable2.font = [UIFont systemFontOfSize:12*BILI];
        giftLable2.text = @"已发出";
        giftLable2.textColor = UIColorFromRGB(0xF85BA3);
        [qunFaVideoView addSubview:giftLable2];
        
        number = [self.suoYaoInfo objectForKey:@"video_totalMoney"];
        
      
        UILabel * numberLable = [[UILabel alloc] initWithFrame:CGRectMake(526*BILI/2, numberTipLable.frame.origin.y+numberTipLable.frame.size.height+6*BILI, 156*BILI/2, 15*BILI)];
        numberLable.font = [UIFont systemFontOfSize:15*BILI];
        numberLable.text = [NSString stringWithFormat:@"%.2f金币",number.floatValue/100];
        numberLable.textColor = UIColorFromRGB(0xF6A623);
        numberLable.adjustsFontSizeToFitWidth = YES;
        numberLable.textAlignment = NSTextAlignmentRight;
        [qunFaVideoView addSubview:numberLable];

        
    }
    if(1==number.intValue)
    {
        [qunFaVideoButton setBackgroundColor:UIColorFromRGB(0xD8D8D8)];
        [qunFaVideoButton setTitle:@"审核中" forState:UIControlStateNormal];
    }
    self.qunFaBottomView.frame = CGRectMake(self.qunFaBottomView.frame.origin.x, self.qunFaBottomView.frame.origin.y, self.qunFaBottomView.frame.size.width, qunFaVideoView.frame.origin.y+qunFaVideoView.frame.size.height+12*BILI);
    [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, self.qunFaBottomView.frame.origin.y+self.qunFaBottomView.frame.size.height)];
    
}


-(void)goToQiangBoListVC
{
    TanLiao_QiangBoViewController * qiangBoVC = [[TanLiao_QiangBoViewController alloc] init];

    [self.navigationController pushViewController:qiangBoVC animated:YES];
}


-(void)goToWoDeXiuChangVC
{
    TanLiao_UploadImagesAndVideoViewController * shiPinXiuVC = [[TanLiao_UploadImagesAndVideoViewController alloc] init];

    [self.navigationController pushViewController:shiPinXiuVC animated:YES];
}
-(void)ligQuShouYi
{
    [self.cloudClient getMeiRiTaskAward:@"8902"
                               delegate:self
                               selector:@selector(getAwardSuccess:)
                          errorSelector:@selector(getAwardError:)];
}


-(void)getAwardSuccess:(NSDictionary *)info
{
    [TanLiao_Common showToastView:@"领取成功" view:self.view];


    [self.cloudClient meiRiTask:@"8901"
                       delegate:self
                       selector:@selector(getTaskDetailSuccess1:)
                  errorSelector:@selector(getTaskDetailError:)];
    
}


-(void)getTaskDetailSuccess1:(NSDictionary *)info
{
    self.messageInfo = info;
    [self initJiChuTaskView];



}


-(void)getAwardError:(NSDictionary *)info
{
    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];

}
#pragma mark -   SelectVideoAndPic_Methood_Begin

-(void)videoAndPicButtonClick:(id)sender
{
    UIButton * button =(UIButton *)sender;
    
    TZImagePickerController *imagePickController = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    //是否 在相册中显示拍照按钮
    imagePickController.allowTakePicture = NO;
    //是否可以选择显示原图
    imagePickController.allowPickingOriginalPhoto = NO;

    //选择视频
    if (button.tag==0) {
        //是否 在相册中可以选择照片
        imagePickController.allowPickingImage= NO;
        //是否 在相册中可以选择视频
        imagePickController.allowPickingVideo = YES;

    }
    else //选择照片
    {
        //是否 在相册中可以选择照片
        imagePickController.allowPickingImage= YES;
        //是否 在相册中可以选择视频
        imagePickController.allowPickingVideo = NO;

    }
  
    
    [self.navigationController presentViewController:imagePickController animated:YES completion:nil];


}
#pragma mark - TZImagePickerController Delegate
//处理从相册单选或多选的照片
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    
    
    [[LLImagePickerManager manager] getMediaInfoFromAsset:[assets objectAtIndex:0] completion:^(NSString *name, id pathData) {
        
        LLImagePickerModel *model = [[LLImagePickerModel alloc] init];

        model.name = name;
        model.uploadType = pathData;
        model.image = photos[0];
        self.mediaModel = model;
        
        [self.selectPhotoOrVideoButton setImage:model.image forState:UIControlStateNormal];
        self.selectOrSelectAgainTipLable.text = @"重新上传";
    }];
    
    
}

///选取视频后的回调
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset {
    [[LLImagePickerManager manager] getMediaInfoFromAsset:asset completion:^(NSString *name, id pathData) {
        LLImagePickerModel *model = [[LLImagePickerModel alloc] init];

        model.name = name;
        model.uploadType = pathData;
        model.image = coverImage;
        model.isVideo = YES;
        model.asset = asset;
        self.mediaModel = model;
        
        [self.selectPhotoOrVideoButton setImage:coverImage forState:UIControlStateNormal];
        self.selectOrSelectAgainTipLable.text = @"重新上传";
        
        UIImageView * videoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.selectPhotoOrVideoButton.frame.size.width-25*BILI)/2, (self.selectPhotoOrVideoButton.frame.size.height-25*BILI)/2, 25*BILI, 25*BILI)];
        videoImageView.image = [UIImage imageNamed:@"renWu_btn_bofang"];
        [self.selectPhotoOrVideoButton addSubview:videoImageView];


        
    }];
}
-(void)uploadVoideoAndPicButtonClick
{
    if (self.mediaModel)
    {
        if( self.mediaModel.isVideo)
        {
            [self showNewLoadingView:@"视频正在上传..." view:nil];
            [self getVideoFromPHAsset:self.mediaModel.asset];

        }
        else
        {
            
            [self showNewLoadingView:@"图片正在上传..." view:self.view];

            UIImage * image = self.mediaModel.image;
            UIImage * uploadImage = [TanLiao_Common scaleToSize:image size:CGSizeMake(400, 400*(image.size.height/image.size.width))];
            
            NSData *data = UIImagePNGRepresentation(uploadImage);
            
            NSString *encodedImageStr = [data base64EncodedStringWithOptions:0];//图片base64
            
            
            NSString *imageType = [TanLiao_Common contentTypeForImageData:data];//图片类型
            
            [self.cloudClient uploadImage:@"8024"
                        picBody_base64Str:encodedImageStr
                                picFormat:imageType
                                     type:@"2"
                                 delegate:self
                                 selector:@selector(uploadPhotoSuccess:)
                            errorSelector:@selector(uploadError:)];
            
            
        }
    }
    else
    {
        [TanLiao_Common showToastView:@"请选择上传的视频或图片" view:self.view];


    }
    
}
-(void)uploadPhotoSuccess:(NSDictionary *)info
{
    [self closeQunFaView];


    [self hideNewLoadingView];


    [TanLiao_Common showToastView:@"图片上传成功" view:self.view];


    [self searchSuoYaoStatus];




}
//获取视频文件的路径
- (void) getVideoFromPHAsset: (PHAsset * ) phAsset {
    
    if (phAsset.mediaType == PHAssetMediaTypeVideo) {
        PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];

        options.version = PHImageRequestOptionsVersionCurrent;
        options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
        
        PHImageManager *manager = [PHImageManager defaultManager];

        [manager requestAVAssetForVideo:phAsset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
//            NSLog(@"%@",asset);
//            if (asset) {
            
                AVURLAsset *urlAsset = (AVURLAsset *)asset;
                NSLog(@"%@",urlAsset.URL);
                NSURL *url = urlAsset.URL;
                
                
                [self yaSuoAndUploadVideo:url];

//            }
//            else
//            {
//                [Common showToastView:@"该视频存在未知错误,请重新选择视频上传" view:self.view];



//            }
            
        }];
    }
    
}
//压缩视频并上传
-(void)yaSuoAndUploadVideo :(NSURL *)fileURL
{
    
    NSString * yaSuoPath = [self getVideoSaveFilePathString];
    NSURL *yaSuoUrl = [[RAFileManager defaultManager] filePathUrlWithUrl:yaSuoPath];
    
    // 视频压缩
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:fileURL options:nil];
    AVAssetExportSession *exportSession= [[AVAssetExportSession alloc] initWithAsset:asset presetName:AVAssetExportPresetMediumQuality];
    
    exportSession.shouldOptimizeForNetworkUse = YES;
    exportSession.outputURL = yaSuoUrl;
    exportSession.outputFileType = AVFileTypeMPEG4;
    [exportSession exportAsynchronouslyWithCompletionHandler:^{
        int exportStatus = exportSession.status;
        switch (exportStatus)
        {
            case AVAssetExportSessionStatusFailed:
            {
                [self hideNewLoadingView];

                [TanLiao_Common showToastView:@"视频上传失败,请重试" view:self.view];
                NSError *exportError = exportSession.error;
                NSLog (@"AVAssetExportSessionStatusFailed: %@", exportError);
                break;
            }
            case AVAssetExportSessionStatusCompleted:
            {
                NSData *data = [NSData dataWithContentsOfURL:yaSuoUrl];
                
                unsigned long long size = data.length;
                NSString * videoFileSize = [NSString stringWithFormat:@"%.2f", size / pow(10, 6)];
                
                //视频大于5兆不让上传
                if (videoFileSize.intValue>5) {
                    
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        
                        [self hideNewLoadingView];

                        [TanLiao_Common showToastView:@"视频过大请重新选择" view:self.view];

                        
                    });
                    
                }
                else
                {
                    NSString *encodedVideoStr = [data base64EncodedStringWithOptions:0];//视频base64
                    
                    UIImage * shouZhenImage = self.mediaModel.image;//[Common getVideoPreViewImage:yaSuoUrl];//获取视频第一帧
                    UIImage * yaSuoShouZhenImage =   [TanLiao_Common scaleToSize:shouZhenImage size:CGSizeMake(200, 200*(shouZhenImage.size.height/shouZhenImage.size.width))];
                    NSData *data = UIImagePNGRepresentation(yaSuoShouZhenImage);
                    NSString *encodedImageStr = [data base64EncodedStringWithOptions:0];//图片base64
                    NSString *imageType = [TanLiao_Common contentTypeForImageData:data];//图片类型
                    
                    [self.cloudClient anchorImageOrtVideoUpload:@"8073"
                                            videoBody_base64Str:encodedVideoStr
                                                    videoFormat:@"MOV"
                                             videoPic_base64Str:encodedImageStr
                                                 videoPicFormat:imageType
                                                           type:@"2"
                                                       delegate:self
                                                       selector:@selector(uploadVideoSuccess:)
                                                  errorSelector:@selector(uploadError:)];
                    
                  
                }
            }
        }
    }];
    
    
}
-(void)uploadVideoSuccess:(NSDictionary *)info
{
    [self closeQunFaView];
    [self hideNewLoadingView];

    [TanLiao_Common showToastView:@"视频上传成功" view:self.view];

    [self searchSuoYaoStatus];


}
#pragma 视频名以当前日期为名
- (NSString*)getVideoSaveFilePathString
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString* nowTimeStr = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    
    return nowTimeStr;
}


#pragma mark -   SelectVideoAndPic_Methood_End
/**发送录音发送录音发送录音发送录音发送录音发送录音发送录音发送录音发送录音发送录音发送录音发送录音发送录音发送录音发送录音发送录音**/
#pragma mark -   RecordAndPlayVoice_Methood_Begin
//点击播放按钮
-(void)playVoice
{
    NSError *playerError;
    //播放
    self. player = nil;
    
    self. player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:self.playName] error:&playerError];
    
    if (self.player == nil)
    {
        NSLog(@"ERror creating player: %@", [playerError description]);
        
    }else{
        [self.player play];
    }
}
//录音前准备录音设置和存储路径
-(void)luYinQianZhunBei
{
    luYinTime = 0;
    //录音权限处理
    [self canRecord];
    //录音设置
    self. recorderSettingsDict =[[NSDictionary alloc] initWithObjectsAndKeys:
                                 [NSNumber numberWithInt:kAudioFormatMPEG4AAC],AVFormatIDKey,
                                 [NSNumber numberWithInt:1000.0],AVSampleRateKey,
                                 [NSNumber numberWithInt:2],AVNumberOfChannelsKey,
                                 [NSNumber numberWithInt:8],AVLinearPCMBitDepthKey,
                                 [NSNumber numberWithBool:NO],AVLinearPCMIsBigEndianKey,
                                 [NSNumber numberWithBool:NO],AVLinearPCMIsFloatKey,
                                 nil];
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    self.playName = [NSString stringWithFormat:@"%@/play.aac",docDir];
}
//停止录音和录音开始
-(void)recordVoiceButtonClick:(id)sender
{
    
    if ([@"开始录音" isEqualToString:self.recoradVoiceStatusLable.text])
    {
        //开始录音
        
        [self startRecordVoice];

        
    }
    else if([@"完成录音" isEqualToString:self.recoradVoiceStatusLable.text])
    {
        //停止录音
        
        [self stopRecordVoice];

    }
    else if ([@"试听录音" isEqualToString:self.recoradVoiceStatusLable.text])
    {
        [self playVoice];

    }
}



-(void)startRecordVoice
{
    if ([@"2" isEqualToString:self.maiKeFengQuanXianStatus]) {
        
        AVAudioSession *session = [AVAudioSession sharedInstance];
        NSError *sessionError;
        //AVAudioSessionCategoryPlayAndRecord用于录音和播放
        [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];

        if(session == nil)
            NSLog(@"Error creating session: %@", [sessionError description]);
        else
            [session setActive:YES error:nil];
        /*****每次录音前得重新设置 这一段设置声音从扬声器和耳机出来***/
        UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
        AudioSessionSetProperty (
                                 kAudioSessionProperty_OverrideAudioRoute,
                                 sizeof (audioRouteOverride),
                                 &audioRouteOverride
                                 );
        /*****这一段设置声音从扬声器出来***/
        self.greenPointView.hidden = NO;
        self.zhengZaiLuYinOrChongXinLuYinButton.hidden = NO;
        [self.recordVoiceButton setImage:[UIImage imageNamed:@"recordVoice_btn_zanting"] forState:UIControlStateNormal];
        self.recoradVoiceStatusLable.text = @"完成录音";
        luYinTime = 0;
        
        NSError *error = nil;
        //必须真机上测试,模拟器上可能会崩溃
        self.recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL URLWithString:self.playName] settings:self.recorderSettingsDict error:&error];
        
        if (self.recorder) {
            self.recorder.meteringEnabled = YES;
            [self.recorder prepareToRecord];
            [self.recorder record];
            
            //启动定时器
            self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(levelTimer) userInfo:nil repeats:YES];
            
        } else
        {
            int errorCode = CFSwapInt32HostToBig ([error code]);
            NSLog(@"Error: %@ [%4.4s])" , [error localizedDescription], (char*)&errorCode);
            
        }
    }
    else
    {
        [TanLiao_Common showAlert:@"麦克风权限未打开" message:@"请在设置中打开探聊的麦克风访问权限"];
    }
}
-(void)levelTimer
{
    luYinTime = luYinTime+0.1;
    if(luYinTime<10)
    {
       
        self.timeLengthLable.text = [NSString stringWithFormat:@"0%.0fs",luYinTime];
    }
    else
    {
        self.timeLengthLable.text = [NSString stringWithFormat:@"%.0fs",luYinTime];
    }
    int timeSeconds = luYinTime*10;
    NSLog(@"%d",timeSeconds);
    if (timeSeconds%4==0) {
        self.boDongImageView.image = [UIImage imageNamed:@"luYin_yinpingtiao"];
        self.greenPointView.hidden = YES;
    }
    else
    {
        self.boDongImageView.image = [UIImage imageNamed:@"luYin_yinpintiao2"];
        self.greenPointView.hidden = NO;
    }
    
    if (luYinTime==20)
    {
        [self stopRecordVoice];

    }
}


-(void)stopRecordVoice
{
    if(luYinTime<5)
    {
         [TanLiao_Common showToastView:@"录音时长不能少于5秒,请重新录制" view:self.view];

        [self stopRecordAndTimer];


         [self initRecordAndUploadVoiceView];

        
    }
    else {
        
    self.greenPointView.hidden = YES;
    self.recoradVoiceStatusLable.text = @"试听录音";
    [self.zhengZaiLuYinOrChongXinLuYinButton setTitle:@"重新录音" forState:UIControlStateNormal];
    [self.recordVoiceButton setImage:[UIImage imageNamed:@"recordVoice_kaishi"] forState:UIControlStateNormal];
    self.uploadVoiceButton.userInteractionEnabled = YES;
    [self.uploadVoiceButton setBackgroundColor:UIColorFromRGB(0xF85BA3)];
    [self stopRecordAndTimer];

    if(luYinTime==20) {
    [TanLiao_Common showToastView:@"录音最长20秒" view:self.view];


    }
  }
}


-(void)stopRecordAndTimer
{
    //录音停止
    [self.recorder stop];
    self.recorder = nil;
    //结束定时器
    [self.timer invalidate];


    self.timer = nil;
}
//判断是否允许使用麦克风7.0新增的方法requestRecordPermission
-(void)canRecord
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    int flag;
         switch (authStatus) {
                     case AVAuthorizationStatusNotDetermined:
                     //没有询问是否开启麦克风
                         flag = 1;
                         break;
                     case AVAuthorizationStatusRestricted:
                     //未授权，家长限制
                         flag = 0;
                         break;
                     case AVAuthorizationStatusDenied:
                     //玩家未授权
                         flag = 0;
                         break;
                     case AVAuthorizationStatusAuthorized:
                     //玩家授权
                         flag = 2;
                         break;
                     default:
                         break;
             }
    if (flag==2) {
        
        self.maiKeFengQuanXianStatus = @"2";
    }
    else if(flag==1)
    {
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
            if (granted) {
                self.maiKeFengQuanXianStatus = @"2";
                return  YES;
            }
            else {
                self.maiKeFengQuanXianStatus = @"0";
                return NO;
            }
        }];
    }
    else
    {
        [TanLiao_Common showAlert:@"麦克风权限未打开" message:@"请在设置中打开麦克风权限"];
    }

}
/**发送录音发送录音发送录音发送录音发送录音发送录音发送录音发送录音发送录音发送录音发送录音发送录音发送录音发送录音发送录音发送录音**/
#pragma mark -   录音并上传


-(void)initRecordAndUploadVoiceView
{
    self.player = nil;
    [self luYinQianZhunBei];
    [self.bottomMengCengView removeFromSuperview];

    [self.qunFaContentView removeFromSuperview];

    self.bottomMengCengView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    self.bottomMengCengView.backgroundColor = [UIColor blackColor];
    self.bottomMengCengView.alpha = 0.3;
    [self.view addSubview:self.bottomMengCengView];

    self.qunFaContentView = [[UIView alloc] initWithFrame:CGRectMake(0*BILI, 728*BILI/2, VIEW_WIDTH, 616*BILI/2)];
    self.qunFaContentView.backgroundColor = [UIColor whiteColor];
    self.qunFaContentView.layer.masksToBounds = YES;
    self.qunFaContentView.layer.cornerRadius = 10*BILI;
    [self.view addSubview:self.qunFaContentView];
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 20*BILI, VIEW_WIDTH, 18*BILI)];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.textColor = UIColorFromRGB(0xF85BA3);
    titleLable.font = [UIFont systemFontOfSize:18*BILI];
    titleLable.text = @"分享私密语音 捕获TA的心";
    [self.qunFaContentView addSubview:titleLable];

    
    UIButton * closeButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-45*BILI, 15*BILI, 30*BILI, 30*BILI)];
    [closeButton setImage:[UIImage imageNamed:@"renWu_btn_guanbi"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeQunFaView) forControlEvents:UIControlEventTouchUpInside];

    [self.qunFaContentView addSubview:closeButton];
    
    CGSize size = [TanLiao_Common setSize:@"付费解锁私密语音" withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_WIDTH) withFontSize:15*BILI];
    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(30*BILI, titleLable.frame.origin.y+titleLable.frame.size.height+20*BILI, size.width, 15*BILI)];
    tipLable.textColor = [UIColor blackColor];

    tipLable.font = [UIFont systemFontOfSize:15*BILI];
    tipLable.alpha = 0.5;
    tipLable.text = @"付费解锁私密语音";
    [self.qunFaContentView addSubview:tipLable];
    
    NSString * price = [self.suoYaoInfo objectForKey:@"voice_price"];
    UILabel * tipLable2 = [[UILabel alloc] initWithFrame:CGRectMake(tipLable.frame.origin.x+tipLable.frame.size.width+5*BILI, tipLable.frame.origin.y, VIEW_WIDTH, 15*BILI)];
    tipLable2.font = [UIFont systemFontOfSize:15*BILI];
    tipLable2.textColor =UIColorFromRGB(0xF6A623);
    tipLable2.text = [NSString stringWithFormat:@"(用户解锁你将获得%.2f金币奖励）",price.floatValue/100];
    [self.qunFaContentView addSubview:tipLable2];
    
    self.recordVoiceButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-80*BILI)/2, tipLable2.frame.origin.y+tipLable2.frame.size.height+20*BILI, 80*BILI, 80*BILI)];
    [self.recordVoiceButton setImage:[UIImage imageNamed:@"recordVoice_kaishi"] forState:UIControlStateNormal];
    [self.recordVoiceButton addTarget:self action:@selector(recordVoiceButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.qunFaContentView addSubview:self.recordVoiceButton];
    
    self.recoradVoiceStatusLable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.recordVoiceButton.frame.origin.y+self.recordVoiceButton.frame.size.height+10*BILI, VIEW_WIDTH, 15*BILI)];
    self.recoradVoiceStatusLable.font = [UIFont systemFontOfSize:15*BILI];
    self.recoradVoiceStatusLable.textColor = [UIColor blackColor];
    self.recoradVoiceStatusLable.textAlignment = NSTextAlignmentCenter;
    self.recoradVoiceStatusLable.alpha = 0.3;
    self.recoradVoiceStatusLable.text = @"开始录音";
    [self.qunFaContentView addSubview:self.recoradVoiceStatusLable];


    self.greenPointView = [[UIView alloc] initWithFrame:CGRectMake(224*BILI, tipLable2.frame.origin.y+tipLable2.frame.size.height+20*BILI, 7*BILI, 7*BILI)];
    self.greenPointView.layer.masksToBounds = YES;
    self.greenPointView.layer.cornerRadius = 7*BILI/2;
    self.greenPointView.backgroundColor = UIColorFromRGB(0x45DD5D);
    [self.qunFaContentView addSubview:self.greenPointView];



    self.greenPointView.hidden = YES;
    
    
    self.zhengZaiLuYinOrChongXinLuYinButton = [[UIButton alloc] initWithFrame:CGRectMake(self.recordVoiceButton.frame.origin.x+self.recordVoiceButton.frame.size.width, tipLable2.frame.origin.y+tipLable2.frame.size.height+20*BILI-11*BILI/2, 48*BILI+20*BILI,23*BILI)];
    [self.zhengZaiLuYinOrChongXinLuYinButton setTitle:@"正在录音" forState:UIControlStateNormal];
    [self.zhengZaiLuYinOrChongXinLuYinButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.zhengZaiLuYinOrChongXinLuYinButton addTarget:self action:@selector(initRecordAndUploadVoiceView) forControlEvents:UIControlEventTouchUpInside];



    self.zhengZaiLuYinOrChongXinLuYinButton.alpha = 0.3;
    self.zhengZaiLuYinOrChongXinLuYinButton.titleLabel.font = [UIFont systemFontOfSize:12*BILI];
    self.zhengZaiLuYinOrChongXinLuYinButton.hidden = YES;
    [self.qunFaContentView addSubview:self.zhengZaiLuYinOrChongXinLuYinButton];
    
    self.timeLengthLable = [[UILabel alloc] initWithFrame:CGRectMake(self.recordVoiceButton.frame.origin.x+self.recordVoiceButton.frame.size.width+10*BILI, self.zhengZaiLuYinOrChongXinLuYinButton.frame.origin.y+self.zhengZaiLuYinOrChongXinLuYinButton.frame.size.height, 30*BILI,18*BILI)];
    self.timeLengthLable.adjustsFontSizeToFitWidth = YES;
    self.timeLengthLable.font = [UIFont systemFontOfSize:18*BILI];
    self.timeLengthLable.textColor = UIColorFromRGB(0xF85BA3);
    self.timeLengthLable.text = @"";
    [self.qunFaContentView addSubview:self.timeLengthLable];

    self.boDongImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.timeLengthLable.frame.origin.x+self.timeLengthLable.frame.size.width+4*BILI, self.timeLengthLable.frame.origin.y, 14*BILI, 15*BILI)];
    [self.qunFaContentView addSubview:self.boDongImageView];


    
    UILabel * tipLable4 = [[UILabel alloc] initWithFrame:CGRectMake(33*BILI , self.recoradVoiceStatusLable.frame.origin.y+self.recoradVoiceStatusLable.frame.size.height+10*BILI, VIEW_WIDTH-66*BILI, 30*BILI)];
    tipLable4.textColor =UIColorFromRGB(0xFA5F5F);
    tipLable4.text = @"此功能会经过审核之后向用户发送，请上传个人真实语音 请勿上传广告、涉黄等违法内容，违者将第一时间予以封号处理";
    tipLable4.font = [UIFont systemFontOfSize:11*BILI];
    tipLable4.numberOfLines = 2;
    tipLable4.textAlignment = NSTextAlignmentCenter;
    tipLable4.adjustsFontSizeToFitWidth = YES;
    [self.qunFaContentView addSubview:tipLable4];
    
    self.uploadVoiceButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 516*BILI/2, VIEW_WIDTH, 45*BILI)];
    [self.uploadVoiceButton setBackgroundColor:UIColorFromRGB(0xF85BA3)];
    [self.uploadVoiceButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.uploadVoiceButton addTarget:self action:@selector(uploadVoiceButtonClick) forControlEvents:UIControlEventTouchUpInside];



    [self.uploadVoiceButton setTitle:@"发送语音" forState:UIControlStateNormal];
    self.uploadVoiceButton.userInteractionEnabled = NO;
    self.uploadVoiceButton.backgroundColor = UIColorFromRGB(0xDBDBDB);
    [self.qunFaContentView addSubview:self.uploadVoiceButton];
    
    
}
-(void)uploadVoiceButtonClick
{
    NSLog(@"%@",[NSURL URLWithString:self.playName]);
    NSData *data = [NSData dataWithContentsOfFile:self.playName];

     NSString *encodedVoiceStr = [data base64EncodedStringWithOptions:0];//声音base64
    [self showNewLoadingView:@"语音上传中..." view:self.view];

    [self.cloudClient suoYaoVoiceUpload:@"8108"
                    voiceBody_base64Str:encodedVoiceStr
                            voiceFormat:@"aac"
                              voiceType:@"0"
                               delegate:self
                               selector:@selector(uploadVoiceSuccess:)
                          errorSelector:@selector(uploadError:)];
}
-(void)uploadVoiceSuccess:(NSDictionary *)info
{
    [self closeQunFaView];


    [self hideNewLoadingView];

    [TanLiao_Common showToastView:@"语音上传成功" view:self.view];


    [self searchSuoYaoStatus];


}
#pragma mark -   上传视频或图片界面


-(void)initShangChuanVideoOrPhotoView:(id)sender
{
    self.bottomMengCengView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    self.bottomMengCengView.backgroundColor = [UIColor blackColor];

    self.bottomMengCengView.alpha = 0.3;
    [self.view addSubview:self.bottomMengCengView];

    self.qunFaContentView = [[UIView alloc] initWithFrame:CGRectMake(0*BILI, 728*BILI/2, VIEW_WIDTH, 616*BILI/2)];
    self.qunFaContentView.backgroundColor = [UIColor whiteColor];
    self.qunFaContentView.layer.masksToBounds = YES;
    self.qunFaContentView.layer.cornerRadius = 10*BILI;
    [self.view addSubview:self.qunFaContentView];
    
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 20*BILI, VIEW_WIDTH, 18*BILI)];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.textColor = UIColorFromRGB(0xF85BA3);
    titleLable.font = [UIFont systemFontOfSize:18*BILI];
    [self.qunFaContentView addSubview:titleLable];


    
    UIButton * closeButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-45*BILI, 15*BILI, 30*BILI, 30*BILI)];
    [closeButton setImage:[UIImage imageNamed:@"renWu_btn_guanbi"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeQunFaView) forControlEvents:UIControlEventTouchUpInside];
    [self.qunFaContentView addSubview:closeButton];
    
    CGSize size = [TanLiao_Common setSize:@"付费解锁视频" withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_WIDTH) withFontSize:15*BILI];
    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(30*BILI, titleLable.frame.origin.y+titleLable.frame.size.height+20*BILI, size.width, 15*BILI)];
    tipLable.textColor = [UIColor blackColor];
    tipLable.font = [UIFont systemFontOfSize:15*BILI];
    tipLable.alpha = 0.5;
    
    [self.qunFaContentView addSubview:tipLable];


    
    UILabel * tipLable2 = [[UILabel alloc] initWithFrame:CGRectMake(tipLable.frame.origin.x+tipLable.frame.size.width+5*BILI, tipLable.frame.origin.y, VIEW_WIDTH, 15*BILI)];
    tipLable2.font = [UIFont systemFontOfSize:15*BILI];
    tipLable2.textColor =UIColorFromRGB(0xF6A623);
   
    [self.qunFaContentView addSubview:tipLable2];
    
    self.selectPhotoOrVideoButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-80*BILI)/2, tipLable2.frame.origin.y+tipLable2.frame.size.height+20*BILI, 80*BILI, 80*BILI)];
    [self.selectPhotoOrVideoButton setImage:[UIImage imageNamed:@"renWu_icon_tianjia"] forState:UIControlStateNormal];
    [self.selectPhotoOrVideoButton addTarget:self action:@selector(videoAndPicButtonClick:) forControlEvents:UIControlEventTouchUpInside];


    self.selectPhotoOrVideoButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.selectPhotoOrVideoButton.imageView.autoresizingMask = UIViewAutoresizingNone;
    self.selectPhotoOrVideoButton.imageView.clipsToBounds = YES;
    self.selectPhotoOrVideoButton.layer.masksToBounds = YES;
    self.selectPhotoOrVideoButton.layer.cornerRadius = 8*BILI;
    [self.qunFaContentView addSubview:self.selectPhotoOrVideoButton];
    
    
    self.selectOrSelectAgainTipLable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.selectPhotoOrVideoButton.frame.origin.y+self.selectPhotoOrVideoButton.frame.size.height+10*BILI, VIEW_WIDTH, 15*BILI)];
    self.selectOrSelectAgainTipLable.textColor = [UIColor blackColor];
    self.selectOrSelectAgainTipLable.alpha = 0.3;
    self.selectOrSelectAgainTipLable.textAlignment = NSTextAlignmentCenter;
    self.selectOrSelectAgainTipLable.font = [UIFont systemFontOfSize:15*BILI];
    [self.qunFaContentView addSubview:self.selectOrSelectAgainTipLable];


    UILabel * tipLable4 = [[UILabel alloc] initWithFrame:CGRectMake(33*BILI , self.selectOrSelectAgainTipLable.frame.origin.y+self.selectOrSelectAgainTipLable.frame.size.height+10*BILI, VIEW_WIDTH-66*BILI, 30*BILI)];
    tipLable4.textColor =UIColorFromRGB(0xFA5F5F);
    tipLable4.text = @"此功能会经过审核之后向用户发送，请上传个人真实照片或视频 请勿上传广告、涉黄等违法内容，违者将第一时间予以封号处理";
    tipLable4.font = [UIFont systemFontOfSize:11*BILI];
    tipLable4.numberOfLines = 2;
    tipLable4.textAlignment = NSTextAlignmentCenter;
    tipLable4.adjustsFontSizeToFitWidth = YES;
    [self.qunFaContentView addSubview:tipLable4];
    
    UIButton * sendButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 516*BILI/2, VIEW_WIDTH, 45*BILI)];
    [sendButton setBackgroundColor:UIColorFromRGB(0xF85BA3)];
    [sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(uploadVoideoAndPicButtonClick) forControlEvents:UIControlEventTouchUpInside];



    [self.qunFaContentView addSubview:sendButton];
    
    UIButton * button = (UIButton *)sender;
    NSString * price;
    if (button.tag==0) {
        price = [self.suoYaoInfo objectForKey:@"video_price"];
        titleLable.text = @"分享私密视频 捕获TA的心";
        tipLable.text = @"付费解锁视频";
        tipLable2.text = [NSString stringWithFormat:@"(用户解锁你将获得%.2f金币奖励）",price.floatValue/100];
        self.selectOrSelectAgainTipLable.text = @"上传视频";
        [sendButton setTitle:@"发送私密视频" forState:UIControlStateNormal];
        self.selectPhotoOrVideoButton.tag = 0;
       
        
    }
    else
    {
        price = [self.suoYaoInfo objectForKey:@"photo_price"];
        titleLable.text = @"分享私房照 捕获TA的心";
        tipLable.text = @"付费解锁照片";
        tipLable2.text = [NSString stringWithFormat:@"(用户解锁你将获得%.2f金币奖励）",price.floatValue/100];
        self.selectOrSelectAgainTipLable.text = @"上传照片";
        [sendButton setTitle:@"发送私房照" forState:UIControlStateNormal];
        self.selectPhotoOrVideoButton.tag = 1;
    }
    
}
-(void)closeQunFaView
{
    [self stopRecordAndTimer];



    self.player = nil;
    
    [self.bottomMengCengView removeFromSuperview];



    [self.qunFaContentView removeFromSuperview];



}


-(void)initQunFaGiftView
{
    self.bottomMengCengView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    self.bottomMengCengView.backgroundColor = [UIColor blackColor];



    self.bottomMengCengView.alpha = 0.3;
    [self.view addSubview:self.bottomMengCengView];



    
    self.qunFaContentView = [[UIView alloc] initWithFrame:CGRectMake(0*BILI, 828*BILI/2, VIEW_WIDTH, 616*BILI/2)];
    self.qunFaContentView.backgroundColor = [UIColor whiteColor];



    self.qunFaContentView.layer.masksToBounds = YES;
    self.qunFaContentView.layer.cornerRadius = 10*BILI;
    [self.view addSubview:self.qunFaContentView];



    
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 20*BILI, VIEW_WIDTH, 18*BILI)];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.textColor = UIColorFromRGB(0xF85BA3);
    titleLable.font = [UIFont systemFontOfSize:18*BILI];
    titleLable.text = @"魅力展示  索要礼物";
    [self.qunFaContentView addSubview:titleLable];



    
    UIButton * closeButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-45*BILI, 15*BILI, 30*BILI, 30*BILI)];
    [closeButton setImage:[UIImage imageNamed:@"renWu_btn_guanbi"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeQunFaView) forControlEvents:UIControlEventTouchUpInside];


    [self.qunFaContentView addSubview:closeButton];
    
    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(19*BILI,titleLable.frame.origin.y+titleLable.frame
                                                                   .size.height+15*BILI, VIEW_WIDTH, 15*BILI)];
    tipLable.textColor = [UIColor blackColor];



    tipLable.font = [UIFont systemFontOfSize:15*BILI];
    tipLable.alpha = 0.3;
    tipLable.text = @"选择你想要的礼物";
    [self.qunFaContentView addSubview:tipLable];



    
    UIScrollView * giftScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, tipLable.frame.origin.y+tipLable.frame.size.height, VIEW_WIDTH, 125*BILI)];
    giftScrollView.showsVerticalScrollIndicator = NO;
    giftScrollView.showsHorizontalScrollIndicator = NO;
    [self.qunFaContentView addSubview:giftScrollView];




    [giftScrollView setContentSize:CGSizeMake(89*BILI*self.giftArray.count+19*BILI, 125*BILI)];
    
    self.nameLableArray = [NSMutableArray array];
    self.priceLableArray = [NSMutableArray array];
    
    for (int i=0; i<self.giftArray.count; i++) {
        
        NSDictionary * info = [self.giftArray objectAtIndex:i];
        
        UIView * giftBottomView = [[UIView alloc] initWithFrame:CGRectMake(19*BILI+89*BILI*i, 15*BILI, 70*BILI, 70*BILI)];
        giftBottomView.backgroundColor = [UIColor blackColor];



        giftBottomView.alpha = 0.05;
        giftBottomView.layer.masksToBounds = YES;
        giftBottomView.layer.cornerRadius = 5*BILI;
        [giftScrollView addSubview:giftBottomView];



        
        TanLiaoCustomImageView * giftImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(19*BILI+89*BILI*i, giftBottomView.frame.origin.y, 70*BILI, 70*BILI)];
        giftImageView.userInteractionEnabled = YES;
        giftImageView.tag =i;
        giftImageView.urlPath = [info objectForKey:@"goodsIconUrl"];
        [giftScrollView addSubview:giftImageView];


        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(giftSelect:)];
        [giftImageView addGestureRecognizer:tap];
        
        UILabel * giftNameLable = [[UILabel alloc] initWithFrame:CGRectMake(giftImageView.frame.origin.x, giftImageView.frame.origin.y+giftImageView.frame.size.height+10*BILI, giftImageView.frame.size.width, 15*BILI)];
        giftNameLable.font = [UIFont systemFontOfSize:15*BILI];
        giftNameLable.textColor = [UIColor blackColor];
        giftNameLable.alpha = 0.5;
        giftNameLable.text = [info objectForKey:@"goodsName"];
        giftNameLable.textAlignment = NSTextAlignmentCenter;
        giftNameLable.adjustsFontSizeToFitWidth = YES;
        [giftScrollView addSubview:giftNameLable];

        [self.nameLableArray addObject:giftNameLable];


        
        UILabel * giftPriceLable = [[UILabel alloc] initWithFrame:CGRectMake(giftImageView.frame.origin.x, giftNameLable.frame.origin.y+giftNameLable.frame.size.height+5*BILI, giftImageView.frame.size.width, 10*BILI)];
        giftPriceLable.font = [UIFont systemFontOfSize:10*BILI];
        giftPriceLable.textColor = [UIColor blackColor];

        giftPriceLable.alpha = 0.5;
        NSString * amount = [info objectForKey:@"amount"];
        if(amount.intValue%JinBiBiLi==0)
        {
            giftPriceLable.text = [NSString stringWithFormat:@"%.0f金币",amount.floatValue/JinBiBiLi];
            
        }
        else
        {
            giftPriceLable.text = [NSString stringWithFormat:@"%.2f金币",amount.floatValue/JinBiBiLi];
        }
        giftPriceLable.textAlignment = NSTextAlignmentCenter;
        giftPriceLable.adjustsFontSizeToFitWidth = YES;
        [giftScrollView addSubview:giftPriceLable];
        [self.priceLableArray addObject:giftPriceLable];

    }
    self.giftSelectImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5*BILI, 20*BILI, 20*BILI)];
    self.giftSelectImageView.image = [UIImage imageNamed:@"renWu_icon-xuanzhong"];
    self.giftSelectImageView.hidden = YES;
    [giftScrollView addSubview:self.giftSelectImageView];
    
    UIButton * suoYaoLiWuButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 416*BILI/2, VIEW_WIDTH, 45*BILI)];
    [suoYaoLiWuButton setBackgroundColor:UIColorFromRGB(0xF85BA3)];
    [suoYaoLiWuButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [suoYaoLiWuButton setTitle:@"索要礼物" forState:UIControlStateNormal];
    [suoYaoLiWuButton addTarget:self action:@selector(usuoYaoLiWuButtonClick) forControlEvents:UIControlEventTouchUpInside];


    [self.qunFaContentView addSubview:suoYaoLiWuButton];
    
}


-(void)giftSelect:(UITapGestureRecognizer *)tap
{
    TanLiaoCustomImageView * imageView = (TanLiaoCustomImageView *)tap.view;
    
    self.giftSelectImageView.frame = CGRectMake(19*BILI+89*BILI*imageView.tag+60*BILI, self.giftSelectImageView.frame.origin.y, 20*BILI, 20*BILI);
    self.giftSelectImageView.hidden = NO;
    
    self.selectGiftDic = [self.giftArray objectAtIndex:imageView.tag];
    for (int i=0; i<self.nameLableArray.count; i++) {
        
        UILabel * nameLable = [self.nameLableArray objectAtIndex:i];
        UILabel * priceLable = [self.priceLableArray objectAtIndex:i];
        if (i==imageView.tag) {
            
            nameLable.alpha = 1;
            nameLable.textColor = UIColorFromRGB(0xF85BA3);
            
            priceLable.alpha = 1;
            priceLable.textColor = UIColorFromRGB(0xF85BA3);
        }
        else
        {
            nameLable.alpha = 0.5;
            nameLable.textColor = [UIColor blackColor];
            priceLable.alpha = 0.5;
            priceLable.textColor = [UIColor blackColor];
        }
    }
}
-(void)usuoYaoLiWuButtonClick
{
    if (self.selectGiftDic)
    {
        [self showNewLoadingView:@"礼物上传中..." view:nil];
        [self.cloudClient suoYaoGiftUpload:@"8111"
                                   goodsId:[self.selectGiftDic objectForKey:@"goodsId"]
                                  delegate:self
                                  selector:@selector(uploadGiftSuccess:)
                             errorSelector:@selector(uploadError:)];
    }
    else
    {
        [TanLiao_Common showToastView:@"请选择要群发的礼物" view:self.view];
    }
}
-(void)uploadGiftSuccess:(NSDictionary *)info
{
    [self closeQunFaView];
    [self hideNewLoadingView];

    [TanLiao_Common showToastView:@"礼物索要成功" view:self.view];
    [self searchSuoYaoStatus];

}
-(void)uploadError:(NSDictionary *)info
{
    [self showLoadingView:[info objectForKey:@"message"] view:self.view];

    [self hideNewLoadingView];

}
#pragma mark -   RecordAndPlayVoice_Methood_End
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setTabBarHidden];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self stopRecordAndTimer];


    self.player = nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
