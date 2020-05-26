//
//  TransactionDetailsViewController.m
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/5/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_TransactionDetailsViewController.h"

@interface TanLiao_TransactionDetailsViewController ()

@end

@implementation TanLiao_TransactionDetailsViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLale.text = @"交易明细";
    self.titleLale.alpha = 0.9;
    
    TanLiaoCustomImageView * headerImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(12*BILI, self.navView.frame.origin.y+self.navView.frame.size.height+10*BILI, 60*BILI, 60*BILI)];
    headerImageView.imgType = IMAGEVIEW_TYPE_CENTER;
    headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    if ([self.info objectForKey:@"avatarUrl"]) {
        
        headerImageView.urlPath = [self.info objectForKey:@"avatarUrl"];
    }
    else
    {
        headerImageView.urlPath = [TanLiao_Common getCurrentAvatarpath];
    }
    
    [self.view addSubview:headerImageView];




    
    UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x+headerImageView.frame.size.width+7*BILI, self.navView.frame.origin.y+self.navView.frame.size.height+22*BILI, 200, 15*BILI)];
    nameLable.textColor = [UIColor blackColor];



   

    nameLable.alpha = 0.9;
    if ([self.info objectForKey:@"nick"]) {
        
        nameLable.text = [self.info objectForKey:@"nick"];
    }
    else
    {
        nameLable.text = [TanLiao_Common getCurrentUserName];



 

    }
    
    nameLable.font = [UIFont systemFontOfSize:15*BILI];
    [self.view addSubview:nameLable];




    
    UILabel * idLbale = [[UILabel alloc] initWithFrame:CGRectMake(nameLable.frame.origin.x, nameLable.frame.origin.y+nameLable.frame.size.height+9*BILI, 200, 12*BILI)];
    idLbale.textColor = [UIColor blackColor];




    idLbale.alpha = 0.5;
    idLbale.font = [UIFont systemFontOfSize:12*BILI];
    if ( [self.info objectForKey:@"toUserId"]) {
         idLbale.text = [self.info objectForKey:@"toUserId"];
    }
    else
    {
         idLbale.text = [TanLiao_Common getNowUserID];
    }
   
    [self.view addSubview:idLbale];


    UILabel * moneyLable = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_WIDTH-100-12*BILI, self.navView.frame.origin.y+self.navView.frame.size.height+30*BILI, 100, 18*BILI)];
    moneyLable.textColor = UIColorFromRGB(0x291A33);
    moneyLable.textAlignment = NSTextAlignmentRight;
    NSString * money = [self.info objectForKey:@"gold__number"];
    if(money.intValue%JinBiBiLi==0)
    {
        moneyLable.text = [NSString stringWithFormat:@"%.0f金币",money.floatValue/JinBiBiLi];

    }
    else
    {
     moneyLable.text = [NSString stringWithFormat:@"%.2f金币",money.floatValue/JinBiBiLi];
    }
    moneyLable.font = [UIFont systemFontOfSize:18*BILI];
    [self.view addSubview:moneyLable];


 

 

    
    UIView * lineview = [[UIView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height+80*BILI, VIEW_WIDTH, 0.5)];
    lineview.backgroundColor = [UIColor blackColor];


   

    lineview.alpha = 0.2;
    [self.view addSubview:lineview];



    
    UILabel * jiaoYiLeiXing = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI, lineview.frame.origin.y+16*BILI, 65*BILI, 15*BILI)];
    jiaoYiLeiXing.textColor = [UIColor blackColor];


 

   

    jiaoYiLeiXing.alpha = 0.5;
    jiaoYiLeiXing.text = @"交易类型";
    jiaoYiLeiXing.font = [UIFont systemFontOfSize:15*BILI];
    [self.view addSubview:jiaoYiLeiXing];
    
    UILabel * jiaoYiLeiXingContent = [[UILabel alloc] initWithFrame:CGRectMake(jiaoYiLeiXing.frame.origin.x+jiaoYiLeiXing.frame.size.width+10*BILI, jiaoYiLeiXing.frame.origin.y, 200, 15*BILI)];
    jiaoYiLeiXingContent.font = [UIFont systemFontOfSize:15*BILI];
    jiaoYiLeiXingContent.textColor = [UIColor blackColor];




    [self.view addSubview:jiaoYiLeiXingContent];


    
    if ([@"0" isEqualToString:[self.info objectForKey:@"trans_type"]]) {
        //充值
        jiaoYiLeiXingContent.text = @"VIP充值";
    }
    else if ([@"1" isEqualToString:[self.info objectForKey:@"trans_type"]]) {
        //充值
        jiaoYiLeiXingContent.text = @"金币充值";
    }
    else if([@"2" isEqualToString:[self.info objectForKey:@"trans_type"]])
    {
        //获得礼物
        jiaoYiLeiXingContent.text = @"收获礼物";
        
    }
    else if([@"3" isEqualToString:[self.info objectForKey:@"trans_type"]]||[@"9" isEqualToString:[self.info objectForKey:@"trans_type"]])
    {
        //送出礼物
        jiaoYiLeiXingContent.text = @"送出礼物";
    }
    else if([@"4" isEqualToString:[self.info objectForKey:@"trans_type"]])
    {
        //提现
        jiaoYiLeiXingContent.text = @"提现";
    }
    else if([@"5" isEqualToString:[self.info objectForKey:@"trans_type"]]||[@"8" isEqualToString:[self.info objectForKey:@"trans_type"]])
    {
        //视频聊天
        
        jiaoYiLeiXingContent.text = @"视频";
        
    }
    else if([@"6" isEqualToString:[self.info objectForKey:@"trans_type"]])
    {
        //视频聊天
        
        jiaoYiLeiXingContent.text = @"私聊";
        
    }
    else if([@"7" isEqualToString:[self.info objectForKey:@"trans_type"]])
    {
        //视频聊天
        
        jiaoYiLeiXingContent.text = @"分享奖励";
        
    } else if([@"10" isEqualToString:[self.info objectForKey:@"trans_type"]])
    {
        //聊天
        jiaoYiLeiXingContent.text = @"推广提现";
        
    }
    else if([@"11" isEqualToString:[self.info objectForKey:@"trans_type"]])
    {
        //聊天
        jiaoYiLeiXingContent.text = @"私密语音";
        
    }
    else if([@"12" isEqualToString:[self.info objectForKey:@"trans_type"]])
    {
        //聊天
        jiaoYiLeiXingContent.text = @"私密视频";
        
    }
    else if([@"13" isEqualToString:[self.info objectForKey:@"trans_type"]])
    {
        //聊天
        jiaoYiLeiXingContent.text = @"私密照片";
        
    }
    else if([@"14" isEqualToString:[self.info objectForKey:@"trans_type"]])
    {
        //聊天
        jiaoYiLeiXingContent.text = @"任务奖励";
        
    }
    else if([@"15" isEqualToString:[self.info objectForKey:@"trans_type"]])
    {
        //聊天
        jiaoYiLeiXingContent.text = @"语音聊天";
        
    }
    else if([@"16" isEqualToString:[self.info objectForKey:@"trans_type"]])
    {
        //聊天
        jiaoYiLeiXingContent.text = @"会员奖励";
        
    }
    else if([@"17" isEqualToString:[self.info objectForKey:@"trans_type"]])
    {
        //聊天
        jiaoYiLeiXingContent.text = @"新人视频";
        
    }
    else if([@"18" isEqualToString:[self.info objectForKey:@"trans_type"]])
    {
        //用户挑逗支出
        jiaoYiLeiXingContent.text = @"挑逗互动";
        
    }
    else if([@"19" isEqualToString:[self.info objectForKey:@"trans_type"]])
    {
        //主播挑逗收入
        jiaoYiLeiXingContent.text = @"挑逗互动";
        
    }
    else if([@"21" isEqualToString:[self.info objectForKey:@"trans_type"]])
    {
        //主播挑逗收入
        jiaoYiLeiXingContent.text = @"首充奖励";
        
    }else if([@"22" isEqualToString:[self.info objectForKey:@"trans_type"]])
    {
        //手机号绑定
        jiaoYiLeiXingContent.text = @"手机号绑定";
        
    }


    
    UILabel * jiaoYiStatus = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI, jiaoYiLeiXing.frame.origin.y+jiaoYiLeiXing.frame.size.height+16*BILI, 65*BILI, 15*BILI)];
    jiaoYiStatus.textColor = [UIColor blackColor];


 


    jiaoYiStatus.alpha = 0.5;
    jiaoYiStatus.text = @"交易状态";
    jiaoYiStatus.font = [UIFont systemFontOfSize:15*BILI];
    [self.view addSubview:jiaoYiStatus];


 


    
    UILabel * jiaoYiStatusContent = [[UILabel alloc] initWithFrame:CGRectMake(jiaoYiLeiXing.frame.origin.x+jiaoYiLeiXing.frame.size.width+10*BILI, jiaoYiStatus.frame.origin.y, 200, 15*BILI)];
    jiaoYiStatusContent.font = [UIFont systemFontOfSize:15*BILI];
    jiaoYiStatusContent.textColor = [UIColor blackColor];


 

    [self.view addSubview:jiaoYiStatusContent];



    
    jiaoYiStatusContent.text = @"正常";
    
    
    UILabel * jiaoYiNumber = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI, jiaoYiStatus.frame.origin.y+jiaoYiStatus.frame.size.height+16*BILI, 65*BILI, 15*BILI)];
    jiaoYiNumber.textColor = [UIColor blackColor];
    jiaoYiNumber.alpha = 0.5;
    jiaoYiNumber.text = @"订单编号";
    jiaoYiNumber.font = [UIFont systemFontOfSize:15*BILI];
    [self.view addSubview:jiaoYiNumber];


   

    
    UILabel * jiaoYiNumberContent = [[UILabel alloc] initWithFrame:CGRectMake(jiaoYiLeiXing.frame.origin.x+jiaoYiLeiXing.frame.size.width+10*BILI, jiaoYiNumber.frame.origin.y, 200, 15*BILI)];
    jiaoYiNumberContent.font = [UIFont systemFontOfSize:15*BILI];
    jiaoYiNumberContent.textColor = [UIColor blackColor];
    [self.view addSubview:jiaoYiNumberContent];


 

    jiaoYiNumberContent.text = [self.info objectForKey:@"bill_id"];
    
    
    UILabel * jiaoYiTime = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI, jiaoYiNumber.frame.origin.y+jiaoYiNumber.frame.size.height+16*BILI, 65*BILI, 15*BILI)];
    jiaoYiTime.textColor = [UIColor blackColor];
    jiaoYiTime.alpha = 0.5;
    jiaoYiTime.text = @"创建时间";
    jiaoYiTime.font = [UIFont systemFontOfSize:15*BILI];
    [self.view addSubview:jiaoYiTime];


    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        UIScrollView * IqdtgpCtywyu = [[UIScrollView alloc]initWithFrame:CGRectMake(34,85,50,27)];
        IqdtgpCtywyu.layer.cornerRadius =7;
        [self.view addSubview:IqdtgpCtywyu];
    }

    
    UILabel * jiaoYiTimeContent = [[UILabel alloc] initWithFrame:CGRectMake(jiaoYiLeiXing.frame.origin.x+jiaoYiLeiXing.frame.size.width+10*BILI, jiaoYiTime.frame.origin.y, 200, 15*BILI)];
    jiaoYiTimeContent.font = [UIFont systemFontOfSize:15*BILI];
    jiaoYiTimeContent.textColor = [UIColor blackColor];



    [self.view addSubview:jiaoYiTimeContent];




    
    NSString* string = [self.info objectForKey:@"updateAt"];
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];


 

 

    [inputFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate* inputDate = [inputFormatter dateFromString:string];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];


 


    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *str = [outputFormatter stringFromDate:inputDate];


 


    jiaoYiTimeContent.text = str;
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0,jiaoYiTime.frame.origin.y+jiaoYiTime.frame.size.height+15*BILI, VIEW_WIDTH, VIEW_HEIGHT)];
    view.backgroundColor = [UIColor blackColor];


 


    view.alpha = 0.05;
    [self.view addSubview:view];



    

}
-(void)initDataMglfzz
{
    UIButton * yiWenButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 35*BILI, VIEW_WIDTH, 18*BILI)];
    [yiWenButton setTitle:@"对此订单有疑问" forState:UIControlStateNormal];
    yiWenButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    yiWenButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
    [yiWenButton setTitleColor:UIColorFromRGB(0xFF6666) forState:UIControlStateNormal];
    [self.view addSubview:yiWenButton];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
