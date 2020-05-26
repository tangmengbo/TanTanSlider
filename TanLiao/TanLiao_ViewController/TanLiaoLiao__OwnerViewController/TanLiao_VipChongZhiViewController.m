//
//  VipChongZhiViewController.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2017/11/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_VipChongZhiViewController.h"

@interface TanLiao_VipChongZhiViewController ()

@end

@implementation TanLiao_VipChongZhiViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLale.text = @"会员续费";
    
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];
    self.appPurchaseTool =  [InAppPurchaseTool getInstance];
    self.appPurchaseTool.delegate = self;




    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getWeiXinZFResult) name:@"GetWeiXinZFResult" object:nil];
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH,VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height))];
    [self.view addSubview:self.mainScrollView];


    
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
    
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        NSMutableArray * viewArray = [NSMutableArray array];
        
        UIView * IyevAico = [[UIView alloc]initWithFrame:CGRectMake(47,40,74,60)];
        IyevAico.layer.cornerRadius =6;
        [viewArray addObject:IyevAico];
    }
    
    [self.mainScrollView removeAllSubviews];

    NSArray * pricesArray = [self.vipInfo objectForKey:@"prices"];
    NSArray * tagsArray = [self.vipInfo objectForKey:@"tags"];

    
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT)];
    bottomView.backgroundColor = [UIColor blackColor];
    bottomView.alpha = 0.05;
    [self.mainScrollView addSubview:bottomView];

    
    UIView * whiteBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, 495*BILI/2)];
    whiteBottomView.backgroundColor = [UIColor whiteColor];
    [self.mainScrollView addSubview:whiteBottomView];


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
    alsoVipImageView.image = [UIImage imageNamed:@"icon_grade_wg_h"];
    
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
    NSString * oneYearPrice = [pricesArray objectAtIndex:0];
    self.oneYearPriceLable.text = [NSString stringWithFormat:@"￥%.2f",oneYearPrice.floatValue/100];
    self.oneYearPriceLable.textAlignment = NSTextAlignmentCenter;
    [self.oneYearBottomButton addSubview:self.oneYearPriceLable];



    
    self.oneYearDiscountLable = [[UILabel alloc] initWithFrame:CGRectMake(41*BILI, self.oneYearBottomButton.frame.origin.y+97*BILI/2, 130*BILI/2, 15*BILI)];
    self.oneYearDiscountLable.textAlignment = NSTextAlignmentCenter;
    self.oneYearDiscountLable.textColor = [UIColor whiteColor];


 


    self.oneYearDiscountLable.backgroundColor = UIColorFromRGB(0xDEB68E);
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
    NSString * threeMonthPrice = [pricesArray objectAtIndex:1];
    self.threeMonthPriceLable.text = [NSString stringWithFormat:@"￥%.2f",threeMonthPrice.floatValue/100];
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
    NSString * oneMonthPrice = [pricesArray objectAtIndex:2];
    self.oneMonthPriceLable.text = [NSString stringWithFormat:@"￥%.2f",oneMonthPrice.floatValue/100];
    self.oneMonthPriceLable.textAlignment = NSTextAlignmentCenter;
    [self.oneMonthBotomButton addSubview:self.oneMonthPriceLable];




    
    self.oneMonthDiscountLable = [[UILabel alloc] initWithFrame:CGRectMake(538*BILI/2, self.oneYearBottomButton.frame.origin.y+97*BILI/2, 130*BILI/2, 15*BILI)];
    self.oneMonthDiscountLable.textAlignment = NSTextAlignmentCenter;
    self.oneMonthDiscountLable.textColor = [UIColor whiteColor];


   

    self.oneMonthDiscountLable.backgroundColor = UIColorFromRGB(0xD8D8D8);
    self.oneMonthDiscountLable.font = [UIFont systemFontOfSize:9*BILI];
    self.oneMonthDiscountLable.layer.masksToBounds = YES;
    self.oneMonthDiscountLable.layer.cornerRadius = 15*BILI/2;
    self.oneMonthDiscountLable.text = [tagsArray objectAtIndex:2];;
    [self.mainScrollView addSubview:self.oneMonthDiscountLable];




    
    UIButton * kaiTongButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-290*BILI)/2, whiteBottomView.frame.origin.y+whiteBottomView.frame.size.height+40*BILI, 290*BILI, 45*BILI)];
    [kaiTongButton setBackgroundImage:[UIImage imageNamed:@"vip_kaitong_xufei"] forState:UIControlStateNormal];
    [kaiTongButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [kaiTongButton setTitle: [NSString stringWithFormat:@"到期(%@)",[self.vipInfo objectForKey:@"vipExpiredDate"]] forState:UIControlStateNormal];
    [kaiTongButton addTarget:self action:@selector(kaiTongVIPButtonClick) forControlEvents:UIControlEventTouchUpInside];




    [self.mainScrollView addSubview:kaiTongButton];
    
    
//    CGSize size = [Common setSize:@"充值开通即视为同意" withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_HEIGHT) withFontSize:12*BILI];
//    UILabel * shuoMingLable = [[UILabel alloc] initWithFrame:CGRectMake(183*BILI/2, kaiTongButton.frame.origin.y+kaiTongButton.frame.size.height+11*BILI, size.width, 12*BILI)];
//    shuoMingLable.text = @"充值开通即视为同意";
//    shuoMingLable.font = [UIFont systemFontOfSize:12*BILI];
//    shuoMingLable.textColor = [UIColor blackColor];



//    shuoMingLable.alpha = 0.5;
//    [self.mainScrollView addSubview:shuoMingLable];




//    
//    UILabel * shuoMingLable1 = [[UILabel alloc] initWithFrame:CGRectMake(shuoMingLable.frame.origin.x+shuoMingLable.frame.size.width, kaiTongButton.frame.origin.y+kaiTongButton.frame.size.height+23*BILI/2, size.width, 12*BILI)];
//    shuoMingLable1.text = @"会员免责说明";
//    shuoMingLable1.font = [UIFont systemFontOfSize:12*BILI];
//    shuoMingLable1.textColor = UIColorFromRGB(0xF85BA3 );
//    [self.mainScrollView addSubview:shuoMingLable1];
    
    [self vipTypeSelect:self.threeMonthBottomButton];

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
-(void)kaiTongVIPButtonClick
{
    [self showNewLoadingView:@"处理中,请稍后..." view:self.view];

    NSString * price;
    NSString * type;
    if ([@"3" isEqualToString:self.vipType]) {
        type = @"3";
        price = @"588";
        self.productID = @"vip1n";
    }
    else if ([@"2" isEqualToString:self.vipType])
    {
        type = @"2";
        price = @"168";
        self.productID = @"vip3g";
    }
    else if ([@"1" isEqualToString:self.vipType])
    {
        type = @"1";
        price = @"68";
        self.productID = @"vip1g";
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
        [TanLiao_Common showToastView:@"VIP续费成功" view:self.view];

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initDataAptaPohfVC:(NSDictionary *)info
{
    
    NSMutableArray * viewArray = [NSMutableArray array];
    
    UIView * IyevAico = [[UIView alloc]initWithFrame:CGRectMake(49,20,94,22)];
    IyevAico.layer.cornerRadius =7;
    [viewArray addObject:IyevAico];
    
    UILabel * ZbvnvuCsjfqg = [[UILabel alloc]initWithFrame:CGRectMake(41,70,18,70)];
    ZbvnvuCsjfqg.layer.cornerRadius =7;
    [viewArray addObject:ZbvnvuCsjfqg];
}

@end
