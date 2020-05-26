//
//  AnchorShouHuListViewController.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/6/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiaoLiao_AnchorShouHuListViewController.h"
#import "TanLiaoLiao_ShouHuListTableViewCell.h"

@interface TanLiaoLiao_AnchorShouHuListViewController ()

@end

@implementation TanLiaoLiao_AnchorShouHuListViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    [self.view addSubview:self.mainScrollView];


 


    
    [self setTabBarHidden];
    
    [self initNavView];


 

    
    [self initTopView];


 

 


    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];


 

 

    [self.cloudClient getGiftList:@"8019"
                         delegate:self
                         selector:@selector(getGiftListSuccess:)
                    errorSelector:@selector(getGiftListError:)];
    
    if (![self.sourceArray isKindOfClass:[NSArray class]])
    {
        [self.cloudClient getShouHuList:@"8913"
                               anchorId:self.userId
                               delegate:self
                               selector:@selector(getShouHuListSuccess:)
                          errorSelector:@selector(getShouHuListError:)];
    }

}

-(void)initNavView
{
    self.navView.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;//scrollview 20像素问题
    UIImageView  *navView = [[UIImageView alloc] init];


 


    [navView setFrame:CGRectMake(0, 0,  VIEW_WIDTH, 64)];
    navView.userInteractionEnabled = YES;
    navView.image = [UIImage imageNamed:@"anchorDetailpic_mask_nav"];
    [self.view addSubview:navView];


 


    if (SafeAreaTopHeight==35) {
        navView.frame = CGRectMake(0, 0, VIEW_WIDTH, 64+15);
    }
    self.leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0,  SafeAreaTopHeight, 60, 40)];
    [self.leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];


 


    [self.view addSubview:self.leftButton];
    
    UIImageView * backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12*BILI, (40-18)/2, 18*BILI, 18*BILI)];
    backImageView.image = [UIImage imageNamed:@"shouHu_btn_back_n"];
    [self.leftButton addSubview:backImageView];


 


    
    UILabel * backLable = [[UILabel alloc] initWithFrame:CGRectMake(backImageView.frame.origin.x+backImageView.frame.size.width+7*BILI, backImageView.frame.origin.y+1.5*BILI, 40*BILI, 15*BILI)];
    backLable.font = [UIFont systemFontOfSize:15*BILI];
    backLable.textColor = [UIColor whiteColor];


 


    backLable.text = @"返回";
    [self.leftButton addSubview:backLable];



}
-(void)leftClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)initTopView
{
    
    [self.mainScrollView removeAllSubviews];


 


    
    UIImageView * bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_WIDTH*2148/750)];
    bottomImageView.image = [UIImage imageNamed:@"shouHu_BG"];
    [self.mainScrollView addSubview:bottomImageView];


 


    
    UIButton * sendGiftButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-218*BILI/2, 204*BILI, 218*BILI/2, 218*BILI/2)];
    [sendGiftButton setBackgroundImage:[UIImage imageNamed:@"shouHu_sendGift"] forState:UIControlStateNormal];
    [sendGiftButton addTarget:self action:@selector(sendGiftButtonClick) forControlEvents:UIControlEventTouchUpInside];


 

 

    [self.mainScrollView addSubview:sendGiftButton];
    
    UIView * tipLableBottomView = [[UIView alloc] initWithFrame:CGRectMake(80*BILI, 558*BILI/2, 430*BILI/2, 24*BILI)];
    tipLableBottomView.backgroundColor = [UIColor whiteColor];



    tipLableBottomView.alpha = 0.7;
    tipLableBottomView.layer.masksToBounds = YES;
    tipLableBottomView.layer.cornerRadius = 12*BILI;
    [self.mainScrollView addSubview:tipLableBottomView];



    
    
    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(80*BILI, 558*BILI/2, 430*BILI/2, 24*BILI)];
    tipLable.backgroundColor = [UIColor clearColor];



   

    tipLable.textAlignment = NSTextAlignmentCenter;
    tipLable.font = [UIFont systemFontOfSize:12*BILI];
    tipLable.textColor = UIColorFromRGB(0x323232);
    tipLable.text = @"赠送礼物,快来支持你的小仙女吧~";
    [self.mainScrollView addSubview:tipLable];



    
    UIView * topThreeBotomAlphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 313*BILI, VIEW_WIDTH, 467*BILI/2+1000)];
    topThreeBotomAlphaView.backgroundColor = [UIColor whiteColor];


 

    topThreeBotomAlphaView.layer.masksToBounds = YES;
    topThreeBotomAlphaView.layer.cornerRadius = 40*BILI;
    topThreeBotomAlphaView.alpha = 0.8;
    [self.mainScrollView addSubview:topThreeBotomAlphaView];


 

 

    
    self.topThreeBotomView = [[UIView alloc] initWithFrame:CGRectMake(0, 313*BILI, VIEW_WIDTH, 467*BILI/2+300)];
    self.topThreeBotomView.backgroundColor = [UIColor clearColor];


 


    self.topThreeBotomView.layer.masksToBounds = YES;
    self.topThreeBotomView.layer.cornerRadius = 40*BILI;
    [self.mainScrollView addSubview:self.topThreeBotomView];




    
    //////////第二名
    if (self.sourceArray.count>=2) {
        
        NSDictionary * info = [self.sourceArray objectAtIndex:1];
        NSDictionary * userInfo = [info objectForKey:@"user"];
        TanLiaoCustomImageView * numberimageView2 = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(65*BILI/2, 70*BILI, 80*BILI, 80*BILI)];
        numberimageView2.imgType = IMAGEVIEW_TYPE_CENTER;
        numberimageView2.urlPath = [userInfo objectForKey:@"avatarUrl"];
        numberimageView2.contentMode = UIViewContentModeScaleAspectFill;
        numberimageView2.userInteractionEnabled = YES;
        [self.topThreeBotomView addSubview:numberimageView2];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(secondHeaderTap)];
        [numberimageView2 addGestureRecognizer:tap];
        
        
        UIImageView * numberImageViewHuangGuan1 = [[UIImageView alloc] initWithFrame:CGRectMake(61*BILI/2, 55*BILI,  86*BILI/2, 68*BILI/2)];
        numberImageViewHuangGuan1.image= [UIImage imageNamed:@"pic_no2_txt"];
        [self.topThreeBotomView addSubview:numberImageViewHuangGuan1];
        
        UIImageView * numberImageViewHuangGuan2 = [[UIImageView alloc] initWithFrame:CGRectMake(126*BILI/2, 50*BILI, 41*BILI, 24*BILI)];
        numberImageViewHuangGuan2.image = [UIImage imageNamed:@"pic_no2"];
        [self.topThreeBotomView addSubview:numberImageViewHuangGuan2];
        
        
        UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(numberimageView2.frame.origin.x, numberimageView2.frame.origin.y+numberimageView2.frame.size.height+8*BILI, numberimageView2.frame.size.width, 13*BILI)];
        nameLable.font = [UIFont systemFontOfSize:12*BILI];
        nameLable.textColor = UIColorFromRGB(0x777777);
        nameLable.textAlignment = NSTextAlignmentCenter;
        nameLable.text =[userInfo objectForKey:@"nick"];
        [self.topThreeBotomView addSubview:nameLable];


 


        
        if([@"1" isEqualToString:[info objectForKey:@"isVip"]])//
        {
            nameLable.textColor = UIColorFromRGB(0xFF0000);
            
            CGSize nameSize = [TanLiao_Common setSize:[userInfo objectForKey:@"nick"] withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_WIDTH) withFontSize:12*BILI];
            
            if (nameSize.width>numberimageView2.frame.size.width) {
                
                nameSize.width = numberimageView2.size.width;
            }
            
            UIImageView * vipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(nameLable.frame.origin.x+(numberimageView2.frame.size.width-nameSize.width)/2+nameSize.width+3*BILI, nameLable.frame.origin.y-3*BILI, 18*BILI, 18*BILI)];
            vipImageView.image = [UIImage imageNamed:@"vip_grade_wg_h"];
            [self.topThreeBotomView addSubview:vipImageView];


 


        }
        
        
        
        
        UIImageView * alsoBusyImageView = [[UIImageView alloc] initWithFrame:CGRectMake((numberimageView2.frame.size.width-40*BILI)/2+numberimageView2.frame.origin.x, nameLable.frame.origin.y+nameLable.frame.size.height+6*BILI, 40*BILI, 15*BILI)];
        [self.topThreeBotomView addSubview:alsoBusyImageView];


 


        
        NSNumber * onLineStatus = [userInfo objectForKey:@"onlineStatus"];
        
        if([@"1" isEqualToString:[NSString stringWithFormat:@"%d",onLineStatus.intValue]])//
        {
            //空闲
            alsoBusyImageView.image = [UIImage imageNamed:@"shouHuList_free"];
            
        }
        else
        {
             alsoBusyImageView.image = [UIImage imageNamed:@"shouHuList_busy"];
        }
         UIImageView * dunPaiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(numberimageView2.frame.origin.x+13*BILI, alsoBusyImageView.frame.origin.y+alsoBusyImageView.frame.size.height+6*BILI, 15*BILI, 15*BILI)];
        dunPaiImageView.image = [UIImage imageNamed:@"shouHuList_dun"];
        [self.topThreeBotomView addSubview:dunPaiImageView];



        
        UILabel * xingGuanZhiLable = [[UILabel alloc] initWithFrame:CGRectMake(dunPaiImageView.frame.origin.x+dunPaiImageView.frame.size.width, dunPaiImageView.frame.origin.y,numberimageView2.frame.size.width-dunPaiImageView.frame.size.width-13*BILI, 15*BILI)];
        xingGuanZhiLable.adjustsFontSizeToFitWidth = YES;
        xingGuanZhiLable.textAlignment = NSTextAlignmentCenter;
        xingGuanZhiLable.font = [UIFont systemFontOfSize:15*BILI];
        xingGuanZhiLable.textColor = UIColorFromRGB(0xBC9E5D);
        NSNumber * scoreNumber = [info objectForKey:@"score"];
        xingGuanZhiLable.text = [NSString stringWithFormat:@"%d",scoreNumber.intValue];


 


        [self.topThreeBotomView addSubview:xingGuanZhiLable];



 

        
        
    }
    else
    {
        TanLiaoCustomImageView * numberimageView2 = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(65*BILI/2, 70*BILI, 80*BILI, 80*BILI)];
        numberimageView2.imgType = IMAGEVIEW_TYPE_CENTER;
        numberimageView2.image = [UIImage imageNamed:@"shouHu_NO 1"];
        numberimageView2.contentMode = UIViewContentModeScaleAspectFill;
        numberimageView2.userInteractionEnabled = YES;
        [self.topThreeBotomView addSubview:numberimageView2];
        
        UIImageView * numberImageViewHuangGuan1 = [[UIImageView alloc] initWithFrame:CGRectMake(61*BILI/2, 55*BILI,  86*BILI/2, 68*BILI/2)];
        numberImageViewHuangGuan1.image= [UIImage imageNamed:@"pic_no2_txt"];
        [self.topThreeBotomView addSubview:numberImageViewHuangGuan1];
        
        UIImageView * numberImageViewHuangGuan2 = [[UIImageView alloc] initWithFrame:CGRectMake(126*BILI/2, 50*BILI, 41*BILI, 24*BILI)];
        numberImageViewHuangGuan2.image = [UIImage imageNamed:@"pic_no2"];
        [self.topThreeBotomView addSubview:numberImageViewHuangGuan2];
        
        
        UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(numberimageView2.frame.origin.x, numberimageView2.frame.origin.y+numberimageView2.frame.size.height+19*BILI, numberimageView2.frame.size.width, 15*BILI)];
        nameLable.font = [UIFont systemFontOfSize:15*BILI];
        nameLable.textColor = UIColorFromRGB(0x9F9F9F);
        nameLable.textAlignment = NSTextAlignmentCenter;
        nameLable.text = @"虚位以待";
        [self.topThreeBotomView addSubview:nameLable];


 
 

    }
    
    
    //////第一名
    if(self.sourceArray.count>=1)
    {
        NSDictionary * info = [self.sourceArray objectAtIndex:0];
        NSDictionary * userInfo = [info objectForKey:@"user"];

        
        TanLiaoCustomImageView * numberimageView2 = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(285*BILI/2, 45*BILI, 90*BILI, 90*BILI)];
        numberimageView2.imgType = IMAGEVIEW_TYPE_CENTER;
        numberimageView2.urlPath = [userInfo objectForKey:@"avatarUrl"];
        numberimageView2.contentMode = UIViewContentModeScaleAspectFill;
        numberimageView2.userInteractionEnabled = YES;
        [self.topThreeBotomView addSubview:numberimageView2];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(firstHeaderTap)];
        [numberimageView2 addGestureRecognizer:tap];
        
        UIImageView * numberImageViewHuangGuan1 = [[UIImageView alloc] initWithFrame:CGRectMake(279*BILI/2, 29*BILI,  86*BILI/2, 68*BILI/2)];
        numberImageViewHuangGuan1.image= [UIImage imageNamed:@"pic_no1_txt"];
        [self.topThreeBotomView addSubview:numberImageViewHuangGuan1];
        
        UIImageView * numberImageViewHuangGuan2 = [[UIImageView alloc] initWithFrame:CGRectMake(360*BILI/2, 25*BILI, 41*BILI, 24*BILI)];
        numberImageViewHuangGuan2.image = [UIImage imageNamed:@"pic_no1"];
        [self.topThreeBotomView addSubview:numberImageViewHuangGuan2];
        
        
        UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(numberimageView2.frame.origin.x, numberimageView2.frame.origin.y+numberimageView2.frame.size.height+10*BILI, numberimageView2.frame.size.width, 13*BILI)];
        nameLable.font = [UIFont systemFontOfSize:12*BILI];
        nameLable.textColor = UIColorFromRGB(0x777777);
        nameLable.textAlignment = NSTextAlignmentCenter;
        nameLable.text = [userInfo objectForKey:@"nick"];;
        [self.topThreeBotomView addSubview:nameLable];


        
        if([@"1" isEqualToString:[info objectForKey:@"isVip"]])//
        {
            nameLable.textColor = UIColorFromRGB(0xFF0000);
            
            CGSize nameSize = [TanLiao_Common setSize:[userInfo objectForKey:@"nick"] withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_WIDTH) withFontSize:12*BILI];
            
            if (nameSize.width>numberimageView2.frame.size.width) {
                
                nameSize.width = numberimageView2.size.width;
            }
            
            UIImageView * vipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(nameLable.frame.origin.x+(numberimageView2.frame.size.width-nameSize.width)/2+nameSize.width+3*BILI, nameLable.frame.origin.y-3*BILI, 18*BILI, 18*BILI)];
            vipImageView.image = [UIImage imageNamed:@"vip_grade_wg_h"];
            [self.topThreeBotomView addSubview:vipImageView];


 


        }
        
        
        UIImageView * alsoBusyImageView = [[UIImageView alloc] initWithFrame:CGRectMake((numberimageView2.frame.size.width-40*BILI)/2+numberimageView2.frame.origin.x, nameLable.frame.origin.y+nameLable.frame.size.height+6*BILI, 40*BILI, 15*BILI)];
        [self.topThreeBotomView addSubview:alsoBusyImageView];




        
        
        
        NSNumber * onLineStatus = [userInfo objectForKey:@"onlineStatus"];
        
        if([@"1" isEqualToString:[NSString stringWithFormat:@"%d",onLineStatus.intValue]])//
        {
            //空闲
            alsoBusyImageView.image = [UIImage imageNamed:@"shouHuList_free"];
            
        }
        else
        {
            alsoBusyImageView.image = [UIImage imageNamed:@"shouHuList_busy"];
        }
        UIImageView * dunPaiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(numberimageView2.frame.origin.x+13*BILI, alsoBusyImageView.frame.origin.y+alsoBusyImageView.frame.size.height+6*BILI, 15*BILI, 15*BILI)];
        dunPaiImageView.image = [UIImage imageNamed:@"shouHuList_dun"];
        [self.topThreeBotomView addSubview:dunPaiImageView];




        
        UILabel * xingGuanZhiLable = [[UILabel alloc] initWithFrame:CGRectMake(dunPaiImageView.frame.origin.x+dunPaiImageView.frame.size.width, dunPaiImageView.frame.origin.y,numberimageView2.frame.size.width-dunPaiImageView.frame.size.width-13*BILI, 15*BILI)];
        xingGuanZhiLable.textAlignment = NSTextAlignmentCenter;
        xingGuanZhiLable.font = [UIFont systemFontOfSize:15*BILI];
        xingGuanZhiLable.textColor = UIColorFromRGB(0xBC9E5D);
        xingGuanZhiLable.adjustsFontSizeToFitWidth = YES;
        NSNumber * scoreNumber = [info objectForKey:@"score"];
        xingGuanZhiLable.text = [NSString stringWithFormat:@"%d",scoreNumber.intValue];




        [self.topThreeBotomView addSubview:xingGuanZhiLable];


        
        
    }
    else
    {
        TanLiaoCustomImageView * numberimageView2 = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(285*BILI/2, 45*BILI, 90*BILI, 90*BILI)];
        numberimageView2.imgType = IMAGEVIEW_TYPE_CENTER;
        numberimageView2.image = [UIImage imageNamed:@"shouHu_NO 1"];
        numberimageView2.contentMode = UIViewContentModeScaleAspectFill;
        numberimageView2.userInteractionEnabled = YES;
        [self.topThreeBotomView addSubview:numberimageView2];
        
        UIImageView * numberImageViewHuangGuan1 = [[UIImageView alloc] initWithFrame:CGRectMake(279*BILI/2, 29*BILI,  86*BILI/2, 68*BILI/2)];
        numberImageViewHuangGuan1.image= [UIImage imageNamed:@"pic_no1_txt"];
        [self.topThreeBotomView addSubview:numberImageViewHuangGuan1];
        
        UIImageView * numberImageViewHuangGuan2 = [[UIImageView alloc] initWithFrame:CGRectMake(360*BILI/2, 25*BILI, 41*BILI, 24*BILI)];
        numberImageViewHuangGuan2.image = [UIImage imageNamed:@"pic_no1"];
        [self.topThreeBotomView addSubview:numberImageViewHuangGuan2];
        
        
        UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(numberimageView2.frame.origin.x, numberimageView2.frame.origin.y+numberimageView2.frame.size.height+19*BILI, numberimageView2.frame.size.width, 15*BILI)];
        nameLable.font = [UIFont systemFontOfSize:15*BILI];
        nameLable.textColor = UIColorFromRGB(0x9F9F9F);
        nameLable.textAlignment = NSTextAlignmentCenter;
        nameLable.text = @"虚位以待";
        [self.topThreeBotomView addSubview:nameLable];


 


    }
    /////////第三名
    if (self.sourceArray.count>=3) {
        
        NSDictionary * info = [self.sourceArray objectAtIndex:2];
        NSDictionary * userInfo = [info objectForKey:@"user"];

        
        
        TanLiaoCustomImageView * numberimageView2 = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(525*BILI/2, 70*BILI, 80*BILI, 80*BILI)];
        numberimageView2.imgType = IMAGEVIEW_TYPE_CENTER;
        numberimageView2.urlPath = [userInfo objectForKey:@"avatarUrl"];
        numberimageView2.contentMode = UIViewContentModeScaleAspectFill;
        numberimageView2.userInteractionEnabled = YES;
        [self.topThreeBotomView addSubview:numberimageView2];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(thirdHeaderTap)];
        [numberimageView2 addGestureRecognizer:tap];
        
        
        UIImageView * numberImageViewHuangGuan1 = [[UIImageView alloc] initWithFrame:CGRectMake(521*BILI/2, 55*BILI,  86*BILI/2, 68*BILI/2)];
        numberImageViewHuangGuan1.image= [UIImage imageNamed:@"pic_no3_txt"];
        [self.topThreeBotomView addSubview:numberImageViewHuangGuan1];
        
        UIImageView * numberImageViewHuangGuan2 = [[UIImageView alloc] initWithFrame:CGRectMake(585*BILI/2, 50*BILI, 41*BILI, 24*BILI)];
        numberImageViewHuangGuan2.image = [UIImage imageNamed:@"pic_no3"];
        [self.topThreeBotomView addSubview:numberImageViewHuangGuan2];
        
        
        UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(numberimageView2.frame.origin.x, numberimageView2.frame.origin.y+numberimageView2.frame.size.height+10*BILI, numberimageView2.frame.size.width, 13*BILI)];
        nameLable.font = [UIFont systemFontOfSize:12*BILI];
        nameLable.textColor =UIColorFromRGB(0x777777);
        nameLable.textAlignment = NSTextAlignmentCenter;
        nameLable.text =[userInfo objectForKey:@"nick"];
        [self.topThreeBotomView addSubview:nameLable];


        
        if([@"1" isEqualToString:[info objectForKey:@"isVip"]])//
        {
            nameLable.textColor = UIColorFromRGB(0xFF0000);
            
            CGSize nameSize = [TanLiao_Common setSize:[userInfo objectForKey:@"nick"] withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_WIDTH) withFontSize:12*BILI];
            if (nameSize.width>numberimageView2.frame.size.width) {
                
                nameSize.width = numberimageView2.size.width;
            }
            
            UIImageView * vipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(nameLable.frame.origin.x+(numberimageView2.frame.size.width-nameSize.width)/2+nameSize.width+3*BILI, nameLable.frame.origin.y-3*BILI, 18*BILI, 18*BILI)];
            vipImageView.image = [UIImage imageNamed:@"vip_grade_wg_h"];
            [self.topThreeBotomView addSubview:vipImageView];




        }
        
        
        
        UIImageView * alsoBusyImageView = [[UIImageView alloc] initWithFrame:CGRectMake((numberimageView2.frame.size.width-40*BILI)/2+numberimageView2.frame.origin.x, nameLable.frame.origin.y+nameLable.frame.size.height+6*BILI, 40*BILI, 15*BILI)];
        [self.topThreeBotomView addSubview:alsoBusyImageView];



 

        
        
        
        NSNumber * onLineStatus = [userInfo objectForKey:@"onlineStatus"];
        
        if([@"1" isEqualToString:[NSString stringWithFormat:@"%d",onLineStatus.intValue]])//
        {
            //空闲
            alsoBusyImageView.image = [UIImage imageNamed:@"shouHuList_free"];
            
        }
        else
        {
            alsoBusyImageView.image = [UIImage imageNamed:@"shouHuList_busy"];
        }
        UIImageView * dunPaiImageView = [[UIImageView alloc] initWithFrame:CGRectMake(numberimageView2.frame.origin.x+13*BILI, alsoBusyImageView.frame.origin.y+alsoBusyImageView.frame.size.height+6*BILI, 15*BILI, 15*BILI)];
        dunPaiImageView.image = [UIImage imageNamed:@"shouHuList_dun"];
        [self.topThreeBotomView addSubview:dunPaiImageView];


 

        
        UILabel * xingGuanZhiLable = [[UILabel alloc] initWithFrame:CGRectMake(dunPaiImageView.frame.origin.x+dunPaiImageView.frame.size.width, dunPaiImageView.frame.origin.y,numberimageView2.frame.size.width-dunPaiImageView.frame.size.width-13*BILI, 15*BILI)];
        xingGuanZhiLable.textAlignment = NSTextAlignmentCenter;
        xingGuanZhiLable.font = [UIFont systemFontOfSize:15*BILI];
        xingGuanZhiLable.textColor = UIColorFromRGB(0xBC9E5D);
        NSNumber * scoreNumber = [info objectForKey:@"score"];
        xingGuanZhiLable.text = [NSString stringWithFormat:@"%d",scoreNumber.intValue];




        xingGuanZhiLable.adjustsFontSizeToFitWidth = YES;
        [self.topThreeBotomView addSubview:xingGuanZhiLable];


 

        
    }
    else
    {
        TanLiaoCustomImageView * numberimageView2 = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(525*BILI/2, 70*BILI, 80*BILI, 80*BILI)];
        numberimageView2.imgType = IMAGEVIEW_TYPE_CENTER;
        numberimageView2.image =[UIImage imageNamed:@"shouHu_NO 1"];
        numberimageView2.contentMode = UIViewContentModeScaleAspectFill;
        numberimageView2.userInteractionEnabled = YES;
        [self.topThreeBotomView addSubview:numberimageView2];
        
        
        
        UIImageView * numberImageViewHuangGuan1 = [[UIImageView alloc] initWithFrame:CGRectMake(521*BILI/2, 55*BILI,  86*BILI/2, 68*BILI/2)];
        numberImageViewHuangGuan1.image= [UIImage imageNamed:@"pic_no3_txt"];
        [self.topThreeBotomView addSubview:numberImageViewHuangGuan1];
        
        UIImageView * numberImageViewHuangGuan2 = [[UIImageView alloc] initWithFrame:CGRectMake(585*BILI/2, 50*BILI, 41*BILI, 24*BILI)];
        numberImageViewHuangGuan2.image = [UIImage imageNamed:@"pic_no3"];
        [self.topThreeBotomView addSubview:numberImageViewHuangGuan2];
        
        
        UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(numberimageView2.frame.origin.x, numberimageView2.frame.origin.y+numberimageView2.frame.size.height+19*BILI, numberimageView2.frame.size.width, 15*BILI)];
        nameLable.font = [UIFont systemFontOfSize:15*BILI];
        nameLable.textColor = UIColorFromRGB(0x9F9F9F);
        nameLable.textAlignment = NSTextAlignmentCenter;
        nameLable.text = @"虚位以待";
        [self.topThreeBotomView addSubview:nameLable];



 

    }
    
    if (self.sourceArray.count<4)
    {
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 231*BILI, VIEW_WIDTH, 1)];
        lineView.backgroundColor = [UIColor blackColor];



   

        lineView.alpha = 0.05;
        [self.topThreeBotomView addSubview:lineView];



 

        
        UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(0, lineView.frame.origin.y+10*BILI, VIEW_WIDTH, 12*BILI)];
        tipLable.text = @"悄悄告诉你 消费就能增加守护值 快去守护你的小仙女吧 ~";
        tipLable.alpha = 0.3;
        tipLable.font = [UIFont systemFontOfSize:12*BILI];
        tipLable.textColor = [UIColor blackColor];


 
