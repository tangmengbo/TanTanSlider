//
//  VipViewController.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2017/11/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_VipViewController.h"
#import "TanLiao_VipChongZhiViewController.h"

@interface TanLiao_VipViewController ()

@end

@implementation TanLiao_VipViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLale.text = @"会员";
    
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];

    self.appPurchaseTool =  [InAppPurchaseTool getInstance];
    self.appPurchaseTool.delegate = self;
    


 

    

    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH,VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height))];
    [self.view addSubview:self.mainScrollView];


 

 

    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     [self setTabBarHidden];
    [self getVipInfo];
}


-(void)getVipInfo
{
    [self.cloudClient getVIPDetailMessage:@"8903"
                                 delegate:self
                                 selector:@selector(getVipInfoSuccess:)
                            errorSelector:@selector(getVipInfoError:)];
}

-(void)getVipInfoSuccess:(NSDictionary *)info
{
    self.vipInfo = info;
    [self initUI];
}


-(void)getVipInfoError:(NSDictionary *)info
{
    
}


-(void)initUI
{
    [self.mainScrollView removeAllSubviews];


 

   

    UIImageView * vipLogoBottomView = [[UIImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-430*BILI/2)/2,10*BILI, 430*BILI/2, 112*BILI)];
    vipLogoBottomView.image = [UIImage imageNamed:@"VIP"];
    [self.mainScrollView addSubview:vipLogoBottomView];



    
    TanLiaoCustomImageView * userHeaderImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-150*BILI/2)/2, self.navView.frame.origin.y+self.navView.frame.size.height+20*BILI, 75*BILI, 75*BILI)];
    userHeaderImageView.imgType = IMAGEVIEW_TYPE_CENTER;
    userHeaderImageView.urlPath = [TanLiao_Common getCurrentAvatarpath];
    [self.mainScrollView addSubview:userHeaderImageView];



    
    UIImageView * alsoVipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(150*BILI, self.navView.frame.origin.y+self.navView.frame.size.height+158*BILI/2, 16*BILI, 16*BILI)];
    [self.mainScrollView addSubview:alsoVipImageView];



    
    UILabel * userNameLable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height+210*BILI/2, VIEW_WIDTH, 19*BILI)];
    userNameLable.textAlignment = NSTextAlignmentCenter;
    userNameLable.textColor = UIColorFromRGB(0x2C2C2C);
    userNameLable.font = [UIFont systemFontOfSize:18*BILI];
    userNameLable.text = [TanLiao_Common getCurrentUserName];




    [self.mainScrollView addSubview:userNameLable];


    
    UILabel * vipTipLable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height+133*BILI, VIEW_WIDTH, 12*BILI)];
    vipTipLable.textAlignment = NSTextAlignmentCenter;
    vipTipLable.textColor =[UIColor blackColor];


 


    vipTipLable.alpha = 0.3;
    vipTipLable.font = [UIFont systemFontOfSize:12*BILI];
    vipTipLable.text = @"加入探聊会员，专享VIP服务";
    [self.mainScrollView addSubview:vipTipLable];




    
    if (![@"true" isEqualToString:[self.vipInfo objectForKey:@"isVip"]]) {
        
        NSArray * pricesArray = [self.vipInfo objectForKey:@"prices"];
        NSArray * tagsArray = [self.vipInfo objectForKey:@"tags"];
        alsoVipImageView.image = [UIImage imageNamed:@"icon_grade_wg_n"];
        
        self.oneYearBottomButton = [[UIButton alloc] initWithFrame:CGRectMake(20*BILI, vipTipLable.frame.origin.y+vipTipLable.frame.size.height+13*BILI, 214*BILI/2, 113*BILI/2)];
        self.oneYearBottomButton.backgroundColor =UIColorFromRGB(0xF4F3F3);
        self.oneYearBottomButton.layer.cornerRadius = 4*BILI;
        self.oneYearBottomButton.layer.borderWidth = 1*BILI;
        self.oneYearBottomButton.layer.borderColor = [UIColorFromRGB(0xF4F3F3) CGColor];

        self.oneYearBottomButton.tag = 0;
        [self.oneYearBottomButton addTarget:self action:@selector(vipTypeSelect:) forControlEvents:UIControlEventTouchUpInside];

        [self.mainScrollView addSubview:self.oneYearBottomButton];
        
        UIImageView * oneYearYouHuiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 27*BILI, 12*BILI)];
        oneYearYouHuiImageView.image = [UIImage imageNamed:@"vip_youhui"];
        [self.oneYearBottomButton addSubview:oneYearYouHuiImageView];

        
        self.oneYearTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 6*BILI, 82*BILI, 21*BILI)];
        self.oneYearTitleLable.adjustsFontSizeToFitWidth = YES;
        self.oneYearTitleLable.font = [UIFont systemFontOfSize:9*BILI];
        self.oneYearTitleLable.textColor = UIColorFromRGB(0x999999);
        self.oneYearTitleLable.textAlignment = NSTextAlignmentRight;
        NSString * str = @"12 个月";
        NSAttributedString * str1 = [[NSAttributedString alloc] initWithString:str];

        NSMutableAttributedString * text1 = [[NSMutableAttributedString alloc] initWithAttributedString:str1];
        [text1 addAttribute:NSFontAttributeName
                      value:[UIFont fontWithName:@"Helvetica-Bold" size:21*BILI]
                      range:NSMakeRange(0, 2)];
        self.oneYearTitleLable.attributedText = text1;
        [self.oneYearBottomButton addSubview:self.oneYearTitleLable];

        
        self.oneYearPriceLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 30*BILI, self.oneYearBottomButton.frame.size.width, 13*BILI)];
        self.oneYearPriceLable.adjustsFontSizeToFitWidth = YES;
        self.oneYearPriceLable.font = [UIFont systemFontOfSize:13*BILI];
        self.oneYearPriceLable.textColor = UIColorFromRGB(0x999999);
        [self.oneYearBottomButton addSubview:self.oneYearPriceLable];
        self.oneYearPriceLable.textAlignment = NSTextAlignmentCenter;
        self.oneYearPriceLable.text = @"￥588";
        
        self.oneYearDiscountLable = [[UILabel alloc] initWithFrame:CGRectMake(41*BILI, self.oneYearBottomButton.frame.origin.y+97*BILI/2, 130*BILI/2, 15*BILI)];
        self.oneYearDiscountLable.textAlignment = NSTextAlignmentCenter;
        self.oneYearDiscountLable.textColor = [UIColor whiteColor];


 


        self.oneYearDiscountLable.backgroundColor = UIColorFromRGB(0xD8D8D8);
        self.oneYearDiscountLable.font = [UIFont systemFontOfSize:9*BILI];
        self.oneYearDiscountLable.layer.masksToBounds = YES;
        self.oneYearDiscountLable.layer.cornerRadius = 15*BILI/2;
        self.oneYearDiscountLable.text = [tagsArray objectAtIndex:0];
        [self.mainScrollView addSubview:self.oneYearDiscountLable];



 

        
        
        self.threeMonthBottomButton = [[UIButton alloc] initWithFrame:CGRectMake(134*BILI, vipTipLable.frame.origin.y+vipTipLable.frame.size.height+13*BILI, 214*BILI/2, 113*BILI/2)];
        self.threeMonthBottomButton.backgroundColor =UIColorFromRGB(0xF4F3F3);
        self.threeMonthBottomButton.layer.cornerRadius = 4*BILI;
        self.threeMonthBottomButton.layer.borderWidth = 1*BILI;
        self.threeMonthBottomButton.layer.borderColor = [UIColorFromRGB(0xF4F3F3) CGColor];




        self.threeMonthBottomButton.tag = 1;
        [self.threeMonthBottomButton addTarget:self action:@selector(vipTypeSelect:) forControlEvents:UIControlEventTouchUpInside];



        [self.mainScrollView addSubview:self.threeMonthBottomButton];
        
        UIImageView * threeMonthYouHuiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 27*BILI, 12*BILI)];
        threeMonthYouHuiImageView.image = [UIImage imageNamed:@"vip_youhui"];
        [self.threeMonthBottomButton addSubview:threeMonthYouHuiImageView];


        
        
        self.threeMonthTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 6*BILI, 82*BILI, 21*BILI)];
        self.threeMonthTitleLable.adjustsFontSizeToFitWidth = YES;
        self.threeMonthTitleLable.font = [UIFont systemFontOfSize:9*BILI];
        self.threeMonthTitleLable.textColor = UIColorFromRGB(0x999999);
        self.threeMonthTitleLable.textAlignment = NSTextAlignmentRight;
        str = @"3 个月";
        str1 = [[NSAttributedString alloc] initWithString:str];

        text1 = [[NSMutableAttributedString alloc] initWithAttributedString:str1];
        [text1 addAttribute:NSFontAttributeName
                      value:[UIFont fontWithName:@"Helvetica-Bold" size:21*BILI]
                      range:NSMakeRange(0, 2)];
        self.threeMonthTitleLable.attributedText = text1;
        [self.threeMonthBottomButton addSubview:self.threeMonthTitleLable];
        
        self.threeMonthPriceLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 30*BILI, self.oneYearBottomButton.frame.size.width, 13*BILI)];
        self.threeMonthPriceLable.adjustsFontSizeToFitWidth = YES;
        self.threeMonthPriceLable.font = [UIFont systemFontOfSize:13*BILI];
        self.threeMonthPriceLable.textColor = UIColorFromRGB(0x999999);
        self.threeMonthPriceLable.text = @"￥168";
        self.threeMonthPriceLable.textAlignment = NSTextAlignmentCenter;
        [self.threeMonthBottomButton addSubview:self.threeMonthPriceLable];



        
        self.threeMonthDiscountLable = [[UILabel alloc] initWithFrame:CGRectMake(310*BILI/2, self.oneYearBottomButton.frame.origin.y+97*BILI/2, 130*BILI/2, 15*BILI)];
        self.threeMonthDiscountLable.textAlignment = NSTextAlignmentCenter;
        self.threeMonthDiscountLable.textColor = [UIColor whiteColor];

        self.threeMonthDiscountLable.backgroundColor = UIColorFromRGB(0xDEB68E);
        self.threeMonthDiscountLable.font = [UIFont systemFontOfSize:9*BILI];
        self.threeMonthDiscountLable.layer.masksToBounds = YES;
        self.threeMonthDiscountLable.layer.cornerRadius = 15*BILI/2;
        self.threeMonthDiscountLable.text = [tagsArray objectAtIndex:1];
        [self.mainScrollView addSubview:self.threeMonthDiscountLable];


        
        self.oneMonthBotomButton = [[UIButton alloc] initWithFrame:CGRectMake(496*BILI/2, vipTipLable.frame.origin.y+vipTipLable.frame.size.height+13*BILI, 214*BILI/2, 113*BILI/2)];
        self.oneMonthBotomButton.backgroundColor =UIColorFromRGB(0xF4F3F3);
        self.oneMonthBotomButton.layer.cornerRadius = 4*BILI;
        self.oneMonthBotomButton.layer.borderWidth = 1*BILI;
        self.oneMonthBotomButton.layer.borderColor = [UIColorFromRGB(0xF4F3F3) CGColor];


        self.oneMonthBotomButton.tag = 2;
        [self.oneMonthBotomButton addTarget:self action:@selector(vipTypeSelect:) forControlEvents:UIControlEventTouchUpInside];


        [self.mainScrollView addSubview:self.oneMonthBotomButton];
        
        self.oneMonthTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 6*BILI, 82*BILI, 21*BILI)];
        self.oneMonthTitleLable.adjustsFontSizeToFitWidth = YES;
        self.oneMonthTitleLable.font = [UIFont systemFontOfSize:9*BILI];
        self.oneMonthTitleLable.textColor = UIColorFromRGB(0x999999);
        self.oneMonthTitleLable.textAlignment = NSTextAlignmentRight;
        str = @"1 个月";
        str1 = [[NSAttributedString alloc] initWithString:str];


        text1 = [[NSMutableAttributedString alloc] initWithAttributedString:str1];
        [text1 addAttribute:NSFontAttributeName
                      value:[UIFont fontWithName:@"Helvetica-Bold" size:21*BILI]
                      range:NSMakeRange(0, 2)];
        self.oneMonthTitleLable.attributedText = text1;
        [self.oneMonthBotomButton addSubview:self.oneMonthTitleLable];


        
        self.oneMonthPriceLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 30*BILI, self.oneYearBottomButton.frame.size.width, 13*BILI)];
        self.oneMonthPriceLable.adjustsFontSizeToFitWidth = YES;
        self.oneMonthPriceLable.font = [UIFont systemFontOfSize:13*BILI];
        self.oneMonthPriceLable.textColor = UIColorFromRGB(0x999999);
        self.oneMonthPriceLable.text = @"￥68";
        self.oneMonthPriceLable.textAlignment = NSTextAlignmentCenter;
        [self.oneMonthBotomButton addSubview:self.oneMonthPriceLable];



        
        self.oneMonthDiscountLable = [[UILabel alloc] initWithFrame:CGRectMake(538*BILI/2, self.oneYearBottomButton.frame.origin.y+97*BILI/2, 130*BILI/2, 15*BILI)];
        self.oneMonthDiscountLable.textAlignment = NSTextAlignmentCenter;
        self.oneMonthDiscountLable.textColor = [UIColor whiteColor];

        self.oneMonthDiscountLable.backgroundColor = UIColorFromRGB(0xD8D8D8);
        self.oneMonthDiscountLable.font = [UIFont systemFontOfSize:9*BILI];
        self.oneMonthDiscountLable.layer.masksToBounds = YES;
        self.oneMonthDiscountLable.layer.cornerRadius = 15*BILI/2;
        self.oneMonthDiscountLable.text = [tagsArray objectAtIndex:2];
        [self.mainScrollView addSubview:self.oneMonthDiscountLable];


        
        UIButton * kaiTongVipButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-270*BILI)/2, self.oneMonthDiscountLable.frame.origin.y+self.oneMonthDiscountLable.frame.size.height+20*BILI, 270*BILI, 35*BILI)];
        [kaiTongVipButton setBackgroundImage:[UIImage imageNamed:@"vip_kaitong_xufei"] forState:UIControlStateNormal];
        kaiTongVipButton.layer.cornerRadius = 35*BILI/2;
        [kaiTongVipButton addTarget:self action:@selector(kaiTongVIPButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.mainScrollView addSubview:kaiTongVipButton];
        
        UILabel * buttonLable  =  [[UILabel alloc] initWithFrame:CGRectMake(35*BILI, 0, kaiTongVipButton.frame.size.width-70*BILI, 35*BILI)];
        buttonLable.textAlignment = NSTextAlignmentCenter;
        buttonLable.font = [UIFont systemFontOfSize:18*BILI];
        buttonLable.textColor = [UIColor whiteColor];
        buttonLable.text = @"立即开通会员";
        [kaiTongVipButton addSubview:buttonLable];

        UIImageView * detailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, kaiTongVipButton.frame.origin.y+kaiTongVipButton.frame.size.height+20*BILI, VIEW_WIDTH, VIEW_WIDTH*2852/1125)];
        if([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
        {
            detailImageView.image = [UIImage imageNamed:@"sh_vip_xiangqing_weikaitong"];

        }
        else
        {
            detailImageView.image = [UIImage imageNamed:@"vip_xiangqing_weikaitong"];

        }
        [self.mainScrollView addSubview:detailImageView];



        
        [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, detailImageView.frame.origin.y+detailImageView.frame.size.height+10*BILI)];
        
        [self vipTypeSelect:self.threeMonthBottomButton];
        
        if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
        {
            NSMutableArray * viewArray = [NSMutableArray array];
            
            UILabel * IqciddYmvtbu = [[UILabel alloc]initWithFrame:CGRectMake(78,80,14,91)];
            IqciddYmvtbu.layer.cornerRadius =9;
            [viewArray addObject:IqciddYmvtbu];
        }
        
    }
    else
    {
        
        
        alsoVipImageView.image = [UIImage imageNamed:@"vip_grade_wg_h"];
        
        
        UIButton * kaiTongVipButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-270*BILI)/2, self.navView.frame.origin.y+self.navView.frame.size.height+318*BILI/2, 270*BILI, 35*BILI)];
        [kaiTongVipButton setBackgroundImage:[UIImage imageNamed:@"vip_kaitong_xufei"] forState:UIControlStateNormal];
        [kaiTongVipButton addTarget:self action:@selector(xuFeiButtonClick) forControlEvents:UIControlEventTouchUpInside];


 

        kaiTongVipButton.layer.cornerRadius = 35*BILI/2;
        [self.mainScrollView addSubview:kaiTongVipButton];
        
        UILabel * buttonLable  =  [[UILabel alloc] initWithFrame:CGRectMake(25*BILI, 0, kaiTongVipButton.frame.size.width-70*BILI, 35*BILI)];
        buttonLable.font = [UIFont systemFontOfSize:16*BILI];
        buttonLable.textColor = [UIColor whiteColor];




        buttonLable.text = [NSString stringWithFormat:@"到期(%@)",[self.vipInfo objectForKey:@"vipExpiredDate"]];
        [kaiTongVipButton addSubview:buttonLable];


 

        
        UIButton * xuFeiButton = [[UIButton alloc] initWithFrame:CGRectMake(kaiTongVipButton.frame.size.width-25*BILI-36*BILI, 0, 40*BILI, 35*BILI)];
        [xuFeiButton setTitleColor:UIColorFromRGB(0x848484) forState:UIControlStateNormal];
        [xuFeiButton setTitle:@"续费" forState:UIControlStateNormal];
        xuFeiButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
        [xuFeiButton addTarget:self action:@selector(xuFeiButtonClick) forControlEvents:UIControlEventTouchUpInside];


 

        [kaiTongVipButton addSubview:xuFeiButton];
        
        
        
        UIButton * lingQuJinBiButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-270*BILI)/2, kaiTongVipButton.frame.origin.y+kaiTongVipButton.frame.size.height+15*BILI, 270*BILI, 35*BILI)];
        [lingQuJinBiButton setBackgroundImage:[UIImage imageNamed:@"vip_kaitong_xufei"] forState:UIControlStateNormal];
        lingQuJinBiButton.layer.cornerRadius = 35*BILI/2;
        [lingQuJinBiButton addTarget:self action:@selector(lingQuJinBiButtonClick) forControlEvents:UIControlEventTouchUpInside];




        [self.mainScrollView addSubview:lingQuJinBiButton];
        
        UILabel * lingQuJinBiButtonLable  =  [[UILabel alloc] initWithFrame:CGRectMake(25*BILI, 0, kaiTongVipButton.frame.size.width-70*BILI, 35*BILI)];
        lingQuJinBiButtonLable.font = [UIFont systemFontOfSize:16*BILI];
        lingQuJinBiButtonLable.textColor = [UIColor whiteColor];


 

   

        lingQuJinBiButtonLable.text = [NSString stringWithFormat:@"%@",@"领取今日奖励"];
        [lingQuJinBiButton addSubview:lingQuJinBiButtonLable];



        
        UIImageView * lingQuJinBiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(210*BILI, 17*BILI/2, 18*BILI, 18*BILI)];
        lingQuJinBiImageView.image = [UIImage imageNamed:@"vip_icon_jinbi"];
        [lingQuJinBiButton addSubview:lingQuJinBiImageView];



 

        
        
        UILabel * lingQuJinBiNumberLable = [[UILabel alloc] initWithFrame:CGRectMake(lingQuJinBiImageView.frame.origin.x+lingQuJinBiImageView.frame.size.height, 17*BILI/2, 100, 18*BILI)];
        lingQuJinBiNumberLable.font = [UIFont systemFontOfSize:18*BILI];
        lingQuJinBiNumberLable.textColor = UIColorFromRGB(0x848484);
        [lingQuJinBiButton addSubview:lingQuJinBiNumberLable];




        
        UIImageView * detailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, lingQuJinBiButton.frame.origin.y+lingQuJinBiButton.frame.size.height+20*BILI, VIEW_WIDTH, VIEW_WIDTH*2852/1125)];
        if([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
        {
            detailImageView.image = [UIImage imageNamed:@"sh_vip_xiangqing_yikaitong"];
        }
        else
        {
            detailImageView.image = [UIImage imageNamed:@"vip_xiangqing_yikaitong"];

        }
        [self.mainScrollView addSubview:detailImageView];
        

 

        
        //今日金币未领取
        if ([@"1" isEqualToString:[self.vipInfo objectForKey:@"isNeedVipHint"]])
        {
            NSString * bonusGold = [self.vipInfo objectForKey:@"bonusGold"];
            lingQuJinBiNumberLable.text = [NSString stringWithFormat:@"x%d",bonusGold.intValue/100];
            
        }
        else
        {
            lingQuJinBiButton.hidden = YES;
            detailImageView.frame = CGRectMake(0, kaiTongVipButton.frame.origin.y+kaiTongVipButton.frame.size.height+20*BILI, VIEW_WIDTH, VIEW_WIDTH*2670/1125);
        }
        
        
        
        [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, detailImageView.frame.origin.y+detailImageView.frame.size.height+10*BILI)];
    }
}
-(void)vipTypeSelect:(id)sender
{
    UIButton * button = (UIButton *)sender;
    switch (button.tag) {
        case 0:
            self.vipType = @"3";
            self.oneYearBottomButton.layer.borderColor = [UIColorFromRGB(0xDEB68E) CGColor];
            self.oneYearBottomButton.backgroundColor = UIColorFromRGB(0xFFFEFC);
            self.oneYearTitleLable.textColor = UIColorFromRGB(0xDEB68E);
            self.oneYearPriceLable.textColor = UIColorFromRGB(0xDEB68E);
            self.oneYearDiscountLable.backgroundColor = UIColorFromRGB(0xDEB68E);

            
            self.threeMonthBottomButton.layer.borderColor = [UIColorFromRGB(0xF4F3F3) CGColor];

            self.threeMonthBottomButton.backgroundColor = UIColorFromRGB(0xF4F3F3);
            self.threeMonthTitleLable.textColor = UIColorFromRGB(0x999999);
            self.threeMonthPriceLable.textColor = UIColorFromRGB(0x999999);
            self.threeMonthDiscountLable.backgroundColor = UIColorFromRGB(0xD8D8D8);

            
            self.oneMonthBotomButton.layer.borderColor = [UIColorFromRGB(0xF4F3F3) CGColor];

            self.oneMonthBotomButton.backgroundColor = UIColorFromRGB(0xF4F3F3);
            self.oneMonthTitleLable.textColor = UIColorFromRGB(0x999999);
            self.oneMonthPriceLable.textColor = UIColorFromRGB(0x999999);
            self.oneMonthDiscountLable.backgroundColor = UIColorFromRGB(0xD8D8D8);

            break;
        case 1:
            self.vipType = @"2";
            self.oneYearBottomButton.layer.borderColor = [UIColorFromRGB(0xF4F3F3) CGColor];

            self.oneYearBottomButton.backgroundColor = UIColorFromRGB(0xF4F3F3);
            self.oneYearTitleLable.textColor = UIColorFromRGB(0x999999);
            self.oneYearPriceLable.textColor = UIColorFromRGB(0x999999);
            self.oneYearDiscountLable.backgroundColor = UIColorFromRGB(0xD8D8D8);

            
            self.threeMonthBottomButton.layer.borderColor = [UIColorFromRGB(0xDEB68E) CGColor];
            self.threeMonthBottomButton.backgroundColor = UIColorFromRGB(0xFFFEFC);
            self.threeMonthTitleLable.textColor = UIColorFromRGB(0xDEB68E);
            self.threeMonthPriceLable.textColor = UIColorFromRGB(0xDEB68E);
            self.threeMonthDiscountLable.backgroundColor = UIColorFromRGB(0xDEB68E);

            
            self.oneMonthBotomButton.layer.borderColor = [UIColorFromRGB(0xF4F3F3) CGColor];
            self.oneMonthBotomButton.backgroundColor = UIColorFromRGB(0xF4F3F3);
            self.oneMonthTitleLable.textColor = UIColorFromRGB(0x999999);
            self.oneMonthPriceLable.textColor = UIColorFromRGB(0x999999);
            self.oneMonthDiscountLable.backgroundColor = UIColorFromRGB(0xD8D8D8);


            break;

        case 2:
            self.vipType = @"1";
            self.oneYearBottomButton.layer.borderColor = [UIColorFromRGB(0xF4F3F3) CGColor];
            self.oneYearBottomButton.backgroundColor = UIColorFromRGB(0xF4F3F3);
            self.oneYearTitleLable.textColor = UIColorFromRGB(0x999999);
            self.oneYearPriceLable.textColor = UIColorFromRGB(0x999999);
            self.oneYearDiscountLable.backgroundColor = UIColorFromRGB(0xD8D8D8);

            
            self.threeMonthBottomButton.layer.borderColor = [UIColorFromRGB(0xF4F3F3) CGColor];
            self.threeMonthBottomButton.backgroundColor = UIColorFromRGB(0xF4F3F3);
            self.threeMonthTitleLable.textColor = UIColorFromRGB(0x999999);
            self.threeMonthPriceLable.textColor = UIColorFromRGB(0x999999);
            self.threeMonthDiscountLable.backgroundColor = UIColorFromRGB(0xD8D8D8);

            
            self.oneMonthBotomButton.layer.borderColor = [UIColorFromRGB(0xDEB68E) CGColor];

            self.oneMonthBotomButton.backgroundColor = UIColorFromRGB(0xFFFEFC);
            self.oneMonthTitleLable.textColor = UIColorFromRGB(0xDEB68E);
            self.oneMonthPriceLable.textColor = UIColorFromRGB(0xDEB68E);
            self.oneMonthDiscountLable.backgroundColor = UIColorFromRGB(0xDEB68E);


            break;

            
        default:
            break;
    }
}
-(void)xuFeiButtonClick
{
    TanLiao_VipChongZhiViewController * vipChongZhiVC = [[TanLiao_VipChongZhiViewController alloc] init];
    [self.navigationController pushViewController:vipChongZhiVC animated:YES];
}
-(void)lingQuJinBiButtonClick
{
    [self.cloudClient vipGetJinBi:@"8904"
                         delegate:self
                         selector:@selector(lingQuSuccess:)
                    errorSelector:@selector(lingQuError:)];
}
-(void)lingQuSuccess:(NSDictionary *)info
{
    [TanLiao_Common showToastView:@"今日金币已领取" view:self.view];

    [self getVipInfo];
}
-(void)lingQuError:(NSDictionary *)info
{
    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];



}
//1239   参数type    会员类型  type 1=>月   2=>季度    3=>年
-(void)kaiTongVIPButtonClick
{
    [self showNewLoadingView:@"处理中,请稍后..." view:self.view];
    NSString * type;
    NSString * price;
    if ([@"3" isEqualToString:self.vipType]) {
        
        price = @"588";
        self.productID = @"vip1n";
        type = @"3";
    }
    else if ([@"2" isEqualToString:self.vipType])
    {
        price = @"168";
        self.productID = @"vip3g";
        type = @"2";
    }
    else if ([@"1" isEqualToString:self.vipType])
    {
        price = @"68";
        self.productID = @"vip1g";
        type = @"1";
    }
    
  [self.cloudClient kaiTongVipByYuE:@"1239"
                               type:type
                           delegate:self
                           selector:@selector(kaiTongSuccess:)
                      errorSelector:@selector(kaiTongError:)];
//    [self.cloudClient getMhtCharge:@"8093"
//                          currency:@"1"
//                            amount:price
//                           channel:@"3"
//                        chargeType:self.vipType
//                          delegate:self
//                          selector:@selector(getChargeSuccess:)
//                     errorSelector:@selector(getChargeError:)];


}
-(void)kaiTongSuccess:(NSDictionary *)info
{
    [self hideNewLoadingView];
    [self getVipInfo];
    [TanLiao_Common showToastView:@"VIP开通成功" view:self.view];

}
-(void)kaiTongError:(NSDictionary *)info
{
    [self hideNewLoadingView];
    if([@"-969" isEqualToString:[info objectForKey:@"code"]])
    {
        TanLiaoLiao_YuEBuZuView * tipView = [[TanLiaoLiao_YuEBuZuView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
        tipView.delegate = self;
        [self.view addSubview:tipView];
        
    }
    else
    {
        [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];

    }
}
-(void)YuEBuZuPushToRechargeView
{
    TanLiao_RechargeViewController * rechargeVC = [[TanLiao_RechargeViewController alloc] init];
    rechargeVC.payChannel = @"appPay";
    rechargeVC.delegate = self;
    [self.navigationController pushViewController:rechargeVC animated:YES];
    
}
-(void)chongZhiSuccess
{
    [TanLiao_Common showToastView:@"充值成功" view:self.view];
}
-(void)getChargeSuccess:(NSDictionary *)info
{

    NSDictionary * charge =  [TanLiao_Common dictionaryWithJsonString:[info objectForKey:@"result"]];
    self.out_trade_no = [charge objectForKey:@"out_trade_no"];
    [self.appPurchaseTool startPurchase:self.productID];
    
}
-(void)purchaseSuccess:(NSString *)base64Str
{
    [self showNewLoadingView:@"验证支付结果..." view:self.view];
    [self.cloudClient getAppPayResult:@"8908"
                              orderNo:self.out_trade_no
                              receipt:base64Str
                             delegate:self
                             selector:@selector(getResultSuccess:)
                        errorSelector:@selector(getResultError:)];
    
}
-(void)purchaseError:(NSString *)errorStr
{
    [self hideNewLoadingView];
}

-(void)getResultSuccess:(NSDictionary *)info
{
    self.out_trade_no = nil;
    [self hideNewLoadingView];


    if ([@"0" isEqualToString:[info objectForKey:@"retCode"]]) {
        [self getVipInfo];
        [TanLiao_Common showToastView:@"VIP开通成功" view:self.view];

    }
    else
    {
        [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];
    }
    
}


-(void)getResultError:(NSDictionary *)info
{
    [self hideNewLoadingView];


 

 

    if (![@"参数类型转换异常,请检查请求APP参数或后台中间参数!"isEqualToString:[info objectForKey:@"message"]]) {
        [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];



 

    }
    
}



-(void)getChargeError:(NSDictionary *)info
{
    [self hideNewLoadingView];

    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];


 
if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
{
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@(493)];
    [array addObject:@(372)];
    [array addObject:@(922)];
    [array addObject:@(291)];
    [array addObject:@(275)];
    [array addObject:@(647)];
}
 

    
}
-(void)initDataAptaPohfVC:(NSDictionary *)info
{
    NSMutableArray * viewArray = [NSMutableArray array];

    UIScrollView * RkspPwut = [[UIScrollView alloc]initWithFrame:CGRectMake(78,79,51,60)];
    RkspPwut.layer.cornerRadius =8;
    [viewArray addObject:RkspPwut];
    
    UIScrollView * EmaxkrApgyqu = [[UIScrollView alloc]initWithFrame:CGRectMake(25,96,95,36)];
    EmaxkrApgyqu.layer.cornerRadius =6;
    [viewArray addObject:EmaxkrApgyqu];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
