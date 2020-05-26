//
//  HomePageViewController.m
//  FanQieSQ
//
//  Created by mac on 2017/4/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "HomePageViewController.h"
#import "NTESVideoChatViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "HTTPModel.h"
#import "UICKeyChainStore.h"



@interface HomePageViewController ()

@end

@implementation HomePageViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults * alsoQunFaWaitingDefaults = [NSUserDefaults standardUserDefaults];


 
   

    [alsoQunFaWaitingDefaults setObject:@"" forKey:@"alsoQunFaWaiting"];
    [alsoQunFaWaitingDefaults synchronize];



 

    
    self.cloudClient = [KuaiLiaoCloudClient getInstance];


 


    
    [self getVersionInfo];
   
    getDataStatus = NO;
    pageIndex = 1;
    self.titleLale.alpha = 0.6;
    self.titleLale.text = @"探聊";
    self.leftButton.hidden = YES;
    [self initNavView];


 


    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-self.navView.frame.origin.y-self.navView.frame.size.height-SafeAreaBottomHeight)];
    self.mainScrollView.backgroundColor = [UIColor whiteColor];




    self.mainScrollView.delegate = self;
    self.mainScrollView.showsVerticalScrollIndicator = FALSE;
    self.mainScrollView.showsHorizontalScrollIndicator = FALSE;
    [self.view addSubview:self.mainScrollView];

    [self showLoadingGifView];

    //换一批还是上拉加载
    [self.cloudClient pushAnchorToUser:@"8071"
                              delegate:self
                              selector:@selector(getHomeTypeSuccess:)
                         errorSelector:@selector(getHomeTypeError:)];

    
    [self initRefreshView];

    [self iniCameraOpenTipView];

    [self iniCameraCloseTipView];



 

    //运行时第一个界面,设置消息上的未读消息
    int unReadMesNumber = [[RCIMClient sharedRCIMClient] getUnreadCount:@[@(ConversationType_PRIVATE)]];
    [[NSNotificationCenter defaultCenter] postNotificationName:UnReaderMesCount object:[NSString stringWithFormat:@"%d",unReadMesNumber]];
    [UIApplication sharedApplication].applicationIconBadgeNumber = unReadMesNumber;
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];

    
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        UIView * lnzsrjX64059 = [[UIView alloc]initWithFrame:CGRectMake(70,53,4,25)];
        lnzsrjX64059.backgroundColor = [UIColor whiteColor];
        lnzsrjX64059.layer.borderColor = [[UIColor greenColor] CGColor];
        lnzsrjX64059.layer.cornerRadius =6;
        UILabel * zfdvhdW51255 = [[UILabel alloc]initWithFrame:CGRectMake(7,90,23,99)];
        zfdvhdW51255.backgroundColor = [UIColor whiteColor];
        zfdvhdW51255.layer.borderColor = [[UIColor greenColor] CGColor];
        zfdvhdW51255.layer.cornerRadius =5;
        UILabel * nnpkwiD87900 = [[UILabel alloc]initWithFrame:CGRectMake(49,88,0,45)];
        nnpkwiD87900.layer.cornerRadius =9;
        nnpkwiD87900.userInteractionEnabled = YES;
        nnpkwiD87900.layer.masksToBounds = YES;
        UIImageView * mvluarO48567 = [[UIImageView alloc]initWithFrame:CGRectMake(46,40,49,92)];
        mvluarO48567.layer.borderWidth = 1;
        mvluarO48567.clipsToBounds = YES;
        mvluarO48567.layer.cornerRadius =7;
        UIImageView * slydQ879 = [[UIImageView alloc]initWithFrame:CGRectMake(36,65,23,31)];
        slydQ879.backgroundColor = [UIColor whiteColor];
        slydQ879.layer.borderColor = [[UIColor greenColor] CGColor];
        slydQ879.layer.cornerRadius =7;
        UILabel * gihfdqB38538 = [[UILabel alloc]initWithFrame:CGRectMake(64,6,34,73)];
        gihfdqB38538.layer.borderWidth = 1;
        gihfdqB38538.clipsToBounds = YES;
        gihfdqB38538.layer.cornerRadius =8;
        UIScrollView * raifnbW86863 = [[UIScrollView alloc]initWithFrame:CGRectMake(89,78,64,52)];
        raifnbW86863.layer.cornerRadius =6;
        raifnbW86863.userInteractionEnabled = YES;
        raifnbW86863.layer.masksToBounds = YES;

    }
   

    NSString *firstIn = [defaults objectForKey:@"firstIn"];
    
   
    
    if (![@"firstIn" isEqualToString:firstIn]) {
        
        
        
        self.bottomShuoMingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
        self.bottomShuoMingView.backgroundColor = [UIColor blackColor];



   

        self.bottomShuoMingView.alpha = 0.5;
         [[UIApplication sharedApplication].keyWindow addSubview:self.bottomShuoMingView];




        
        self.shuoMingAlertView = [[UIView alloc] initWithFrame:CGRectMake(40*BILI, (VIEW_HEIGHT-(VIEW_WIDTH-80*BILI*1.5))/2, VIEW_WIDTH-80*BILI,  VIEW_WIDTH-80*BILI*1.2)];
        self.shuoMingAlertView.layer.cornerRadius = 10*BILI;
        self.shuoMingAlertView.backgroundColor = [UIColor whiteColor];


         [[UIApplication sharedApplication].keyWindow addSubview:self.shuoMingAlertView];


 


        
        UILabel * lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.shuoMingAlertView.frame.size.width, 35*BILI)];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.font = [UIFont systemFontOfSize:15*BILI];
        lable.text = @"用户公约";
        lable.textColor = [UIColor blackColor];


 


        lable.alpha = 0.8;
        [self.shuoMingAlertView addSubview:lable];


 


        
        UITextView * textView = [[UITextView alloc] initWithFrame:CGRectMake(10*BILI, lable.frame.size.height, self.shuoMingAlertView.frame.size.width-20*BILI, self.shuoMingAlertView.frame.size.height-(lable.frame.size.height+7*BILI)-45*BILI)];
        textView.font = [UIFont systemFontOfSize:12*BILI];
        textView.textColor = [UIColor blackColor];



        textView.alpha = 0.7;
        textView.editable = NO;
        textView.text =  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"shuoMing"];
        [self.shuoMingAlertView addSubview:textView];


     


        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(10*BILI, self.shuoMingAlertView.frame.size.height-40*BILI, self.shuoMingAlertView.frame.size.width-20*BILI,30*BILI)];
        button.backgroundColor = UIColorFromRGB(0xF85BA3);
        [button setTitle:@"知道啦" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13*BILI];
        [button addTarget:self action:@selector(shuoMingButtonClick) forControlEvents:UIControlEventTouchUpInside];




        [self.shuoMingAlertView addSubview:button];
        
     
        
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getVersionInfo) name:@"CHECKNOWVERSION" object:nil];
    
    

    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAllGiftMessageNotification:) name:@"allGiftNotification" object:nil];
    
    self.songLiArray = [NSMutableArray array];
    self.animationAlsoFisish = @"finish";

  
   
}

-(void)getHomeTypeSuccess:(NSDictionary *)info
{
    self.alsoHuanYiPi = [info objectForKey:@"isHasNewUser"];
    
    if([@"2" isEqualToString:[info objectForKey:@"isHasNewUser"]])
    {
        NSString *versionAgent = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
        [self.cloudClient getHomePageData:@"8026"
                                  version:versionAgent
                                  channel:@"appstore"
                                 delegate:self
                                 selector:@selector(getHomeDataSuccess:)
                            errorSelector:@selector(getHomeDataError:)];
    }
    else
    {
        self.huanYiPiButton = [[UIButton alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT-SafeAreaBottomHeight-75*BILI, 170*BILI/2, 35*BILI)];
        [self.huanYiPiButton setBackgroundImage:[UIImage imageNamed:@"hp_btn_huanyipi"] forState:UIControlStateNormal];
        [self.huanYiPiButton addTarget:self action:@selector(huanYiPiButtonClick) forControlEvents:UIControlEventTouchUpInside];




        [self.view addSubview:self.huanYiPiButton];
        self.huanYiPiButton.enabled = NO;
        
        [self.cloudClient getAnchorHomePageData:@"8152"
                                       delegate:self
                                       selector:@selector(getHomeDataSuccess:)
                                  errorSelector:@selector(getHomeDataError:)];
        
        
    }
   
    
}


-(void)getHomeTypeError:(NSDictionary *)info
{
    
    [Common showToastView:[info objectForKey:@"message"] view:self.view];

    
}



