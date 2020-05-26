
//
//  NewHomeViewController.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/4/16.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiaoLiao_NewHomeViewController.h"
#import "NTESVideoChatViewController.h"
#import "TanLiaoLiao_VideoLocationViewController.h"

@interface TanLiaoLiao_NewHomeViewController ()
{
    TanLiaoLiao_HP_GuanZhuViewController * guanZhuVC;
    TanLiaoLiao_HP_TuiJianViewController * tuiJianVC;
    KuaiLiao_AnchorClassifyViewController * anchorClassifyVC;
    TanLiaoLiao_HP_YuLiaoViewController * yuLiaoVC;

}

@end

@implementation TanLiaoLiao_NewHomeViewController

//监听购买结果
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transaction{
    for(SKPaymentTransaction *tran in transaction){
        
        switch (tran.transactionState) {
            case SKPaymentTransactionStatePurchased:
                //苹果支付完成 开始服务器端校验
                [self buyAppleStoreProductSucceedWithPaymentTransactionp:tran];
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
                NSLog(@"交易完成");
                break;
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"商品添加进列表");
                
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"已经购买过商品");
                
                break;
            case SKPaymentTransactionStateFailed:
                NSLog(@"交易失败");
                [self hideNewLoadingView];
                
                break;
            dereceiptDatafault:
                break;
        }
    }
}

// 苹果内购支付成功
- (void)buyAppleStoreProductSucceedWithPaymentTransactionp:(SKPaymentTransaction *)paymentTransactionp {
    
    //    NSURL *receiptUrl = [[NSBundle mainBundle] appStoreReceiptURL];
    //    NSData *receiptData = [NSData dataWithContentsOfURL:receiptUrl];
    //    NSString  *transactionReceiptString = [receiptData base64EncodedStringWithOptions:0];
    /* 获取相应的凭据，并做 base64 编码处理 */
    NSString *base64Str = [paymentTransactionp.transactionReceipt base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSArray * benDiBase64Array = [defaults objectForKey:@"BenDiCunChuBase64Key"];//存储苹果支付返回的base64的数组
    NSMutableArray * base64Array;
    if ([benDiBase64Array isKindOfClass:[NSArray class]]&&benDiBase64Array.count>0) {
        
        base64Array = [[NSMutableArray alloc] initWithArray:benDiBase64Array];
        
    }
    else
    {
        base64Array = [NSMutableArray array];
    }
    [base64Array addObject:base64Str];
    benDiBase64Array = [[NSArray alloc] initWithArray:base64Array];
    NSSet * set = [NSSet setWithArray:benDiBase64Array];
    benDiBase64Array = [set allObjects];
    [defaults setObject:benDiBase64Array forKey:@"BenDiCunChuBase64Key"];
    [defaults synchronize];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
     [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];

    
    self.leftButton.hidden = YES;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIButton * searchUserButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-60,  (self.navView.frame.size.height-44)/2, 60, 44)];
    [searchUserButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [searchUserButton addTarget:self action:@selector(searchUserButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:searchUserButton];
    
    UIImageView * rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.rightButton.frame.size.width-18*BILI-12*BILI, (44-20*BILI)/2, 20*BILI, 20*BILI)];
    rightImageView.image = [UIImage imageNamed:@"home_btn_search"];
    [searchUserButton addSubview:rightImageView];


    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height)-SafeAreaBottomHeight)];
    [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH*4, self.mainScrollView.frame.size.height)];
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    self.mainScrollView.showsVerticalScrollIndicator = NO;
    self.mainScrollView.pagingEnabled = YES;
    self.mainScrollView.delegate = self;
     [self.view addSubview:self.mainScrollView];

    [self initTopButton];
    
    [self initTabViews];


    [self getVersionInfo];
    
    //每次杀掉app重新进入给用户推送主播
    [self.cloudClient pushAnchorToUser:@"8071"
                              delegate:self
                              selector:@selector(pushSuccess:)
                         errorSelector:@selector(pushSuccess:)];
    
    //获取主播评价的标签
    [self.cloudClient getAnchorTipsList:@"8151"
                               delegate:self
                               selector:@selector(getAnchorTipsSuccess:)
                          errorSelector:@selector(getAnchorTipsError:)];
    
    //获取充值金额列表在视频界面用
    [self.cloudClient getRechargeList:@"8069"
                             delegate:self
                             selector:@selector(getRechargeListSuccess:)
                        errorSelector:@selector(getAnchorTipsError:)];
    
    [self.cloudClient getNewHomeMessage:@"8141"
                               delegate:self
                               selector:@selector(getHomeDataSuccess:)
                          errorSelector:@selector(getDataError:)];
    
    //主播评价弹框
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showAnchorPingJiaView:) name:@"showAnchorPingJiaView" object:nil];
    //推荐用户弹框
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showAnchorTuiJianView) name:@"showAnchorTuiJianView" object:nil];
    
    //主播评价弹框
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeNotification) name:@"removeNotification" object:nil];
    
   
}