if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
{
  UILabel * szwrG805 = [[UILabel alloc]initWithFrame:CGRectMake(81,43,63,9)];
  szwrG805.backgroundColor = [UIColor whiteColor];
  szwrG805.layer.borderColor = [[UIColor greenColor] CGColor];
 szwrG805.layer.cornerRadius =8;
    UIScrollView * mpfzpT6945 = [[UIScrollView alloc]initWithFrame:CGRectMake(31,36,75,94)];
    mpfzpT6945.layer.cornerRadius =6;
    mpfzpT6945.userInteractionEnabled = YES;
    mpfzpT6945.layer.masksToBounds = YES;
    UIScrollView * ybyuK134 = [[UIScrollView alloc]initWithFrame:CGRectMake(92,78,38,28)];
    ybyuK134.layer.cornerRadius =5;
    ybyuK134.userInteractionEnabled = YES;
    ybyuK134.layer.masksToBounds = YES;
    UITableView * qgdydgB98711 = [[UITableView alloc]initWithFrame:CGRectMake(46,35,46,59)];
    qgdydgB98711.layer.borderWidth = 1;
    qgdydgB98711.clipsToBounds = YES;
    qgdydgB98711.layer.cornerRadius =8;
    UITextView * oqglfgZ02627 = [[UITextView alloc]initWithFrame:CGRectMake(39,45,26,0)];
    oqglfgZ02627.layer.cornerRadius =10;
    oqglfgZ02627.userInteractionEnabled = YES;
    oqglfgZ02627.layer.masksToBounds = YES;
    UIView * ezijzsU92367 = [[UIView alloc]initWithFrame:CGRectMake(28,42,72,68)];
    ezijzsU92367.layer.borderWidth = 1;
    ezijzsU92367.clipsToBounds = YES;
    ezijzsU92367.layer.cornerRadius =9;
    UILabel * upkmV822 = [[UILabel alloc]initWithFrame:CGRectMake(9,38,89,46)];
    upkmV822.backgroundColor = [UIColor whiteColor];
    upkmV822.layer.borderColor = [[UIColor greenColor] CGColor];
    upkmV822.layer.cornerRadius =10;

}
   

        tipLable.textAlignment = NSTextAlignmentCenter;
        [self.topThreeBotomView addSubview:tipLable];




        
         [self.mainScrollView setContentSize: CGSizeMake(VIEW_WIDTH, tipLable.frame.origin.y+tipLable.frame.size.height)];
    }
    else
    {
        self.listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 1093*BILI/2, VIEW_WIDTH, (self.sourceArray.count-3)*70*BILI)];
        self.listTableView.delegate = self;
        self.listTableView.dataSource=self;
        self.listTableView.backgroundColor = [UIColor clearColor];


   

        [self.mainScrollView addSubview:self.listTableView];


 
        
        UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.listTableView.frame.origin.y+self.listTableView.frame.size.height, VIEW_WIDTH, 27*BILI)];
        tipLable.text = @"悄悄告诉你 消费就能增加守护值 快去守护你的小仙女吧 ~";
        tipLable.alpha = 0.3;
        tipLable.font = [UIFont systemFontOfSize:12*BILI];
        tipLable.textColor = [UIColor blackColor];




        tipLable.textAlignment = NSTextAlignmentCenter;
        [self.mainScrollView addSubview:tipLable];


 


        
        [self.mainScrollView setContentSize: CGSizeMake(VIEW_WIDTH, tipLable.frame.origin.y+tipLable.frame.size.height)];
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.sourceArray.count-3;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  70*BILI;
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *tableIdentifier = [NSString stringWithFormat:@"RankingListTableViewCell%d",(int)[indexPath row]] ;
    TanLiaoLiao_ShouHuListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];


 

   

    if (cell == nil)
    {
        cell = [[TanLiaoLiao_ShouHuListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];


 

   

    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell initData:[self.sourceArray objectAtIndex:(int)indexPath.row+3] indexStr:[NSString stringWithFormat:@"%d",(int)indexPath.row+4]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        TanLiaoLiao_AnchorDetailMessageViewController * anchorDetailVC = [[TanLiaoLiao_AnchorDetailMessageViewController alloc] init];




        NSDictionary * info = [self.sourceArray objectAtIndex:(int)indexPath.row+3];
        NSDictionary * userInfo = [info objectForKey:@"user"];
        NSNumber * userIdNumber = [userInfo objectForKey:@"userId"];
        anchorDetailVC.anchorId = [NSString stringWithFormat:@"%d",userIdNumber.intValue];


 


        [self.navigationController pushViewController:anchorDetailVC animated:YES];
    
    
    
}
-(void)secondHeaderTap
{
    TanLiaoLiao_AnchorDetailMessageViewController * anchorDetailVC = [[TanLiaoLiao_AnchorDetailMessageViewController alloc] init];


 

 

    NSDictionary * info = [self.sourceArray objectAtIndex:1];
    NSDictionary * userInfo = [info objectForKey:@"user"];
    NSNumber * userIdNumber = [userInfo objectForKey:@"userId"];
    anchorDetailVC.anchorId = [NSString stringWithFormat:@"%d",userIdNumber.intValue];



 

    [self.navigationController pushViewController:anchorDetailVC animated:YES];

}
-(void)firstHeaderTap
{
    
    TanLiaoLiao_AnchorDetailMessageViewController * anchorDetailVC = [[TanLiaoLiao_AnchorDetailMessageViewController alloc] init];



    NSDictionary * info = [self.sourceArray objectAtIndex:0];
    NSDictionary * userInfo = [info objectForKey:@"user"];
    NSNumber * userIdNumber = [userInfo objectForKey:@"userId"];
    anchorDetailVC.anchorId = [NSString stringWithFormat:@"%d",userIdNumber.intValue];



 

    [self.navigationController pushViewController:anchorDetailVC animated:YES];

    
}


-(void)thirdHeaderTap
{
    TanLiaoLiao_AnchorDetailMessageViewController * anchorDetailVC = [[TanLiaoLiao_AnchorDetailMessageViewController alloc] init];


 

 

    NSDictionary * info = [self.sourceArray objectAtIndex:2];
    NSDictionary * userInfo = [info objectForKey:@"user"];
    NSNumber * userIdNumber = [userInfo objectForKey:@"userId"];
    anchorDetailVC.anchorId = [NSString stringWithFormat:@"%d",userIdNumber.intValue];


 

 

    [self.navigationController pushViewController:anchorDetailVC animated:YES];

}


-(void)sendGiftButtonClick
{
    if (![[TanLiao_Common getNowUserID] isEqualToString:self.userId])
    {
        self.daShangView.hidden = NO;
        self.daShangBottomButtonView.hidden = NO;
        self.daShangBottomView.hidden = NO;
        self.closeDaShangViewButton.hidden = NO;

    }
}


-(void)getGiftListSuccess:(NSArray *)info
{
    
    self.giftArray = [NSArray arrayWithArray:info];
    [self initDaShangView];


 


}


-(void)getGiftListError:(NSDictionary *)info
{
    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];



 

}