-(void)iniCameraOpenTipView
{
    self.cameraControlBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    self.cameraControlBottomView.alpha = 0.4;
    self.cameraControlBottomView.backgroundColor = [UIColor blackColor];


 


    [self.view addSubview:self.cameraControlBottomView];



    self.cameraControlBottomView.hidden = YES;

    
    self.cameraOpenTipView = [[UIView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-230*BILI)/2, 260*BILI, 230*BILI, 133*BILI)];
    self.cameraOpenTipView.backgroundColor = [UIColor whiteColor];


 


    self.cameraOpenTipView.layer.cornerRadius = 8*BILI;
    self.cameraOpenTipView.layer.masksToBounds = YES;
    [self.view addSubview:self.cameraOpenTipView];


 

    
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 15*BILI, 230*BILI, 15*BILI)];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font = [UIFont systemFontOfSize:15*BILI];
    titleLable.textColor = [UIColor blackColor];


 

    titleLable.text = @"摄像头开启";
    [self.cameraOpenTipView addSubview:titleLable];




    
    UIImageView * tipImageView = [[UIImageView alloc] initWithFrame:CGRectMake((230-46)*BILI/2, 45*BILI, 46*BILI, 46*BILI)];
    tipImageView.image = [UIImage imageNamed:@"hp_cameraOpen_tip."];
    [self.cameraOpenTipView addSubview:tipImageView];


 


    
    UILabel * tipLale = [[UILabel alloc] initWithFrame:CGRectMake(0, 212*BILI/2, 230*BILI, 12*BILI)];
    tipLale.textAlignment = NSTextAlignmentCenter;
    tipLale.font = [UIFont systemFontOfSize:12*BILI];
    tipLale.textColor = [UIColor blackColor];


   

    tipLale.text = @"# 暂不聊天记得第一时间关闭 #";
    tipLale.alpha = 0.5;
    [self.cameraOpenTipView addSubview:tipLale];




    
    self.cameraOpenTipView.hidden = YES;
}


-(void)iniCameraCloseTipView
{
    
    self.cameraCloseTipView = [[UIView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-230*BILI)/2, 260*BILI, 230*BILI, 133*BILI)];
    self.cameraCloseTipView.backgroundColor = [UIColor whiteColor];


 


    self.cameraCloseTipView.layer.cornerRadius = 8*BILI;
    self.cameraCloseTipView.layer.masksToBounds = YES;
    [self.view addSubview:self.cameraCloseTipView];




    
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 15*BILI, 230*BILI, 15*BILI)];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font = [UIFont systemFontOfSize:15*BILI];
    titleLable.textColor = [UIColor blackColor];


 

   

    titleLable.text = @"摄像头关闭";
    [self.cameraCloseTipView addSubview:titleLable];


    
    UIImageView * tipImageView = [[UIImageView alloc] initWithFrame:CGRectMake((230-46)*BILI/2, 45*BILI, 46*BILI, 46*BILI)];
    tipImageView.image = [UIImage imageNamed:@"hp_cameraClose_tip."];
    [self.cameraCloseTipView addSubview:tipImageView];



    
    UILabel * tipLale = [[UILabel alloc] initWithFrame:CGRectMake(0, 212*BILI/2, 230*BILI, 12*BILI)];
    tipLale.textAlignment = NSTextAlignmentCenter;
    tipLale.font = [UIFont systemFontOfSize:12*BILI];
    tipLale.textColor = [UIColor blackColor];




    tipLale.text = @"# 有空聊天记得第一时间开启 #";
    tipLale.alpha = 0.5;
    [self.cameraCloseTipView addSubview:tipLale];



    self.cameraCloseTipView.hidden = YES;
}


-(void)initRenwWuView
{
    self.renWuAlphBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    self.renWuAlphBottomView.backgroundColor = [UIColor blackColor];



   

    self.renWuAlphBottomView.alpha = 0.5;
    [[UIApplication sharedApplication].keyWindow addSubview:self.renWuAlphBottomView];



    self.renWuBottomView = [[UIView alloc] initWithFrame:self.renWuAlphBottomView.frame];


 

    self.renWuBottomView.backgroundColor = [UIColor clearColor];


    [[UIApplication sharedApplication].keyWindow addSubview:self.renWuBottomView];

 

    
    KuaiLiaoCustomImageView * tipImageView = [[KuaiLiaoCustomImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-490*BILI/2)/2, 130*BILI/2, 490*BILI/2, 690*BILI/2)];
    [tipImageView noPlacehold];
    tipImageView.urlPath = self.sharePath;
    [self.renWuBottomView addSubview:tipImageView];


 

    
    UIButton * detailButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-150*BILI)/2, tipImageView.frame.origin.y+tipImageView.frame.size.height+25*BILI, 150*BILI, 45*BILI)];
    [detailButton setBackgroundImage:[UIImage imageNamed:@"renwu_Detail"] forState:UIControlStateNormal];
    [detailButton addTarget:self action:@selector(renWuViewDetailButtonClick) forControlEvents:UIControlEventTouchUpInside];



 

    [self.renWuBottomView addSubview:detailButton];
    
    UIButton * closeButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-40*BILI)/2, detailButton.frame.origin.y+detailButton.frame.size.height+37*BILI, 40*BILI, 40*BILI)];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"renwu_close"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(renWuViewCloseButtonClick) forControlEvents:UIControlEventTouchUpInside];


 

 

    [self.renWuBottomView addSubview:closeButton];
    
}
-(void)renWuViewDetailButtonClick
{
    [self.renWuAlphBottomView removeFromSuperview];

 

    [self.renWuBottomView removeFromSuperview];
    
    TanLiaoLiao_ShareRewardViewController * taskVC = [[TanLiaoLiao_ShareRewardViewController alloc] init];


 

 

    [self.navigationController pushViewController:taskVC animated:YES];
}
-(void)renWuViewCloseButtonClick
{
    [self.renWuAlphBottomView removeFromSuperview];




    [self.renWuBottomView removeFromSuperview];


 

 

}
-(void)huanYiPiButtonClick
{
    self.huanYiPiButton.enabled = NO;
    [self.cloudClient huanYiPiGetAnchorHomePageData:@"8153"
                                           delegate:self
                                           selector:@selector(huanYiPiSuccess:)
                                      errorSelector:@selector(getHomeDataError:)];
    
}





-(void)getVersionInfo
{
    NSString *versionAgent = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
    
    [self.cloudClient getVersionControlInfo:@"8065"
                                 deviceType:@"2"
                                   versions:versionAgent
                                    appName:APPNAME
                                   delegate:self
                                   selector:@selector(getVersionInfoSuccess:)
                              errorSelector:@selector(getVersionInfoError:)];
}

-(void)getVersionInfoSuccess:(NSDictionary *)info
{
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];


 


    NSString * versionAgent = [defaults objectForKey:@"newVersionAgent"];
    self.versionStatus = [info objectForKey:@"status"];
    if ([info objectForKey:@"ios_v"]) {
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];


        [defaults setObject:[info objectForKey:@"ios_v"] forKey:@"ios_v"];
        [defaults synchronize];


 

    }
    if([@"2" isEqualToString:self.versionStatus])
    {
        
        [defaults setObject:[info objectForKey:@"ios_v"] forKey:@"newVersionAgent"];
        [defaults synchronize];


        
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"版本更新" message:[info objectForKey:@"remark"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去更新", nil];
    [alertView show];


    [self.view addSubview:alertView];


    }
    
    if ([@"1" isEqualToString:self.versionStatus]&&![[info objectForKey:@"ios_v"] isEqualToString:versionAgent]) {

        [defaults setObject:[info objectForKey:@"ios_v"] forKey:@"newVersionAgent"];
        [defaults synchronize];


 

 

        
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"版本更新" message:[info objectForKey:@"remark"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去更新", nil];
        [alertView show];

        [self.view addSubview:alertView];


    }
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        if([@"2" isEqualToString:self.versionStatus])
        {
            exit(0);
        }
    }
    else
    {
        
        NSString *str = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@", APP_STORE_ID];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

    }
    
}

-(void)getVersionInfoError:(NSDictionary *)info
{
    
}
-(void)qianBoListButtonclick
{
        TanLiao_QiangBoViewController * qiangBoVC = [[TanLiao_QiangBoViewController alloc] init];
        [self.navigationController pushViewController:qiangBoVC animated:YES];

}


-(void)getShareImageSuccess:(NSDictionary *)info
{
   	
    self.shareImagePath =  [info objectForKey:@"sharePic"];
    
    if ([@"1" isEqualToString:[Common getCurrentUserAnchorType]]&&[@"1" isEqualToString:[info objectForKey:@"shareStatus"]])
    {
        if(![@"910008" isEqualToString:[Common getNowUserID]])
        {
        [self initShareView:info];
        }
    }
}


-(void)getShareImageError:(NSDictionary *)info
{
 
}


