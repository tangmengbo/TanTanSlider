//
//  SJTabBarController.m
//  SajiaoShopping
//
//  Created by 鸣 王 on 15/10/10.
//  Copyright © 2015年 唐蒙波. All rights reserved.
//

#import "SJTabBarController.h"
#import "ConstDefine.h"


@interface SJTabBarController ()

@end

@implementation SJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    for(UIView *view in self.view.subviews){
        
        if([view isKindOfClass:[UITabBar class]]){
            
            view.hidden = YES;
            
            break;
            
        }
    }
   
    [self initTabBar];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(unreadMessCount:) name:UnReaderMesCount object:nil];

}
//获取到礼物通知执行动画
-(void)unreadMessCount:(NSNotification *)notification
{
    
    NSString * unReadCount = [notification object];
    dispatch_async(dispatch_get_main_queue(), ^{
        
            if (unReadCount.intValue<=0) {
                self.unReadMesLable.hidden = YES;
        
            }
            else
            {
                self.unReadMesLable.hidden = NO;
                self.unReadMesLable.text = unReadCount;
                if (unReadCount.length<2) {
                    self.unReadMesLable.frame = CGRectMake(self.unReadMesLable.frame.origin.x, self.unReadMesLable.frame.origin.y, 15*BILI, 15*BILI);
                }
                else
                {
                    self.unReadMesLable.frame = CGRectMake(self.unReadMesLable.frame.origin.x, self.unReadMesLable.frame.origin.y, 20*BILI, 15*BILI);
                }
            }

        
    });
    [UIApplication sharedApplication].applicationIconBadgeNumber = unReadCount.intValue;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)initTabBar
{
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT-(SafeAreaBottomHeight),VIEW_WIDTH ,SafeAreaBottomHeight)];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottomView];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 0.5)];
    lineView.backgroundColor = UIColorFromRGB(0xd9d9e3);
    [self.bottomView addSubview: lineView];
    
    
    self.sliderView = [[UIView alloc] initWithFrame:CGRectMake(0, 1, VIEW_WIDTH/3, 3)];
    self.sliderView.backgroundColor = UIColorFromRGB(0xfe4299);
   // [self.bottomView addSubview:self.sliderView];
    
    
    self.button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH/5, (130*USERCC))];
    self.button1.tag = 0;
    [self.button1 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.button1];
    
    
    self.homeImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake((self.button1.frame.size.width-24)/2, 8, 24, 24)];
    self.homeImageView1.image = [UIImage imageNamed:@"btn_home_n"];
    [self.button1 addSubview:self.homeImageView1];
    
    self.homeLable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 8+24+3, self.button1.frame.size.width, 9)] ;
    self.homeLable1.font = [UIFont systemFontOfSize:9];
    self.homeLable1.textAlignment = NSTextAlignmentCenter;
    self.homeLable1.text = @"视频聊天";
    self.homeLable1.textColor = UIColorFromRGB(0x999999);
    [self.button1 addSubview:self.homeLable1];
    
    
    self.homeImageView2 = [[UIImageView alloc] initWithFrame:self.homeImageView1.frame];
    self.homeImageView2.image = [UIImage imageNamed:@"btn_home_h"];
    [self.button1 addSubview:self.homeImageView2];
    
    self.homeLable2 = [[UILabel alloc] initWithFrame:self.homeLable1.frame];
    self.homeLable2.font = [UIFont systemFontOfSize:9];
    self.homeLable2.textAlignment = NSTextAlignmentCenter;
    self.homeLable2.text = @"视频聊天";
    self.homeLable2.textColor = [UIColor blackColor];
    [self.button1 addSubview:self.homeLable2];
    
    
    
    self.button2 = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH/5, 0, VIEW_WIDTH/5, (130*USERCC))];
    self.button2.tag = 1;
    [self.button2 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.button2];
    
    self.noticeImageView1 = [[UIImageView alloc] initWithFrame:self.homeImageView1.frame];
    self.noticeImageView1.image = [UIImage imageNamed:@"spx_btn_my_n"];
    [self.button2 addSubview:self.noticeImageView1];
    
    self.noticeLable1 = [[UILabel alloc] initWithFrame:self.homeLable1.frame] ;
    self.noticeLable1.font = [UIFont systemFontOfSize:9];
    self.noticeLable1.textAlignment = NSTextAlignmentCenter;
    self.noticeLable1.text = @"发现";
    self.noticeLable1.textColor = UIColorFromRGB(0x999999);
    [self.button2 addSubview:self.noticeLable1];
    
    
    self.noticeImageView2 = [[UIImageView alloc] initWithFrame:self.homeImageView1.frame];
    self.noticeImageView2.image = [UIImage imageNamed:@"spx_btn_my_h"];
    [self.button2 addSubview:self.noticeImageView2];
    
    self.noticeLable2 = [[UILabel alloc] initWithFrame:self.homeLable1.frame] ;
    self.noticeLable2.font = [UIFont systemFontOfSize:9];
    self.noticeLable2.textAlignment = NSTextAlignmentCenter;
    self.noticeLable2.text = @"发现";
    self.noticeLable2.textColor = [UIColor blackColor];
    [self.button2 addSubview:self.noticeLable2];
    
    
    
    
    self.button3 = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH/5*2, 0, VIEW_WIDTH/5, (130*USERCC))];
    self.button3.tag = 2;
    [self.button3 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.button3];
    
    
    self.centerImageView1 = [[UIImageView alloc] initWithFrame:self.homeImageView1.frame];
    self.centerImageView1.image = [UIImage imageNamed:@"btn_paihang_n"];
    [self.button3 addSubview:self.centerImageView1];
    
    self.centerImageView2 = [[UIImageView alloc] initWithFrame:self.homeImageView1.frame];
    self.centerImageView2.image = [UIImage imageNamed:@"btn_paihang_h"];
    [self.button3 addSubview:self.centerImageView2];
    
    self.centerLable1 = [[UILabel alloc] initWithFrame:self.homeLable1.frame] ;
    self.centerLable1.font =[UIFont systemFontOfSize:9];
    self.centerLable1.textAlignment = NSTextAlignmentCenter;
    self.centerLable1.text = @"排行榜";
    self.centerLable1.textColor = UIColorFromRGB(0x999999);
    [self.button3 addSubview:self.centerLable1];
    
    self.centerLable2 = [[UILabel alloc] initWithFrame:self.homeLable1.frame] ;
    self.centerLable2.font = [UIFont systemFontOfSize:9];
    self.centerLable2.textAlignment = NSTextAlignmentCenter;
    self.centerLable2.text = @"排行榜";
    self.centerLable2.textColor = [UIColor blackColor];
    [self.button3 addSubview:self.centerLable2];
    
    
    
    self.button4 = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH/5*3, 0, VIEW_WIDTH/5, (130*USERCC))];
    self.button4.tag = 3;
    [self.button4 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.button4];
    
    self.chatterImageView1 = [[UIImageView alloc] initWithFrame:self.homeImageView1.frame];
    self.chatterImageView1.image = [UIImage imageNamed:@"btn_message_n"];
    [self.button4 addSubview:self.chatterImageView1];
    
    self.chatterLable1 = [[UILabel alloc] initWithFrame:self.homeLable1.frame] ;
    self.chatterLable1.font =[UIFont systemFontOfSize:9];
    self.chatterLable1.textAlignment = NSTextAlignmentCenter;
    self.chatterLable1.text = @"消息";
    self.chatterLable1.textColor = UIColorFromRGB(0x999999);
    [self.button4 addSubview:self.chatterLable1];
    
    
    self.chatterImageView2 = [[UIImageView alloc] initWithFrame:self.homeImageView1.frame];
    self.chatterImageView2.image = [UIImage imageNamed:@"btn_message_h"];
    [self.button4 addSubview:self.chatterImageView2];
    
    self.chatterLable2 = [[UILabel alloc] initWithFrame:self.homeLable1.frame] ;
    self.chatterLable2.font = [UIFont systemFontOfSize:9];
    self.chatterLable2.textAlignment = NSTextAlignmentCenter;
    self.chatterLable2.text = @"消息";
    self.chatterLable2.textColor = [UIColor blackColor];
    [self.button4 addSubview:self.chatterLable2];
    
    self.unReadMesLable = [[UILabel alloc] initWithFrame:CGRectMake(self.button2.frame.size.width-34*BILI, 4*BILI, 20*BILI, 15*BILI)];
    self.unReadMesLable.textColor = [UIColor whiteColor];
    self.unReadMesLable.font = [UIFont systemFontOfSize:10*BILI];
    self.unReadMesLable.textAlignment = NSTextAlignmentCenter;
    self.unReadMesLable.layer.cornerRadius = 15*BILI/2;
    self.unReadMesLable.layer.masksToBounds = YES;
    self.unReadMesLable.hidden = YES;
    self.unReadMesLable.backgroundColor = [UIColor redColor];
    [self.button4 addSubview:self.unReadMesLable];


    
    self.button5 = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH/5*4, 0, VIEW_WIDTH/5, (130*USERCC))];
    self.button5.tag = 4;
    [self.button5 addTarget:self action:@selector(selectButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.button5];
    
    self.ownerImageView1 = [[UIImageView alloc] initWithFrame:self.homeImageView1.frame];
    self.ownerImageView1.image = [UIImage imageNamed:@"btn_my_n"];
    [self.button5 addSubview:self.ownerImageView1];
    
    self.ownerLable1 = [[UILabel alloc] initWithFrame:self.homeLable1.frame] ;
    self.ownerLable1.font = [UIFont systemFontOfSize:9];
    self.ownerLable1.textAlignment = NSTextAlignmentCenter;
    self.ownerLable1.text = @"我";
    self.ownerLable1.textColor = UIColorFromRGB(0x999999);
    [self.button5 addSubview:self.ownerLable1];
    
    
    self.ownerImageView2 = [[UIImageView alloc] initWithFrame:self.homeImageView1.frame];
    self.ownerImageView2.image = [UIImage imageNamed:@"btn_my_h"];
    [self.button5 addSubview:self.ownerImageView2];
    
    self.ownerLable2 = [[UILabel alloc] initWithFrame:self.homeLable1.frame] ;
    self.ownerLable2.font = [UIFont systemFontOfSize:9];
    self.ownerLable2.textAlignment = NSTextAlignmentCenter;
    self.ownerLable2.text = @"我";
    self.ownerLable2.textColor = [UIColor blackColor];
    [self.button5 addSubview:self.ownerLable2];
    
    UIView * topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 1)];
    topLineView.backgroundColor = [UIColor blackColor];
    topLineView.alpha = 0.05;
    [self.bottomView addSubview:topLineView];

    self.homeLable1.hidden = YES;
    self.homeImageView1.hidden = YES;
    self.homeLable2.hidden = NO;
    self.homeImageView2.hidden = NO;
    
    self.noticeLable1.hidden = NO;
    self.noticeImageView1.hidden = NO;
    self.noticeLable2.hidden = YES;
    self.noticeImageView2.hidden = YES;
    
    self.centerLable1.hidden = NO;
    self.centerImageView1.hidden = NO;
    self.centerLable2.hidden = YES;
    self.centerImageView2.hidden = YES;
    
    self.chatterLable1.hidden = NO;
    self.chatterImageView1.hidden = NO;
    self.chatterLable2.hidden = YES;
    self.chatterImageView2.hidden = YES;
    
    self.ownerLable1.hidden = NO;
    self.ownerImageView1.hidden = NO;
    self.ownerLable2.hidden = YES;
    self.ownerImageView2.hidden = YES;
    
    
    if( [@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
    {
        
        self.button1.frame = CGRectMake(0, 0, VIEW_WIDTH/4, (130*USERCC));
        self.button2.frame = CGRectMake(VIEW_WIDTH/4, 0, VIEW_WIDTH/4, (130*USERCC));
        self.button3.frame = CGRectMake(VIEW_WIDTH/4*2, 0, VIEW_WIDTH/4, (130*USERCC));
        self.button4.frame = CGRectMake(VIEW_WIDTH/4*3, 0, VIEW_WIDTH/4, (130*USERCC));
        self.button5.hidden = YES;
        
        self.unReadMesLable.frame = CGRectMake(self.button2.frame.size.width-40*BILI, 4*BILI, 20*BILI, 15*BILI);
        [self.button2 addSubview:self.unReadMesLable];
        
        
        self.homeImageView1.frame = CGRectMake((self.button1.frame.size.width-24)/2, 8, 24, 24);
        self.homeImageView2.frame = self.homeImageView1.frame;
        self.homeLable1.frame =CGRectMake(0, 8+24+3, self.button1.frame.size.width, 9);
        self.homeLable2.frame = self.homeLable1.frame;
        
        self.homeImageView1.image = [UIImage imageNamed:@"mjb_home_n"];
        self.homeImageView2.image = [UIImage imageNamed:@"mjb_home_h"];
        self.homeLable1.textColor = UIColorFromRGB(0xBBBBBB);
        self.homeLable1.alpha = 0.5;
        self.homeLable2.textColor = UIColorFromRGB(0xF5646B);
        self.homeLable1.text = @"首页";
        self.homeLable2.text = @"首页";
        
        
        self.noticeImageView1.frame = self.homeImageView1.frame;
        self.noticeLable1.frame = self.homeLable1.frame;;
        self.noticeImageView2.frame = self.homeImageView1.frame;
        self.noticeLable2.frame  = self.homeLable1.frame;

        self.noticeImageView1.image = [UIImage imageNamed:@"mjb_message_n"];
        self.noticeImageView2.image = [UIImage imageNamed:@"mjb_message_h"];
        self.noticeLable1.textColor = UIColorFromRGB(0xBBBBBB);
        self.noticeLable1.alpha = 0.5;
        self.noticeLable2.textColor = UIColorFromRGB(0xF5646B);
        self.noticeLable1.text = @"消息";
        self.noticeLable2.text = @"消息";
        
        
        
        
        self.centerImageView1.frame = self.homeImageView1.frame;
        self.centerLable1.frame = self.homeLable1.frame;
        self.centerImageView2.frame = self.homeImageView1.frame;
        self.centerLable2.frame = self.homeLable1.frame;

        self.centerImageView1.image = [UIImage imageNamed:@"symj_btn_remen_n"];
        self.centerImageView2.image = [UIImage imageNamed:@"symj_btn_remen_h"];
        self.centerLable1.textColor = UIColorFromRGB(0xBBBBBB);
        self.centerLable1.alpha = 0.5;
        self.centerLable2.textColor = UIColorFromRGB(0xF5646B);
        self.centerLable1.text = @"动态";
        self.centerLable2.text = @"动态";
        
        self.chatterImageView1.frame = self.homeImageView1.frame;
        self.chatterLable1.frame = self.homeLable1.frame;
        self.chatterImageView2.frame = self.homeImageView1.frame;
        self.chatterLable2.frame = self.homeLable1.frame;

        self.chatterImageView1.image = [UIImage imageNamed:@"mjb_wo_n"];
        self.chatterImageView2.image = [UIImage imageNamed:@"mjb_wo_h"];
        self.chatterLable1.textColor = UIColorFromRGB(0xBBBBBB);
        self.chatterLable1.alpha = 0.5;
        self.chatterLable2.textColor = UIColorFromRGB(0xF5646B );
        self.chatterLable1.text = @"我";
        self.chatterLable2.text = @"我";
        
        
//        self.ownerImageView1.image = [UIImage imageNamed:@"symj_btn_wode_n"];
//        self.ownerImageView2.image = [UIImage imageNamed:@"symj_btn_wode_h"];
//        self.ownerLable1.textColor = UIColorFromRGB(0xBBBBBB);
//        self.ownerLable1.alpha = 0.5;
//        self.ownerLable2.textColor = UIColorFromRGB(0xF5646B);
//        self.ownerLable1.text = @"我";
//        self.ownerLable2.text = @"我";
        
    }

   
}
-(void)selectButton:(id)sender
{
    if (![self checkAlsoLogin])
    {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"notLogin" object:nil];
        return;
    }
    
    
    if( [@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]]) {


        UIButton * button = (UIButton *)sender;
        if (button.tag ==0) {

            self.selectedIndex = 0;

            self.homeImageView1.hidden = YES;
            self.homeImageView2.hidden = NO;
            self.noticeImageView1.hidden = NO;
            self.noticeImageView2.hidden = YES;
            self.centerImageView1.hidden = NO;
            self.centerImageView2.hidden = YES;
            self.chatterImageView1.hidden = NO;
            self.chatterImageView2.hidden = YES;
            
            self.homeLable1.hidden = YES;
            self.homeLable2.hidden = NO;
            self.noticeLable1.hidden = NO;
            self.noticeLable2.hidden = YES;
            self.centerLable1.hidden = NO;
            self.centerLable2.hidden = YES;
            self.chatterLable1.hidden = NO;
            self.chatterLable2.hidden = YES;
        }
        else if (button.tag ==1)
        {
            self.selectedIndex = 1;

            self.homeImageView1.hidden = NO;
            self.homeImageView2.hidden = YES;
            self.noticeImageView1.hidden = YES;
            self.noticeImageView2.hidden = NO;
            self.centerImageView1.hidden = NO;
            self.centerImageView2.hidden = YES;
            self.chatterImageView1.hidden = NO;
            self.chatterImageView2.hidden = YES;
            
            self.homeLable1.hidden = NO;
            self.homeLable2.hidden = YES;
            self.noticeLable1.hidden = YES;
            self.noticeLable2.hidden = NO;
            self.chatterLable1.hidden = NO;
            self.centerLable2.hidden = YES;
            self.chatterLable1.hidden = NO;
            self.chatterLable2.hidden = YES;



        }
        else if (button.tag ==2)
        {
            self.selectedIndex = 2;

            self.homeImageView1.hidden = NO;
            self.homeImageView2.hidden = YES;
            self.noticeImageView1.hidden = NO;
            self.noticeImageView2.hidden = YES;
            self.centerImageView1.hidden = YES;
            self.centerImageView2.hidden = NO;
            self.chatterImageView1.hidden = NO;
            self.chatterImageView2.hidden = YES;

            self.homeLable1.hidden = NO;
            self.homeLable2.hidden = YES;
            self.noticeLable1.hidden = NO;
            self.noticeLable2.hidden = YES;
            self.centerLable1.hidden = YES;
            self.centerLable2.hidden = NO;
            self.chatterLable1.hidden = NO;
            self.chatterLable2.hidden = YES;

        }
        else if (button.tag ==3)
        {
            self.selectedIndex = 3;
            
            self.homeImageView1.hidden = NO;
            self.homeImageView2.hidden = YES;
            self.noticeImageView1.hidden = NO;
            self.noticeImageView2.hidden = YES;
            self.centerImageView1.hidden = NO;
            self.centerImageView2.hidden = YES;
            self.chatterImageView1.hidden = YES;
            self.chatterImageView2.hidden = NO;
            
            self.homeLable1.hidden = NO;
            self.homeLable2.hidden = YES;
            self.noticeLable1.hidden = NO;
            self.noticeLable2.hidden = YES;
            self.centerLable1.hidden = NO;
            self.centerLable2.hidden = YES;
            self.chatterLable1.hidden = YES;
            self.chatterLable2.hidden = NO;


        }
    }
    else
    {
    UIButton * button = (UIButton *)sender;
    if (button.tag ==0)
    {
        self.selectedIndex = 0;
        
        self.homeLable1.hidden = YES;
        self.homeImageView1.hidden = YES;
        self.homeLable2.hidden = NO;
        self.homeImageView2.hidden = NO;
        
        self.noticeLable1.hidden = NO;
        self.noticeImageView1.hidden = NO;
        self.noticeLable2.hidden = YES;
        self.noticeImageView2.hidden = YES;
        
        self.centerLable1.hidden = NO;
        self.centerImageView1.hidden = NO;
        self.centerLable2.hidden = YES;
        self.centerImageView2.hidden = YES;
        
        self.chatterLable1.hidden = NO;
        self.chatterImageView1.hidden = NO;
        self.chatterLable2.hidden = YES;
        self.chatterImageView2.hidden = YES;
        
        self.ownerLable1.hidden = NO;
        self.ownerImageView1.hidden = NO;
        self.ownerLable2.hidden = YES;
        self.ownerImageView2.hidden = YES;
       
    }
    else if (button.tag ==1)
    {
        
        self.selectedIndex = 1;
       
        self.homeLable1.hidden = NO;
        self.homeImageView1.hidden = NO;
        self.homeLable2.hidden = YES;
        self.homeImageView2.hidden = YES;
        
        self.noticeLable1.hidden = YES;
        self.noticeImageView1.hidden = YES;
        self.noticeLable2.hidden = NO;
        self.noticeImageView2.hidden = NO;
        
        self.centerLable1.hidden = NO;
        self.centerImageView1.hidden = NO;
        self.centerLable2.hidden = YES;
        self.centerImageView2.hidden = YES;
        
        self.chatterLable1.hidden = NO;
        self.chatterImageView1.hidden = NO;
        self.chatterLable2.hidden = YES;
        self.chatterImageView2.hidden = YES;
        
        self.ownerLable1.hidden = NO;
        self.ownerImageView1.hidden = NO;
        self.ownerLable2.hidden = YES;
        self.ownerImageView2.hidden = YES;
       
        
    }
    else if (button.tag ==2)
    {
        
        self.selectedIndex = 2;
        
        
        self.homeLable1.hidden = NO;
        self.homeImageView1.hidden = NO;
        self.homeLable2.hidden = YES;
        self.homeImageView2.hidden = YES;
        
        self.noticeLable1.hidden = NO;
        self.noticeImageView1.hidden = NO;
        self.noticeLable2.hidden = YES;
        self.noticeImageView2.hidden = YES;
        
        self.centerLable1.hidden = YES;
        self.centerImageView1.hidden = YES;
        self.centerLable2.hidden = NO;
        self.centerImageView2.hidden = NO;
        
        self.chatterLable1.hidden = NO;
        self.chatterImageView1.hidden = NO;
        self.chatterLable2.hidden = YES;
        self.chatterImageView2.hidden = YES;
        
        self.ownerLable1.hidden = NO;
        self.ownerImageView1.hidden = NO;
        self.ownerLable2.hidden = YES;
        self.ownerImageView2.hidden = YES;
       
    }
    else if (button.tag ==3)
    {
    self.selectedIndex = 3;
        self.homeLable1.hidden = NO;
        self.homeImageView1.hidden = NO;
        self.homeLable2.hidden = YES;
        self.homeImageView2.hidden = YES;
        
        self.noticeLable1.hidden = NO;
        self.noticeImageView1.hidden = NO;
        self.noticeLable2.hidden = YES;
        self.noticeImageView2.hidden = YES;
        
        self.centerLable1.hidden = NO;
        self.centerImageView1.hidden = NO;
        self.centerLable2.hidden = YES;
        self.centerImageView2.hidden = YES;
        
        self.chatterLable1.hidden = YES;
        self.chatterImageView1.hidden = YES;
        self.chatterLable2.hidden = NO;
        self.chatterImageView2.hidden = NO;
        
        self.ownerLable1.hidden = NO;
        self.ownerImageView1.hidden = NO;
        self.ownerLable2.hidden = YES;
        self.ownerImageView2.hidden = YES;
    }
    else if (button.tag ==4)
    {
        self.selectedIndex = 4;
        self.homeLable1.hidden = NO;
        self.homeImageView1.hidden = NO;
        self.homeLable2.hidden = YES;
        self.homeImageView2.hidden = YES;
        
        self.noticeLable1.hidden = NO;
        self.noticeImageView1.hidden = NO;
        self.noticeLable2.hidden = YES;
        self.noticeImageView2.hidden = YES;
        
        self.centerLable1.hidden = NO;
        self.centerImageView1.hidden = NO;
        self.centerLable2.hidden = YES;
        self.centerImageView2.hidden = YES;
        
        self.chatterLable1.hidden = NO;
        self.chatterImageView1.hidden = NO;
        self.chatterLable2.hidden = YES;
        self.chatterImageView2.hidden = YES;
        
        self.ownerLable1.hidden = YES;
        self.ownerImageView1.hidden = YES;
        self.ownerLable2.hidden = NO;
        self.ownerImageView2.hidden = NO;
    }
    }
}