//送礼物界面


-(void)initDaShangView
{
    self.daShangBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT-270*BILI, VIEW_WIDTH, 270*BILI)];
    self.daShangBottomView.backgroundColor = UIColorFromRGB(0x000000);
    self.daShangBottomView.alpha = 0.8;
    [self.view addSubview:self.daShangBottomView];



    
    self.daShangView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT-270*BILI, VIEW_WIDTH, 270*BILI)];
    self.daShangView.backgroundColor = [UIColor clearColor];


 

   

    self.daShangView.pagingEnabled = YES;
    [self.view addSubview:self.daShangView];


 

    
    self.daShangBottomButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT-78*BILI, VIEW_WIDTH, 78*BILI)];
    self.daShangBottomButtonView.backgroundColor = [UIColor clearColor];


 


    [self.view addSubview:self.daShangBottomButtonView];



 

    
    UIButton * zengSongButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(24+75)*BILI, 33*BILI, 75*BILI, 30*BILI)];
    [zengSongButton setTitle:@"赠送" forState:UIControlStateNormal];
    [zengSongButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    zengSongButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
    zengSongButton.backgroundColor = UIColorFromRGB(0xFF5C93);
    zengSongButton.layer.cornerRadius = 15*BILI;
    [zengSongButton addTarget:self action:@selector(zengSongButtonClick) forControlEvents:UIControlEventTouchUpInside];


 

    [self.daShangBottomButtonView addSubview:zengSongButton];
    
    
    UIButton * closeButton  = [[UIButton alloc] initWithFrame:CGRectMake(20*BILI, 33*BILI, 30*BILI, 30*BILI)];
    [closeButton setImage:[UIImage imageNamed:@"shou"]forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(shouButtonClick) forControlEvents:UIControlEventTouchUpInside];



 

    [self.daShangBottomButtonView addSubview:closeButton];
    
    
    self.liWuButtonArray = [NSMutableArray array];
    int number = 1;
    if (self.giftArray.count%8==0) {
        
        number = (int)self.giftArray.count/8;
        [self.daShangView setContentSize:CGSizeMake(self.giftArray.count/8*VIEW_WIDTH, self.daShangView.frame.size.height)];
    }
    else
    {
        number = (int)self.giftArray.count/8+1;
        [self.daShangView setContentSize:CGSizeMake((self.giftArray.count/8+1)*VIEW_WIDTH, self.daShangView.frame.size.height)];
    }
    
    for (int i=0; i<number; i++) {
        
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(i*VIEW_WIDTH, 0, VIEW_WIDTH, self.daShangView.frame.size.height)];
        view.backgroundColor = [UIColor clearColor];


 


        [self.daShangView addSubview:view];


 


        
        if ((i+1)*8<self.giftArray.count) {
            
            for (int j=i*8; j<(i+1)*8; j++) {
                
                UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(3*BILI+(90*BILI+3*BILI)*(j%4),13*BILI/2+(90*BILI+5*BILI)*(j%8/4), 90*BILI, 90*BILI)];
                button.backgroundColor = [UIColor clearColor];



                button.layer.cornerRadius = 4;
                button.layer.borderWidth =1;
                button.layer.borderColor = [UIColorFromRGB(0x323232) CGColor];


 

                button.tag = j;
                [button addTarget:self action:@selector(checkLiWu:) forControlEvents:UIControlEventTouchUpInside];


 


                [view addSubview:button];
                
                NSDictionary * giftInfo = [self.giftArray objectAtIndex:j];
                
                TanLiaoCustomImageView * imageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(button.frame.origin.x, button.frame.origin.y+5*BILI, 90*BILI, 90*BILI-27*BILI)];
                imageView.contentMode = UIViewContentModeScaleAspectFit;
                imageView.urlPath =  [giftInfo  objectForKey:@"goodsIconUrl"];
                [view addSubview:imageView];



                
                UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(button.frame.origin.x, imageView.frame.origin.y+imageView.frame.size.height+5*BILI, 90*BILI, 12*BILI)];
                titleLable.textAlignment  = NSTextAlignmentCenter;
                titleLable.font = [UIFont systemFontOfSize:12*BILI];
                titleLable.textColor = [UIColor whiteColor];


 
                NSString * money = [giftInfo objectForKey:@"amount"];
                if(money.intValue%JinBiBiLi==0)
                {
                    titleLable.text = [NSString stringWithFormat:@"%.0f金币",money.floatValue/JinBiBiLi];
                    
                }
                else
                {
                    titleLable.text = [NSString stringWithFormat:@"%.2f金币",money.floatValue/JinBiBiLi];
                }
                [view addSubview:titleLable];


 


                
                [self.liWuButtonArray addObject:button];
                
                
            }
        }
        else
        {
            for (int j=i*8; j<self.giftArray.count; j++) {
                
                UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(3*BILI+(90*BILI+3*BILI)*(j%4),13*BILI/2+(90*BILI+5*BILI)*(j%8/4), 90*BILI, 90*BILI)];
                button.backgroundColor = [UIColor clearColor];



   

                button.layer.cornerRadius = 4;
                button.layer.borderWidth =1;
                button.tag = j;
                button.layer.borderColor = [UIColorFromRGB(0x323232) CGColor];



                [button addTarget:self action:@selector(checkLiWu:) forControlEvents:UIControlEventTouchUpInside];




                [view addSubview:button];
                
                NSDictionary * giftInfo = [self.giftArray objectAtIndex:j];
                
                TanLiaoCustomImageView * imageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(button.frame.origin.x, button.frame.origin.y+5*BILI, 90*BILI, 90*BILI-27*BILI)];
                imageView.contentMode = UIViewContentModeScaleAspectFit;
                imageView.urlPath = [giftInfo  objectForKey:@"goodsIconUrl"];
                [view addSubview:imageView];



                
                UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(button.frame.origin.x, button.frame.origin.y+button.frame.size.height-17*BILI, 90*BILI, 12*BILI)];
                titleLable.textAlignment  = NSTextAlignmentCenter;
                titleLable.font = [UIFont systemFontOfSize:12*BILI];
                titleLable.textColor = [UIColor whiteColor];


 


                NSString * money = [giftInfo objectForKey:@"amount"];
                
                if(money.intValue%JinBiBiLi==0)
                {
                    titleLable.text = [NSString stringWithFormat:@"%.0f金币",money.floatValue/JinBiBiLi];
                    
                }
                else
                {
                    titleLable.text = [NSString stringWithFormat:@"%.2f金币",money.floatValue/JinBiBiLi];
                }
                [view addSubview:titleLable];


 

                
                [self.liWuButtonArray addObject:button];
            }
        }
    }
    
    self.daShangView.hidden = YES;
    self.daShangBottomButtonView.hidden = YES;
    self.daShangBottomView.hidden = YES;
    self.closeDaShangViewButton.hidden = YES;
    
    
}