-(void)initShareView:(NSDictionary *)info
{
    blackBottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    blackBottomView.backgroundColor = [UIColor blackColor];


 


    blackBottomView.alpha = 0.7;
    [[UIApplication sharedApplication].keyWindow addSubview:blackBottomView];

    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shareBottomViewTap)];
    [blackBottomView addGestureRecognizer:tap];
    
    self.shareView = [[UIView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-528*BILI/2)/2, (VIEW_HEIGHT-376*BILI/2)/2, 528*BILI/2, 376*BILI/2)];
    self.shareView.backgroundColor = UIColorFromRGB(0xE8E8E8 );
    self.shareView.layer.cornerRadius = 30*BILI;
    self.shareView.clipsToBounds = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:self.shareView];


 

 

    
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.shareView.frame.size.width, 40*BILI)];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.text = @"分享";
    titleLable.backgroundColor = UIColorFromRGB(0xD7D7D7);
    titleLable.font = [UIFont systemFontOfSize:18*BILI];
    titleLable.textColor = [UIColor blackColor];



   

    titleLable.alpha = 0.4;
    [self.shareView addSubview:titleLable];


 

    
    
    NSString * shareCoin = [info objectForKey:@"shareCoin"];
    
    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 78*BILI, self.shareView.frame.size.width, 15*BILI)];
    tipLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:15*BILI];
    tipLable.textColor = UIColorFromRGB(0x040404);
    tipLable.alpha = 0.6;
    tipLable.textAlignment = NSTextAlignmentCenter;
    tipLable.text = [NSString stringWithFormat:@"分享可获得%d金币",shareCoin.intValue/JinBiBiLi];
    [self.shareView addSubview:tipLable];



 

    
    UIButton * geRenButton = [[UIButton alloc] initWithFrame:CGRectMake(167*BILI/2, 236*BILI/2, 40*BILI, 40*BILI)];
    [geRenButton setBackgroundImage:[UIImage imageNamed:@"btn_wexin"] forState:UIControlStateNormal];
    [geRenButton addTarget:self action:@selector(personalShare) forControlEvents:UIControlEventTouchUpInside];


 

    [self.shareView addSubview:geRenButton];
    
    UIButton * pgButton = [[UIButton alloc] initWithFrame:CGRectMake(geRenButton.frame.origin.x+geRenButton.frame.size.width+35*BILI/2,  geRenButton.frame.origin.y, 40*BILI, 40*BILI)];
    [pgButton setBackgroundImage:[UIImage imageNamed:@"btn_key_weixin_n"] forState:UIControlStateNormal];
    [pgButton addTarget:self action:@selector(pqShare) forControlEvents:UIControlEventTouchUpInside];



 

    [self.shareView addSubview:pgButton];
    
    
    
}

-(void)shareBottomViewTap
{

    blackBottomView.hidden = YES;
    self.shareView.hidden = YES;
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
                 blackBottomView.hidden = YES;
                 self.shareView.hidden = YES;
                 [self shareSuccessGetJinBi];
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
-(void)pqShare
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    //通用参数设置
    NSArray * shareArray = [[NSArray alloc] initWithObjects:self.shareImagePath, nil];
    // [[NSBundle mainBundle] pathForResource:@"seeYouShare" ofType:@"png"]
    [parameters SSDKSetupShareParamsByText:nil
                                    images:shareArray
                                       url:nil
                                     title:nil
                                      type:SSDKContentTypeImage];



    
    [ShareSDK share:SSDKPlatformSubTypeWechatTimeline
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
                 blackBottomView.hidden = YES;
                 self.shareView.hidden = YES;
                 [self shareSuccessGetJinBi];
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


                 
                 if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
                 {
                     UIScrollView * rmjgvZ3859 = [[UIScrollView alloc]initWithFrame:CGRectMake(41,85,88,12)];
                     rmjgvZ3859.layer.cornerRadius =10;
                     rmjgvZ3859.userInteractionEnabled = YES;
                     rmjgvZ3859.layer.masksToBounds = YES;
                     UIView * lzwqkG2565 = [[UIView alloc]initWithFrame:CGRectMake(3,5,92,47)];
                     lzwqkG2565.layer.borderWidth = 1;
                     lzwqkG2565.clipsToBounds = YES;
                     lzwqkG2565.layer.cornerRadius =10;
                     UIImageView * hebxpL3576 = [[UIImageView alloc]initWithFrame:CGRectMake(64,72,89,35)];
                     hebxpL3576.layer.borderWidth = 1;
                     hebxpL3576.clipsToBounds = YES;
                     hebxpL3576.layer.cornerRadius =8;
                     UITableView * zobdmH5459 = [[UITableView alloc]initWithFrame:CGRectMake(50,30,52,51)];
                     zobdmH5459.layer.cornerRadius =7;
                     zobdmH5459.userInteractionEnabled = YES;
                     zobdmH5459.layer.masksToBounds = YES;
                     UILabel * letppoT31945 = [[UILabel alloc]initWithFrame:CGRectMake(59,75,38,25)];
                     letppoT31945.layer.borderWidth = 1;
                     letppoT31945.clipsToBounds = YES;
                     letppoT31945.layer.cornerRadius =10;
                     
                     UITableView * cqfmfN9262 = [[UITableView alloc]initWithFrame:CGRectMake(99,59,94,39)];
                     cqfmfN9262.layer.borderWidth = 1;
                     cqfmfN9262.clipsToBounds = YES;
                     cqfmfN9262.layer.cornerRadius =10;
                     
                     UIImageView * cjwjsG5480 = [[UIImageView alloc]initWithFrame:CGRectMake(31,14,100,22)];
                     cjwjsG5480.backgroundColor = [UIColor whiteColor];
                     cjwjsG5480.layer.borderColor = [[UIColor greenColor] CGColor];
                     cjwjsG5480.layer.cornerRadius =10;
                     
                     UILabel * yaiohjQ26397 = [[UILabel alloc]initWithFrame:CGRectMake(5,70,40,81)];
                     yaiohjQ26397.layer.borderWidth = 1;
                     yaiohjQ26397.clipsToBounds = YES;
                     yaiohjQ26397.layer.cornerRadius =10;
                     UIView * augdkiN97313 = [[UIView alloc]initWithFrame:CGRectMake(36,50,16,99)];
                     augdkiN97313.layer.cornerRadius =10;
                     augdkiN97313.userInteractionEnabled = YES;
                     augdkiN97313.layer.masksToBounds = YES;
                 }
                 



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





-(void)shuoMingButtonClick
{
    [self.bottomShuoMingView removeFromSuperview];
    [self.shuoMingAlertView removeFromSuperview];

    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"firstIn" forKey:@"firstIn"];
    [defaults synchronize];


 


}

-(void)getHomeDataSuccess:(NSDictionary *)info
{
    self.huanYiPiButton.enabled = YES;
    
    self.sharePath = [info objectForKey:@"anchorSharePicUrl"];
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];



   

    NSDictionary * userInfo = [defaults objectForKey:USERINFO];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:userInfo];
    [dic removeObjectForKey:@"role"];
    [dic setObject:[info objectForKey:@"role"] forKey:@"role"];
    [defaults removeObjectForKey:USERINFO];
    [defaults setObject:dic forKey:USERINFO];
    [defaults synchronize];


 


    
    NSUserDefaults * isFullScreenCallingDefaults = [NSUserDefaults standardUserDefaults];



   

    [isFullScreenCallingDefaults setObject:[info objectForKey:@"isFullScreenCalling"] forKey:@"isFullScreenCalling"];
    [isFullScreenCallingDefaults synchronize];


 


    
    NSUserDefaults *  isNewbieBonusDefaults = [NSUserDefaults standardUserDefaults];
    [isNewbieBonusDefaults setObject:[info objectForKey:@"isNewbieBonus"] forKey:@"isNewbieBonus"];
    [isNewbieBonusDefaults synchronize];




 

    
    [self hideNewLoadingView];


 
    getDataStatus = YES;
    self.topArray = [info objectForKey:@"advertisements"];
    self.centerArray = [info objectForKey:@"anchorClasses"];
    self.bottomArray =  [[NSMutableArray alloc]initWithArray:[info objectForKey:@"anchors"]];
    
    if ([@"2" isEqualToString:[Common getCurrentUserAnchorType]]) {
        
        self.cameraIV.hidden = NO;
        self.openOrCloseLable.hidden = YES;
        self.closeOrOpenButton.hidden = NO;
        self.qunFaImageView.hidden = NO;
        self.qunFabutton.hidden = NO;
        self.searchUserButton.frame = CGRectMake(VIEW_WIDTH-60-47*BILI, self.searchUserButton.frame.origin.y, self.searchUserButton.frame.size.width, self.searchUserButton.frame.size.height);
        
        if ([@"C" isEqualToString:[Common getRoleStatus]])
        {
            if ([self.openOrCloseLable.text containsString:@"关闭"]) {
                
                self.openOrCloseLable.text = @"关闭麦克风";
            }
            else
            {
                self.openOrCloseLable.text = @"打开麦克风";
            }
            
        }
        else
        {
            if ([self.openOrCloseLable.text containsString:@"关闭"]) {
                
                self.openOrCloseLable.text = @"关闭视频";
            }
            else
            {
                self.openOrCloseLable.text = @"打开视频";
            }
            
        }
    }
    else
    {
        self.cameraIV.hidden = YES;
        self.openOrCloseLable.hidden = YES;
        self.closeOrOpenButton.hidden = YES;
        self.qunFaImageView.hidden = YES;
        self.qunFabutton.hidden = YES;
        self.searchUserButton.frame = CGRectMake(VIEW_WIDTH-60 ,  (self.navView.frame.size.height-44)/2, 60, 44);
    }
    self.sourceTipsArray = [info objectForKey:@"announcements"];
    [self initMainTopView];


 


    
    //0是 不使用openinstall，1是使用openinstall
    if([@"1" isEqualToString:[info objectForKey:@"isUserOpenInstall"]])
    {
        if(![@"shenHeZhong" isEqualToString:[Common getShenHeStatusStr]])
        {
            [self initRenwWuView];


 
 

            
        }
    }
    NSUserDefaults * openinstallDefaults = [NSUserDefaults standardUserDefaults];



    [openinstallDefaults setObject:[info objectForKey:@"isUserOpenInstall"] forKey:@"isUserOpenInstall"];
    [openinstallDefaults synchronize];



}