-(void)setItemSelected:(int)index
{
    
    
    
    if( [@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]]) {

        if (index ==0) {

            self.selectedIndex = 0;
            self.homeImageView1.hidden = YES;
            self.homeImageView2.hidden = NO;
            self.noticeImageView1.hidden = NO;
            self.noticeImageView2.hidden = YES;
            self.centerImageView1.hidden = NO;
            self.centerImageView2.hidden = YES;
            self.chatterImageView1.hidden = NO;
            self.chatterImageView2.hidden = YES;
            
            self.homeLable1.hidden = NO;
            self.homeLable2.hidden = YES;
            self.noticeLable1.hidden = YES;
            self.noticeLable2.hidden = NO;
            self.centerLable1.hidden = NO;
            self.centerLable2.hidden = YES;
            self.chatterLable1.hidden = NO;
            self.chatterLable2.hidden = YES;


        }
        else if (index ==1)
        {
            self.selectedIndex = 1;
            self.homeImageView1.hidden = NO;
            self.homeImageView2.hidden = YES;
            self.noticeImageView1.hidden = YES;
            self.noticeImageView2.hidden = NO;
            self.centerImageView1.hidden = NO;
            self.centerImageView2.hidden = YES;
            self.chatterImageView1.hidden = NO;
            self.chatterImageView2.hidden = YES;
            
            self.homeLable1.hidden = YES;
            self.homeLable2.hidden = NO;
            self.noticeLable1.hidden = NO;
            self.noticeLable2.hidden = YES;
            self.centerLable1.hidden = NO;
            self.centerLable2.hidden = YES;
            self.chatterLable1.hidden = NO;
            self.chatterLable2.hidden = YES;


        }
        else if (index ==2)
        {
            self.selectedIndex = 2;
            self.homeImageView1.hidden = NO;
            self.homeImageView2.hidden = YES;
            self.noticeImageView1.hidden = NO;
            self.noticeImageView2.hidden = YES;
            self.centerImageView1.hidden = YES;
            self.centerImageView2.hidden = NO;
            self.chatterImageView1.hidden = NO;
            self.chatterImageView2.hidden = YES;
            
            self.homeLable1.hidden = NO;
            self.homeLable2.hidden = YES;
            self.noticeLable1.hidden = NO;
            self.noticeLable2.hidden = YES;
            self.centerLable1.hidden = YES;
            self.centerLable2.hidden = NO;
            self.chatterLable1.hidden = NO;
            self.chatterLable2.hidden = YES;


        }
        else if (index==3)
        {
            self.selectedIndex = 3;
            
            self.homeImageView1.hidden = NO;
            self.homeImageView2.hidden = YES;
            self.noticeImageView1.hidden = NO;
            self.noticeImageView2.hidden = YES;
            self.centerImageView1.hidden = NO;
            self.centerImageView2.hidden = YES;
            self.chatterImageView1.hidden = YES;
            self.chatterImageView2.hidden = NO;
            
            self.homeLable1.hidden = NO;
            self.homeLable2.hidden = YES;
            self.noticeLable1.hidden = NO;
            self.noticeLable2.hidden = YES;
            self.centerLable1.hidden = NO;
            self.centerLable2.hidden = YES;
            self.chatterLable1.hidden = YES;
            self.chatterLable2.hidden = NO;


        }
    }
    else
    {
        if (index ==0)
        {
            self.selectedIndex = 0;
            
            self.homeLable1.hidden = YES;
            self.homeImageView1.hidden = YES;
            self.homeLable2.hidden = NO;
            self.homeImageView2.hidden = NO;
            
            self.noticeLable1.hidden = NO;
            self.noticeImageView1.hidden = NO;
            self.noticeLable2.hidden = YES;
            self.noticeImageView2.hidden = YES;
            
            self.centerLable1.hidden = NO;
            self.centerImageView1.hidden = NO;
            self.centerLable2.hidden = YES;
            self.centerImageView2.hidden = YES;
            
            self.chatterLable1.hidden = NO;
            self.chatterImageView1.hidden = NO;
            self.chatterLable2.hidden = YES;
            self.chatterImageView2.hidden = YES;
            
            self.ownerLable1.hidden = NO;
            self.ownerImageView1.hidden = NO;
            self.ownerLable2.hidden = YES;
            self.ownerImageView2.hidden = YES;
            
            
        }
        else if (index ==1)
        {
            
            self.selectedIndex = 1;
            
            self.homeLable1.hidden = NO;
            self.homeImageView1.hidden = NO;
            self.homeLable2.hidden = YES;
            self.homeImageView2.hidden = YES;
            
            self.noticeLable1.hidden = YES;
            self.noticeImageView1.hidden = YES;
            self.noticeLable2.hidden = NO;
            self.noticeImageView2.hidden = NO;
            
            self.centerLable1.hidden = NO;
            self.centerImageView1.hidden = NO;
            self.centerLable2.hidden = YES;
            self.centerImageView2.hidden = YES;
            
            self.chatterLable1.hidden = NO;
            self.chatterImageView1.hidden = NO;
            self.chatterLable2.hidden = YES;
            self.chatterImageView2.hidden = YES;
            
            self.ownerLable1.hidden = NO;
            self.ownerImageView1.hidden = NO;
            self.ownerLable2.hidden = YES;
            self.ownerImageView2.hidden = YES;
            
            
        }
        else if (index ==2)
        {
            
            self.selectedIndex = 2;
            
            self.homeLable1.hidden = NO;
            self.homeImageView1.hidden = NO;
            self.homeLable2.hidden = YES;
            self.homeImageView2.hidden = YES;
            
            self.noticeLable1.hidden = NO;
            self.noticeImageView1.hidden = NO;
            self.noticeLable2.hidden = YES;
            self.noticeImageView2.hidden = YES;
            
            self.centerLable1.hidden = YES;
            self.centerImageView1.hidden = YES;
            self.centerLable2.hidden = NO;
            self.centerImageView2.hidden = NO;
            
            self.chatterLable1.hidden = NO;
            self.chatterImageView1.hidden = NO;
            self.chatterLable2.hidden = YES;
            self.chatterImageView2.hidden = YES;
            
            self.ownerLable1.hidden = NO;
            self.ownerImageView1.hidden = NO;
            self.ownerLable2.hidden = YES;
            self.ownerImageView2.hidden = YES;
        }
        else if (index ==3)
        {
            self.selectedIndex = 3;
            self.homeLable1.hidden = NO;
            self.homeImageView1.hidden = NO;
            self.homeLable2.hidden = YES;
            self.homeImageView2.hidden = YES;
            
            self.noticeLable1.hidden = NO;
            self.noticeImageView1.hidden = NO;
            self.noticeLable2.hidden = YES;
            self.noticeImageView2.hidden = YES;
            
            self.centerLable1.hidden = NO;
            self.centerImageView1.hidden = NO;
            self.centerLable2.hidden = YES;
            self.centerImageView2.hidden = YES;
            
            self.chatterLable1.hidden = YES;
            self.chatterImageView1.hidden = YES;
            self.chatterLable2.hidden = NO;
            self.chatterImageView2.hidden = NO;
            
            self.ownerLable1.hidden = NO;
            self.ownerImageView1.hidden = NO;
            self.ownerLable2.hidden = YES;
            self.ownerImageView2.hidden = YES;
        }
        else if (index ==4)
        {
            self.selectedIndex = 4;
            self.homeLable1.hidden = NO;
            self.homeImageView1.hidden = NO;
            self.homeLable2.hidden = YES;
            self.homeImageView2.hidden = YES;
            
            self.noticeLable1.hidden = NO;
            self.noticeImageView1.hidden = NO;
            self.noticeLable2.hidden = YES;
            self.noticeImageView2.hidden = YES;
            
            self.centerLable1.hidden = NO;
            self.centerImageView1.hidden = NO;
            self.centerLable2.hidden = YES;
            self.centerImageView2.hidden = YES;
            
            self.chatterLable1.hidden = NO;
            self.chatterImageView1.hidden = NO;
            self.chatterLable2.hidden = YES;
            self.chatterImageView2.hidden = YES;
            
            self.ownerLable1.hidden = YES;
            self.ownerImageView1.hidden = YES;
            self.ownerLable2.hidden = NO;
            self.ownerImageView2.hidden = NO;
        }

    
    }

}
-(BOOL)checkAlsoLogin
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * userInfo = [defaults objectForKey:USERINFO];
    if (userInfo) {
        return YES;
    }
    else
    {
        return NO;
    }
}
- (void)viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