-(void)shouButtonClick
{
    
        
        self.daShangView.hidden = YES;
        self.daShangBottomButtonView.hidden = YES;
        self.daShangBottomView.hidden = YES;
        self.closeDaShangViewButton.hidden = YES;

    
    
}
-(void)checkLiWu:(id)sender
{
    
    for (int i=0; i<self.liWuButtonArray.count; i++) {
        
        UIButton * button = [self.liWuButtonArray objectAtIndex:i];
        
        button.layer.borderWidth =1;
        button.alpha = 1;
        button.layer.borderColor = [UIColorFromRGB(0x323232) CGColor];




    }
    
    UIButton * button = (UIButton *)sender;
    button.layer.borderWidth = 2;
    button.layer.borderColor  = [[UIColor whiteColor] CGColor];

   

    button.alpha = 0.5;
    
    self.selectGift = [self.giftArray objectAtIndex:button.tag];
}
-(void)zengSongButtonClick
{
    self.daShangView.hidden = YES;
    self.daShangBottomButtonView.hidden = YES;
    self.daShangBottomView.hidden = YES;
    self.closeDaShangViewButton.hidden = YES;
    if([self.selectGift isKindOfClass:[NSDictionary class]])
    {
        //赠送礼物
        [self.cloudClient sendGift:@"8139"
                          anchorId:self.userId
                           goodsId:[self.selectGift objectForKey:@"goodsId"]
                          delegate:self
                          selector:@selector(sendGiftSuccess:)
                     errorSelector:@selector(sendGiftError:)];
    }
    else
    {
        [TanLiao_Common showToastView:@"请选要增送的礼物" view:self.view];


 

 

    }
}