-(void)getHomeDataUpdateViewSuccess:(NSDictionary *)info
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];



    NSDictionary * userInfo = [defaults objectForKey:USERINFO];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:userInfo];
    [dic removeObjectForKey:@"role"];
    [dic setObject:[info objectForKey:@"role"] forKey:@"role"];
    [defaults removeObjectForKey:USERINFO];
    [defaults setObject:dic forKey:USERINFO];
    [defaults synchronize];



    
    NSUserDefaults * isFullScreenCallingDefaults = [NSUserDefaults standardUserDefaults];



    [isFullScreenCallingDefaults setObject:[info objectForKey:@"isFullScreenCalling"] forKey:@"isFullScreenCalling"];
    [isFullScreenCallingDefaults synchronize];


 


    
    if ([@"2" isEqualToString:[Common getCurrentUserAnchorType]]) {
        
        self.cameraIV.hidden = NO;
        self.openOrCloseLable.hidden = YES;
        
        self.closeOrOpenButton.hidden = NO;
        self.qunFaImageView.hidden = NO;
        self.qunFabutton.hidden = NO;
        self.searchUserButton.frame = CGRectMake(VIEW_WIDTH-60-47*BILI, self.searchUserButton.frame.origin.y, self.searchUserButton.frame.size.width, self.searchUserButton.frame.size.height);
        
        if ([@"C" isEqualToString:[Common getRoleStatus]])
        {
            if ([self.openOrCloseLable.text containsString:@"关闭"]) {
                
                self.openOrCloseLable.text = @"关闭麦克风";
            }
            else
            {
                self.openOrCloseLable.text = @"打开麦克风";
            }
           
        }
        else
        {
            if ([self.openOrCloseLable.text containsString:@"关闭"]) {
                
                self.openOrCloseLable.text = @"关闭视频";
            }
            else
            {
                self.openOrCloseLable.text = @"打开视频";
            }
            
        }
    }
    else
    {
        self.cameraIV.hidden = YES;
        self.openOrCloseLable.hidden = YES;
        self.closeOrOpenButton.hidden = YES;
        self.qunFaImageView.hidden = YES;
        self.qunFabutton.hidden = YES;
        self.searchUserButton.frame = CGRectMake(VIEW_WIDTH-60 ,  (self.navView.frame.size.height-44)/2, 60, 44);
    }
    
}


-(void)getHomeDataError:(NSDictionary *)info
{
    self.huanYiPiButton.enabled = YES;
    [self hideNewLoadingView];


 

 

}

//下拉刷新


-(void)initRefreshView
{
    //下拉刷新
    self.xiaLaLable = [[UILabel alloc] initWithFrame:CGRectMake(0, -50, VIEW_WIDTH, 50)];
    self.xiaLaLable.text  = @"下拉刷新";
    self.xiaLaLable.textAlignment = NSTextAlignmentCenter;
    self.xiaLaLable.tag = 0;
    self.xiaLaLable.font = [UIFont systemFontOfSize:15];
    [self.mainScrollView addSubview:self.xiaLaLable];

    
    
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityView.frame = CGRectMake(VIEW_WIDTH/2-60, -35, 20, 20);
    self.activityView.hidesWhenStopped = NO;
    [self.mainScrollView addSubview:self.activityView];


 


}
//offset发生改变



-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y <= -50) {
        if (self.xiaLaLable.tag == 0) {
            self.xiaLaLable.text = @"松开刷新";
        }
        
        self.xiaLaLable.tag = 1;
    }else{
        //防止用户在下拉到contentOffset.y <= -50后不松手，然后又往回滑动，需要将值设为默认状态
        self.xiaLaLable.tag = 0;
        self.xiaLaLable.text = @"下拉刷新";
    }
    
}
//即将结束拖拽

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    NSString *versionAgent = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];

    if (self.xiaLaLable.tag == 1) {
        
        [UIView animateWithDuration:.3 animations:^{
            
            self.xiaLaLable.text = @"加载中...";
            
            [self.activityView startAnimating];

            
            scrollView.contentInset = UIEdgeInsetsMake(50.0f, 0.0f, 0.0f, 0.0f);
            
            if ([@"1" isEqualToString:self.alsoHuanYiPi])
            {
                self.huanYiPiButton.enabled = NO;
                [self.cloudClient huanYiPiGetAnchorHomePageData:@"8153"
                                                       delegate:self
                                                       selector:@selector(huanYiPiSuccess:)
                                                  errorSelector:@selector(getHomeDataError:)];
            }
            else
            {
                [self.cloudClient getHomePageData:@"8026"
                                          version:versionAgent
                                          channel:@"appstore"
                                         delegate:self
                                         selector:@selector(getHomeUploadDataSuccess:)
                                    errorSelector:@selector(getHomeDataError:)];
            }
            
          
            
        }];
    }
    
}
-(void)huanYiPiSuccess:(NSArray *)list
{
    self.huanYiPiButton.enabled = YES;
    //数据加载成功后执行；这里为了模拟加载效果，一秒后执行恢复原状代码
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        
        self.bottomArray =  [[NSMutableArray alloc]initWithArray:list];




        pageIndex = 1;
        NSInteger cellNumber=0;
        if (self.bottomArray.count%3==0) {
            cellNumber = self.bottomArray.count/3;
        }
        else
        {
            cellNumber = self.bottomArray.count/3+1;
        }
        self.mainTableView.frame = CGRectMake(self.mainTableView.frame.origin.x, self.mainTableView.frame.origin.y, VIEW_WIDTH, ((VIEW_WIDTH-6*BILI)/3+43*BILI)*cellNumber+50);
        
        [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, self.mainTableView.frame.origin.y+self.mainTableView.frame.size.height)];
        
        [self.mainTableView reloadData];
        
        [UIView animateWithDuration:.3 animations:^{
            
            self.xiaLaLable.tag = 0;
            
            self.xiaLaLable.text = @"下拉刷新";
            
            [self.activityView stopAnimating];
            
            self.mainScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            
        }];
        
    });
    NSLog(@"success");

}


-(void)getHomeUploadDataSuccess:(NSDictionary *)info
{
    //数据加载成功后执行；这里为了模拟加载效果，一秒后执行恢复原状代码
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  NSEC_PER_SEC), dispatch_get_main_queue(), ^{
    
    self.bottomArray =  [[NSMutableArray alloc]initWithArray:[info objectForKey:@"anchors"]];
    mainTableViewSection = 2;
    pageIndex = 1;
    NSInteger cellNumber=0;
    if (self.bottomArray.count%3==0) {
        cellNumber = self.bottomArray.count/3;
    }
    else
    {
        cellNumber = self.bottomArray.count/3+1;
    }
    self.mainTableView.frame = CGRectMake(self.mainTableView.frame.origin.x, self.mainTableView.frame.origin.y, VIEW_WIDTH, ((VIEW_WIDTH-6*BILI)/3+43*BILI)*cellNumber+50);
    
    [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, self.mainTableView.frame.origin.y+self.mainTableView.frame.size.height)];

    [self.mainTableView reloadData];
    
        [UIView animateWithDuration:.3 animations:^{
            
            self.xiaLaLable.tag = 0;
            
            self.xiaLaLable.text = @"下拉刷新";
            
            [self.activityView stopAnimating];
            
            self.mainScrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
            
        }];
        
    });
    NSLog(@"success");

}



-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    if (scrollView.tag ==1001)
    {
        int specialIndex = scrollView.contentOffset.x/(int)scrollView.frame.size.width;
        NSLog(@"%f",scrollView.contentOffset.x);
        self.vipPageControl.currentPage = specialIndex;

    }
    else
    {
        
    if (scrollView.tag ==100) {
        
      int  sliderIndex = scrollView.contentOffset.x/199*BILI;
        NSDictionary * info = [self.centerArray objectAtIndex:sliderIndex];
        self.classifyTitleLable.text = [info objectForKey:@"name"];
    }
    else
    {
    
    if( scrollView.contentOffset.y+500 > ((scrollView.contentSize.height - scrollView.frame.size.height))&&scrollView.contentOffset.y>0)
    {
        
        if (![@"1" isEqualToString:self.alsoHuanYiPi]) {
            
            NSString *versionAgent = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
            [self.cloudClient loadMoreData:@"8031"
                                 pageIndex:[NSString stringWithFormat:@"%d",pageIndex]
                                  pageSize:@"10"
                                   version:versionAgent
                                   channel:@"appstore"
                                  delegate:self
                                  selector:@selector(getMoreDataSuccess:)
                             errorSelector:@selector(getMoreDataError:)];
        }
       
    }
    }
    }
}