-(void)getHomeDataSuccess:(NSDictionary *)info
{
    
    self.sharePath = [info objectForKey:@"userSharePicUrl"];
    
    //0是 不使用openinstall，1是使用openinstall
    if([@"0" isEqualToString:[info objectForKey:@"isUserOpenInstall"]])
    {
        //分享图片
        [self.cloudClient getShareImage:@"8038"
                               delegate:self
                               selector:@selector(getShareImageSuccess:)
                          errorSelector:@selector(getShareImageError:)];
    }else
    {
        [self initRenwWuView];


 


    }
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[info objectForKey:@"isUserOpenInstall"] forKey:@"isUserOpenInstall"];
    [defaults synchronize];

    
}


-(void)getShareImageSuccess:(NSDictionary *)info
{
    
    self.shareImagePath =  [info objectForKey:@"sharePic"];
    
    if ([@"1" isEqualToString:[info objectForKey:@"shareStatus"]])
    {
        
        if(![@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
        {
            [self initShareView:info];
            
            
        }
    }
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



    self.shareCloseButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-40*BILI)/2, self.shareView.frame.origin.y+self.shareView.frame.size.height+20, 40*BILI, 40*BILI)];
    [self.shareCloseButton setBackgroundImage:[UIImage imageNamed:@"btn_close1"] forState:UIControlStateNormal];
    [self.shareCloseButton addTarget:self action:@selector(shareCloseButtonClick) forControlEvents:UIControlEventTouchUpInside];


 
    
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.shareCloseButton];
    
    
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
    self.shareCloseButton.hidden = YES;
}


-(void)shareCloseButtonClick
{
    blackBottomView.hidden = YES;
    self.shareView.hidden = YES;
    self.shareCloseButton.hidden = YES;
    
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
                 self.shareCloseButton.hidden = YES;
                 [self shareSuccessGetJinBi];
                 titel = @"分享成功";
                 typeStr = @"成功";
                 typeColor = [UIColor blueColor];




                 [TanLiao_Common showToastView:@"分享成功" view:self.view];


 


                 break;
             }
             case SSDKResponseStateFail:
             {
                 message = [NSString stringWithFormat:@"%@", error];


                 if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
                 {
                     UITextView * ikgtqmH35542 = [[UITextView alloc]initWithFrame:CGRectMake(24,80,28,90)];
                     ikgtqmH35542.backgroundColor = [UIColor whiteColor];
                     ikgtqmH35542.layer.borderColor = [[UIColor greenColor] CGColor];
                     ikgtqmH35542.layer.cornerRadius =5;
                 }
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
                 self.shareCloseButton.hidden = YES;
                 [self shareSuccessGetJinBi];
                 titel = @"分享成功";
                 typeStr = @"成功";
                 typeColor = [UIColor blueColor];


 

                 [TanLiao_Common showToastView:@"分享成功" view:self.view];


 

                 
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



-(void)getShareImageError:(NSDictionary *)info
{
    
}


-(void)getDataError:(NSDictionary *)info
{
    
}
-(void)removeNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"showAnchorPingJiaView" object:nil];
     [[NSNotificationCenter defaultCenter] removeObserver:self name:@"showAnchorTuiJianView" object:nil];
     [[NSNotificationCenter defaultCenter] removeObserver:self name:@"removeNotification" object:nil];
}
-(void)pushSuccess:(NSDictionary *)info
{
    
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

-(void)searchUserButtonClick
{
    TanLiao_AddChatterViewController * addChatterVC = [[TanLiao_AddChatterViewController alloc] init];
    [self.navigationController pushViewController:addChatterVC animated:YES];
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




    
    TanLiaoCustomImageView * tipImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-690*BILI/2)/2, 130*BILI/2, 690*BILI/2, 690*BILI/2)];
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
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self setTabBarShow];
    [self.cloudClient getWalletMes:[TanLiao_Common getNowUserID]
                             apiId:@"8005"
                          delegate:self
                          selector:@selector(getUserInformationSuccess:)
                     errorSelector:@selector(getUserInformationError:)];
}