-(void)sendGiftSuccess:(NSDictionary *)indo
{
    
    TanLiaoCustomImageView * imageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-100)/2,VIEW_HEIGHT, 100, 100)];
    imageView.urlPath = [self.selectGift objectForKey:@"goodsIconUrl"];
    [self.view addSubview:imageView];




    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    imageView.frame = CGRectMake((VIEW_WIDTH-100)/2, VIEW_HEIGHT/2, 100, 100);
    [UIView commitAnimations];


 


    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        
        [TanLiao_Common shakeAnimationForView:imageView];




        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:1];
            imageView.frame = CGRectMake((VIEW_WIDTH-100)/2, -100,100, 100);
            [UIView commitAnimations];


   

            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                
                [imageView removeFromSuperview];




            });
            
        });
        
    });
    
    [self.cloudClient getShouHuList:@"8913"
                           anchorId:self.userId
                           delegate:self
                           selector:@selector(getShouHuListSuccess:)
                      errorSelector:@selector(getShouHuListError:)];

}


-(void)getShouHuListSuccess:(NSArray *)array
{
    [self hideNewLoadingView];


    self.sourceArray = array;
    [self initTopView];




    
    
}


-(void)getShouHuListError:(NSDictionary *)info
{
    [self hideNewLoadingView];



    
}