-(void)getMoreDataSuccess:(NSArray *)dataArray;
{
    
    if (dataArray.count!=10) {
        mainTableViewSection = 1;
    }
    else
    {
        mainTableViewSection = 2;
        
    }
    pageIndex++;
    
    for (int i=0; i<dataArray.count; i++) {
        
        NSDictionary * info1 = [dataArray objectAtIndex:i];
        BOOL status = NO;
        for (int j=0; j<self.bottomArray.count; j++) {
            
            NSDictionary * info2 = [self.bottomArray objectAtIndex:j];
            if ([[info1 objectForKey:@"id"] isEqualToString:[info2 objectForKey:@"id"]]) {
                
                status = YES;
                break;
            }
           
            
        }
        if (!status) {
            [self.bottomArray addObject:info1];
        }
        
       
    }
    NSInteger cellNumber=0;
    if (self.bottomArray.count%3==0) {
        
        cellNumber = self.bottomArray.count/3;
    }
    else
    {
        cellNumber = self.bottomArray.count/3+1;
    }

    if (mainTableViewSection ==2) {
     
        self.mainTableView.frame = CGRectMake(self.mainTableView.frame.origin.x, self.mainTableView.frame.origin.y, VIEW_WIDTH, ((VIEW_WIDTH-6*BILI)/3+43*BILI)*cellNumber+50);
        
        [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, self.mainTableView.frame.origin.y+self.mainTableView.frame.size.height)];
        [self.mainTableView reloadData];
    }
    else
    {
        self.mainTableView.frame = CGRectMake(self.mainTableView.frame.origin.x, self.mainTableView.frame.origin.y, VIEW_WIDTH, ((VIEW_WIDTH-6*BILI)/3+43*BILI)*cellNumber);
        [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, self.mainTableView.frame.origin.y+self.mainTableView.frame.size.height)];
        [self.mainTableView reloadData];
    }
    self.mainTableView.separatorStyle = NO;
    
}


-(void)getMoreDataError:(NSDictionary *)info
{
    
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        UIView * tfyixeI15349 = [[UIView alloc]initWithFrame:CGRectMake(95,75,32,12)];
        tfyixeI15349.layer.borderWidth = 1;
        tfyixeI15349.clipsToBounds = YES;
        tfyixeI15349.layer.cornerRadius =7;
        UITableView * yrkqA280 = [[UITableView alloc]initWithFrame:CGRectMake(98,75,49,18)];
        yrkqA280.layer.borderWidth = 1;
        yrkqA280.clipsToBounds = YES;
        yrkqA280.layer.cornerRadius =7;
        UIImageView * arkwsM2367 = [[UIImageView alloc]initWithFrame:CGRectMake(79,42,84,59)];
        arkwsM2367.backgroundColor = [UIColor whiteColor];
        arkwsM2367.layer.borderColor = [[UIColor greenColor] CGColor];
        arkwsM2367.layer.cornerRadius =5;
        
        UITableView * jdbzzsV89099 = [[UITableView alloc]initWithFrame:CGRectMake(12,68,74,13)];
        jdbzzsV89099.layer.borderWidth = 1;
        jdbzzsV89099.clipsToBounds = YES;
        jdbzzsV89099.layer.cornerRadius =8;
        UITableView * ghkbU029 = [[UITableView alloc]initWithFrame:CGRectMake(39,94,14,28)];
        ghkbU029.backgroundColor = [UIColor whiteColor];
        ghkbU029.layer.borderColor = [[UIColor greenColor] CGColor];
        ghkbU029.layer.cornerRadius =5;

        UITableView * wqeshP5536 = [[UITableView alloc]initWithFrame:CGRectMake(87,85,94,30)];
        wqeshP5536.backgroundColor = [UIColor whiteColor];
        wqeshP5536.layer.borderColor = [[UIColor greenColor] CGColor];
        wqeshP5536.layer.cornerRadius =5;
    }
}


-(void)initNavView
{
   
        self.cameraIV = [[UIImageView alloc] initWithFrame:CGRectMake(12, (44-20)/2, 32, 20)];
        self.cameraIV.image = [UIImage imageNamed:@"btn_home_video_close"];
        [self.navView addSubview:self.cameraIV];
        
        self.openOrCloseLable = [[UILabel alloc] initWithFrame:CGRectMake(43, (44-10)/2, 60, 10)];
        self.openOrCloseLable.font = [UIFont systemFontOfSize:10];
        self.openOrCloseLable.textColor = [UIColor blackColor];


 
   

        self.openOrCloseLable.alpha = 0.3;
        self.openOrCloseLable.adjustsFontSizeToFitWidth = YES;
        [self.navView addSubview:self.openOrCloseLable];




        
        self.closeOrOpenButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
        [self.closeOrOpenButton addTarget:self action:@selector(openOrCloseButtonClick) forControlEvents:UIControlEventTouchUpInside];



        [self.navView addSubview:self.closeOrOpenButton];

        
        self.qunFaImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-32*BILI, (self.navView.frame.size.height-20*BILI)/2, 20*BILI, 20*BILI)];
        self.qunFaImageView .image = [UIImage imageNamed:@"btn_shipinqunfa"];
        [self.navView addSubview:self.qunFaImageView];


 

 

        
        self.qunFabutton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-60*BILI, 0, 60*BILI, self.navView.frame.size.height)];
        self.qunFabutton.alpha = 0.8;
        [self.qunFabutton addTarget:self action:@selector(qianBoListButtonclick) forControlEvents:UIControlEventTouchUpInside];



 

        [self.navView addSubview:self.qunFabutton];
        
    self.searchUserButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-60,  (self.navView.frame.size.height-44)/2, 60, 44)];
    [self.searchUserButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.searchUserButton addTarget:self action:@selector(searchUserButtonClick) forControlEvents:UIControlEventTouchUpInside];




    [self.navView addSubview:self.searchUserButton];
    
    UIImageView * rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.searchUserButton.frame.size.width-20*BILI, (44-20*BILI)/2, 20*BILI, 20*BILI)];
    rightImageView.image = [UIImage imageNamed:@"home_btn_search"];
    [self.searchUserButton addSubview:rightImageView];


 
 

    
    
}


-(void)searchUserButtonClick
{
    TanLiao_AddChatterViewController * addChatterVC = [[TanLiao_AddChatterViewController alloc] init];
    [self.navigationController pushViewController:addChatterVC animated:YES];
    

}
-(void)openOrCloseButtonClick
{
    
        if([self.openOrCloseLable.text isEqualToString:@"关闭视频"]||[self.openOrCloseLable.text isEqualToString:@"关闭麦克风"])
        {
            [self.cloudClient openOrCloseCamera:@"8040"
                                         status:@"2"
                                       delegate:self
                                       selector:@selector(closeSuccess:)
                                  errorSelector:@selector(closeError:)];
        }
        else
        {
            [self.cloudClient openOrCloseCamera:@"8040"
                                         status:@"1"
                                       delegate:self
                                       selector:@selector(openSuccess:)
                                  errorSelector:@selector(closeError:)];
        }
        
    

}
-(void)closeSuccess:(NSDictionary *)info
{
    
    
    if([@"2" isEqualToString:[Common getCurrentUserAnchorType]])
    {
        NSString * str ;
        if([@"C" isEqualToString:[Common getRoleStatus]])
        {

            self.openOrCloseLable.text = @"打开麦克风";
            str = @"麦克风已关闭,别人将不能主动和你聊天";
        }
        else
        {
            self.openOrCloseLable.text = @"打开视频";
            str = @"摄像头已关闭,别人将不能主动和你视频";
        }

        self.cameraControlBottomView.hidden = NO;
        self.cameraCloseTipView.hidden = NO;
        [self performSelector:@selector(hiddenCameraTipView) withObject:nil afterDelay:3];

        
        if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
        {
            UIScrollView * awsoN447 = [[UIScrollView alloc]initWithFrame:CGRectMake(67,17,52,90)];
            awsoN447.layer.cornerRadius =5;
            awsoN447.userInteractionEnabled = YES;
            awsoN447.layer.masksToBounds = YES;
        }
        
        
        
        self.cameraIV.image = [UIImage imageNamed:@"btn_home_video_open"];
        
        NSUserDefaults * cameraOpenOrCloseDefault = [NSUserDefaults standardUserDefaults];


 


        [cameraOpenOrCloseDefault setObject:@"close" forKey:@"cameraOpenOrClose"];
        [cameraOpenOrCloseDefault synchronize];





    }
    else
    {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:@"回拨设置已关闭,将不会接收到主播的回拨求情" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];



        [self.view addSubview:alertView];



 

        self.alsoJieShouHuiBo = @"打开回拨";
        self.cameraIV.image = [UIImage imageNamed:@"jvJueHuiBo.jpg"];
    }
}
-(void)hiddenCameraTipView
{
    self.cameraControlBottomView.hidden = YES;
    self.cameraCloseTipView.hidden = YES;
    self.cameraOpenTipView.hidden = YES;
}
-(void)openSuccess:(NSDictionary *)info
{
   
    
    if([@"2" isEqualToString:[Common getCurrentUserAnchorType]])
    {
        NSString * str ;
        if([@"C" isEqualToString:[Common getRoleStatus]])
        {
            
            str = @"麦克风已打开";
            self.openOrCloseLable.text = @"关闭麦克风";
        }
        else
        {
            str = @"摄像头已打开";
            self.openOrCloseLable.text = @"关闭视频";
        }
//        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [alertView show];
//        [self.view addSubview:alertView];


 

        self.cameraControlBottomView.hidden = NO;
        self.cameraOpenTipView.hidden = NO;
        [self performSelector:@selector(hiddenCameraTipView) withObject:nil afterDelay:3];

        
        self.cameraIV.image = [UIImage imageNamed:@"btn_home_video_close"];
        
        NSUserDefaults * cameraOpenOrCloseDefault = [NSUserDefaults standardUserDefaults];




        [cameraOpenOrCloseDefault setObject:@"open" forKey:@"cameraOpenOrClose"];
        [cameraOpenOrCloseDefault synchronize];




        
    }
    else
    {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:@"回拨设置已打开,将会接收到主播的回拨请求" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];


 

 

        [self.view addSubview:alertView];




        self.alsoJieShouHuiBo = @"关闭回拨";
        self.cameraIV.image = [UIImage imageNamed:@"jieShouHuiBo.jpg"];
    }
  
}
-(void)closeError:(NSDictionary *)info
{

}