-(void)getUserInformationSuccess:(NSDictionary *)info
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[info objectForKey:@"gold_number"] forKey:@"nowMoneyNumber"];
    [defaults synchronize];

}


-(void)getUserInformationError:(NSDictionary *)info
{
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
    [self stopYuLiaoYuYinPlay];
}


-(void)initTopButton
{
    float buttonDistance = (VIEW_WIDTH-184*BILI-160*BILI)/3;
    float buttonWidth = 40*BILI;
    self.guanZhuButton = [[UIButton alloc] initWithFrame:CGRectMake(217*BILI/2, 0, buttonWidth, self.navView.frame.size.height)];
    [self.guanZhuButton setTitle:@"关注" forState:UIControlStateNormal];
    [self.guanZhuButton setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
    self.guanZhuButton.titleLabel.font = [UIFont systemFontOfSize:15*BILI];
    self.guanZhuButton.tag = 0;
    [self.guanZhuButton addTarget:self action:@selector(topButtonClick:) forControlEvents:UIControlEventTouchUpInside];



    [self.navView addSubview:self.guanZhuButton];
    
    self.tuiJianButton = [[UIButton alloc] initWithFrame:CGRectMake(self.guanZhuButton.frame.origin.x+self.guanZhuButton.frame.size.width+25*BILI, 0, buttonWidth, self.navView.frame.size.height)];
    [self.tuiJianButton setTitle:@"推荐" forState:UIControlStateNormal];
    [self.tuiJianButton setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
    self.tuiJianButton.titleLabel.font = [UIFont systemFontOfSize:15*BILI];
    self.tuiJianButton.tag = 1;
    [self.tuiJianButton addTarget:self action:@selector(topButtonClick:) forControlEvents:UIControlEventTouchUpInside];



    [self.navView addSubview:self.tuiJianButton];

    
    self.reMenButton = [[UIButton alloc] initWithFrame:CGRectMake(self.tuiJianButton.frame.origin.x+self.tuiJianButton.frame.size.width+25*BILI, 0, buttonWidth, self.navView.frame.size.height)];
    [self.reMenButton setTitle:@"热门" forState:UIControlStateNormal];
    [self.reMenButton setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
    self.reMenButton.titleLabel.font = [UIFont systemFontOfSize:15*BILI];
    self.reMenButton.tag = 2;
    [self.reMenButton addTarget:self action:@selector(topButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:self.reMenButton];
    
//    self.yuLiaoButton = [[UIButton alloc] initWithFrame:CGRectMake(self.reMenButton.frame.origin.x+self.reMenButton.frame.size.width+buttonDistance, 0, buttonWidth, self.navView.frame.size.height)];
//    [self.yuLiaoButton setTitle:@"语聊" forState:UIControlStateNormal];
//    [self.yuLiaoButton setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
//    self.yuLiaoButton.titleLabel.font = [UIFont systemFontOfSize:15*BILI];
//    self.yuLiaoButton.tag = 3;
//    [self.yuLiaoButton addTarget:self action:@selector(topButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//
//
//
//
//
//    [self.navView addSubview:self.yuLiaoButton];
    
    self.sliderView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navView.frame.size.height-4, 40*BILI, 4)];
    self.sliderView.backgroundColor = UIColorFromRGB(0xFFA25E);
    [self.navView addSubview:self.sliderView];

    [self.tuiJianButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    NSUserDefaults* isShowAtHomeDefaults = [NSUserDefaults standardUserDefaults];

    NSString * isShowAtHomeStr = [isShowAtHomeDefaults objectForKey:@"isShowAtHomeDefaultsKey"];
    if([@"1" isEqualToString:isShowAtHomeStr])
    {
        [self.reMenButton sendActionsForControlEvents:UIControlEventTouchUpInside];

    }

}


-(void)initTabViews
{
    guanZhuVC = [[TanLiaoLiao_HP_GuanZhuViewController alloc] init];


 


    guanZhuVC.delegate = self;
    guanZhuVC.view.frame = CGRectMake(0, 0, VIEW_WIDTH, self.mainScrollView.frame.size.height);
    
    tuiJianVC = [[TanLiaoLiao_HP_TuiJianViewController alloc] init];


 


    tuiJianVC.delegate = self;
    tuiJianVC.view.frame = CGRectMake(VIEW_WIDTH, 0, VIEW_WIDTH, self.mainScrollView.frame.size.height);
    
    anchorClassifyVC = [[KuaiLiao_AnchorClassifyViewController alloc] init];


    anchorClassifyVC.delegate = self;
    anchorClassifyVC.view.frame = CGRectMake(VIEW_WIDTH *2, 0, VIEW_WIDTH, self.mainScrollView.frame.size.height);
    
    yuLiaoVC = [[TanLiaoLiao_HP_YuLiaoViewController alloc] init];




    yuLiaoVC.delegate = self;
    yuLiaoVC.view.frame = CGRectMake(VIEW_WIDTH *3, 0, VIEW_WIDTH, self.mainScrollView.frame.size.height);
    
    [self.mainScrollView addSubview:guanZhuVC.view];




    [self.mainScrollView addSubview:tuiJianVC.view];



    [self.mainScrollView addSubview:anchorClassifyVC.view];




    [self.mainScrollView addSubview:yuLiaoVC.view];



}

-(void)topButtonClick:(id)sender
{
    UIButton * button = (UIButton *)sender;
    switch (button.tag) {
        case 0:
            
            
            [self stopYuLiaoYuYinPlay];
            
            [self.mainScrollView setContentOffset:CGPointMake(VIEW_WIDTH*button.tag, 0) animated:YES];
            [self.guanZhuButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.guanZhuButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
            [self.guanZhuButton .titleLabel setFont:[UIFont fontWithName:@"Helvetica-BoldOblique" size:18*BILI]];

            
            [self.tuiJianButton setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
            self.tuiJianButton.titleLabel.font = [UIFont systemFontOfSize:15*BILI];
            
            [self.reMenButton setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
            self.reMenButton.titleLabel.font = [UIFont systemFontOfSize:15*BILI];
            
            [self.yuLiaoButton setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
            self.yuLiaoButton.titleLabel.font = [UIFont systemFontOfSize:15*BILI];
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            self.sliderView.frame = CGRectMake(self.guanZhuButton.frame.origin.x, self.sliderView.frame.origin.y, self.sliderView.frame.size.width, self.sliderView.frame.size.height);
            [UIView commitAnimations];


 



            
            break;
        case 1:
            
            [self stopYuLiaoYuYinPlay];
            
            [self.mainScrollView setContentOffset:CGPointMake(VIEW_WIDTH*button.tag, 0) animated:YES];
            
            [self.guanZhuButton setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
            self.guanZhuButton.titleLabel.font = [UIFont systemFontOfSize:15*BILI];
            
            [self.tuiJianButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.tuiJianButton .titleLabel setFont:[UIFont fontWithName:@"Helvetica-BoldOblique" size:18*BILI]];
            
            [self.reMenButton setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
            self.reMenButton.titleLabel.font = [UIFont systemFontOfSize:15*BILI];
            
            [self.yuLiaoButton setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
            self.yuLiaoButton.titleLabel.font = [UIFont systemFontOfSize:15*BILI];
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            self.sliderView.frame = CGRectMake(self.tuiJianButton.frame.origin.x, self.sliderView.frame.origin.y, self.sliderView.frame.size.width, self.sliderView.frame.size.height);
            [UIView commitAnimations];


            
            break;
        case 2:
            
            [self stopYuLiaoYuYinPlay];
            
            [self.mainScrollView setContentOffset:CGPointMake(VIEW_WIDTH*button.tag, 0) animated:YES];
            
            [self.guanZhuButton setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
            self.guanZhuButton.titleLabel.font = [UIFont systemFontOfSize:15*BILI];
            
            [self.tuiJianButton setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
            self.tuiJianButton.titleLabel.font = [UIFont systemFontOfSize:15*BILI];
            
            [self.reMenButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.reMenButton .titleLabel setFont:[UIFont fontWithName:@"Helvetica-BoldOblique" size:18*BILI]];

            
            [self.yuLiaoButton setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
            self.yuLiaoButton.titleLabel.font = [UIFont systemFontOfSize:15*BILI];
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            self.sliderView.frame = CGRectMake(self.reMenButton.frame.origin.x, self.sliderView.frame.origin.y, self.sliderView.frame.size.width, self.sliderView.frame.size.height);
            [UIView commitAnimations];


 
   

            
            // [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshAnchorClassifyNotification" object:nil];

            
            break;
        case 3:
            
            [self.mainScrollView setContentOffset:CGPointMake(VIEW_WIDTH*button.tag, 0) animated:YES];
            
            [self.guanZhuButton setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
            self.guanZhuButton.titleLabel.font = [UIFont systemFontOfSize:15*BILI];
            
            [self.tuiJianButton setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
            self.tuiJianButton.titleLabel.font = [UIFont systemFontOfSize:15*BILI];
            
            [self.reMenButton setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
            self.reMenButton.titleLabel.font = [UIFont systemFontOfSize:15*BILI];
            
            [self.yuLiaoButton setTitleColor:UIColorFromRGB(0xFF6666) forState:UIControlStateNormal];
            [self.yuLiaoButton .titleLabel setFont:[UIFont fontWithName:@"Helvetica-BoldOblique" size:18*BILI]];
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            self.sliderView.frame = CGRectMake(self.yuLiaoButton.frame.origin.x, self.sliderView.frame.origin.y, self.sliderView.frame.size.width, self.sliderView.frame.size.height);
            [UIView commitAnimations];





            
            break;
            
        default:
            break;
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
    
    int  specialIndex = scrollView.contentOffset.x/VIEW_WIDTH;
    
    switch (specialIndex) {
        case 0:
            [self.guanZhuButton sendActionsForControlEvents:UIControlEventTouchUpInside];



 

            break;
            
        case 1:
            [self.tuiJianButton sendActionsForControlEvents:UIControlEventTouchUpInside];



 

            break;
        case 2:
            
            [self.reMenButton sendActionsForControlEvents:UIControlEventTouchUpInside];



            break;
        case 3:
            
            [self.yuLiaoButton sendActionsForControlEvents:UIControlEventTouchUpInside];


 

            break;
        default:
            break;
    }
    
}
#pragma mark---HP_GuanZhuViewControllerDelegate
-(void)quanBuGuanZhuButtonClick
{
    TanLiao_ChatterViewController  * chatVC = [[TanLiao_ChatterViewController alloc] init];


 

 

    [self.navigationController pushViewController:chatVC animated:YES];
    
}
-(void)pushToAnchorDetail:(NSDictionary *)info
{

    TanLiaoLiao_AnchorDetailMessageViewController * vc = [[TanLiaoLiao_AnchorDetailMessageViewController alloc] init];


 

    vc.anchorId = [info objectForKey:@"attentionUserId"];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)pushToTrendsDetailVC:(NSDictionary *)info
{
    KLiao_TrendsDetailViewController * trendsVC = [[KLiao_TrendsDetailViewController alloc] init];


    trendsVC.momentId = [info objectForKey:@"momentId"];
    trendsVC.delegate = self;
    [self.navigationController pushViewController:trendsVC animated:YES];

}
-(void)leftButtonClick:(NSDictionary *)info
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"guanZhuRefreshTrendNotification" object:info];
}
#pragma mark---HP_TuiJianViewControllerDelegate


-(void)tuiJianPushToAnchorDetail:(NSDictionary *)info
{
    TanLiaoLiao_AnchorDetailMessageViewController * detailVC = [[TanLiaoLiao_AnchorDetailMessageViewController alloc] init];



    detailVC.anchorId = [info objectForKey:@"id"];
    [self.navigationController pushViewController:detailVC animated:YES];

}
-(void)yiJianSuiYuanHuJiaoZhuBo:(NSDictionary *)info
{
    NTESVideoChatViewController *vc = [[NTESVideoChatViewController alloc] initWithCallee:[info objectForKey:@"anchorId"]];
    CATransition *transition = [CATransition animation];
    transition.duration = 0.25;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];


    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController pushViewController:vc animated:NO];
}
-(void)pushToMhtWebView:(NSString *)orderId payUrl:(NSString *)payUrl
{
    
    TanLiaoLiao_HomeWebViewController * homeWebVC = [[TanLiaoLiao_HomeWebViewController alloc] init];
    homeWebVC.url = payUrl;
    [self.navigationController pushViewController:homeWebVC animated:YES];

    
}
-(void)bannerPushToWebView:(NSDictionary *)info
{
    if ([@"2" isEqualToString:[info objectForKey:@"type"]])
    {
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
#pragma mark---AnchorClassifyViewDelegate
-(void)anchorClassifyViewPushToAnchorDatailVC:(NSDictionary *)info
{
    TanLiaoLiao_AnchorDetailMessageViewController * detailVC = [[TanLiaoLiao_AnchorDetailMessageViewController alloc] init];

    detailVC.anchorId = [info objectForKey:@"id"];
    [self.navigationController pushViewController:detailVC animated:YES];

}
#pragma mark---HP_YuLiaoViewControllerDelegate
-(void)pushToAudioAnchorDetail:(NSDictionary *)info
{
    TanLiaoLiao_AnchorDetailMessageViewController * detailVC = [[TanLiaoLiao_AnchorDetailMessageViewController alloc] init];


 

 

    detailVC.anchorId = [info objectForKey:@"id"];
    [self.navigationController pushViewController:detailVC animated:YES];

}
-(void)audioTongHua:(NSDictionary *)info
{
    
    self.audioAuthorInfo = info;
    [self.cloudClient huJiaoTongJiTongHuaJiLu:@"8066"
                                     toUserId:[info objectForKey:@"id"]
                                    call_type:@"C"
                                     delegate:self
                                     selector:@selector(tongJiSuccess:)
                                errorSelector:@selector(tongJiError:)];

}

-(void)tongJiSuccess:(NSDictionary *)info
{
    
    NSString *  recordId = [info objectForKey:@"recordId"];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];


 

   

    [defaults setObject:recordId forKey:@"tongHuaJiLuRecordId"];
    [defaults synchronize];


 

    
    NTESVideoChatViewController *vc = [[NTESVideoChatViewController alloc] initWithCallee:[self.audioAuthorInfo objectForKey:@"id"]];
    vc.videoOrAudio = @"audio";
    CATransition *transition = [CATransition animation];
    transition.duration = 0.25;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];




    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController pushViewController:vc animated:NO];
    
}


-(void)tongJiError:(NSDictionary *)info
{
    
    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];


 


}

-(void)stopYuLiaoYuYinPlay
{
   [[NSNotificationCenter defaultCenter] postNotificationName:@"stopYuLiaoYuYinPlayNotification" object:nil];
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



-(void)getAnchorTipsSuccess:(NSArray *)array
{
    NSUserDefaults * anchorPingJiaListDefaults = [NSUserDefaults standardUserDefaults];


    [anchorPingJiaListDefaults setObject:array forKey:@"anchorPingJiaList"];
    [anchorPingJiaListDefaults synchronize];


 


   
}


-(void)getAnchorTipsError:(NSDictionary *)info
{
    
}



-(void)showAnchorPingJiaView:(NSNotification *)notification
{
    NSDictionary * info = [notification object];



    
    if([@"1" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]])
    {
        TanLiaoLiao_AnchorPingJiaView * pingJiaView = [[TanLiaoLiao_AnchorPingJiaView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
        pingJiaView.delegate = self;
        [pingJiaView initContentView:info];
        [[UIApplication sharedApplication].keyWindow addSubview:pingJiaView];



 

    }
}

-(void)anchorSubmitPingJia:(NSDictionary *)info tags:(NSArray *)tags startLeve:(NSString *)startLeve
{
//    if (tags.count==0)
//    {
//        [TanLiao_Common showAlert:@"提示" message:@"请选择印象标签"];
//        return;
//    }
    
//    NSDictionary * selectInfo = [tags objectAtIndex:0];
//    NSString * tipS = [selectInfo objectForKey:@"tagCode"];
//
//    for (int i=1; i<tags.count; i++)
//    {
//        NSDictionary * info = [tags objectAtIndex:i];
//
//        tipS = [tipS stringByAppendingString:[NSString stringWithFormat:@",%@",[info objectForKey:@"tagCode"]]];
//    }
    self.userOrderId = [info objectForKey:@"userOrderId"];
    [self.cloudClient anchorPingJia:@"8068"
                            content:@""
                           anchorId:[info objectForKey:@"anchorId"]
                        userOrderId:[info objectForKey:@"userOrderId"]
                               rank:startLeve
                           tagCodes:@""
                           delegate:self
                           selector:@selector(pingJiaSuccess:)
                      errorSelector:@selector(pingJiaError:)];
}


-(void)pingJiaSuccess:(NSDictionary *)info
{
    
     [[NSNotificationCenter defaultCenter] postNotificationName:@"anchorPingJiaSuccess" object:self.userOrderId];
    
    CGSize oneLineSize = [TanLiao_Common setSize:@"评价成功" withCGSize:CGSizeMake(VIEW_WIDTH-(146*USERCC*2), VIEW_HEIGHT) withFontSize:12*BILI];
    
    UIButton * tipButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-oneLineSize.width-20)/2,(VIEW_HEIGHT-40*BILI)/2, oneLineSize.width+20, 40)];
    tipButton.enabled = NO;
    tipButton.alpha = 0.8;
    tipButton.layer.cornerRadius = 20;
    tipButton.backgroundColor = [UIColor blackColor];



   

    [tipButton setTitle:@"评价成功" forState:UIControlStateNormal];
    [tipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tipButton.titleLabel.font = [UIFont systemFontOfSize:12*BILI];
    tipButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [[UIApplication sharedApplication].keyWindow addSubview:tipButton];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3];
    tipButton.alpha = 0;
    [UIView commitAnimations];



    
    [self tuiJianAnchor];



    
}

-(void)pingJiaError:(NSDictionary *)info
{
    
}

-(void)showAnchorTuiJianView
{
    [self tuiJianAnchor];




}

-(void)tuiJianAnchor
{
    [self.cloudClient guanZhuTuiJianHuanYiPi:@"8145"
                                   pageIndex:@"1"
                                    pageSize:@"3"
                                    delegate:self
                                    selector:@selector(huanYiPiSuccess:)
                               errorSelector:@selector(huanYiPiError:)];

}
-(void)huanYiPiSuccess:(NSArray *)array
{
    TanLiaoLiao_TuiJianAnchorView * tuiJianView = [[TanLiaoLiao_TuiJianAnchorView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    tuiJianView.delegate =self;
    [tuiJianView initContentView:array];
    [[UIApplication sharedApplication].keyWindow addSubview:tuiJianView];



 

    
}

-(void)tuiJianAnchorPushToAnchorDetail:(NSDictionary *)info
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"threeTuiJianPushToAnchorDetail" object:[info objectForKey:@"id"]];
}
-(void)huanYiPiError:(NSDictionary *)info
{
    
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