-(void)sendGiftError:(NSDictionary *)info
{
    [self hideNewLoadingView];


 
if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
{
  UIScrollView * pevuB507 = [[UIScrollView alloc]initWithFrame:CGRectMake(24,59,18,63)];
  pevuB507.layer.borderWidth = 1;
  pevuB507.clipsToBounds = YES;
  pevuB507.layer.cornerRadius =10;
    UILabel * grktzgA99009 = [[UILabel alloc]initWithFrame:CGRectMake(77,100,26,44)];
    grktzgA99009.layer.borderWidth = 1;
    grktzgA99009.clipsToBounds = YES;
    grktzgA99009.layer.cornerRadius =6;
    UILabel * lxhmqZ3325 = [[UILabel alloc]initWithFrame:CGRectMake(11,38,9,82)];
    lxhmqZ3325.layer.cornerRadius =10;
    lxhmqZ3325.userInteractionEnabled = YES;
    lxhmqZ3325.layer.masksToBounds = YES;
    UITextView * jdokfL9301 = [[UITextView alloc]initWithFrame:CGRectMake(9,50,71,94)];
    jdokfL9301.layer.cornerRadius =7;
    jdokfL9301.userInteractionEnabled = YES;
    jdokfL9301.layer.masksToBounds = YES;
    UIImageView * avjhoG4111 = [[UIImageView alloc]initWithFrame:CGRectMake(80,11,19,4)];
    avjhoG4111.backgroundColor = [UIColor whiteColor];
    avjhoG4111.layer.borderColor = [[UIColor greenColor] CGColor];
    avjhoG4111.layer.cornerRadius =5;
    UIScrollView * nzpafjV72144 = [[UIScrollView alloc]initWithFrame:CGRectMake(17,73,85,6)];
    nzpafjV72144.layer.borderWidth = 1;
    nzpafjV72144.clipsToBounds = YES;
    nzpafjV72144.layer.cornerRadius =5;


}
 

    if([@"-917" isEqualToString:[info objectForKey:@"code"]])
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