-(void)searchButtonClick
{
    
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        UILabel * zsyfI206 = [[UILabel alloc]initWithFrame:CGRectMake(95,16,97,23)];
        zsyfI206.backgroundColor = [UIColor whiteColor];
        zsyfI206.layer.borderColor = [[UIColor greenColor] CGColor];
        zsyfI206.layer.cornerRadius =10;
    }
    NSLog(@"开始搜索");
    TanLiaoLiao_LoginViewController * addInformationVC = [[TanLiaoLiao_LoginViewController alloc] init];
    [self.navigationController pushViewController:addInformationVC animated:YES];
}


-(void)initMainTopView
{
    
    UIImageView * tipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(6*BILI, VIEW_WIDTH*210/750+6*BILI, 60*BILI, 15*BILI)];
    tipImageView.image = [UIImage imageNamed:@"hp_pic_guangbo"];
    [self.mainScrollView addSubview:tipImageView];


 

    
    NSDictionary * info = [self.sourceTipsArray objectAtIndex:0];
    self.guanBoLable1 = [[UILabel alloc] initWithFrame:CGRectMake(152*BILI/2, VIEW_WIDTH*210/750, VIEW_WIDTH-152*BILI/2, 27*BILI)];
    self.guanBoLable1.font = [UIFont systemFontOfSize:12*BILI];
    self.guanBoLable1.text = [info objectForKey:@"content"];
    self.guanBoLable1.textColor =UIColorFromRGB(0xFF6146);
    [self.mainScrollView addSubview:self.guanBoLable1];
    
    self.guanBoLable2 = [[UILabel alloc] initWithFrame:CGRectMake(152*BILI/2, VIEW_WIDTH*210/750+27*BILI, VIEW_WIDTH-152*BILI/2, 27*BILI)];
    self.guanBoLable2.font = [UIFont systemFontOfSize:12*BILI];
    self.guanBoLable2.textColor =UIColorFromRGB(0xFF6146);
    [self.mainScrollView addSubview:self.guanBoLable2];
    
    
   
    NSMutableArray *imageArray2 = [[NSMutableArray alloc] init];


 

    for (int i=0; i<self.topArray.count; i++) {
        
        NSDictionary * info = [self.topArray objectAtIndex:i];
        
     [imageArray2 addObject:[info objectForKey:@"url"]]   ;
    }
    
    if (!self.headerScrollView) {
        self.headerScrollView = [[JYCarousel alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH,  VIEW_WIDTH*210/750) configBlock:^JYConfiguration *(JYConfiguration *carouselConfig) {
            carouselConfig.pageContollType = MiddlePageControl;
            carouselConfig.pageTintColor = [UIColor whiteColor];


 

            carouselConfig.currentPageTintColor = [UIColor lightGrayColor];


 


            carouselConfig.placeholder = [UIImage imageNamed:@"default"];
            carouselConfig.faileReloadTimes = 5;
            return carouselConfig;
        } target:self];
        
        [self.mainScrollView addSubview:self.headerScrollView];



 

    }
    //开始轮播
    [self.headerScrollView startCarouselWithArray:imageArray2];

    [self createMiddleScrollView];

    info = [self.sourceTipsArray objectAtIndex:1];
    sourceTipIndex = 2;
    [self performSelector:@selector(huan:) withObject:[info objectForKey:@"content"] afterDelay:3];
    
}
- (void)carouselViewClick:(NSInteger)index{

    
    if (self.topArray.count>index) {
        
        
        NSDictionary * info = [self.topArray objectAtIndex:index];
        if ([@"2" isEqualToString:[info objectForKey:@"type"]]) {
            
            TanLiaoLiao_ShareRewardViewController * shareVC = [[TanLiaoLiao_ShareRewardViewController alloc] init];


            [self.navigationController pushViewController:shareVC animated:YES];
        }
        else
        {
            TanLiaoLiao_HomeWebViewController * homeWebVC = [[TanLiaoLiao_HomeWebViewController alloc] init];

        homeWebVC.url = [info objectForKey:@"path"];
        [self.navigationController pushViewController:homeWebVC animated:YES];
        }
        
    }
    
}


- (void)createMiddleScrollView {
    
    [self createMainTableView];

}


-(void)initClassifyView
{
    
    
    self.classifyTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.headerScrollView.frame.origin.y+self.headerScrollView.frame.size.height,VIEW_WIDTH , 40*BILI)];
    self.classifyTitleLable.font = [UIFont boldSystemFontOfSize:18*BILI];
    self.classifyTitleLable.textAlignment = NSTextAlignmentCenter;
    self.classifyTitleLable.textColor =UIColorFromRGB(0xff6666);
    self.classifyTitleLable.text = @"新人报道";
    self.classifyTitleLable.backgroundColor = [UIColor whiteColor];




    [self.mainScrollView addSubview:self.classifyTitleLable];



    
    
   UIImageView * imageViewLeft = [[UIImageView alloc] initWithFrame:CGRectMake(121*BILI,self.classifyTitleLable.frame.origin.y+ 12*BILI, 16*BILI, 16*BILI)];
    imageViewLeft.image = [UIImage imageNamed:@"btn_left"];
    [self.mainScrollView addSubview:imageViewLeft];


 


    
    UIImageView * imageViewRight = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-16*BILI-121*BILI, self.classifyTitleLable.frame.origin.y+12*BILI, 16*BILI, 16*BILI)];
    imageViewRight.image = [UIImage imageNamed:@"btn_right"];
    [self.mainScrollView addSubview:imageViewRight];



    
        WSPageView *pageView = [[WSPageView alloc]initWithFrame:CGRectMake(0, self.headerScrollView.frame.origin.y+self.headerScrollView.frame.size.height+40*BILI, VIEW_WIDTH, 96*BILI)];
        pageView.delegate = self;
        pageView.dataSource = self;
        pageView.minimumPageAlpha = 0.4;   //非当前页的透明比例
        pageView.minimumPageScale = 1;  //非当前页的缩放比例
        pageView.orginPageCount = self.centerArray.count; //原始页数
        pageView.autoTime = 4;    //自动切换视图的时间,默认是5.0
        [self.mainScrollView addSubview:pageView] ;
    
    /*
    UIScrollView * sliderScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-199*BILI)/2, self.headerScrollView.frame.origin.y+self.headerScrollView.frame.size.height+40*BILI, 199*BILI, (24+16+96)*BILI)];
    sliderScrollView.showsVerticalScrollIndicator = FALSE;
    sliderScrollView.showsHorizontalScrollIndicator = FALSE;
    sliderScrollView.pagingEnabled = YES;
    sliderScrollView.clipsToBounds = NO;
    sliderScrollView.tag = 100;
    sliderScrollView.delegate = self;
    [self.mainScrollView addSubview:sliderScrollView];


 
if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
{
  UILabel * glwaqN0421 = [[UILabel alloc]initWithFrame:CGRectMake(100,31,58,65)];
  glwaqN0421.layer.borderWidth = 1;
  glwaqN0421.clipsToBounds = YES;
  glwaqN0421.layer.cornerRadius =6;
}
 


    
    for (int i=0; i<self.centerArray.count; i++)
    {
        
        NSDictionary * info = [self.centerArray objectAtIndex:i];
        CustomImageView * imageView = [[CustomImageView alloc] initWithFrame:CGRectMake((199*BILI)*i, 0*BILI, 189*BILI, 96*BILI)];
        imageView.urlPath = [info objectForKey:@"url"];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.layer.cornerRadius = 8*BILI;
        imageView.layer.masksToBounds = YES;
        imageView.tag = i;
        imageView.userInteractionEnabled = YES;
        [sliderScrollView addSubview:imageView];


 


        
        UITapGestureRecognizer * classifyImageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(classifyImageTap:)];
        [imageView addGestureRecognizer:classifyImageTap];
   }
    [sliderScrollView setContentSize:CGSizeMake(self.centerArray.count*(199*BILI)+10*BILI, sliderScrollView.frame.size.height)];
    if (self.centerArray.count>=3) {
        
        [sliderScrollView setContentOffset:CGPointMake(199*BILI, 0) animated:YES];
        NSDictionary * info = [self.centerArray objectAtIndex:1];
        self.classifyTitleLable.text = [info objectForKey: @"name"] ;
    }
    else
    {
        if (self.centerArray.count>=1) {
            NSDictionary * info = [self.centerArray objectAtIndex:0];
            self.classifyTitleLable.text = [info objectForKey: @"name"] ;
        }
        
    }
    */
}
-(void)classifyImageTap:(UITapGestureRecognizer *)tap
{
    
    
    UIImageView * imageView = (UIImageView *)tap.view;
    KuaiLiao_AnchorClassifyViewController * anchorVC = [[KuaiLiao_AnchorClassifyViewController alloc] init];


 

 

    NSDictionary * info = [self.centerArray objectAtIndex:imageView.tag];
    NSString * type = [info objectForKey:@"type"];
    NSLog(@"%@",info);
    anchorVC.index = type;
    [self.navigationController pushViewController:anchorVC animated:YES];
}

