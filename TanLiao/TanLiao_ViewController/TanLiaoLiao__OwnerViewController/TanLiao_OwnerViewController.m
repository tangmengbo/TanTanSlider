//
//  OwnerViewController.m
//  FanQieSQ
//
//  Created by mac on 2017/4/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_OwnerViewController.h"
#import "TanLiao_UploadImagesAndVideoViewController.h"
#import "RCDCustomerServiceViewController.h"

@interface TanLiao_OwnerViewController ()

@end

@implementation TanLiao_OwnerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];
    
    self.navView.hidden = YES;
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    self.mainScrollView.delegate = self;
    [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, VIEW_HEIGHT+20)];
    [self.view addSubview:self.mainScrollView];
    
    
    
    self.listBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 369*BILI/2, VIEW_WIDTH, VIEW_HEIGHT)];
    self.listBottomView.backgroundColor = [UIColor blackColor];
    self.listBottomView.alpha = 0.05;
    [self.mainScrollView addSubview:self.listBottomView];
    
    
    [self initView];
    
    
}


-(void)initView
{
    
    self.smallHeaderImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(15*BILI, 25*BILI+SafeAreaTopHeight, 90*BILI, 90*BILI)];
    self.smallHeaderImageView.layer.cornerRadius = 8*BILI;
    self.smallHeaderImageView.layer.masksToBounds = YES;
    self.smallHeaderImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.smallHeaderImageView.userInteractionEnabled = YES;
    [self.mainScrollView addSubview:self.smallHeaderImageView];
    UITapGestureRecognizer * headerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(eaditMessage)];
    [self.smallHeaderImageView addGestureRecognizer:headerTap];

    
    self.nameLable = [[UILabel alloc] initWithFrame:CGRectMake(self.smallHeaderImageView.frame.origin.x+self.smallHeaderImageView.frame.size.width+15*BILI,self.smallHeaderImageView.frame.origin.y+4.5*BILI, 468*BILI/2, 20*BILI)];
    self.nameLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:18*BILI];
    self.nameLable.textColor = [UIColor blackColor];
    [self.mainScrollView addSubview:self.nameLable];

    
    self.alsoVipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.smallHeaderImageView.frame.origin.x+self.smallHeaderImageView.frame.size.width-10*BILI, self.smallHeaderImageView.frame.origin.y+self.smallHeaderImageView.frame.size.height-15*BILI, 20*BILI, 20*BILI)];
    self.alsoVipImageView.image = [UIImage imageNamed:@"vip_grade_wg_n"];
    [self.mainScrollView addSubview:self.alsoVipImageView];
    if([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
    {
        self.alsoVipImageView.hidden = YES;
    }
    
    UILabel *  tipLable= [[UILabel alloc] initWithFrame:CGRectMake(self.nameLable.frame.origin.x, self.nameLable.frame.origin.y+self.nameLable.frame.size.height+7*BILI, 300*BILI, 12*BILI)];
    tipLable.text = @"查看编辑个人资料 >";
    tipLable.textColor = UIColorFromRGB(0xC2C2C2);
    tipLable.font = [UIFont systemFontOfSize:12*BILI];
    [self.mainScrollView addSubview:tipLable];

    
    UITapGestureRecognizer * mengCengTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(eaditMessage)];
    [self.mengCengTopView addGestureRecognizer:mengCengTap];

    
    
    self.messgaeLable = [[UILabel alloc] initWithFrame:CGRectMake(tipLable.frame.origin.x, tipLable.frame.origin.y+tipLable.frame.size.height+10*BILI, VIEW_WIDTH, 14*BILI)];
    self.messgaeLable.font = [UIFont systemFontOfSize:14*BILI];
    self.messgaeLable.textColor = UIColorFromRGB(0x555555);
    [self.mainScrollView addSubview:self.messgaeLable];
    
    
    self.signatureLable = [[UILabel alloc] initWithFrame:CGRectMake(tipLable.frame.origin.x, self.messgaeLable.frame.origin.y+self.messgaeLable.frame.size.height+8*BILI, VIEW_WIDTH, 12*BILI)];
    self.signatureLable.font = [UIFont systemFontOfSize:12*BILI];
    self.signatureLable.textColor = UIColorFromRGB(0x555555);
    [self.mainScrollView addSubview:self.signatureLable];

    
    
    
    UIButton * editMessageButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.nameLable.frame.origin.y, VIEW_WIDTH, 90*BILI)];
    editMessageButton.backgroundColor = [UIColor clearColor];
    [editMessageButton addTarget:self action:@selector(eaditMessage) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:editMessageButton];
    
    self.listView = [[UIView alloc] initWithFrame:CGRectMake(0, self.smallHeaderImageView.frame.origin.y+self.smallHeaderImageView.frame.size.height+30*BILI, VIEW_WIDTH, 500)];
    self.listView.backgroundColor = [UIColor clearColor];
    [self.mainScrollView addSubview:self.listView];

    
}
-(void)initBottomButtonView
{
    [self.listView removeAllSubviews];
    //用户
    self.acountButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0*BILI, VIEW_WIDTH, 60*BILI)];
    self.acountButton.backgroundColor = [UIColor whiteColor];
    [self.acountButton addTarget:self action:@selector(acountButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.acountButton setBackgroundImage:[UIImage imageNamed:@"buttonSelectHeight"] forState:UIControlStateHighlighted];
    [self.listView addSubview:self.acountButton];
    
    UIImageView * acountImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12*BILI, (60*BILI-20*BILI)/2, 20*BILI, 20*BILI)];
    acountImageView.image = [UIImage imageNamed:@"icon_zh"];
    [self.acountButton addSubview:acountImageView];
    
    
    UILabel * acountLable = [[UILabel alloc] initWithFrame:CGRectMake(52*BILI, (60*BILI-15*BILI)/2, 15*BILI*4.5, 15*BILI)];
    acountLable.font = [UIFont systemFontOfSize:15*BILI];
    acountLable.textColor = UIColorFromRGB(0x333333);
    acountLable.alpha = 0.9;
    acountLable.text = @"我的钱包";
    [self.acountButton addSubview:acountLable];
    
    self.moneyLable = [[UILabel alloc] initWithFrame:CGRectMake(acountLable.frame.origin.x+acountLable.frame.size.width+5*BILI, acountLable.frame.origin.y, VIEW_WIDTH, 15*BILI)];
    self.moneyLable.textColor = UIColorFromRGB(0xFF9D56);
    self.moneyLable.font = [UIFont systemFontOfSize:15*BILI];
    [self.acountButton addSubview:self.moneyLable];
    
    
    UIImageView * acountLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(12+18)*BILI, (60*BILI-18*BILI)/2, 18*BILI, 18*BILI)];
    acountLeftImageView.image = [UIImage imageNamed:@"btn_back_nr_n"];
    [self.acountButton addSubview:acountLeftImageView];
    
    self.pushMoneyButton = [[UIButton alloc] initWithFrame:CGRectMake(acountLeftImageView.frame.origin.x-11*BILI-65*BILI, (60*BILI-29*BILI)/2 ,65*BILI, 29*BILI)];
    [self.pushMoneyButton setBackgroundImage:[UIImage imageNamed:@"buttonSelectHeight"] forState:UIControlStateHighlighted];
    self.pushMoneyButton.backgroundColor = UIColorFromRGB(0xFF9D56);
    self.pushMoneyButton.layer.cornerRadius = 6;
    [self.pushMoneyButton setTitle:@"充值" forState:UIControlStateNormal];
    if ([@"2" isEqualToString:[self.userInformation objectForKey:@"accountType"]]) {
        [self.pushMoneyButton setTitle:@"提现" forState:UIControlStateNormal];
    }
    
    [self.pushMoneyButton addTarget:self action:@selector(pushMoneyButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.pushMoneyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.pushMoneyButton.titleLabel.font = [UIFont systemFontOfSize:14*BILI];
    [self.acountButton addSubview:self.pushMoneyButton];
    
    
        //////////////////////////////////////
        
        self.vipCenterButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.acountButton.frame.origin.y+self.acountButton.frame.size.height+1, VIEW_WIDTH, 60*BILI)];
        self.vipCenterButton.backgroundColor = [UIColor whiteColor];
        [self.vipCenterButton addTarget:self action:@selector(vipCenterButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.vipCenterButton setBackgroundImage:[UIImage imageNamed:@"buttonSelectHeight"] forState:UIControlStateHighlighted];

        [self.listView addSubview:self.vipCenterButton];
        
        UIImageView * vipCenterImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12*BILI, (60*BILI-20*BILI)/2, 20*BILI, 20*BILI)];
        vipCenterImageView.image = [UIImage imageNamed:@"vip_icon_huiyuan"];
        [self.vipCenterButton addSubview:vipCenterImageView];
        
        UILabel * vipCenterLable = [[UILabel alloc] initWithFrame:CGRectMake(52*BILI, (60*BILI-15*BILI)/2, 15*BILI*4.5, 15*BILI)];
        vipCenterLable.font = [UIFont systemFontOfSize:15*BILI];
        vipCenterLable.textColor = UIColorFromRGB(0x333333);
        vipCenterLable.text = @"会员中心";
        [self.vipCenterButton addSubview:vipCenterLable];
        
        UIImageView * vipCenterLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(12+18)*BILI, (60*BILI-18*BILI)/2, 18*BILI, 18*BILI)];
        vipCenterLeftImageView.image = [UIImage imageNamed:@"btn_back_nr_n"];
        [self.vipCenterButton addSubview:vipCenterLeftImageView];
        
        self.vipLingQuJinBiPointView = [[UIView alloc] initWithFrame:CGRectMake(648*BILI/2, (60-7)*BILI/2, 7*BILI, 7*BILI)];
        self.vipLingQuJinBiPointView.layer.masksToBounds = YES;
        self.vipLingQuJinBiPointView.layer.cornerRadius = 3.5*BILI;
        self.vipLingQuJinBiPointView.backgroundColor = UIColorFromRGB(0xff0000);
        [self.vipCenterButton addSubview:self.vipLingQuJinBiPointView];
        
        if ([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]]||[@"2" isEqualToString:[self.userInformation objectForKey:@"accountType"]]) {
            
            self.vipCenterButton.hidden = YES;
            self.vipCenterButton.frame =self.acountButton.frame;
        }
        ////////////////////////////
        //////////////////////////////////////认证中心
        
        UIButton * huiChangRenZengButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.vipCenterButton.frame.origin.y+self.vipCenterButton.frame.size.height+1, VIEW_WIDTH, 60*BILI)];
        huiChangRenZengButton.backgroundColor = [UIColor whiteColor];
        [huiChangRenZengButton addTarget:self action:@selector(huiChangRenZengButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [huiChangRenZengButton setBackgroundImage:[UIImage imageNamed:@"buttonSelectHeight"] forState:UIControlStateHighlighted];

        [self.listView addSubview:huiChangRenZengButton];
        
        UIImageView * huiChangRenZengImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12*BILI, (60*BILI-20*BILI)/2, 20*BILI, 20*BILI)];
        huiChangRenZengImageView.image = [UIImage imageNamed:@"icon_renzheng"];
        [huiChangRenZengButton addSubview:huiChangRenZengImageView];
        
        UILabel * huiChangRenZengLable = [[UILabel alloc] initWithFrame:CGRectMake(52*BILI, (60*BILI-15*BILI)/2, 15*BILI*4.5, 15*BILI)];
        huiChangRenZengLable.font = [UIFont systemFontOfSize:15*BILI];
        huiChangRenZengLable.textColor = UIColorFromRGB(0x333333);
        huiChangRenZengLable.text = @"主播认证";
        [huiChangRenZengButton addSubview:huiChangRenZengLable];
        
        UIImageView * huiChangRenZengLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(12+18)*BILI, (60*BILI-18*BILI)/2, 18*BILI, 18*BILI)];
        huiChangRenZengLeftImageView.image = [UIImage imageNamed:@"btn_back_nr_n"];
        [huiChangRenZengButton addSubview:huiChangRenZengLeftImageView];
        
        
        if ([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]]) {
            
            huiChangRenZengButton.hidden = YES;
            huiChangRenZengButton.frame =self.acountButton.frame;
        }
        ////////////////////////////
        UIButton * shiPinKuaiLiaoButton;
        if ([@"2" isEqualToString:[self.userInformation objectForKey:@"accountType"]])
        {
            huiChangRenZengButton.hidden = YES;
            huiChangRenZengButton.frame =self.acountButton.frame;

            
           shiPinKuaiLiaoButton  = [[UIButton alloc] initWithFrame:CGRectMake(0, huiChangRenZengButton.frame.origin.y+huiChangRenZengButton.frame.size.height+1, VIEW_WIDTH, 60*BILI)];
            [shiPinKuaiLiaoButton setBackgroundImage:[UIImage imageNamed:@"buttonSelectHeight"] forState:UIControlStateHighlighted];

            shiPinKuaiLiaoButton.backgroundColor = [UIColor whiteColor];
            [shiPinKuaiLiaoButton addTarget:self action:@selector(shiPinKuaiLiaoButtonClick) forControlEvents:UIControlEventTouchUpInside];
            [self.listView addSubview:shiPinKuaiLiaoButton];
            
            UIImageView * shiPinKuaiLiaoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12*BILI, (60*BILI-20*BILI)/2, 20*BILI, 20*BILI)];
            shiPinKuaiLiaoImageView.image = [UIImage imageNamed:@"huiChang_icon_shipin"];
            [shiPinKuaiLiaoButton addSubview:shiPinKuaiLiaoImageView];
            
            UILabel * shiPinKuaiLiaoLable = [[UILabel alloc] initWithFrame:CGRectMake(52*BILI, (60*BILI-15*BILI)/2, 15*BILI*4.5, 15*BILI)];
            shiPinKuaiLiaoLable.font = [UIFont systemFontOfSize:15*BILI];
            shiPinKuaiLiaoLable.textColor = UIColorFromRGB(0x333333);
            shiPinKuaiLiaoLable.text = @"视频探聊";
            [shiPinKuaiLiaoButton addSubview:shiPinKuaiLiaoLable];
            
            UIImageView * shiPinKuaiLiaoLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(12+18)*BILI, (60*BILI-18*BILI)/2, 18*BILI, 18*BILI)];
            shiPinKuaiLiaoLeftImageView.image = [UIImage imageNamed:@"btn_back_nr_n"];
            [shiPinKuaiLiaoButton addSubview:shiPinKuaiLiaoLeftImageView];
            
            
            if ([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]]) {
                
                shiPinKuaiLiaoButton.hidden = YES;
                shiPinKuaiLiaoButton.frame =self.acountButton.frame;
            }

        }
        //////////
        self.shareButton = [[UIButton alloc] initWithFrame:CGRectMake(0, huiChangRenZengButton.frame.origin.y+huiChangRenZengButton.frame.size.height+1*BILI, VIEW_WIDTH, 60*BILI)];
    [self.shareButton setBackgroundImage:[UIImage imageNamed:@"buttonSelectHeight"] forState:UIControlStateHighlighted];

        if ([@"2" isEqualToString:[self.userInformation objectForKey:@"accountType"]])
        {
            self.shareButton.frame = CGRectMake(0, shiPinKuaiLiaoButton.frame.origin.y+shiPinKuaiLiaoButton.frame.size.height+1*BILI, VIEW_WIDTH, 60*BILI);
        }
        self.shareButton.backgroundColor = [UIColor whiteColor];
        [self.shareButton addTarget:self action:@selector(shareButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.listView addSubview:self.shareButton];
        
        
        UIImageView * shareImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15*BILI, (60*BILI-20*BILI)/2, 20*BILI, 20*BILI)];
        shareImageView.image = [UIImage imageNamed:@"icon_fx"];
        [self.shareButton addSubview:shareImageView];
        
        UILabel * shareLable = [[UILabel alloc] initWithFrame:CGRectMake(52*BILI, (60*BILI-15*BILI)/2, 15*BILI*8, 15*BILI)];
        shareLable.font = [UIFont systemFontOfSize:15*BILI];
        shareLable.textColor = [UIColor blackColor];
        shareLable.alpha = 0.9;
        if ([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]]) {
            
            shareLable.text = @"分享";
            
        }
        else
        {
            shareLable.text = @"邀请好友";
            
        }
        [self.shareButton addSubview:shareLable];
        
        
        UIImageView * shareLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(12+18)*BILI, (60*BILI-18*BILI)/2, 18*BILI, 18*BILI)];
        shareLeftImageView.image = [UIImage imageNamed:@"btn_back_nr_n"];
        [self.shareButton addSubview:shareLeftImageView];
        
        
        ///////////////////////////
        self.connectMiShu =  [[UIButton alloc] initWithFrame:CGRectMake(0, self.shareButton.frame.origin.y+self.shareButton.frame.size.height+1*BILI, VIEW_WIDTH, 60*BILI)];
        self.connectMiShu.backgroundColor = [UIColor whiteColor];
        [self.connectMiShu addTarget:self action:@selector(connectButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.connectMiShu setBackgroundImage:[UIImage imageNamed:@"buttonSelectHeight"] forState:UIControlStateHighlighted];

        [self.listView addSubview:self.connectMiShu];
        
        UIImageView * connectImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15*BILI, (60*BILI-20*BILI)/2, 20*BILI, 20*BILI)];
        connectImageView.image = [UIImage imageNamed:@"icon_xiaomishu"];
        [self.connectMiShu addSubview:connectImageView];
        
        UILabel * connectLable = [[UILabel alloc] initWithFrame:CGRectMake(52*BILI, (60*BILI-15*BILI)/2, 15*BILI*4.5, 15*BILI)];
        connectLable.font = [UIFont systemFontOfSize:15*BILI];
        connectLable.textColor = UIColorFromRGB(0x333333);
        connectLable.text = @"客服反馈";
        [self.connectMiShu addSubview:connectLable];
        
        self.messageCountLable = [[UILabel alloc] initWithFrame:CGRectMake(648*BILI/2-5*BILI, 20*BILI, 20*BILI, 20*BILI)];
        self.messageCountLable.textColor = [UIColor whiteColor];
        self.messageCountLable.font = [UIFont systemFontOfSize:10*BILI];
        self.messageCountLable.textAlignment = NSTextAlignmentCenter;
        self.messageCountLable.layer.cornerRadius = 20*BILI/2;
        self.messageCountLable.layer.masksToBounds = YES;
        self.messageCountLable.hidden = YES;
        self.messageCountLable.backgroundColor = [UIColor redColor];
        [self.connectMiShu addSubview:self.messageCountLable];
        
        UIImageView * connectLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(12+18)*BILI, (60*BILI-18*BILI)/2, 18*BILI, 18*BILI)];
        connectLeftImageView.image = [UIImage imageNamed:@"btn_back_nr_n"];
        [self.connectMiShu addSubview:connectLeftImageView];
        
        
       
        //////////////////
        
        self.changJianQuestionsButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.connectMiShu.frame.origin.y+self.connectMiShu.frame.size.height+1*BILI, VIEW_WIDTH, 60*BILI)];
        self.changJianQuestionsButton.backgroundColor = [UIColor whiteColor];
        [self.changJianQuestionsButton addTarget:self action:@selector(changJianQuestionsButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.changJianQuestionsButton setBackgroundImage:[UIImage imageNamed:@"buttonSelectHeight"] forState:UIControlStateHighlighted];

        [self.listView addSubview:self.changJianQuestionsButton];
        
        
        UIImageView * changJianImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15*BILI, (60*BILI-20*BILI)/2, 20*BILI, 20*BILI)];
        changJianImageView.image = [UIImage imageNamed:@"icon_fk"];
        [self.changJianQuestionsButton addSubview:changJianImageView];
        
        UILabel * changJianLable = [[UILabel alloc] initWithFrame:CGRectMake(52*BILI, (60*BILI-15*BILI)/2, 15*BILI*4.5, 15*BILI)];
        changJianLable.font = [UIFont systemFontOfSize:15*BILI];
        changJianLable.textColor = [UIColor blackColor];
        changJianLable.alpha = 0.9;
        changJianLable.text = @"常见问题";
        [self.changJianQuestionsButton addSubview:changJianLable];
        
        UIImageView * changJianLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(12+18)*BILI, (60*BILI-18*BILI)/2, 18*BILI, 18*BILI)];
        changJianLeftImageView.image = [UIImage imageNamed:@"btn_back_nr_n"];
        [self.changJianQuestionsButton addSubview:changJianLeftImageView];
        
    
    
        

        
        ///////////////////////////
    self.settingButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.changJianQuestionsButton.frame.origin.y+self.changJianQuestionsButton.frame.size.height+1*BILI, VIEW_WIDTH, 60*BILI)];
    if ([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]]) {
        
        self.changJianQuestionsButton.hidden = YES;
         self.settingButton.frame = self.changJianQuestionsButton.frame;
    }
        self.settingButton.backgroundColor = [UIColor whiteColor];
        [self.settingButton addTarget:self action:@selector(settingButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.settingButton setBackgroundImage:[UIImage imageNamed:@"buttonSelectHeight"] forState:UIControlStateHighlighted];

        [self.listView addSubview:self.settingButton];
        
        UIImageView * settingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15*BILI, (60*BILI-20*BILI)/2, 20*BILI, 20*BILI)];
        settingImageView.image = [UIImage imageNamed:@"icon_sz"];
        [self.settingButton addSubview:settingImageView];
        
        UILabel * settingLable = [[UILabel alloc] initWithFrame:CGRectMake(52*BILI, (60*BILI-15*BILI)/2, 15*BILI*4.5, 15*BILI)];
        settingLable.font = [UIFont systemFontOfSize:15*BILI];
        settingLable.textColor = [UIColor blackColor];
        settingLable.alpha = 0.9;
        settingLable.text = @"设置";
        [self.settingButton addSubview:settingLable];
        
    
        UIImageView * settingLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(12+18)*BILI, (60*BILI-18*BILI)/2, 18*BILI, 18*BILI)];
        settingLeftImageView.image = [UIImage imageNamed:@"btn_back_nr_n"];
        [self.settingButton addSubview:settingLeftImageView];
        
        
        
        self.listView.frame = CGRectMake(0, self.listView.frame.origin.y, VIEW_WIDTH, self.settingButton.frame.origin.y+self.settingButton.frame.size.height+5);
        
        self.listBottomView.frame = CGRectMake(0, self.listView.frame.origin.y, VIEW_WIDTH, self.settingButton.frame.origin.y+self.settingButton.frame.size.height+5);
        [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, self.listView.frame.origin.y+self.listView.frame.size.height+70)];


        if(self.listView.frame.origin.y+self.listView.frame.size.height+70<self.mainScrollView.frame.size.height+20*BILI) {
            
            [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, self.mainScrollView.frame.size.height+20*BILI)];
            
        }
    

    
    if ([@"1" isEqualToString:[self.userInformation objectForKey:@"accountType"]])
    {
        if ([@"true" isEqualToString:[self.userInformation objectForKey:@"isVip"]]) {
            
            self.alsoVipImageView.image = [UIImage imageNamed:@"vip_grade_wg_h"];
            self.nameLable.textColor = UIColorFromRGB(0xFC416C);
        }
        else
        {
            self.alsoVipImageView.image = [UIImage imageNamed:@"vip_grade_wg_n"];
            self.nameLable.textColor = [UIColor blackColor];
        }
    }
    else
    {
        self.alsoVipImageView.hidden = YES;
    }
    self.signatureLable.text  = [self.userInformation objectForKey:@"sign"];
    NSString * money = [self.userInformation objectForKey:@"gold_number"];
    self.moneyLable.text = [NSString stringWithFormat:@"%.2f金币",money.floatValue/JinBiBiLi];

    if ([@"1" isEqualToString:[self.userInformation objectForKey:@"isNeedVipHint"]]) {
        
        self.vipLingQuJinBiPointView.hidden = NO;
    }
    else
    {
        self.vipLingQuJinBiPointView.hidden = YES;
    }

    if(![@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
    {
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSString * iosv = [defaults objectForKey:@"ios_v"];
        NSString *versionAgent = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
        if (![versionAgent isEqualToString:iosv]) {
            
            UIView * pointView = [[UIView alloc] initWithFrame:CGRectMake(648*BILI/2, (60-7)*BILI/2, 7*BILI, 7*BILI)];
            pointView.layer.masksToBounds = YES;
            pointView.layer.cornerRadius = 3.5*BILI;
            pointView.backgroundColor = UIColorFromRGB(0xff0000);
            [self.settingButton addSubview:pointView];
        }
        
    }

    
}
-(void)personalShare
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSArray * shareArray = [[NSArray alloc] initWithObjects:self.shareImagePath, nil];

    //通用参数设置
    [parameters SSDKSetupShareParamsByText:nil
                                    images:shareArray
                                       url:nil
                                     title:nil
                                      type:SSDKContentTypeImage];
    [ShareSDK share:SSDKPlatformSubTypeWechatSession
         parameters:parameters
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
//         if(state == SSDKResponseStateBeginUPLoad){
//             return ;
//         }
         NSString *titel = @"";
         NSString *message = @"";
         NSString *typeStr = @"";
         UIColor *typeColor = [UIColor grayColor];
         switch (state) {
             case SSDKResponseStateSuccess:
             {
                 titel = @"分享成功";
                 typeStr = @"成功";
                 typeColor = [UIColor blueColor];
                 break;
             }
             case SSDKResponseStateFail:
             {
                 message = [NSString stringWithFormat:@"%@", error];
                 NSLog(@"error :%@",error);
                 typeStr = @"失败";
                 typeColor = [UIColor redColor];
                 break;
             }
             case SSDKResponseStateCancel:
             {
                 titel = @"分享已取消";
                 typeStr = @"取消";
                 break;
             }
             default:
                 break;
         }
     }];

}