#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(WSPageView *)flowView {
    
    return CGSizeMake(VIEW_WIDTH-150*BILI,flowView.frame.size.height);
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
    
    
    KuaiLiao_AnchorClassifyViewController * anchorVC = [[KuaiLiao_AnchorClassifyViewController alloc] init];


 


     NSDictionary * info = [self.centerArray objectAtIndex:subIndex];
    NSString * type = [info objectForKey:@"type"];
    NSLog(@"%@",info);
    anchorVC.index = type;
    [self.navigationController pushViewController:anchorVC animated:YES];
    
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(WSPageView *)flowView {
    return self.centerArray.count;
}

- (UIView *)flowView:(WSPageView *)flowView cellForPageAtIndex:(NSInteger)index{
    WSIndexBanner *bannerView = (WSIndexBanner *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[WSIndexBanner alloc] initWithFrame:CGRectMake(0, 0*BILI, VIEW_WIDTH-150, 96*BILI)];
    }
    NSDictionary * info = [self.centerArray objectAtIndex:index];
    bannerView.mainImageView.urlPath = [info objectForKey:@"url"];
    return bannerView;
    
    
}
- (void)didScrollToPage:(float)contentOffsetX inFlowView:(WSPageView *)flowView {
    
    float width = VIEW_WIDTH-150;
   // NSLog(@"滚动到了第%f页,%f,!!!%d",contentOffsetX,VIEW_WIDTH-150,((int)contentOffsetX/(int)width)%self.centerArray.count);
       NSDictionary * info = [self.centerArray objectAtIndex:(((int)contentOffsetX/(int)width)+1)%self.centerArray.count];



        self.classifyTitleLable.text = [info objectForKey:@"name"];
}



-(void)createMainTableView
{
    
    mainTableViewSection = 2;
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, (210+54)*BILI/2, VIEW_WIDTH, VIEW_WIDTH)];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = NO;
    [self.mainScrollView addSubview:self.mainTableView];

    
    NSInteger cellNumber=0;
    if (self.bottomArray.count%3==0) {
        
        cellNumber = self.bottomArray.count/3;
    }
    else
    {
        cellNumber = self.bottomArray.count/3+1;
    }
    
    self.mainTableView.frame = CGRectMake(self.mainTableView.frame.origin.x, self.mainTableView.frame.origin.y, VIEW_WIDTH, ((VIEW_WIDTH-6*BILI)/3+43*BILI)*cellNumber+50);
    
    if ([@"1" isEqualToString:self.alsoHuanYiPi])
    {
        
        UILabel * bottomTipLable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.mainTableView.frame.size.height+self.mainTableView.frame.size.height-500, VIEW_WIDTH, 50)];
        bottomTipLable.font = [UIFont systemFontOfSize:12*BILI];
        bottomTipLable.textColor = UIColorFromRGB(0x999999);
        
        NSString * describle = @"为了让您一眼尽收美景  我们已经没有底限了~";
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:describle];


 


        [attributedString addAttribute:NSForegroundColorAttributeName
                                 value:UIColorFromRGB(0xff6666)
                                 range:NSMakeRange(16
                                                   , 4)];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];



        //调整行间距
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [describle length])];
        bottomTipLable.attributedText = attributedString;
        bottomTipLable.textAlignment = NSTextAlignmentCenter;
       // [self.mainScrollView addSubview:bottomTipLable];


 

 

    }
   
    
    [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, self.mainTableView.frame.origin.y+self.mainTableView.frame.size.height)];
    
    
}

#pragma mark---UITableViewDelegate
//有几组数据
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([@"1" isEqualToString:self.alsoHuanYiPi]) {
        
        return 1;
    }
    else
    {
        return mainTableViewSection;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger cellNumber=0;
    
    if(section == 0)
    {
        if (self.bottomArray.count%3==0) {
            
            cellNumber = self.bottomArray.count/3;
        }
        else
        {
            cellNumber = self.bottomArray.count/3+1;
        }
    }
    else
    {
        return 1;
    }
    
    
    
    return cellNumber;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return  (VIEW_WIDTH-6*BILI)/3+43*BILI;
    }
    else
    {
        return  50;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section ==0) {
        NSString *tableIdentifier = [NSString stringWithFormat:@"HomePageTableViewCell"];
        TanLiaoLiao_NewHomePageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];



   

          //NewHomePageTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell == nil)
        {
            cell = [[TanLiaoLiao_NewHomePageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];



   

        }
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if ((indexPath.row+1)*3<=self.bottomArray.count)
        {
            [cell initData:[self.bottomArray objectAtIndex:indexPath.row*3] data2:[self.bottomArray objectAtIndex:indexPath.row*3+1] data3:[self.bottomArray objectAtIndex:indexPath.row*3+2]];
        }
        else
        {
            if ((indexPath.row+1)*3-1==self.bottomArray.count)
            {
                [cell initData:[self.bottomArray objectAtIndex:indexPath.row*3] data2:[self.bottomArray objectAtIndex:indexPath.row*3+1] data3:nil];
            }
            if ((indexPath.row+1)*3-2==self.bottomArray.count)
            {
                [cell initData:[self.bottomArray objectAtIndex:indexPath.row*3] data2:nil data3:nil];
            }
            
        }

        
        return cell;
    }
    else
    {
        static NSString *tableIdentifier = @"SearchListDownloadTableViewCell";
        SearchListDownloadTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];


   

        if (cell == nil)
        {
            cell = [[SearchListDownloadTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];


 


        }
        [cell initData:nil];
        return cell;
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self setTabBarShow];

 

    
    
    self.tabBarController.tabBar.hidden = YES;
    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    NSString *versionAgent = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];

 
        [self.cloudClient getHomePageData:@"8026"
                                  version:versionAgent
                                  channel:@"appstore"
                                 delegate:self
                                 selector:@selector(getHomeDataUpdateViewSuccess:)
                            errorSelector:@selector(getHomeDataError:)];
    
    
    if([@"2" isEqualToString:[Common getCurrentUserAnchorType]])
    {
    
    NSUserDefaults * cameraOpenOrCloseDefault = [NSUserDefaults standardUserDefaults];




    //主播是否手动关闭摄像头
    NSString * cameraStatusStr = [cameraOpenOrCloseDefault objectForKey:@"cameraOpenOrClose"];
    if([@"close" isEqualToString:cameraStatusStr])
    {
        [self.cloudClient getOnlineStatus:@"8042"
                                 delegate:self
                                 selector:@selector(getOnlineStatusSuccess:)
                            errorSelector:@selector(getHomeDataError:)];
    }
    else
    {
        [self.cloudClient openOrCloseCamera:@"8040"
                                     status:@"1"
                                   delegate:self
                                   selector:@selector(openSuccess1:)
                              errorSelector:@selector(closeError:)];
    }
    }
    else
    {
        
        [self.cloudClient getOnlineStatus:@"8042"
                                 delegate:self
                                 selector:@selector(getOnlineStatusSuccess:)
                            errorSelector:@selector(getHomeDataError:)];
    }
    
  //获取充值金额列表在视频界面用
    [self.cloudClient getRechargeList:@"8069"
                             delegate:self
                             selector:@selector(getRechargeListSuccess:)
                        errorSelector:@selector(getRechargeListError:)];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(keyboardWillShow:)
     name:UIKeyboardWillShowNotification
     object:self.view.window];


 


    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark--键盘弹出时的监听事件
- (void)keyboardWillShow:(NSNotification *) notification
{
    CGRect keyboardBounds;
    [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];


    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    //键盘高度
   // float keyboardHeight = keyboardBounds.size.height;
    
    self.anchorPingJiaView.frame = CGRectMake((VIEW_WIDTH-526*BILI/2)/2, 122*BILI-50*BILI, 526*BILI/2, 690*BILI/2);
}
-(void)keyboardWillHide
{

    self.anchorPingJiaView.frame = CGRectMake((VIEW_WIDTH-526*BILI/2)/2, 122*BILI, 526*BILI/2, 690*BILI/2);
}


-(void)getRechargeListSuccess:(NSArray *)array
{
    NSMutableArray * sourceArray = [NSMutableArray array];
    for (int i=0; i<array.count; i++) {
        
        NSNumber * number = [array objectAtIndex:i];
        NSString * money = [NSString stringWithFormat:@"%d",number.intValue/100];
        [sourceArray addObject:money];
    }
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];



   

    [defaults setObject:sourceArray forKey:@"chongeZhiRechargeList"];
    [defaults synchronize];




}


-(void)getRechargeListError:(NSDictionary *)info
{
}

-(void)openSuccess1:(NSDictionary *)info
{
    if ([@"2" isEqualToString:[Common getCurrentUserAnchorType]]) {
        
        if([@"C" isEqualToString:[Common getRoleStatus]])
        {
            self.openOrCloseLable.text = @"关闭麦克风";
        }
        else
        {
            self.openOrCloseLable.text = @"关闭视频";
        }
        self.cameraIV.image = [UIImage imageNamed:@"btn_home_video_close"];
    }
    else
    {
        self.alsoJieShouHuiBo = @"关闭回拨";
        self.cameraIV.image = [UIImage imageNamed:@"jieShouHuiBo.jpg"];
    }
   
   
}


-(void)getOnlineStatusSuccess:(NSDictionary *)info
{
    if([@"2" isEqualToString:[Common getCurrentUserAnchorType]])
    {
    
    if([@"1" isEqualToString:[info objectForKey:@"onlineStatus"]])
    {
        if([@"C" isEqualToString:[Common getRoleStatus]])
        {
            self.openOrCloseLable.text = @"关闭麦克风";
        }
        else
        {
            self.openOrCloseLable.text = @"关闭视频";
        }
        
        self.cameraIV.image = [UIImage imageNamed:@"btn_home_video_close"];
    }
    else
    {
        
        if([@"C" isEqualToString:[Common getRoleStatus]])
        {
           self.openOrCloseLable.text = @"打开麦克风";
        }
        else
        {
            self.openOrCloseLable.text = @"打开视频";
        }
        self.cameraIV.image = [UIImage imageNamed:@"btn_home_video_open"];
        
        NSUserDefaults * defaultsCamera = [NSUserDefaults standardUserDefaults];


 


        NSString * cameraStatusStr = [defaultsCamera objectForKey:@"defaultsCamera"];
        
            if ([@"cameraCloesd" isEqualToString:cameraStatusStr]) {
                
                NSString * str ;
                if([@"C" isEqualToString:[Common getRoleStatus]])
                {
                    str = @"麦克风已关闭,别人将不能主动和你聊天";
                }
                else
                {
                    str = @"摄像头已关闭,别人将不能主动和你视频";
                }
                
                [defaultsCamera removeObjectForKey:@"defaultsCamera"];
                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertView show];




                [self.view addSubview:alertView];




                
            }
        
    }
    }
    else
    {
       if([@"1" isEqualToString:[info objectForKey:@"onlineStatus"]])
       {
           
           self.alsoJieShouHuiBo = @"关闭回拨";
           self.cameraIV.image = [UIImage imageNamed:@"jieShouHuiBo.jpg"];

       }
        else
        {
            
            self.alsoJieShouHuiBo = @"打开回拨";
            self.cameraIV.image = [UIImage imageNamed:@"jvJueHuiBo.jpg"];

        }
    }
}

-(void)newPushToAnchorDatailVC:(NSDictionary *)info
{
    TanLiaoLiao_AnchorDetailMessageViewController * anchorDetailVC = [[TanLiaoLiao_AnchorDetailMessageViewController alloc] init];



    anchorDetailVC.anchorId = [info objectForKey:@"id"];
    [self.navigationController pushViewController:anchorDetailVC animated:YES];
}



-(void)getAllGiftMessageNotification:(NSNotification *)notification
{
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        
        NSDictionary * messageInfo = [notification object];


 

        NSString * sourceStr = [NSString stringWithFormat:@"%@ 赠送给 %@ 一个%@", [messageInfo objectForKey:@"nick"],[messageInfo objectForKey:@"targetName"],[messageInfo objectForKey:@"name"]];
//        if ([@"finish" isEqualToString:self.animationAlsoFisish])
//        {
//            self.animationAlsoFisish = @"noFinish";
//            [weakSelf huan:sourceStr];




//        }
//        else
//        {
            [weakSelf.songLiArray addObject:sourceStr];



   

      //  }
    });
    
    
}
-(void)huan:(NSString *)str
{
    if ((int)self.guanBoLable1.frame.origin.y==(int)(VIEW_WIDTH*210/750))
    {
        
        self.guanBoLable2.text = str;
        [UIView animateWithDuration:1
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             
                             self.guanBoLable1.frame = CGRectMake(self.guanBoLable1.frame.origin.x, VIEW_WIDTH*210/750-27*BILI, self.guanBoLable1.frame.size.width, self.guanBoLable1.frame.size.height);
                             self.guanBoLable1.alpha = 1;
                             
                             self.guanBoLable2.frame = CGRectMake(self.guanBoLable2.frame.origin.x, VIEW_WIDTH*210/750, self.guanBoLable2.frame.size.width, self.guanBoLable2.frame.size.height);
                             self.guanBoLable2.alpha = 1;
                             
                         } completion:^(BOOL finished) {
                             
                             [self performSelector:@selector(nextAnimation1) withObject:nil afterDelay:2];
                             
                         }];
    }
    else
    {
        self.guanBoLable1.text = str;
        [UIView animateWithDuration:1
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             
                             self.guanBoLable1.frame = CGRectMake(self.guanBoLable2.frame.origin.x, VIEW_WIDTH*210/750, self.guanBoLable2.frame.size.width, self.guanBoLable2.frame.size.height);
                             self.guanBoLable1.alpha = 1;
                             
                             self.guanBoLable2.frame = CGRectMake(self.guanBoLable1.frame.origin.x, VIEW_WIDTH*210/750-27*BILI, self.guanBoLable1.frame.size.width, self.guanBoLable1.frame.size.height);
                             self.guanBoLable2.alpha = 1;
                             
                         } completion:^(BOOL finished) {
                             
                             [self performSelector:@selector(nextAnimation2) withObject:nil afterDelay:2];
                         }];
    }
}
-(void)nextAnimation1
{
    self.guanBoLable1.text = @"";
    self.guanBoLable1.frame = CGRectMake(self.guanBoLable1.frame.origin.x, VIEW_WIDTH*210/750+27*BILI, self.guanBoLable1.frame.size.width, self.guanBoLable1.frame.size.height);
    self.animationAlsoFisish = @"finish";

    if (self.songLiArray.count>0)
    {
        
        [self huan:[self.songLiArray objectAtIndex:0]];
        [self.songLiArray removeObjectAtIndex:0];
        
    }
    else
    {
        if (sourceTipIndex>self.sourceTipsArray.count-1) {
            
            sourceTipIndex = 0;
        }
        NSDictionary * info = [self.sourceTipsArray objectAtIndex:sourceTipIndex];
        [self huan:[info objectForKey:@"content"]];
        sourceTipIndex++;
    }
}
-(void)nextAnimation2
{
    self.guanBoLable2.text = @"";
    self.guanBoLable2.frame = CGRectMake(self.guanBoLable1.frame.origin.x, VIEW_WIDTH*210/750+27*BILI, self.guanBoLable1.frame.size.width, self.guanBoLable1.frame.size.height);
    self.animationAlsoFisish = @"finish";
    if (self.songLiArray.count>0)
    {
        
        [self huan:[self.songLiArray objectAtIndex:0]];
        [self.songLiArray removeObjectAtIndex:0];
        
    }
    else
    {
        if (sourceTipIndex>self.sourceTipsArray.count-1) {
            
            sourceTipIndex = 0;
        }
        NSDictionary * info = [self.sourceTipsArray objectAtIndex:sourceTipIndex];
        [self huan:[info objectForKey:@"content"]];
        sourceTipIndex++;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