-(void)shareSuccessGetJinBi
{
    [self.cloudClient shareSuccessGetJinBi:@"8061"
                                  delegate:self
                                  selector:@selector(getJinBiSuccess:)
                             errorSelector:@selector(getJinBiError:)];
}

-(void)getJinBiSuccess:(NSDictionary *)info
{
    
}
-(void)getJinBiError:(NSDictionary *)info
{
    
}

-(void)eaditMessage
{
    TanLiao_EditMessageViewController * editMessgaeVC = [[TanLiao_EditMessageViewController alloc] init];
    editMessgaeVC.userInformation = self.userInformation;
    [self.navigationController pushViewController:editMessgaeVC animated:YES];
     
}

-(void)pushMoneyButtonClick
{
    
    if([@"2" isEqualToString:[self.userInformation objectForKey:@"accountType"]])
    {
        
        NSString * money =  [self.userInformation objectForKey:@"gold_number"];;
        NSString * withDrawAmount = [self.userInformation objectForKey:@"withDrawAmount"];
        if (money.intValue<withDrawAmount.intValue) {
            [TanLiao_Common showAlert:@"提示" message:[NSString stringWithFormat:@"提现金额不能小于%d元(1元=1金币)",withDrawAmount.intValue/100]];
            
        }
        else
        {
            
            TanLiao_TiXianViewController * tiXianVC = [[TanLiao_TiXianViewController alloc] init];
            tiXianVC.money = money;
            tiXianVC.info = self.userInformation;
            [self.navigationController pushViewController:tiXianVC animated:YES];
            
            
            
        }

    }
    else
    {
        

            TanLiao_RechargeViewController * rechargeVC = [[TanLiao_RechargeViewController alloc] init];
            rechargeVC.delegate = self;
            rechargeVC.payChannel = @"appPay";
            [self.navigationController pushViewController:rechargeVC animated:YES];
  
    }

}


-(void)acountButtonClick
{
    if ([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
    {
//        KLiao_RechargeViewController * rechargeVC = [[KLiao_RechargeViewController alloc] init];
//        rechargeVC.delegate = self;
//        [self.navigationController pushViewController:rechargeVC animated:YES];
    }
    else
    {
        TanLiao_RechargeViewController * rechargeVC = [[TanLiao_RechargeViewController alloc] init];
        rechargeVC.delegate = self;
        rechargeVC.payChannel = @"appPay";
        [self.navigationController pushViewController:rechargeVC animated:YES];
    }
}
-(void)gongHuiShenQingButtonClick
{
    TanLiao_GongHuiShenQingViewController * vc = [[TanLiao_GongHuiShenQingViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)huiChangRenZengButtonClick
{
     TanLiao_IndificationViewController * vc = [[TanLiao_IndificationViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}
-(void)vipCenterButtonClick
{
    TanLiao_VipViewController * vipVC = [[TanLiao_VipViewController alloc] init];
    [self.navigationController pushViewController:vipVC animated:YES];
    
}
-(void)shiPinKuaiLiaoButtonClick
{
    TanLiao_AnchorFunctionListViewController * vc = [[TanLiao_AnchorFunctionListViewController alloc] init];
    vc.userInformation = self.userInformation;
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)becomeAnchorButtonClick
{
//    SecondIndificationViewController * secondIntificationVC = [[SecondIndificationViewController alloc] init];
//    secondIntificationVC.anchorRole = self.anchorRole;
//    [self.navigationController pushViewController:secondIntificationVC animated:YES];
//
//    return;
    NSString * role_radio = [self.anchorRole objectForKey:@"role_radio"];
    NSString * role_vedio = [self.anchorRole objectForKey:@"role_vedio"];
    if ([@"0" isEqualToString:role_radio]&&[@"0" isEqualToString:role_vedio]) {
        
        TanLiao_TiJiaoSuccessViewController * tiJiaoSuccessVC = [[TanLiao_TiJiaoSuccessViewController alloc] init];
        [self.navigationController pushViewController:tiJiaoSuccessVC animated:YES];
    }
    else if ([@"0" isEqualToString:role_radio]&&[@"1" isEqualToString:role_vedio])
    {
        TanLiao_TiJiaoSuccessViewController * tiJiaoSuccessVC = [[TanLiao_TiJiaoSuccessViewController alloc] init];
        [self.navigationController pushViewController:tiJiaoSuccessVC animated:YES];
    }
    else if ([@"1" isEqualToString:role_radio]&&[@"0" isEqualToString:role_vedio])
    {
        TanLiao_TiJiaoSuccessViewController * tiJiaoSuccessVC = [[TanLiao_TiJiaoSuccessViewController alloc] init];
        [self.navigationController pushViewController:tiJiaoSuccessVC animated:YES];
    }
    else if([@"-1" isEqualToString:role_radio]&&[@"-1" isEqualToString:role_vedio])
    {
        AgreementViewController * agreeMentVC = [[AgreementViewController alloc] init];
        [self.navigationController pushViewController:agreeMentVC animated:YES];
    }
    else if ([@"2" isEqualToString:role_radio]&&[@"-1" isEqualToString:role_vedio])
    {
        AgreementViewController * agreeMentVC = [[AgreementViewController alloc] init];
        [self.navigationController pushViewController:agreeMentVC animated:YES];
    }
    else if ([@"2" isEqualToString:role_radio]&&[@"2" isEqualToString:role_vedio])
    {
        AgreementViewController * agreeMentVC = [[AgreementViewController alloc] init];
        [self.navigationController pushViewController:agreeMentVC animated:YES];
    }
    else if ([@"-1" isEqualToString:role_radio]&&[@"2" isEqualToString:role_vedio])
    {
        AgreementViewController * agreeMentVC = [[AgreementViewController alloc] init];
        [self.navigationController pushViewController:agreeMentVC animated:YES];
    }
    else
    {
        TanLiao_SecondIndificationViewController * secondIntificationVC = [[TanLiao_SecondIndificationViewController alloc] init];
        secondIntificationVC.anchorRole = self.anchorRole;
        [self.navigationController pushViewController:secondIntificationVC animated:YES];
    }
}
-(void)setPriceButtonClick
{
    
//    SetPriceViewController * setPriceVC = [[SetPriceViewController alloc] init];
//    setPriceVC.userInformation = self.userInformation;
//    [self.navigationController pushViewController:setPriceVC animated:YES];
}
-(void)woDeSgouHuButtonClick
{
    TanLiaoLiao_AnchorShouHuListViewController * vc = [[TanLiaoLiao_AnchorShouHuListViewController alloc] init];
    vc.userId = [TanLiao_Common getNowUserID];
    [self.navigationController pushViewController:vc animated:YES];

}
-(void)bangDingTelButtonClick
{
    if ([self.userInformation objectForKey:@"mobile"]==nil || [@"" isEqualToString:[self.userInformation objectForKey:@"mobile"]])
    {
        TanLiao_BangDingTelViewController * vc = [[TanLiao_BangDingTelViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        TanLiao_BangDingTelViewController * vc = [[TanLiao_BangDingTelViewController alloc] init];
        vc.mobel = [self.userInformation objectForKey:@"mobile"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
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
-(void)blackListButtonClick
{
    TanLiao_BlackListViewController  * blackListVC = [[TanLiao_BlackListViewController alloc] init];
    [self.navigationController pushViewController:blackListVC animated:YES];
}
-(void)commitButtonClick
{
    TanLiao_FeedBackViewController * feedVC = [[TanLiao_FeedBackViewController alloc] init];
    [self.navigationController pushViewController:feedVC animated:YES];
}
-(void)changJianQuestionsButtonClick
{
    
    TanLiaoLiao_HomeWebViewController * homeWebVC = [[TanLiaoLiao_HomeWebViewController alloc] init];
    homeWebVC.url = @"http://pages.cyoulive.net/question/";
    [self.navigationController pushViewController:homeWebVC animated:YES];

}
-(void)lianXiJingJiRenButtonClick
{
        ChatViewController *chatVC = [[ChatViewController alloc] initWithConversationType:
                                      ConversationType_PRIVATE targetId:[self.userInformation objectForKey:@"brokerId"]];
    
        chatVC.conversationType = ConversationType_PRIVATE;
        chatVC.targetId = [self.userInformation objectForKey:@"brokerId"];
        chatVC.title = @"经纪人";
        [self.navigationController pushViewController:chatVC animated:YES];
}
-(void)connectButtonClick
{
    if([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
    {
        ChatViewController *chatVC = [[ChatViewController alloc] initWithConversationType:
                                      ConversationType_PRIVATE targetId:@"910005"];
        
        chatVC.conversationType = ConversationType_PRIVATE;
        chatVC.targetId = @"910005";
        chatVC.title = @"客服小秘书";
        [self.navigationController pushViewController:chatVC animated:YES];
    }
    else
    {
        RCDCustomerServiceViewController *chatService = [[RCDCustomerServiceViewController alloc] init];
        chatService.conversationType = ConversationType_CUSTOMERSERVICE;
        chatService.targetId = RongCloud_SERVICE_ID;
        chatService.title = @"客服小秘书";
        [self.navigationController pushViewController :chatService animated:YES];

    }
    
}

-(void)shareButtonClick
{
    
        //分享的标题
        NSString *textToShare = @"分享的标题。";
        //分享的图片
        UIImage *imageToShare = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[self.userInformation objectForKey:@"sharePic"]]]];
        //分享的url
        // NSURL *urlToShare = [NSURL URLWithString:@"http://www.baidu.com"];
        //在这里呢 如果想分享图片 就把图片添加进去  文字什么的通上
        NSArray *activityItems = @[textToShare,imageToShare];
        UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
        //不出现在活动项目
        activityVC.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll];
        [self presentViewController:activityVC animated:YES completion:nil];
        // 分享之后的回调
        activityVC.completionWithItemsHandler = ^(UIActivityType  _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
            if (completed) {
                NSLog(@"completed");
                [self shareSuccessGetJinBi];
                //分享 成功
            } else  {
                [TanLiao_Common showToastView:@"取消分享" view:self.view];
                NSLog(@"cancled");
                //分享 取消
            }
        };
    


}

-(void)settingButtonClick
{
    TanLiao_SettingViewController * settingVC = [[TanLiao_SettingViewController alloc] init];
    settingVC.userInfo = self.userInformation;
    [self.navigationController pushViewController:settingVC animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setTabBarShow];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = YES;
    
    [self.cloudClient anchorShenHeStatus:@"8050"
                                delegate:self
                                selector:@selector(getShenHeStatusSuccess:)
                           errorSelector:@selector(getShenHEStatusError:)];


    
    int unReadMessNumber =  [[RCIMClient sharedRCIMClient] getUnreadCount:ConversationType_CUSTOMERSERVICE targetId:RongCloud_SERVICE_ID];
    if (unReadMessNumber>0) {
        
        self.messageCountLable.text = [NSString stringWithFormat:@"%d",unReadMessNumber];
        self.messageCountLable.hidden = NO;

    }
    else
    {
        self.messageCountLable.hidden = YES;

    }
    [self performSelector:@selector(chuLiBenDiCunChuBase64Array) withObject:self afterDelay:1];//处理本地存储的(苹果支付成功并返回base64str但是账户余额增加接口8908没有调用或者调用失败的情况)
}
-(void)chongZhiSuccessToOwner:(NSDictionary *)info
{
    [TanLiao_Common showToastView:@"充值成功" view:self.view];
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSArray * benDiBase64Array = [defaults objectForKey:@"BenDiCunChuBase64Key"];//存储苹果支付返回的base64的数组
    NSMutableArray * base64Array = [[NSMutableArray alloc] initWithArray:benDiBase64Array];
    
    for (int i=0;i<base64Array.count;i++) {
        
        NSString * base64Str = [base64Array objectAtIndex:i];
        if ([base64Str isEqualToString:[info objectForKey:@"receipt"]]) {
            [base64Array removeObjectAtIndex:i];
        }
    }
    benDiBase64Array = [[NSArray alloc] initWithArray:base64Array];
    [defaults setObject:benDiBase64Array forKey:@"BenDiCunChuBase64Key"];
    [defaults synchronize];
    
}
-(void)chuLiBenDiCunChuBase64Array
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSArray * benDiBasr64Array = [defaults objectForKey:@"BenDiCunChuBase64Key"];//存储苹果支付返回的base64的数组
    for (int i=0; i<benDiBasr64Array.count; i++) {
        
        NSString * base64Str  = [benDiBasr64Array objectAtIndex:i];
        [self.cloudClient getAppPayResult:@"8908"
                                  orderNo:@""
                                  receipt:base64Str
                                 delegate:self
                                 selector:@selector(getResultSuccess:)
                            errorSelector:@selector(getResultError:)];

    }


}
-(void)getResultSuccess:(NSDictionary *)info
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSArray * benDiBase64Array = [defaults objectForKey:@"BenDiCunChuBase64Key"];//存储苹果支付返回的base64的数组
    
    NSMutableArray * base64Array = [[NSMutableArray alloc] initWithArray:benDiBase64Array];
    
    
    for (int i=0;i<base64Array.count;i++) {
        
        NSString * base64Str = [base64Array objectAtIndex:i];
        if ([base64Str isEqualToString:[info objectForKey:@"receipt"]])
        {
            [base64Array removeObjectAtIndex:i];
        }
    }
    benDiBase64Array = [[NSArray alloc] initWithArray:base64Array];
    [defaults setObject:benDiBase64Array forKey:@"BenDiCunChuBase64Key"];
    [defaults synchronize];
    
    [self.cloudClient getUserInformation:@"8029"
                                delegate:self
                                selector:@selector(getUserInformationSuccess:)
                           errorSelector:@selector(getUserInformationError:)];

}
-(void)getResultError:(NSDictionary *)info
{
    
}
-(void)getShenHeStatusSuccess:(NSDictionary *)info
{
    //0：审核申请中，1：没有正在审核的申请
    self.anchorRole = info;
    [self.cloudClient getUserInformation:@"8029"
                                delegate:self
                                selector:@selector(getUserInformationSuccess:)
                           errorSelector:@selector(getUserInformationError:)];

}
-(void)getShenHEStatusError:(NSDictionary *)info
{
    shenHeStatus = NO;
    [self.cloudClient getUserInformation:@"8029"
                                delegate:self
                                selector:@selector(getUserInformationSuccess:)
                           errorSelector:@selector(getUserInformationError:)];

}
-(void)getUserInformationSuccess:(NSDictionary *)info
{
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * userInfo = [defaults objectForKey:USERINFO];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:userInfo];
    [dic removeObjectForKey:@"accountType"];
    [dic setObject:[info objectForKey:@"accountType"] forKey:@"accountType"];
    [dic removeObjectForKey:@"isVip"];
    [dic setObject:[info objectForKey:@"isVip"] forKey:@"isVip"];
    [dic removeObjectForKey:@"role"];
    [dic setObject:[info objectForKey:@"role"] forKey:@"role"];
    [dic removeObjectForKey:@"avatarUrl"];
    [dic setObject:[info objectForKey:@"avatarUrl"] forKey:@"avatarUrl"];
    
    [defaults removeObjectForKey:USERINFO];
    [defaults setObject:dic forKey:USERINFO];
    [defaults synchronize];
    
    self.userInformation = info;
    self.bigHeaderImageView.urlPath = [info objectForKey:@"avatarUrl"];
    self.smallHeaderImageView.urlPath = [info objectForKey:@"avatarUrl"];;
    self.nameLable.text = [info objectForKey:@"nick"];
    if ([@"0" isEqualToString:[info objectForKey:@"sex"]]) {
        
        self.sexAgeView.image = [UIImage imageNamed:@"pic_old_woman"];
        
    }
    else
    {
        self.sexAgeView.image = [UIImage imageNamed:@"pic_old_man"];
        
    }
    NSNumber * number = [info objectForKey:@"age"];
    self.ageLable.text = [NSString stringWithFormat:@"%d",number.intValue];
    self.messgaeLable.text = [NSString stringWithFormat:@"ID:%@",[info objectForKey:@"userId"]];
    
    
    
    
    NSUserDefaults * nowMoneyDefaults = [NSUserDefaults standardUserDefaults];
    [nowMoneyDefaults setObject:[info objectForKey:@"gold_number"] forKey:@"nowMoneyNumber"];
    [nowMoneyDefaults synchronize];
    

    
    [self initBottomButtonView];
    

}



-(void)getUserInformationError:(NSDictionary *)info
{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
