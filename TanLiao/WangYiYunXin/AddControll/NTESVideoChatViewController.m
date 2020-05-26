 //
//  NTESVideoChatViewController.m
//  NIM
//
//  Created by chris on 15/5/5.
//  Copyright (c) 2015年 Netease. All rights reserved.
//

#import "NTESVideoChatViewController.h"
#import "UIView+Toast.h"
#import "NTESTimerHolder.h"
//#import "NTESAudioChatViewController.h"
//#import "NTESMainTabController.h"
#import "NetCallChatInfo.h"
#import "NTESVideoChatNetStatusView.h"
#import "NTESGLView.h"
#import "NTESBundleSetting.h"
#import "NTESRecordSelectView.h"
#import "UIView+NTES.h"


#define NTESUseGLView

@interface NTESVideoChatViewController ()
@property (nonatomic,assign) NIMNetCallCamera cameraType;


@property (nonatomic,strong) CALayer *localVideoLayer;

@property (nonatomic,assign) BOOL oppositeCloseVideo;

#if defined (NTESUseGLView)
@property (nonatomic, strong) NTESGLView *remoteGLView;
#endif

@property (nonatomic,weak) UIView   *localView;

@property (nonatomic,weak) UIView   *localPreView;

@property (nonatomic, assign) BOOL calleeBasy;




@end

@implementation NTESVideoChatViewController

- (instancetype)initWithCallInfo:(NetCallChatInfo *)callInfo
{
    self = [self initWithNibName:nil bundle:nil];
    if (self) {
        self.callInfo = callInfo;
        self.callInfo.isMute = NO;
        self.callInfo.useSpeaker = NO;
        self.callInfo.disableCammera = NO;
        if (!self.localPreView) {
            //没有的话，尝试去取一把预览层（从视频切到语音再切回来的情况下是会有的）
            //self.localVideoLayer = [NIMAVChatSDK sharedSDK].netCallManager.localPreview.layer;
           self.localPreView = [NIMAVChatSDK sharedSDK].netCallManager.localPreview;
        }
        [[NIMAVChatSDK sharedSDK].netCallManager switchType:NIMNetCallMediaTypeVideo];
    }
    return self;
}


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.callInfo.callType = NIMNetCallTypeVideo;
        _cameraType = [[NTESBundleSetting sharedConfig] startWithBackCamera] ? NIMNetCallCameraBack :NIMNetCallCameraFront;
    }
    return self;
}
- (void)dealloc
{
    
}
- (void)viewDidLoad {
    
    //调整小头像位置
    
    //视频通话并且由用户发起主叫
    if (![@"audio" isEqualToString:self.videoOrAudio]&&[self.callInfo.caller isEqualToString:[TanLiao_Common getNowUserID]]&&[@"1" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]]&&self.anchorVideoUrl)
    {
        [self playAnchorVideo];
        
    }
    
    self.shieldArr = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0", @"WeChat", @"vx",
                 @"VX", @"weixin", @"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k", @"l", @"m", @"n", @"o", @"p",
                 @"q", @"r", @"s", @"t", @"u", @"v", @"w", @"x", @"y", @"z", nil];

    
    self.hangUpType = @"100";
    
    stopMeiFenZhongKouFei = YES;
    
    [RCIM sharedRCIM].disableMessageAlertSound = YES;
    
    if ([@"audio" isEqualToString:self.videoOrAudio]) {
        
        self.call_type = @"C";
    }
    else
    {
        self.call_type = @"B";
    }

    self.allGiftListArray = [NSMutableArray array];
    self.animationAlsoFisish = @"finish";
    
    self.localView = self.smallVideoView;
    [super viewDidLoad];
    if (self.localPreView) {
        self.localPreView.frame = self.localView.bounds;
        [self.localView addSubview:self.localPreView];
    }
    [self initUI];
    [self.cloudClient getGiftList:@"8019"
                         delegate:self
                         selector:@selector(getGiftListSuccess:)
                    errorSelector:@selector(getGiftListError:)];
    
      if ([[TanLiao_Common getNowUserID] isEqualToString:self.callInfo.callee]) {
          
          [self.cloudClient getAnchorDetailMes:self.callInfo.caller
                                            apiId:user_detail_info
                                         delegate:self
                                         selector:@selector(getAnchorMesSuccess:)
                                    errorSelector:@selector(getAnchorMesError:)];
      }
    else
    {
        //发起视频时获取对方的头像昵称
        [self.cloudClient getAnchorDetailMes:self.callInfo.callee
                                       apiId:user_detail_info
                                    delegate:self
                                    selector:@selector(getAnchorMesSuccess:)
                               errorSelector:@selector(getAnchorMesError:)];
    }
    

    
    //发起视频时获取对方单价
    if([@"1" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]])
    {
        if ([self.callInfo.callee isEqualToString:[TanLiao_Common getNowUserID]]) {
            
            
            [self.cloudClient getAnchorDetailMes:self.callInfo.caller
                                           apiId:user_detail_info
                                        delegate:self
                                        selector:@selector(getAnchorPriceMesSuccess:)
                                   errorSelector:@selector(getAnchorMesError:)];
        }
        else
        {
                [self.cloudClient getAnchorDetailMes:self.callInfo.callee
                                               apiId:user_detail_info
                                            delegate:self
                                            selector:@selector(getAnchorPriceMesSuccess:)
                                       errorSelector:@selector(getAnchorMesError:)];
        }
    }
    else
    {
    
        if ([self.callInfo.callee isEqualToString:[TanLiao_Common getNowUserID]]) {
            
            
            [self.cloudClient getAnchorDetailMes:self.callInfo.callee
                                           apiId:user_detail_info
                                        delegate:self
                                        selector:@selector(getAnchorPriceMesSuccess:)
                                   errorSelector:@selector(getAnchorMesError:)];
            
                   }
        else
        {
            
            
            [self.cloudClient getAnchorDetailMes:self.callInfo.caller
                                           apiId:user_detail_info
                                        delegate:self
                                        selector:@selector(getAnchorPriceMesSuccess:)
                                   errorSelector:@selector(getAnchorMesError:)];

        }

    }
  
    
    //如果是普通用户则获取账户余额
    if([@"1" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]])
    {
        [self getUserGoldNumber];
    }
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedGiftNotification:) name:ReceivedGiftNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoGetMessageNotification:) name:VideoGetMessageNotification object:nil];
   
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(kouFeiSuccessNotification) name:@"kouFeiSuccess" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getTiaoDouMessageNotification:) name:@"getTiaoDouMessgae" object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getAllGiftMessageNotification:) name:@"allGiftNotification" object:nil];

}
-(void)getUserInformationSuccess:(NSDictionary *)info
{
    
    NSUserDefaults * nowMoneyDefaults = [NSUserDefaults standardUserDefaults];
    [nowMoneyDefaults setObject:[info objectForKey:@"gold_number"] forKey:@"nowMoneyNumber"];
    [nowMoneyDefaults synchronize];
    
    self.money = [info objectForKey:@"gold_number"];
    self.yuEStr = self.money;
    self.daShangViewJinBiLable.text = [NSString stringWithFormat:@"%.2f金币",self.yuEStr.floatValue/JinBiBiLi];
    
}
-(void)getUserInformationError:(NSDictionary *)info
{
    
}
-(void)buttonClick
{
    self.flashGiftImageView.hidden = NO;
    self.flashGiftImageView.backgroundColor = [UIColor greenColor];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    self.flashGiftImageView.frame = CGRectMake((VIEW_WIDTH-100)/2, VIEW_HEIGHT/2, 100, 50);
    [UIView commitAnimations];

}
-(void)getAllGiftMessageNotification:(NSNotification *)notification
{
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  NSEC_PER_SEC), dispatch_get_main_queue(), ^{

         NSDictionary * messageInfo = [notification object];
        if ([@"finish" isEqualToString:self.animationAlsoFisish])
        {
     
            [weakSelf giftPaoMaDengViewInit:messageInfo];
            
        }
        else
        {
            [weakSelf.allGiftListArray addObject:messageInfo];
        }
    });
        
   
}
-(void)giftPaoMaDengViewInit:(NSDictionary *)messageInfo
{
    self.animationAlsoFisish = @"";
    
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(VIEW_WIDTH, 80*BILI, (VIEW_WIDTH-19*BILI), 70*BILI)];
    bottomView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bottomView];
    
    UIView * describleBottomView = [[UIView alloc] initWithFrame:CGRectMake(22*BILI, 55*BILI/2, 334*BILI, 30*BILI)];
    describleBottomView.backgroundColor = UIColorFromRGB(0x5EB3F9);
    describleBottomView.layer.masksToBounds  = YES;
    describleBottomView.layer.cornerRadius = 15*BILI;
    [bottomView addSubview:describleBottomView];
    
    UIImageView * headerBottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 114*BILI/2, 116*BILI/2)];
    headerBottomView.image = [UIImage imageNamed:@"shipin_touxiang_bg"];
    [bottomView addSubview:headerBottomView];
    
    TanLiaoCustomImageView * userHeaderImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(16*BILI, 17*BILI, 37*BILI, 37*BILI)];
    userHeaderImageView.imgType = IMAGEVIEW_TYPE_CENTER;
    userHeaderImageView.urlPath = [messageInfo objectForKey:@"avatarUrl"];
    userHeaderImageView.contentMode = UIViewContentModeScaleAspectFill;
    userHeaderImageView.autoresizingMask = UIViewAutoresizingNone;
    [bottomView addSubview:userHeaderImageView];
    
    UILabel * userNameLable = [[UILabel alloc] initWithFrame:CGRectMake(headerBottomView.frame.origin.y+headerBottomView.frame.size.width+4*BILI, 10*BILI, 200*BILI, 14*BILI)];
    userNameLable.font = [UIFont systemFontOfSize:14*BILI];
    userNameLable.textColor =UIColorFromRGB(0xE8BA26);
    userNameLable.text = [messageInfo objectForKey:@"nick"];
    [bottomView addSubview:userNameLable];
    
    UILabel * describleLable = [[UILabel alloc] initWithFrame:CGRectMake(headerBottomView.frame.origin.y+headerBottomView.frame.size.height+19*BILI, describleBottomView.frame.origin.y, 190*BILI, 30*BILI)];
    describleLable.textColor = [UIColor whiteColor];
    describleLable.font = [UIFont systemFontOfSize:15*BILI];
    describleLable.adjustsFontSizeToFitWidth = YES;
    [bottomView addSubview:describleLable];
    
    NSString * targetName = [messageInfo objectForKey:@"targetName"];
    NSString * str = [NSString stringWithFormat:@"赠送给 %@ 一个%@  ",targetName,[messageInfo objectForKey:@"name"]];
    
    NSAttributedString * str1 = [[NSAttributedString alloc] initWithString:str];
    
    NSMutableAttributedString * text1 = [[NSMutableAttributedString alloc] initWithAttributedString:str1];
    
    [text1 addAttribute:NSForegroundColorAttributeName
     
                  value:UIColorFromRGB(0xE8BA26)
     
                  range:NSMakeRange(3, targetName.length+1)];
    describleLable.attributedText = text1;
    
    
    TanLiaoCustomImageView * giftImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(headerBottomView.frame.origin.x+headerBottomView.frame.size.width+456*BILI/2, 6*BILI,71*BILI, 71*BILI)];
    giftImageView.urlPath = [messageInfo objectForKey:@"url"];
    [bottomView addSubview:giftImageView];
    
    [UIView animateWithDuration:4.0
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         bottomView.frame = CGRectMake(0, bottomView.frame.origin.y, bottomView.frame.size.width, bottomView.frame.size.height);
                     } completion:^(BOOL finished) {
                         
                         if (self.allGiftListArray.count>0)
                         {
                             NSDictionary * info = [self.allGiftListArray objectAtIndex:0];
                             [self.allGiftListArray removeObjectAtIndex:0];
                             [self giftPaoMaDengViewInit:info];
                         }
                         else
                         {
                             self.animationAlsoFisish = @"finish";
                         }
                         
                         [UIView animateWithDuration:4.0
                                               delay:0
                                             options:UIViewAnimationOptionCurveLinear
                                          animations:^{
                                              bottomView.frame = CGRectMake(-(VIEW_WIDTH-19*BILI), bottomView.frame.origin.y, bottomView.frame.size.width, bottomView.frame.size.height);
                                          } completion:^(BOOL finished) {
                                              [bottomView removeFromSuperview];
                                          }];
                     }];
    
}

//刷新聊天列表
-(void)videoGetMessageNotification:(NSNotification *)notification
{
    NSDictionary * messageInfo = [notification object];
    [self performSelectorOnMainThread:@selector(videoGetMessageMainMethod:) withObject:messageInfo waitUntilDone:NO];
}
-(void)videoGetMessageMainMethod:(NSDictionary *)messageInfo
{
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        
        NSString * targetID ;
        if ([weakSelf.callInfo.callee isEqualToString:[TanLiao_Common getNowUserID]]) {
            
            targetID = weakSelf.callInfo.caller;
        }
        else
        {
             targetID = weakSelf.callInfo.callee;
        }
        
        if([targetID isEqualToString:[messageInfo objectForKey:@"targetId"]])
        {
            NSDictionary * chatInfo = [[NSDictionary alloc] initWithObjectsAndKeys:[messageInfo objectForKey:@"sendUserName"],@"nick",[messageInfo objectForKey:@"content"],@"content",targetID,@"targetID", nil];
            [weakSelf.chatSourceArray addObject:chatInfo];
            [weakSelf.chatTableView reloadData];
            CGFloat yOffset = 0; //设置要滚动的位置 0最顶部 CGFLOAT_MAX最底部
            if (weakSelf.chatTableView.contentSize.height > weakSelf.chatTableView.bounds.size.height) {
                yOffset = weakSelf.chatTableView.contentSize.height - weakSelf.chatTableView.bounds.size.height;
            }
            [weakSelf.chatTableView setContentOffset:CGPointMake(0, yOffset) animated:NO];
        }

        
});
}
//获取到礼物通知执行动画
-(void)receivedGiftNotification:(NSNotification *)notification
{
    NSDictionary * selectGift ;
    NSDictionary * sendInfo = [notification object];

    for (int i=0; i<self.giftArray.count; i++) {
        
        NSDictionary * info = [self.giftArray objectAtIndex:i];
        if ([[info objectForKey:@"goodsId"] isEqualToString:[sendInfo objectForKey:@"txtInfo"]]) {
            
            selectGift = [[NSDictionary alloc] initWithDictionary:info];
        }
    }
   [self performSelectorOnMainThread:@selector(myThreadMainMethod:) withObject:selectGift waitUntilDone:NO];
    
}

-(void)myThreadMainMethod:(NSDictionary *)selectGift
{
    TanLiaoCustomImageView * imageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH)/2,VIEW_HEIGHT/2, 0, 0)];
    imageView.urlPath = [selectGift objectForKey:@"goodsIconUrl"];
    [self.view addSubview:imageView];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    imageView.frame = CGRectMake((VIEW_WIDTH-200)/2, VIEW_HEIGHT/2-100, 150, 150);
    [UIView commitAnimations];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        
        [TanLiao_Common shakeAnimationForView:imageView];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:1];
            imageView.frame = CGRectMake((VIEW_WIDTH-50)/2, -50,50, 50);
            [UIView commitAnimations];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                
                [imageView removeFromSuperview];
            });
            
        });
        
    });
}
-(void)shake:(id)imageView
{
    UIImageView * shakeImageView = (UIImageView *)imageView;
    [TanLiao_Common shakeAnimationForView:shakeImageView];
    [self performSelector:@selector(yidong:) withObject:shakeImageView afterDelay:1];
}
-(void)yidong:(id)imageView
{
    UIImageView * shakeImageView = (UIImageView *)imageView;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    shakeImageView.frame = CGRectMake((VIEW_WIDTH-100)/2, -100,100, 100);
    [UIView commitAnimations];
    [self performSelector:@selector(huiShou:) withObject:shakeImageView afterDelay:1];
}

-(void)huiShou:(id)imageView
{
    UIImageView * shakeImageView = (UIImageView *)imageView;
    [shakeImageView removeFromSuperview];
}
-(void)getAnchorPriceMesSuccess:(NSDictionary *)info
{
    self.price = [info objectForKey:@"price"];
    self.lureList = [info objectForKey:@"lureList"];
}
-(void)getAnchorMesSuccess:(NSDictionary *)info
{
    self.anchorPingJiaInfo = [[NSDictionary alloc] initWithDictionary:info];
    
    self.beiJiaoHeaderImageView.urlPath = [info objectForKey:@"avatarUrl"];
    self.beiJiaoNameLable.text = [info objectForKey:@"nick"];
    if ([@"1" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]]&&![@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
    {
        NSString * cityName = [info objectForKey:@"cityName"];
        CGSize size = [TanLiao_Common setSize:cityName withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_WIDTH) withFontSize:12*BILI];
        
        UILabel * renZhengLable = [[UILabel alloc] initWithFrame:CGRectMake((VIEW_WIDTH-(size.width+12*BILI+44*BILI+150*BILI))/2, 0, 150*BILI/2, 20*BILI)];
        renZhengLable.layer.borderWidth = 1*BILI;
        renZhengLable.layer.borderColor = [[UIColor whiteColor] CGColor];
        renZhengLable.textAlignment = NSTextAlignmentCenter;
        renZhengLable.textColor = [UIColor whiteColor];
        renZhengLable.font = [UIFont systemFontOfSize:12*BILI];
        renZhengLable.text = @"声优认证";
        renZhengLable.layer.cornerRadius = 10*BILI;
        renZhengLable.layer.masksToBounds = YES;
        renZhengLable.adjustsFontSizeToFitWidth = YES;
        [self.userMessageBottomView addSubview:renZhengLable];

        
        UILabel * addressLable = [[UILabel alloc] initWithFrame:CGRectMake(renZhengLable.frame.origin.x+renZhengLable.frame.size.width+22*BILI, 0, size.width+12*BILI, 20*BILI)];
        addressLable.layer.borderWidth = 1*BILI;
        addressLable.layer.borderColor = [[UIColor whiteColor] CGColor];
        addressLable.textAlignment = NSTextAlignmentCenter;
        addressLable.textColor = [UIColor whiteColor];
        addressLable.font = [UIFont systemFontOfSize:12*BILI];
        addressLable.text = [info objectForKey:@"cityName"];
        addressLable.adjustsFontSizeToFitWidth = YES;
        addressLable.layer.cornerRadius = 10*BILI;
        addressLable.layer.masksToBounds = YES;
        [self.userMessageBottomView addSubview:addressLable];
        
        
        
        NSString *  signature = [info objectForKey:@"signature"];
        if (signature.length>0)
        {
            UILabel * signatureLable = [[UILabel alloc] initWithFrame:CGRectMake(47*BILI, addressLable.frame.origin.y+addressLable.frame.size.height+10*BILI, VIEW_WIDTH-94*BILI, 34*BILI)];
            signatureLable.textAlignment = NSTextAlignmentCenter;
            signatureLable.textColor = [UIColor whiteColor];
            signatureLable.font = [UIFont systemFontOfSize:12*BILI];
            signatureLable.numberOfLines = 2;
            signatureLable.text = [@"个人独白：" stringByAppendingString:signature];
            [self.userMessageBottomView addSubview:signatureLable];
            
        }
        
    }
    else
    {
        
        NSString * cityName = [info objectForKey:@"cityName"];
        CGSize size = [TanLiao_Common setSize:cityName withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_WIDTH) withFontSize:12*BILI];
        UILabel * addressLable = [[UILabel alloc] initWithFrame:CGRectMake((VIEW_WIDTH-(size.width+12*BILI))/2, 0, size.width+12*BILI, 20*BILI)];
        addressLable.layer.borderWidth = 1*BILI;
        addressLable.layer.borderColor = [[UIColor whiteColor] CGColor];
        addressLable.textAlignment = NSTextAlignmentCenter;
        addressLable.textColor = [UIColor whiteColor];
        addressLable.font = [UIFont systemFontOfSize:12*BILI];
        addressLable.text = [info objectForKey:@"cityName"];
        addressLable.adjustsFontSizeToFitWidth = YES;
        addressLable.layer.cornerRadius = 10*BILI;
        addressLable.layer.masksToBounds = YES;
        [self.userMessageBottomView addSubview:addressLable];
        
        NSString *  signature = [info objectForKey:@"signature"];
        if (signature.length>0)
        {
            UILabel * signatureLable = [[UILabel alloc] initWithFrame:CGRectMake(47*BILI, addressLable.frame.origin.y+addressLable.frame.size.height+10*BILI, VIEW_WIDTH-94*BILI, 34*BILI)];
            signatureLable.textAlignment = NSTextAlignmentCenter;
            signatureLable.textColor = [UIColor whiteColor];
            signatureLable.font = [UIFont systemFontOfSize:12*BILI];
            signatureLable.numberOfLines = 2;
            signatureLable.text = [@"个人独白：" stringByAppendingString:signature];
            [self.userMessageBottomView addSubview:signatureLable];
            
        }
    }
}
-(void)getAnchorMesError:(NSDictionary *)info
{
    
}

-(void)getGiftListSuccess:(NSArray *)info
{
    self.giftArray = [NSArray arrayWithArray:info];
   // [self initDaShangView];

}
-(void)getGiftListError:(NSDictionary *)info
{
    
}
- (void)initUI
{
    
    
    if ([@"audio" isEqualToString:self.videoOrAudio])
    {
        
        self.audioBottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
        self.audioBottomView.image = [UIImage imageNamed:@"audio_bg"];
        [self.view addSubview:self.audioBottomView];
        
        UIImageView * headerBottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-370*BILI/2)/2, 222*BILI/2-40*BILI, 370*BILI/2, 370*BILI/2)];
        headerBottomImageView.image = [UIImage imageNamed:@"audio_pic_touixangyinyin"];
        [self.view addSubview:headerBottomImageView];
        
        self.beiJiaoHeaderImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-210*BILI/2)/2, 222*BILI/2, 210*BILI/2, 210*BILI/2)];
        self.beiJiaoHeaderImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.beiJiaoHeaderImageView.autoresizingMask = UIViewAutoresizingNone;
        self.beiJiaoHeaderImageView.clipsToBounds = YES;
        self.beiJiaoHeaderImageView.urlPath = @"http://s.tongcheng1314.com/default_avatar.png";
        self.beiJiaoHeaderImageView.imgType = IMAGEVIEW_TYPE_CENTER;
        [self.view addSubview:self.beiJiaoHeaderImageView];
        
        
        self.beiJiaoNameLable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.beiJiaoHeaderImageView.frame.origin.y+self.beiJiaoHeaderImageView.frame.size.height+19*BILI, VIEW_WIDTH, 24*BILI)];
        self.beiJiaoNameLable.font = [UIFont systemFontOfSize:24*BILI];
        self.beiJiaoNameLable.textColor = [UIColor whiteColor];
        self.beiJiaoNameLable.text = @"小仙女";
        self.beiJiaoNameLable.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:self.beiJiaoNameLable];

        self.userMessageBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.beiJiaoNameLable.frame.origin.y+self.beiJiaoNameLable.frame.size.height+10*BILI, VIEW_WIDTH, 94*BILI)];
        [self.view addSubview:self.userMessageBottomView];
        
        self.beiJiaoTelImageView = [[UIImageView alloc] initWithFrame:CGRectMake(75*BILI, self.userMessageBottomView.frame.origin.y+self.userMessageBottomView.frame.size.height, 36*BILI, 36*BILI)];
        self.beiJiaoTelImageView.image = [UIImage imageNamed:@"icon_tel"];
        [self.view addSubview:self.beiJiaoTelImageView];

        self.beiJiaoTipLable = [[UILabel alloc] initWithFrame:CGRectMake(self.beiJiaoTelImageView.frame.origin.x+self.beiJiaoTelImageView.frame.size.width+9*BILI, self.beiJiaoTelImageView.frame.origin.y, VIEW_WIDTH, 36*BILI)];
        self.beiJiaoTipLable.text = @"正在等待对方接受你的邀请";
        self.beiJiaoTipLable.textColor = [UIColor whiteColor];
        self.beiJiaoTipLable.font = [UIFont systemFontOfSize:15*BILI];
        [self.view addSubview:self.beiJiaoTipLable];
        
        self.agreementBottomView = [[UIView alloc] initWithFrame:CGRectMake(68*BILI/2, self.beiJiaoTipLable.frame.origin.y+self.beiJiaoTipLable.frame.size.height+15*BILI, VIEW_WIDTH-68*BILI, 145*BILI/2)];
        self.agreementBottomView.alpha = 0.2;
        self.agreementBottomView.layer.cornerRadius = 4;
        self.agreementBottomView.layer.masksToBounds = YES;
        self.agreementBottomView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.agreementBottomView];

        
        self.agreementTipLable = [[UILabel alloc] initWithFrame:CGRectMake(87*BILI/2, self.agreementBottomView.frame.origin.y+10*BILI, VIEW_WIDTH-87*BILI, 105*BILI/2)];
        self.agreementTipLable.textColor = UIColorFromRGB(0xd5d5d5);
        self.agreementTipLable.numberOfLines = 3;
        self.agreementTipLable.font = [UIFont systemFontOfSize:12*BILI];
        self.agreementTipLable.text = @"语音过程中严禁出现任何涉及色情、淫秽、政治、赌博、暴力等违反国家法律法规的内容，已经发现我们将立即对账号进行封停处理。";
        [self.view addSubview:self.agreementTipLable];
        
        
        self.huJiaoGuaDuanButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-50*BILI)/2, VIEW_HEIGHT-90*BILI, 50*BILI, 50*BILI)];
        [self.huJiaoGuaDuanButton addTarget:self action:@selector(quXiaoHangup) forControlEvents:UIControlEventTouchUpInside];
        [self.huJiaoGuaDuanButton setImage:[UIImage imageNamed:@"audio_yonghu_guaduan"] forState:UIControlStateNormal];
        [self.view addSubview:self.huJiaoGuaDuanButton];
        
        self.huJiaoGuaDuanLable = [[UILabel alloc] initWithFrame:CGRectMake(self.huJiaoGuaDuanButton.frame.origin.x, self.huJiaoGuaDuanButton.frame.origin.y+self.huJiaoGuaDuanButton.frame.size.height+7*BILI, self.huJiaoGuaDuanButton.frame.size.width, 12*BILI)];
        self.huJiaoGuaDuanLable.textAlignment = NSTextAlignmentCenter;
        self.huJiaoGuaDuanLable.text = @"挂断";
        self.huJiaoGuaDuanLable.textColor = [UIColor whiteColor];
        self.huJiaoGuaDuanLable.font = [UIFont systemFontOfSize:12*BILI];
        [self.view addSubview:self.huJiaoGuaDuanLable];
        
        
        self.jvJueButtn = [[UIButton alloc] initWithFrame:CGRectMake(70*BILI, VIEW_HEIGHT-130*BILI, 60*BILI, 60*BILI)];
        [self.jvJueButtn addTarget:self action:@selector(jieShou:) forControlEvents:UIControlEventTouchUpInside];
        [self.jvJueButtn setBackgroundImage:[UIImage imageNamed:@"audio_yonghu_guaduan"] forState:UIControlStateNormal];
        [self.view addSubview:self.jvJueButtn];
        
        self.beiJiaoGuaDuanLable = [[UILabel alloc] initWithFrame:CGRectMake(self.jvJueButtn.frame.origin.x, self.jvJueButtn.frame.origin.y+self.jvJueButtn.frame.size.height+10*BILI, self.jvJueButtn.frame.size.width, 12*BILI)];
        self.beiJiaoGuaDuanLable.textAlignment = NSTextAlignmentCenter;
        self.beiJiaoGuaDuanLable.text = @"挂断";
        self.beiJiaoGuaDuanLable.textColor = [UIColor whiteColor];
        self.beiJiaoGuaDuanLable.font = [UIFont systemFontOfSize:12*BILI];
        [self.view addSubview:self.beiJiaoGuaDuanLable];


        
        self.jieShouButton = [[UIButton alloc] initWithFrame:CGRectMake(490*BILI/2, VIEW_HEIGHT-130*BILI, 60*BILI, 60*BILI)];
        [self.jieShouButton addTarget:self action:@selector(jieShou:) forControlEvents:UIControlEventTouchUpInside];
        [self.jieShouButton setBackgroundImage:[UIImage imageNamed:@"audio_zhubo_jieting"] forState:UIControlStateNormal];
        [self.view addSubview:self.jieShouButton];
        
        self.beiJiaoJieTongLable = [[UILabel alloc] initWithFrame:CGRectMake(self.jieShouButton.frame.origin.x, self.jieShouButton.frame.origin.y+self.jieShouButton.frame.size.height+10*BILI, self.jieShouButton.frame.size.width, 12*BILI)];
        self.beiJiaoJieTongLable.textAlignment = NSTextAlignmentCenter;
        self.beiJiaoJieTongLable.text = @"接听";
        self.beiJiaoJieTongLable.textColor = [UIColor whiteColor];
        self.beiJiaoJieTongLable.font = [UIFont systemFontOfSize:12*BILI];
        [self.view addSubview:self.beiJiaoJieTongLable];
        
        
        self.shiChangLableBottom = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-140*BILI)/2, 403*BILI, 140*BILI, 40*BILI)];
        self.shiChangLableBottom.alpha = 0.16;
        self.shiChangLableBottom.backgroundColor = [UIColor whiteColor];
        self.shiChangLableBottom.layer.cornerRadius = 20*BILI;
        [self.view addSubview:self.shiChangLableBottom];
        
        self.shiChangLable = [[UILabel alloc] initWithFrame:self.shiChangLableBottom.frame];
        self.shiChangLable.font = [UIFont systemFontOfSize:24*BILI];
        self.shiChangLable.textAlignment = NSTextAlignmentCenter;
        self.shiChangLable.textColor = [UIColor whiteColor];
        [self.view addSubview:self.shiChangLable];

        self.jingYinButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-100*BILI)/3, VIEW_HEIGHT-90*BILI, 50*BILI, 50*BILI)];
        [self.jingYinButton setImage:[UIImage imageNamed:@"audio_yonghu_jingyin_n"] forState:UIControlStateNormal];
        [self.jingYinButton addTarget:self action:@selector(openOrCloseVoice) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.jingYinButton];
        
        self.jingYinLable = [[UILabel alloc] initWithFrame:CGRectMake(self.jingYinButton.frame.origin.x, self.jingYinButton.frame.origin.y+self.jingYinButton.frame.size.height+7*BILI, self.jingYinButton.frame.size.width, 12*BILI)];
        self.jingYinLable.textAlignment = NSTextAlignmentCenter;
        self.jingYinLable.text = @"静音";
        self.jingYinLable.textColor = [UIColor whiteColor];
        self.jingYinLable.font = [UIFont systemFontOfSize:12*BILI];
        [self.view addSubview:self.jingYinLable];
        
        self.songLiButton = [[UIButton alloc] initWithFrame:CGRectMake(50*BILI, VIEW_HEIGHT-65*BILI, 225*BILI/2, 45*BILI)];
        [self.songLiButton setImage:[UIImage imageNamed:@"audio_yonghu_songli"] forState:UIControlStateNormal];
        [self.songLiButton addTarget:self action:@selector(songLi) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.songLiButton];


        self.chongZhiBUtton = [[UIButton alloc] initWithFrame:CGRectMake(425*BILI/2, VIEW_HEIGHT-65*BILI, 225*BILI/2, 45*BILI)];
        [self.chongZhiBUtton setImage:[UIImage imageNamed:@"audio_songli_chongzhi"] forState:UIControlStateNormal];
        [self.chongZhiBUtton addTarget:self action:@selector(beginChongZhi) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.chongZhiBUtton];

        self.authorGiftButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-60*BILI)/2, VIEW_HEIGHT-55*BILI, 60*BILI, 55*BILI)];
        [self.authorGiftButton addTarget:self action:@selector(songLi) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:self.authorGiftButton];
        
        UIImageView * authorGiftJianTou = [[UIImageView alloc] initWithFrame:CGRectMake((60-15)*BILI/2, 0, 15*BILI, 8*BILI)];
        authorGiftJianTou.image = [UIImage imageNamed:@"audio_zhubo_liebiao"];
        [self.authorGiftButton addSubview:authorGiftJianTou];
        
        UILabel * authorGiftLable = [[UILabel alloc] initWithFrame:CGRectMake(0, authorGiftJianTou.frame.origin.y+authorGiftJianTou.frame.size.height+10*BILI, 60*BILI, 15*BILI)];
        authorGiftLable.font = [UIFont systemFontOfSize:15*BILI];
        authorGiftLable.textAlignment = NSTextAlignmentCenter;
        authorGiftLable.textColor = UIColorFromRGB(0x999999);
        authorGiftLable.text = @"礼物列表";
        authorGiftLable.adjustsFontSizeToFitWidth = YES;
        [self.authorGiftButton addSubview:authorGiftLable];
        
        if ([@"jieShou" isEqualToString:self.huJiaoOrJieShou]) {
            
            self.beiJiaoTipLable.text = @"邀请你进行语音聊天";
            self.huJiaoGuaDuanButton.hidden = YES;
            self.huJiaoGuaDuanLable.hidden = YES;
            
        }
        else if([@"dengDai" isEqualToString:self.huJiaoOrJieShou])
        {
            self.jvJueButtn.hidden = YES;
            self.beiJiaoGuaDuanLable.hidden = YES;
            self.jieShouButton.hidden = YES;
            self.beiJiaoJieTongLable.hidden = YES;
        }
        else
        {
            self.jvJueButtn.hidden = YES;
            self.beiJiaoGuaDuanLable.hidden = YES;
            self.jieShouButton.hidden = YES;
            self.beiJiaoJieTongLable.hidden = YES;
            self.huJiaoGuaDuanButton.hidden = YES;
            self.huJiaoGuaDuanLable.hidden = YES;

        }
        self.jingYinButton.hidden = YES;
        self.jingYinLable.hidden = YES;
        self.songLiButton.hidden = YES;
        self.chongZhiBUtton.hidden = YES;
        self.authorGiftButton.hidden = YES;
        self.shiChangLableBottom.hidden = YES;
        self.shiChangLable.hidden = YES;

    }
    else
    {
    self.bigAndSmallBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    [self.view addSubview:self.bigAndSmallBottomView];
    //new add****************************************
    self.view.backgroundColor = UIColorFromRGB(0x818594);
    
    self.beiJiaoHeaderImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(18*BILI, 36*BILI, 105*BILI, 105*BILI)];
    self.beiJiaoHeaderImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.beiJiaoHeaderImageView.autoresizingMask = UIViewAutoresizingNone;
    self.beiJiaoHeaderImageView.clipsToBounds = YES;
    self.beiJiaoHeaderImageView.urlPath = @"http://s.tongcheng1314.com/default_avatar.png";
    self.beiJiaoHeaderImageView.imgType = IMAGEVIEW_TYPE_CENTER;
    [self.view addSubview:self.beiJiaoHeaderImageView];
    
    self.beiJiaoNameLable = [[UILabel alloc] initWithFrame:CGRectMake(18*BILI, self.beiJiaoHeaderImageView.frame.origin.y+self.beiJiaoHeaderImageView.frame.size.height+4*BILI, VIEW_WIDTH, 24*BILI)];
    self.beiJiaoNameLable.font = [UIFont systemFontOfSize:24*BILI];
    self.beiJiaoNameLable.textColor = [UIColor whiteColor];
    self.beiJiaoNameLable.text = @"小仙女";
    [self.view addSubview:self.beiJiaoNameLable];
    
    self.beiJiaoTelImageView = [[UIImageView alloc] initWithFrame:CGRectMake(18*BILI, self.beiJiaoNameLable.frame.origin.y+self.beiJiaoNameLable.frame.size.height+10*BILI, 36*BILI, 36*BILI)];
    self.beiJiaoTelImageView.image = [UIImage imageNamed:@"icon_tel"];
    [self.view addSubview:self.beiJiaoTelImageView];
    
    self.beiJiaoTipLable = [[UILabel alloc] initWithFrame:CGRectMake(self.beiJiaoTelImageView.frame.origin.x+self.beiJiaoTelImageView.frame.size.width+9*BILI, self.beiJiaoNameLable.frame.origin.y+self.beiJiaoNameLable.frame.size.height+15*BILI, VIEW_WIDTH, 15*BILI)];
    self.beiJiaoTipLable.text = @"正在等待对方接受你的邀请";
    self.beiJiaoTipLable.textColor = [UIColor whiteColor];
    self.beiJiaoTipLable.font = [UIFont systemFontOfSize:15*BILI];
    [self.view addSubview:self.beiJiaoTipLable];
    
    self.agreementBottomView = [[UIView alloc] initWithFrame:CGRectMake(75*BILI/2, 314*BILI, VIEW_WIDTH-75*BILI, 90*BILI)];
    self.agreementBottomView.alpha = 0.3;
    self.agreementBottomView.layer.cornerRadius = 4;
    self.agreementBottomView.layer.masksToBounds = YES;
    self.agreementBottomView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.agreementBottomView];
    
    self.agreementTipLable = [[UILabel alloc] initWithFrame:CGRectMake(106*BILI/2, self.agreementBottomView.frame.origin.y+19*BILI, VIEW_WIDTH-106*BILI, 53*BILI)];
    self.agreementTipLable.textColor = [UIColor whiteColor];
    self.agreementTipLable.numberOfLines = 3;
    self.agreementTipLable.font = [UIFont systemFontOfSize:12*BILI];
    self.agreementTipLable.text = @"视频过程中严禁出现任何涉及色情、淫秽、政治、赌博、暴力等违反国家法律法规的内容,一经发现我们将立即对账号进行封停处理";
    [self.view addSubview:self.agreementTipLable];
    
//    self.openOrCloseCameraButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-30*BILI)/2, self.agreementBottomView.frame.origin.y+self.agreementBottomView.frame.size.height+117*BILI/2, 30*BILI, 30*BILI)];
//    [self.openOrCloseCameraButton setImage:[UIImage imageNamed:@"btn_close_video"] forState:UIControlStateNormal];
//    [self.view addSubview:self.openOrCloseCameraButton];
//    [self.openOrCloseCameraButton addTarget:self action:@selector(openOrCloseCameraButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    
//    self.openOrCloseCameraLable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.openOrCloseCameraButton.frame.origin.y+self.openOrCloseCameraButton.frame.size.height+7*BILI, VIEW_WIDTH, 15*BILI)];
//    self.openOrCloseCameraLable.font = [UIFont systemFontOfSize:15*BILI];
//    self.openOrCloseCameraLable.textColor = [UIColor whiteColor];
//    self.openOrCloseCameraLable.text = @"关闭摄像头";
//    self.openOrCloseCameraLable.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:self.openOrCloseCameraLable];
    
    
    self.quXiaoButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-75*BILI)/2, VIEW_HEIGHT-75*BILI-42*BILI, 75*BILI, 75*BILI)];
    [self.quXiaoButton setImage:[UIImage imageNamed:@"btn_tel"] forState:UIControlStateNormal];
    [self.quXiaoButton addTarget:self action:@selector(quXiaoHangup) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.quXiaoButton];
    
    self.quXiaoLable = [[UILabel alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT-(39+30)*BILI/2, VIEW_WIDTH, 15*BILI)];
    self.quXiaoLable.textAlignment = NSTextAlignmentCenter;
    self.quXiaoLable.font = [UIFont systemFontOfSize:15*BILI];
    self.quXiaoLable.textColor = [UIColor whiteColor];
    self.quXiaoLable.text = @"取消";
    [self.view addSubview:self.quXiaoLable];
    
    
    //已经接通
        if([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
        {
            self.closeShiPinButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 27*BILI, 43*BILI, 38*BILI)];
            self.closeShiPinButton.layer.cornerRadius = 19*BILI;
            [self.closeShiPinButton setImage:[UIImage imageNamed:@"btn_closeNew"] forState:UIControlStateNormal];
            [self.closeShiPinButton addTarget:self action:@selector(yiJieTongHangUp) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:self.closeShiPinButton];
        }
        else
        {
            if ([@"1" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]])
            {
                self.closeShiPinButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 27*BILI, 43*BILI, 38*BILI)];
                self.closeShiPinButton.layer.cornerRadius = 19*BILI;
                [self.closeShiPinButton setImage:[UIImage imageNamed:@"btn_closeNew"] forState:UIControlStateNormal];
                [self.closeShiPinButton addTarget:self action:@selector(yiJieTongHangUp) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:self.closeShiPinButton];
            }

        }
    
    self.shiChangLableBottom = [[UIButton alloc] initWithFrame:CGRectMake(109*BILI/2, 31*BILI, 116*BILI/2, 30*BILI)];
    self.shiChangLableBottom.alpha = 0.2;
    self.shiChangLableBottom.backgroundColor = [UIColor blackColor];
    self.shiChangLableBottom.layer.cornerRadius = 15*BILI;
    [self.view addSubview:self.shiChangLableBottom];
    
    self.shiChangLable = [[UILabel alloc] initWithFrame:self.shiChangLableBottom.frame];
    self.shiChangLable.font = [UIFont systemFontOfSize:12*BILI];
    self.shiChangLable.textAlignment = NSTextAlignmentCenter;
    self.shiChangLable.textColor = [UIColor whiteColor];
    [self.view addSubview:self.shiChangLable];
    
    
    
    
    self.jinBiLableBottom = [[UIButton alloc] initWithFrame:CGRectMake(245*BILI/2, 31*BILI, 168*BILI/2, 30*BILI)];
    self.jinBiLableBottom.alpha = 0.2;
    self.jinBiLableBottom.backgroundColor = [UIColor blackColor];
    self.jinBiLableBottom.layer.cornerRadius = 15*BILI;
    [self.view addSubview:self.jinBiLableBottom];
    
    self.jinBiLable = [[UILabel alloc] initWithFrame:self.jinBiLableBottom.frame];
    self.jinBiLable.font = [UIFont systemFontOfSize:12*BILI];
    self.jinBiLable.textAlignment = NSTextAlignmentCenter;
    self.jinBiLable.textColor = [UIColor whiteColor];
    [self.view addSubview:self.jinBiLable];

    
    self.sendMessageButton = [[UIButton alloc] initWithFrame:CGRectMake(11*BILI, VIEW_HEIGHT-(41+86)*BILI/2, 34*BILI, 34*BILI)];
    [self.sendMessageButton setImage:[UIImage imageNamed:@"btn_massage"] forState:UIControlStateNormal];
    [self.sendMessageButton addTarget:self action:@selector(willSendMessage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sendMessageButton];
    
        if([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
        {
            self.sendMessageButton.frame = CGRectMake(self.sendMessageButton.frame.origin.x, self.sendMessageButton.frame.origin.y, 0, 0);
        }
    
    self.openOrCloseVoiceButton = [[UIButton alloc] initWithFrame:CGRectMake(self.sendMessageButton.frame.origin.x+self.sendMessageButton.frame.size.width+15*BILI, self.sendMessageButton.frame.origin.y, 34*BILI, 34*BILI)];
    [self.openOrCloseVoiceButton setImage:[UIImage imageNamed:@"btn_mac_close"] forState:UIControlStateNormal];
    [self.openOrCloseVoiceButton addTarget:self action:@selector(openOrCloseVoice) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.openOrCloseVoiceButton];
    
    
    self.qieHuanJingTouButton = [[UIButton alloc] initWithFrame:CGRectMake(self.openOrCloseVoiceButton.frame.origin.x+self.openOrCloseVoiceButton.frame.size.width+15*BILI, self.sendMessageButton.frame.origin.y, 34*BILI, 34*BILI)];
    [self.qieHuanJingTouButton setImage:[UIImage imageNamed:@"btn_change"] forState:UIControlStateNormal];
    [self.qieHuanJingTouButton addTarget:self action:@selector(qieHuanJIngTou) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.qieHuanJingTouButton];
    
    
    self.guanBiDaKaiCameraButton = [[UIButton alloc] initWithFrame:CGRectMake(self.qieHuanJingTouButton.frame.origin.x+self.qieHuanJingTouButton.frame.size.width+15*BILI, self.sendMessageButton.frame.origin.y, 34*BILI, 34*BILI)];
    [self.guanBiDaKaiCameraButton setImage:[UIImage imageNamed:@"btn_open_video"] forState:UIControlStateNormal];
    [self.guanBiDaKaiCameraButton addTarget:self action:@selector(guanBiDaKaiCamera) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.guanBiDaKaiCameraButton];
    
    
//    self.chongZhiBUtton = [[UIButton alloc] initWithFrame:CGRectMake(self.guanBiDaKaiCameraButton.frame.origin.x+self.guanBiDaKaiCameraButton.frame.size.width+22*BILI, VIEW_HEIGHT-(48+72)*BILI/2, 36*BILI, 36*BILI)];
//    [self.chongZhiBUtton setImage:[UIImage imageNamed:@"btn_qian"] forState:UIControlStateNormal];
//    [self.chongZhiBUtton addTarget:self action:@selector(beginChongZhi) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.chongZhiBUtton];
    
        if(![@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
        {
            self.songLiButton = [[UIButton alloc] initWithFrame:CGRectMake(self.guanBiDaKaiCameraButton.frame.origin.x+self.guanBiDaKaiCameraButton.frame.size.width+22*BILI, self.sendMessageButton.frame.origin.y-23*BILI/2, 57*BILI, 57*BILI)];
            [self.songLiButton setImage:[UIImage imageNamed:@"btn_lw"] forState:UIControlStateNormal];
            [self.songLiButton addTarget:self action:@selector(songLi) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:self.songLiButton];

        }
        if(![@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
        {
            if ([@"1" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]])
            {
                
                self.huDongButton = [[UIButton alloc] initWithFrame:CGRectMake(self.guanBiDaKaiCameraButton.frame.origin.x+self.guanBiDaKaiCameraButton.frame.size.width+73*BILI, self.songLiButton.frame.origin.y, 198*BILI/2, 57*BILI)];
                [self.huDongButton setImage:[UIImage imageNamed:@"shiPin_btn_tiaodou"] forState:UIControlStateNormal];
                [self.huDongButton addTarget:self action:@selector(huDongButtonClick) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:self.huDongButton];
                
                self.huDongButton.hidden = YES;
            }
            
        }
       
        
    
        
        self.chatTextFieldBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT+50*BILI, VIEW_WIDTH, 50*BILI)];
        self.chatTextFieldBottomView.backgroundColor = [UIColor blackColor];
        self.chatTextFieldBottomView.alpha = 0.2;
        [self.view addSubview:self.chatTextFieldBottomView];
        
        
        self.chatTextField = [[UITextField alloc] initWithFrame:CGRectMake(22*BILI, self.chatTextFieldBottomView.frame.origin.y, 144*BILI/2+440*BILI/2, 50*BILI)];
        self.chatTextField.backgroundColor = [UIColor clearColor];
        self.chatTextField.font = [UIFont systemFontOfSize:15*BILI];
        self.chatTextField.textColor = [UIColor whiteColor];
        self.chatTextField.placeholder = @"说点什么";
        self.chatTextField.returnKeyType=UIReturnKeySend;
        self.chatTextField.delegate = self;
        [self.chatTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
        [self.view addSubview:self.chatTextField];
        
//        self.faSongButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-62*BILI, self.chatTextFieldBottomView.frame.origin.y+10*BILI, 50*BILI, 30*BILI)];
//        [self.faSongButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [self.faSongButton setTitle:@"发送" forState:UIControlStateNormal];
//        self.faSongButton.layer.cornerRadius = 5*BILI;
//        self.faSongButton.backgroundColor = [UIColor blackColor];
//        self.faSongButton.titleLabel.font = [UIFont systemFontOfSize:15*BILI];
//        self.faSongButton.alpha = 0.5;
//        [self.faSongButton addTarget:self action:@selector(faSongMessage) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:self.faSongButton];

        
    
    self.closeShiPinButton.hidden = YES;
    self.shiChangLableBottom.hidden = YES;
    self.shiChangLable.hidden = YES;
    self.jinBiLableBottom.hidden = YES;
    self.jinBiLable.hidden = YES;
    self.sendMessageButton.hidden = YES;
    self.openOrCloseVoiceButton.hidden = YES;
    self.qieHuanJingTouButton.hidden = YES;
    self.guanBiDaKaiCameraButton.hidden = YES;
    self.chongZhiBUtton.hidden = YES;
    self.songLiButton.hidden = YES;
    
    self.jieShouButton = [[UIButton alloc] initWithFrame:CGRectMake(18*BILI, VIEW_HEIGHT-158*BILI/2, 160*BILI, 50*BILI)] ;
    self.jieShouButton.backgroundColor = UIColorFromRGB(0x7ED321);
    self.jieShouButton.layer.cornerRadius = 4;
    [self.jieShouButton setTitle:@"接通" forState:UIControlStateNormal];
    [self.jieShouButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.jieShouButton addTarget:self action:@selector(jieShou:) forControlEvents:UIControlEventTouchUpInside];
    self.jieShouButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
    [self.view addSubview:self.jieShouButton];
    
    self.jvJueButtn = [[UIButton alloc] initWithFrame:CGRectMake(198*BILI, VIEW_HEIGHT-158*BILI/2, 160*BILI, 50*BILI)] ;
    self.jvJueButtn.backgroundColor = UIColorFromRGB(0xFF6666);
    self.jvJueButtn.layer.cornerRadius = 4;
    [self.jvJueButtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.jvJueButtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.jvJueButtn addTarget:self action:@selector(jieShou:) forControlEvents:UIControlEventTouchUpInside];
    self.jvJueButtn.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
    [self.view addSubview:self.jvJueButtn];
    
    //隐藏原有正在连接中提示lable
    self.connectingLabel.hidden = YES;
    //隐藏原有视频语音切换按钮
    self.switchModelBtn.hidden = YES;
    //隐藏原有记录视频时间的lable
    self.durationLabel.hidden = YES;
    //设置是否静音属性
    self.callInfo.isMute = NO;

    
    if ([@"jieShou" isEqualToString:self.huJiaoOrJieShou]) {
        
        self.beiJiaoTipLable.text = @"正在邀请你";
        self.openOrCloseCameraButton.hidden = YES;
        self.openOrCloseCameraLable.hidden = YES;
        self.quXiaoButton.hidden = YES;
        self.quXiaoLable.hidden = YES;
    }
    else if([@"dengDai" isEqualToString:self.huJiaoOrJieShou])
    {
        self.jieShouButton.hidden = YES;
        self.jvJueButtn.hidden = YES;
    }
    else
    {
        self.beiJiaoTipLable.text = @"正在邀请你";
        self.openOrCloseCameraButton.hidden = YES;
        self.openOrCloseCameraLable.hidden = YES;
        self.quXiaoButton.hidden = YES;
        self.quXiaoLable.hidden = YES;
        
        self.jieShouButton.hidden = YES;
        self.jvJueButtn.hidden = YES;
    }
    //****************************************************
    
    
    self.switchCameraBtn.hidden = YES;
    self.disableCameraBtn.hidden = YES;
    
   
    
 }
    self.localRecordingView.layer.cornerRadius = 10.0;
    self.localRecordingRedPoint.layer.cornerRadius = 4.0;
    self.lowMemoryView.layer.cornerRadius = 10.0;
    self.lowMemoryRedPoint.layer.cornerRadius = 4.0;
    self.refuseBtn.exclusiveTouch = YES;
    self.acceptBtn.exclusiveTouch = YES;
    if ([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive) {
        [self initRemoteGLView];
    }
    
    
    if (![@"audio" isEqualToString:self.videoOrAudio]) {
        
        self.chatSourceArray = [NSMutableArray array];
        
        self.chatTableView = [[UITableView alloc] initWithFrame:CGRectMake(12*BILI, VIEW_HEIGHT-230*BILI, VIEW_WIDTH-24*BILI, 140*BILI)];
        self.chatTableView.delegate = self;
        self.chatTableView.dataSource = self;
        self.chatTableView.separatorStyle = NO;
        self.chatTableView.backgroundColor = [UIColor clearColor];
        if (@available(iOS 11, *)) {
            self.chatTableView.estimatedRowHeight = 0;
            self.chatTableView.estimatedSectionHeaderHeight = 0;
            self.chatTableView.estimatedSectionFooterHeight = 0;
        }
        [self.view addSubview:self.chatTableView];

    }
    

    [self initNoWifiView];
    self.buttonArray = [NSMutableArray array];
    [self initChongZhiView];
}

//聊天展示tableView
#pragma mark---UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.chatSourceArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return  35*BILI;
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *tableIdentifier = [NSString stringWithFormat:@"ShiPinXiuPingLunTableViewCell%d",(int)[indexPath row]] ;
    TanLiaoLiao_ShiPinXiuPingLunTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    if (cell == nil)
    {
        cell = [[TanLiaoLiao_ShiPinXiuPingLunTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    cell.fromWhere = @"videoChat";
    cell.backgroundColor = [UIColor clearColor];
    [cell initData:[self.chatSourceArray objectAtIndex:indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)yiJieTongHangUp
{
    //用户端视频中点击挂断
    if ([@"1" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]]) {
        
        self.hangUpType = @"5";

    }
    [self hangup];
}

-(void)quXiaoHangup
{
    //用户端拨打时取消通话,用户端拒绝接听
    if ([@"1" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]]) {
        
        self.hangUpType = @"1";//用户拒接
        
    }
    else
    {
        self.hangUpType = @"4";//主播拒接
    }
    
    
    [self hangup];
}

-(void)guaDuanSuccess:(NSDictionary *)info
{
    NSLog(@"8888888888 hungSuccess");
}
-(void)guaDuError:(NSDictionary *)info
{
    
}
-(void)initNoWifiView
{
    self.noWifiView = [[UIView alloc] initWithFrame:CGRectMake(75*BILI/2, 330*BILI/2, VIEW_WIDTH-75*BILI, 300*BILI)];
    
    self.noWifiView.backgroundColor = UIColorFromRGB(0xE7E7E7);
    self.noWifiView.layer.cornerRadius = 30;
    [self.view addSubview:self.noWifiView];
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(59*BILI/2, 21*BILI, self.noWifiView.frame.size.width-59*BILI, 254*BILI/2)];
    imageView.image = [UIImage imageNamed:@"pic_flow"];
    [self.noWifiView addSubview:imageView];
    
    UILabel * lable = [[UILabel alloc] initWithFrame:CGRectMake(59*BILI/2, imageView.frame.origin.y+imageView.frame.size.height+20*BILI, imageView.frame.size.width, 48*BILI)];
    lable.text = @"在移动网络环境下会影视频品质量,并产生手机流量,确定继续?";
    lable.numberOfLines = 2;
    lable.font = [UIFont systemFontOfSize:15*BILI];
    lable.textColor = UIColorFromRGB(0x040404);
    lable.alpha = 0.6;
    [self.noWifiView addSubview:lable];
    
    UIButton * jiXuButton = [[UIButton alloc] initWithFrame:CGRectMake(lable.frame.origin.x, lable.frame.origin.y+lable.frame.size.height+30*BILI, 110*BILI, 40*BILI)];
    jiXuButton.backgroundColor = UIColorFromRGB(0xFF5C93);
    jiXuButton.layer.cornerRadius = 20*BILI;
    [jiXuButton setTitle:@"继续" forState:UIControlStateNormal];
    [jiXuButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    jiXuButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
    [jiXuButton addTarget:self action:@selector(jiXuButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.noWifiView addSubview:jiXuButton];
    
    
    UIButton * quXiaoButton = [[UIButton alloc] initWithFrame:CGRectMake(lable.frame.origin.x+jiXuButton.frame.size.width+20*BILI, lable.frame.origin.y+lable.frame.size.height+30*BILI, 110*BILI, 40*BILI)];
    quXiaoButton.backgroundColor = [UIColor whiteColor];
    quXiaoButton.layer.cornerRadius = 20*BILI;
    quXiaoButton.alpha = 0.7;
    [quXiaoButton setTitle:@"取消" forState:UIControlStateNormal];
    [quXiaoButton setTitleColor:UIColorFromRGB(0x3B3B3B) forState:UIControlStateNormal];
    quXiaoButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
    [quXiaoButton addTarget:self action:@selector(noWifiHangUp) forControlEvents:UIControlEventTouchUpInside];
    [self.noWifiView addSubview:quXiaoButton];
    
    self.noWifiView.hidden = YES;
    continueNoWifi = NO;

}
-(void)noWifiHangUp
{
    //用户端没有wifi挂断
    if ([@"1" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]]) {
        
        self.hangUpType = @"1";
    }
    [self hangup];
}
//充值界面
-(void)initChongZhiView
{
    self.chongZhiView = [[UIView alloc] initWithFrame:CGRectMake(75*BILI/2, 330*BILI/2-40*BILI, VIEW_WIDTH-75*BILI, 300*BILI)];
    
    self.chongZhiView.backgroundColor = UIColorFromRGB(0xE7E7E7);
    self.chongZhiView.layer.cornerRadius = 20;
    [self.view addSubview:self.chongZhiView];
    
    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(22*BILI, 67*BILI/2, 100*BILI, 24*BILI)];
    tipLable.font = [UIFont systemFontOfSize:24*BILI];
    tipLable.textColor = [UIColor blackColor];
    tipLable.alpha = 0.4;
    tipLable.text = @"充值金额";
    [self.chongZhiView addSubview:tipLable];
    
    self.chongZhiJinErLable = [[UILabel alloc] initWithFrame:CGRectMake(tipLable.frame.origin.x+tipLable.frame.size.width, 79*BILI/2, 121*BILI, 18*BILI)];
    self.chongZhiJinErLable.font = [UIFont systemFontOfSize:18];
    self.chongZhiJinErLable.textColor = UIColorFromRGB(0xF5A623);
    [self.chongZhiView addSubview:self.chongZhiJinErLable];
    
    
    
    NSArray * array ;
    
  
    array = [[NSArray alloc] initWithObjects:@"5",@"42",@"68",@"138",@"271",@"698", nil];
   
    
    self.productIDArray = [[NSArray alloc] initWithObjects:@"lwb5",@"lwb42",@"lwb68",@"lwb138",@"lwb271",@"lwb698", nil];
    if([array isKindOfClass:[NSArray class]])
    {
    for (int i=0; i<array.count; i++) {
        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(19*BILI+(5+84)*BILI*(i%3), tipLable.frame.origin.y+tipLable.frame.size.height+25*BILI+(45*BILI)*(i/3), 84*BILI, 35*BILI)];
        NSString * money = [array objectAtIndex:i];
        button.tag = money.intValue;
        button.layer.cornerRadius = 6;
        button.layer.borderWidth = 2;
        button.layer.borderColor = [UIColorFromRGB(0xC7C7C7) CGColor];
        button.titleLabel.font = [UIFont systemFontOfSize:15*BILI];
        if(VIEW_WIDTH==320)
        {
            button.titleLabel.font = [UIFont systemFontOfSize:13*BILI];

        }
        [button setTitle:[NSString stringWithFormat:@"%@金币",money] forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromRGB(0xFF9000) forState:UIControlStateNormal];
        [button addTarget:self action:@selector(moneyButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.chongZhiView addSubview:button];
        [self.buttonArray addObject:button];
        
    }
    }
    UIButton * chongZhiButton = [[UIButton alloc] initWithFrame:CGRectMake(19*BILI, 240*BILI, 262*BILI, 40*BILI)];
    chongZhiButton.backgroundColor = UIColorFromRGB(0xFF5C93);
    chongZhiButton.layer.cornerRadius = 20*BILI;
    chongZhiButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
    [chongZhiButton setTitle:[NSString stringWithFormat:@"充值"] forState:UIControlStateNormal];
    [chongZhiButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [chongZhiButton addTarget:self action:@selector(chongZhi) forControlEvents:UIControlEventTouchUpInside];
    [self.chongZhiView addSubview:chongZhiButton];
    
    self.closeChongZhiViewButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-43*BILI)/2,self.chongZhiView.frame.origin.y-50*BILI, 43*BILI, 43*BILI)];
    [self.closeChongZhiViewButton setImage:[UIImage imageNamed:@"btn_close1"] forState:UIControlStateNormal];
    [self.closeChongZhiViewButton addTarget:self action:@selector(closeChongZhiViewButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.closeChongZhiViewButton];
    
    self.chongZhiView.hidden = YES;
    self.closeChongZhiViewButton.hidden = YES;
}
//送礼物界面
-(void)initDaShangView
{
    self.selectGift = nil;
    
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
    
    UIView * jinBiBottomView = [[UIView alloc] initWithFrame:CGRectMake(-10, 33*BILI, 125*BILI, 30*BILI)];
    jinBiBottomView.layer.cornerRadius = 15*BILI;
    jinBiBottomView.layer.masksToBounds = YES;
    jinBiBottomView.backgroundColor = [UIColor whiteColor];
    jinBiBottomView.alpha = 0.2;
    [self.daShangBottomButtonView addSubview:jinBiBottomView];
    
    self.daShangViewJinBiLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 33*BILI, 115*BILI, 30*BILI)];
    self.daShangViewJinBiLable.font = [UIFont systemFontOfSize:18*BILI];
    self.daShangViewJinBiLable.textColor = [UIColor whiteColor];
    self.daShangViewJinBiLable.textAlignment = NSTextAlignmentCenter;
    
    self.daShangViewJinBiLable.text =[NSString stringWithFormat:@"%.2f金币",self.money.floatValue/JinBiBiLi];
    [self.daShangBottomButtonView addSubview:self.daShangViewJinBiLable];
    
    UIButton * chongZhiButton = [[UIButton alloc] initWithFrame:CGRectMake(120*BILI, 33*BILI, 75*BILI, 30*BILI)];
    [chongZhiButton setTitle:@"充值" forState:UIControlStateNormal];
    [chongZhiButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    chongZhiButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
    chongZhiButton.backgroundColor = UIColorFromRGB(0xF5A623);
    chongZhiButton.layer.cornerRadius = 15*BILI;
    [chongZhiButton addTarget:self action:@selector(daShangChongZhiButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.daShangBottomButtonView addSubview:chongZhiButton];
    
     if ([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
     {
         chongZhiButton.hidden = YES;
     }
    
    UIButton * zengSongButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(24+75)*BILI, 33*BILI, 75*BILI, 30*BILI)];
    [zengSongButton setTitle:@"赠送" forState:UIControlStateNormal];
    [zengSongButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    zengSongButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
    zengSongButton.backgroundColor = UIColorFromRGB(0xFF5C93);
    zengSongButton.layer.cornerRadius = 15*BILI;
    [zengSongButton addTarget:self action:@selector(zengSongButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.daShangBottomButtonView addSubview:zengSongButton];
    
    //主播只展示送礼界面但是不能赠送
    if([@"2" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]])
    {
        zengSongButton.hidden = YES;
        self.daShangViewJinBiLable.hidden = YES;
        chongZhiButton.hidden = YES;
        jinBiBottomView.hidden = YES;
    }
    
   // NSArray * array = [[NSArray alloc] initWithObjects:@"10",@"30",@"50",@"100",@"200",@"500",@"1500", @"2000",@"2500",@"3000",@"3500",@"4000",nil];
    
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
    
    self.closeDaShangViewButton = [[UIButton alloc] initWithFrame:CGRectMake(332*BILI/2,VIEW_HEIGHT-270*BILI-20*BILI-43*BILI, 43*BILI, 43*BILI)];
    [self.closeDaShangViewButton setImage:[UIImage imageNamed:@"btn_close1"] forState:UIControlStateNormal];
    [self.closeDaShangViewButton addTarget:self action:@selector(closeDaShangViewButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.closeDaShangViewButton];

//    self.daShangView.hidden = YES;
//    self.daShangBottomButtonView.hidden = YES;
//    self.daShangBottomView.hidden = YES;
//    self.closeDaShangViewButton.hidden = YES;
    
    
}
-(void)removeDaShangView
{
    
    [self.daShangView removeFromSuperview];
    [self.daShangBottomButtonView removeFromSuperview];
    [self.daShangBottomView removeFromSuperview];
    [self.closeDaShangViewButton removeFromSuperview];
}
-(void)closeDaShangViewButtonClick
{
//    self.daShangView.hidden = YES;
//    self.daShangBottomButtonView.hidden = YES;
//    self.daShangBottomView.hidden = YES;
//    self.closeDaShangViewButton.hidden = YES;
    
    [self removeDaShangView];
}
//点击打赏界面的充值按钮
-(void)daShangChongZhiButtonClick
{
//    self.daShangView.hidden = YES;
//    self.daShangBottomButtonView.hidden = YES;
//    self.daShangBottomView.hidden = YES;
//    self.closeDaShangViewButton.hidden = YES;
    
     [self removeDaShangView];
    
    self.chongZhiView.hidden = NO;
    self.closeChongZhiViewButton.hidden = NO;
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
    [self removeDaShangView];
//    self.daShangView.hidden = YES;
//    self.daShangBottomButtonView.hidden = YES;
//    self.daShangBottomView.hidden = YES;
//    self.closeDaShangViewButton.hidden = YES;
    if([self.selectGift isKindOfClass:[NSDictionary class]])
    {
        
        NSString * giftMoney = [self.selectGift objectForKey:@"goodsWorth"];
        if (self.yuEStr.intValue<giftMoney.intValue) {
            
            if ([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]]) {
                
                [TanLiao_Common showToastView:@"余额不足请充值" view:self.view];
                return;
            }
            else
            {
                [TanLiao_Common showToastView:@"余额不足请充值" view:self.view];
                self.chongZhiView.hidden = NO;
                self.closeChongZhiViewButton.hidden = NO;
                return;
            }
        }
        
        if ([self.callInfo.callee isEqualToString:[TanLiao_Common getNowUserID]])
        {
            //赠送礼物
            [self.cloudClient sendGift:@"8139"
                              anchorId:self.callInfo.caller
                               goodsId:[self.selectGift objectForKey:@"goodsId"]
                              delegate:self
                              selector:@selector(sendGiftSuccess:)
                         errorSelector:@selector(sendGiftError:)];
        }
        else
        {
            //赠送礼物
            [self.cloudClient sendGift:@"8139"
                              anchorId:self.callInfo.callee
                               goodsId:[self.selectGift objectForKey:@"goodsId"]
                              delegate:self
                              selector:@selector(sendGiftSuccess:)
                         errorSelector:@selector(sendGiftError:)];
        }
    
        
    }
    else
    {
        [TanLiao_Common showToastView:@"请选要增送的礼物" view:self.view];
    }
}

-(void)sendGiftSuccess:(NSDictionary *)indo
{
    
    [self getUserGoldNumber];
    
    
    
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
     

}
-(void)sendGiftError:(NSDictionary *)info
{
    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];
}
-(void)moneyButtonClick:(id)sender
{
    for (int i=0; i<self.buttonArray.count; i++) {
        
        UIButton * button = [self.buttonArray objectAtIndex:i];
        button.layer.borderColor = [UIColorFromRGB(0xC7C7C7) CGColor];
        [button setTitleColor:UIColorFromRGB(0xFF9000) forState:UIControlStateNormal];
        button.backgroundColor = [UIColor whiteColor];
    }
    
    UIButton * button = (UIButton *)sender;
    button.backgroundColor = UIColorFromRGB(0xF5A623);
    button.layer.borderColor = [UIColorFromRGB(0xF5A623) CGColor];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.chongZhiMoney = [NSString stringWithFormat:@"%d",(int)button.tag*JinBiBiLi];
    
    switch ((int)button.tag) {
        case 5:
            self.productID = [self.productIDArray objectAtIndex:0];
            self.chongZhiJinErLable.text = @"(8元)";
            break;
        case 42:
            self.productID = [self.productIDArray objectAtIndex:1];
            self.chongZhiJinErLable.text = @"(60元)";
            break;
        case 68:
            self.productID = [self.productIDArray objectAtIndex:2];
            self.chongZhiJinErLable.text = @"(98元)";
            break;
        case 138:
            self.productID = [self.productIDArray objectAtIndex:3];
            self.chongZhiJinErLable.text = @"(198元)";
            break;
        case 271:
            self.productID = [self.productIDArray objectAtIndex:4];
            self.chongZhiJinErLable.text = @"(388元)";
            break;
        case 698:
            self.productID = [self.productIDArray objectAtIndex:5];
            self.chongZhiJinErLable.text = @"(998元)";
            break;
            
        default:
            break;
    }
}
-(void)chongZhi
{
    if (self.chongZhiMoney==nil||[@"" isEqualToString:self.chongZhiMoney]) {
        
        UIButton * tipButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-200)/2,VIEW_HEIGHT-100, 200, 40)];
        tipButton.enabled = NO;
        tipButton.alpha = 0.8;
        tipButton.layer.cornerRadius = 20;
        tipButton.backgroundColor = [UIColor blackColor];
        [tipButton setTitle:@"请选择要充值的金币" forState:UIControlStateNormal];
        [tipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        tipButton.titleLabel.font = [UIFont systemFontOfSize:15];
        tipButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.view addSubview:tipButton];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:3];
        tipButton.alpha = 0;
        [UIView commitAnimations];
        
        
    }
    else
    {
        self.chongZhiView.hidden = YES;
        self.closeChongZhiViewButton.hidden = YES;

        NSString * payChannel;
        
        payChannel = @"3";
        int  finalMoney = self.chongZhiMoney.intValue;
        [self showNewLoadingView:@"处理中,请稍后..."  view:self.view];
        [self.cloudClient qianBaoPayCharge:@"8093"
                                  currency:@"1"
                                    amount:[NSString stringWithFormat:@"%d",finalMoney]
                                   channel:payChannel
                                chargeType:@"0"
                                  chargeId:@""
                                  delegate:self
                                  selector:@selector(getChargeSuccess:)
                             errorSelector:@selector(getChargeError:)];
        
        
      
        
    }
}
-(void)getChargeSuccess:(NSDictionary *)info
{
    NSDictionary * charge =  [TanLiao_Common dictionaryWithJsonString:[info objectForKey:@"result"]];
    self.out_trade_no = [charge objectForKey:@"out_trade_no"];
    
    [self showNewLoadingView:@"正在购买..." view:nil];
    appPayTotast = YES;
    if([SKPaymentQueue canMakePayments]){
        [self requestProductData:self.productID];
    }else{
        NSLog(@"不允许程序内付费");
    }
}

//苹果内购开始
//请求商品
- (void)requestProductData:(NSString *)type{
    NSLog(@"-------------请求对应的产品信息----------------");
    NSArray *product = [[NSArray alloc] initWithObjects:type, nil];
    
    NSSet *nsset = [NSSet setWithArray:product];
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:nsset];
    request.delegate = self;
    [request start];
    
}
//收到产品返回信息
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response{
    
    NSLog(@"--------------收到产品反馈消息---------------------");
    NSArray *product = response.products;
    if([product count] == 0){
        NSLog(@"--------------没有商品------------------");
        return;
    }
    
    NSLog(@"productID:%@", response.invalidProductIdentifiers);
    NSLog(@"产品付费数量:%d",[product count]);
    
    SKProduct *p = nil;
    for (SKProduct *pro in product) {
        NSLog(@"%@", [pro description]);
        NSLog(@"%@", [pro localizedTitle]);
        NSLog(@"%@", [pro localizedDescription]);
        NSLog(@"%@", [pro price]);
        NSLog(@"%@", [pro productIdentifier]);
        
        if([pro.productIdentifier isEqualToString:self.productID]){
            p = pro;
        }
    }
    
    SKPayment *payment = [SKPayment paymentWithProduct:p];
    
    NSLog(@"发送购买请求");
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}
//请求失败
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"------------------错误-----------------:%@", error);
}

- (void)requestDidFinish:(SKRequest *)request{
    NSLog(@"------------反馈信息结束-----------------");
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    
}


//监听购买结果
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transaction{
    for(SKPaymentTransaction *tran in transaction){
        
        switch (tran.transactionState) {
            case SKPaymentTransactionStatePurchased:
                [self buyAppleStoreProductSucceedWithPaymentTransactionp:tran];
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
                NSLog(@"交易完成");
                break;
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"商品添加进列表");
                appPayTotast = NO;
                
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"已经购买过商品");
                
                break;
            case SKPaymentTransactionStateFailed:
                NSLog(@"交易失败");
                if (appPayTotast ==NO) {
                    
                    [self hideNewLoadingView];
                    
                }
                
                break;
            default:
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
    NSLog(@"苹果内购凭据号\n\n\n\n\n\n%@\n\n\n\n\n\n",base64Str);
    
    [self checkAppStorePayResultWithBase64String:base64Str];
    //12077
    
    
}


- (void)checkAppStorePayResultWithBase64String:(NSString *)base64String {
    
    /* 生成订单参数，注意沙盒测试账号与线上正式苹果账号的验证途径不一样，要给后台标明 */
    NSNumber *sandbox;
#if (defined(APPSTORE_ASK_TO_BUY_IN_SANDBOX) && defined(DEBUG))
    sandbox = @(0);
#else
    sandbox = @(1);
#endif
    
    NSMutableDictionary *prgam = [[NSMutableDictionary alloc] init];
    
    [prgam setValue:sandbox forKey:@"sandbox"];
    [prgam setValue:base64String forKey:@"reciept"];
    
    /*
     请求后台接口，服务器处验证是否支付成功，依据返回结果做相应逻辑处理
     */
    
    [self showNewLoadingView:@"验证支付结果..." view:self.view];
    
    [self.cloudClient getAppPayResult:@"8908"
                              orderNo:self.out_trade_no
                              receipt:base64String
                             delegate:self
                             selector:@selector(getResultSuccess:)
                        errorSelector:@selector(getResultError:)];
    
}
//交易结束
- (void)completeTransaction:(SKPaymentTransaction *)transaction{
    NSLog(@"交易结束");
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}
-(void)getResultSuccess:(NSDictionary *)info
{
        [self hideNewLoadingView];
    
        [self getUserGoldNumber];
        
        UIButton * tipButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-200)/2,VIEW_HEIGHT-100, 200, 40)];
        tipButton.enabled = NO;
        tipButton.alpha = 0.8;
        tipButton.layer.cornerRadius = 20;
        tipButton.backgroundColor = [UIColor blackColor];
        [tipButton setTitle:@"充值成功" forState:UIControlStateNormal];
        [tipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        tipButton.titleLabel.font = [UIFont systemFontOfSize:15];
        tipButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.view addSubview:tipButton];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:3];
        tipButton.alpha = 0;
        [UIView commitAnimations];

    
}
-(void)getResultError:(NSDictionary *)info
{
    [self hideNewLoadingView];
}


-(void)getPayReturnError:(NSDictionary *)info
{
    
}
-(void)getChargeError:(NSDictionary *)info
{
    
}

//关闭充值界面
-(void)closeChongZhiViewButtonClick
{
    self.chongZhiView.hidden = YES;
    self.closeChongZhiViewButton.hidden = YES;

}
-(void)jiXuButtonClick
{
    self.noWifiView.hidden = YES;
    continueNoWifi = YES;
}
-(void)willSendMessage
{
    [self.chatTextField becomeFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (![TanLiao_Common isEmpty:self.chatTextField.text])
    {
        RCTextMessage * messageContent = [[RCTextMessage alloc] init];
        messageContent.senderUserInfo = [[RCUserInfo alloc] initWithUserId:[TanLiao_Common getNowUserID] name:[TanLiao_Common getCurrentUserName] portrait:[TanLiao_Common getCurrentAvatarpath]];
        messageContent.content = self.chatTextField.text;
        for (NSString *str in self.shieldArr) {
            if ([messageContent.content containsString:str]) {
                messageContent.content = [messageContent
                                          .content stringByReplacingOccurrencesOfString:str withString:@" "];
            }
        }
        self.chatTextField.text = nil;
        NSString * targetId ;
        if ([self.callInfo.callee isEqualToString:[TanLiao_Common getNowUserID]]) {
            targetId = self.callInfo.caller;
        }
        else
        {
            targetId = self.callInfo.callee;
        }
        [self.chatTextField resignFirstResponder];
        
        
        [[RCIM sharedRCIM] sendMessage:ConversationType_PRIVATE targetId:targetId content:messageContent pushContent:nil pushData:nil success:^(long messageId)
         {
             
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                 NSDictionary * chatInfo = [[NSDictionary alloc] initWithObjectsAndKeys:[TanLiao_Common getCurrentUserName],@"nick",messageContent.content,@"content",[TanLiao_Common getNowUserID],@"targetID", nil];
                 [self.chatSourceArray addObject:chatInfo];
                 [self.chatTableView reloadData];
                 CGFloat yOffset = 0; //设置要滚动的位置 0最顶部 CGFLOAT_MAX最底部
                 if (self.chatTableView.contentSize.height > self.chatTableView.bounds.size.height) {
                     yOffset = self.chatTableView.contentSize.height - self.chatTableView.bounds.size.height;
                 }
                 [self.chatTableView setContentOffset:CGPointMake(0, yOffset) animated:NO];
                 
                 
                 
             });
             
         } error:^(RCErrorCode nErrorCode, long messageId) {
              [TanLiao_Common showToastView:@"发送失败,请重试" view:self.view];
         }];
    }
    else
    {
        [TanLiao_Common showToastView:@"发送内容不能为空" view:self.view];
        self.chatTextField.text = nil;
        [self.chatTextField resignFirstResponder];
    }
    return YES;
}

-(void)openOrCloseVoice
{
    
    
    
    if (YES == self.callInfo.isMute) {
        [self.openOrCloseVoiceButton setImage:[UIImage imageNamed:@"btn_mac_close"] forState:UIControlStateNormal];
        [self.jingYinButton setImage:[UIImage imageNamed:@"audio_yonghu_jingyin_n"] forState:UIControlStateNormal];
        self.callInfo.isMute = NO;
        [[NIMAVChatSDK sharedSDK].netCallManager setMute:NO];
    }
    else
    {
        [self.openOrCloseVoiceButton setImage:[UIImage imageNamed:@"btn_mac_open"] forState:UIControlStateNormal];
        [self.jingYinButton setImage:[UIImage imageNamed:@"audio_yonghu_jingyin_h"] forState:UIControlStateNormal];
        self.callInfo.isMute = YES;
        [[NIMAVChatSDK sharedSDK].netCallManager setMute:YES];

    }
}
-(void)qieHuanJIngTou
{
    if (self.cameraType == NIMNetCallCameraFront) {
        self.cameraType = NIMNetCallCameraBack;
         [[NIMAVChatSDK sharedSDK].netCallManager switchCamera:NIMNetCallCameraBack];
        
    }else{
        self.cameraType = NIMNetCallCameraFront;
         [[NIMAVChatSDK sharedSDK].netCallManager switchCamera:NIMNetCallCameraFront];
    }
}

-(void)guanBiDaKaiCamera
{
    self.callInfo.disableCammera = !self.callInfo.disableCammera;
    [[NIMAVChatSDK sharedSDK].netCallManager setCameraDisable:self.callInfo.disableCammera];
    if (self.callInfo.disableCammera) {
        [self.guanBiDaKaiCameraButton setImage:[UIImage imageNamed:@"btn_close_video"] forState:UIControlStateNormal];
        [self.localPreView removeFromSuperview];
        [[NIMAVChatSDK sharedSDK].netCallManager control:self.callInfo.callID type:NIMNetCallControlTypeCloseVideo];
    }else{
         [self.guanBiDaKaiCameraButton setImage:[UIImage imageNamed:@"btn_open_video"] forState:UIControlStateNormal];
        [self.localView addSubview:self.localPreView];
        [[NIMAVChatSDK sharedSDK].netCallManager control:self.callInfo.callID type:NIMNetCallControlTypeOpenVideo];
    }

}
-(void)beginChongZhi
{
    self.chongZhiView.hidden = NO;
    self.closeChongZhiViewButton.hidden = NO;
}
-(void)songLi
{
    //[self songYa];
    
    self.chongZhiView.hidden = YES;
    self.closeChongZhiViewButton.hidden = YES;
    
    [self. button sendActionsForControlEvents:UIControlEventTouchUpInside];

    [self initDaShangView];
}
-(void)getTiaoDouMessageNotification:(NSNotification *)notification
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        
        NSDictionary * messageInfo = [notification object];
        
        if([[messageInfo allKeys] containsObject:@"status"])
        {
            [self.tiaoDouPingJiaView removeFromSuperview];
          
            self.yongHuTiaoDouPingJiaAlphaView = [[UIView alloc] initWithFrame:CGRectMake(-511*BILI/2, 210*BILI/2, 511*BILI/2, 50*BILI)];
            self.yongHuTiaoDouPingJiaAlphaView.backgroundColor = [UIColor whiteColor];
            self.yongHuTiaoDouPingJiaAlphaView.alpha = 0.8;
            self.yongHuTiaoDouPingJiaAlphaView.layer.masksToBounds = YES;
            self.yongHuTiaoDouPingJiaAlphaView.layer.cornerRadius = 25*BILI;
            [self.view addSubview:self.yongHuTiaoDouPingJiaAlphaView];
            
            self.yongHuTiaoDouPingJiaView = [[UIView alloc] initWithFrame:CGRectMake(-511*BILI/2, 210*BILI/2, 511*BILI/2, 50*BILI)];
            self.yongHuTiaoDouPingJiaView.backgroundColor = [UIColor clearColor];
            [self.view addSubview:self.yongHuTiaoDouPingJiaView];
            
            UILabel * messageLable = [[UILabel alloc] initWithFrame:CGRectMake(100*BILI/2, 0, 411*BILI/2, 50*BILI)];
            messageLable.font = [UIFont systemFontOfSize:24*BILI];
            messageLable.textAlignment = NSTextAlignmentCenter;
            if ([@"1" isEqualToString:[messageInfo objectForKey:@"status"]]) {
                
                messageLable.textColor = UIColorFromRGB(0xF950AB);

                NSString * str = @"本次互动评价  很满意";
                NSAttributedString * str1 = [[NSAttributedString alloc] initWithString:str];
                NSMutableAttributedString * text1 = [[NSMutableAttributedString alloc] initWithAttributedString:str1];
                [text1 addAttribute:NSForegroundColorAttributeName
                              value:UIColorFromRGB(0x9168DE)
                              range:NSMakeRange(0, 6)];
                [text1 addAttribute:NSFontAttributeName
                              value:[UIFont fontWithName:@"Helvetica-Bold" size:15*BILI]
                              range:NSMakeRange(0, 6)];
                messageLable.attributedText = text1;
            }
            else
            {
                messageLable.textColor = UIColorFromRGB(0x765959);
                
                NSString * str = @"本次互动评价  不满意";
                NSAttributedString * str1 = [[NSAttributedString alloc] initWithString:str];
                NSMutableAttributedString * text1 = [[NSMutableAttributedString alloc] initWithAttributedString:str1];
                [text1 addAttribute:NSForegroundColorAttributeName
                              value:UIColorFromRGB(0x9168DE)
                              range:NSMakeRange(0, 6)];
                [text1 addAttribute:NSFontAttributeName
                              value:[UIFont fontWithName:@"Helvetica-Bold" size:15*BILI]
                              range:NSMakeRange(0, 6)];
                messageLable.attributedText = text1;
            }
            [self.yongHuTiaoDouPingJiaView addSubview:messageLable];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:0.5];
            self.yongHuTiaoDouPingJiaAlphaView.frame = CGRectMake(-100*BILI/2, 210*BILI/2, 511*BILI/2, 50*BILI);
            self.yongHuTiaoDouPingJiaView.frame = CGRectMake(-100*BILI/2, 210*BILI/2, 511*BILI/2, 50*BILI);
            [UIView commitAnimations];
            
            [self performSelector:@selector(remoeResutView) withObject:nil afterDelay:3];

            
            
        }
        else
        {
        
            self.tiaoDouPingJiaView = [[TanLiaoLiao_TiaoDouPingJiaView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
            [ self.tiaoDouPingJiaView initContentView:messageInfo];
            [self.view addSubview: self.tiaoDouPingJiaView];
        }
        
    });
    
}
-(void)remoeResutView
{
    
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         self.yongHuTiaoDouPingJiaAlphaView.frame = CGRectMake(-511*BILI/2, 210*BILI/2, 511*BILI/2, 50*BILI);
                         self.yongHuTiaoDouPingJiaView.frame = CGRectMake(-511*BILI/2, 210*BILI/2, 511*BILI/2, 50*BILI);

                     } completion:^(BOOL finished)
                        {
                         
                         [self.yongHuTiaoDouPingJiaAlphaView removeFromSuperview];
                         [self.yongHuTiaoDouPingJiaView removeFromSuperview];

                     }];
    
    
    
}
-(void)huDongButtonClick
{
    self.huDongButton.enabled = NO;
    if ([self.lureList isKindOfClass:[NSArray class]]&&self.lureList.count>0)
    {
        self.tiaoDouView = [[TanLiaoLiao_TiaoDouView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
        [self.tiaoDouView initContentView:self.lureList];
        self.tiaoDouView.delegate = self;
        [self.view addSubview:self.tiaoDouView];
        
    }
    else
    {
        [TanLiao_Common showToastView:@"当前主播暂时没有挑逗选项~" view:self.view];
    }
}
-(void)tiaoDouBottomTap
{
    self.huDongButton.enabled = YES;
}
-(void)faQiTiaoDou:(NSDictionary *)info
{
    self.lureInfo = info;
    NSNumber * rulePrice = [info objectForKey:@"price"];
    if (self.money.intValue>rulePrice.intValue+self.price.intValue)
    {
        TanLiaoLiao_TanKuangQueRenAlert * alertView = [[TanLiaoLiao_TanKuangQueRenAlert alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
        [alertView initContentView:@"xuanze" title:@"确定支付" content:[NSString stringWithFormat:@"%d金币",rulePrice.intValue/100] message:@"与小仙女精彩有趣的互动马上开始~"];
        alertView.delegate = self;
        [self.view addSubview:alertView];
        
       
    }
    else if (self.money.intValue>=rulePrice.intValue && self.money.intValue<rulePrice.intValue+self.price.intValue)
    {
        TanLiaoLiao_TanKuangQueRenAlert * alertView = [[TanLiaoLiao_TanKuangQueRenAlert alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
        [alertView initContentView:@"xuanZeBuZuYiFenZhong" title:@"确定支付" content:[NSString stringWithFormat:@"%d金币",rulePrice.intValue/100] message:@"与小仙女精彩有趣的互动马上开始~"];
        alertView.delegate = self;
        [self.view addSubview:alertView];
    }
    
    else
    {
        
        self.huDongButton.enabled = YES;
        [self beginChongZhi];
        [self.tiaoDouView removeFromSuperview];
        [TanLiao_Common showToastView:@"余额不足" view:self.view];

    }
   
}
-(void)tanKuangQueRenAlertSelectQueDing
{
    NSString * anchorId;
    if ([self.callInfo.callee isEqualToString:[TanLiao_Common getNowUserID]]) {
        
        
        anchorId = self.callInfo.caller;
    }
    else
    {
        anchorId = self.callInfo.callee;
    }
    NSNumber * lureId = [self.lureInfo objectForKey:@"lureId"];
    NSNumber * rulePrice = [self.lureInfo objectForKey:@"price"];
    [self.cloudClient faQiTiaoDou:@"8909"
                        anchor_id:anchorId
                          lure_id:[NSString stringWithFormat:@"%d",lureId.intValue]
                            price:[NSString stringWithFormat:@"%d",rulePrice.intValue]
                         delegate:self
                         selector:@selector(faQiTiaoDouSuccess:)
                    errorSelector:@selector(faQiTiaoDouError:)];
}
-(void)faQiTiaoDouSuccess:(NSDictionary *)info
{
//    [self.cloudClient getUserInformation:@"8029"
//                                delegate:self
//                                selector:@selector(getUserInformationSuccess:)
//                           errorSelector:@selector(getUserInformationError:)];
    [self getUserGoldNumber];
    self.order_lure_id = [info objectForKey:@"order_lure_id"];
    [self.tiaoDouView removeFromSuperview];
    
    TanLiaoLiao_TiaoDouPingJiaView * view = [[TanLiaoLiao_TiaoDouPingJiaView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    [view initContentView:self.lureInfo];
    view.delegate = self;
    [self.view addSubview:view];
    
}
-(void)faQiTiaoDouError:(NSDictionary *)info
{
    [self.tiaoDouView removeFromSuperview];
    self.huDongButton.enabled = YES;
    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];
}
-(void)huDongPingJia:(NSString *)status
{
    [self.cloudClient tiaoDouPingJia:@"8910"
                       order_lure_id:self.order_lure_id
                              status:status
                            delegate:self
                            selector:@selector(pingJiaSuccess:)
                       errorSelector:@selector(pingJiaError:)];
}
-(void)pingJiaSuccess:(NSDictionary *)info
{
    self.huDongButton.enabled = YES;
    [TanLiao_Common showToastView:@"您已对当前互动作出评价" view:self.view];
}
-(void)pingJiaError:(NSDictionary *)info
{
    self.huDongButton.enabled = YES;
    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];
}
- (void)initRemoteGLView {
#if defined (NTESUseGLView)
    _remoteGLView = [[NTESGLView alloc] initWithFrame:_bigVideoView.bounds];
    [_remoteGLView setContentMode:UIViewContentModeScaleAspectFill];
    [_remoteGLView setBackgroundColor:[UIColor clearColor]];
    _remoteGLView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_bigVideoView addSubview:_remoteGLView];
#endif
}


#pragma mark - Call Life
- (void)startByCaller{

  
    
    self.huJiaoOrJieShou = @"dengDai";
    [super startByCaller];
    [self startInterface];
}

- (void)startByCallee{
    self.huJiaoOrJieShou = @"jieShou";
    [super startByCallee];
    [self waitToCallInterface];
}
- (void)onCalling{
    [super onCalling];
    [self videoCallingInterface];
}

- (void)waitForConnectiong{
    [super waitForConnectiong];
    [self connectingInterface];
}
- (void)onCalleeBusy
{
    _calleeBasy = YES;
    if (_localPreView)
    {
        [_localPreView removeFromSuperview];
    }
}
#pragma mark - Interface
//正在接听中界面
- (void)startInterface{
    
    self.acceptBtn.hidden = YES;
    self.refuseBtn.hidden   = YES;
    self.hungUpBtn.hidden   = NO;
    self.connectingLabel.hidden = NO;
    //self.connectingLabel.text = @"正在呼叫，请稍候...";
    self.switchModelBtn.hidden = YES;
    self.switchCameraBtn.hidden = YES;
    self.muteBtn.hidden = NO;
    self.disableCameraBtn.hidden = YES;
    self.localRecordBtn.hidden = NO;
    self.muteBtn.enabled = NO;
    self.disableCameraBtn.enabled = NO;
    self.localRecordBtn.enabled = NO;
    
    self.localRecordingView.hidden = YES;
    self.lowMemoryView.hidden = YES;
    
    self.localView = self.bigVideoView;
    
    self.openOrCloseCameraButton.hidden = NO;
    self.openOrCloseCameraLable.hidden = NO;
    self.quXiaoButton.hidden = NO;
    self.quXiaoLable.hidden = NO;
    
    self.jieShouButton.hidden = YES;
    self.jvJueButtn.hidden = YES;
    
    if ([@"audio" isEqualToString:self.videoOrAudio]) {
        
        self.localView.hidden = YES;
        self.localPreView.hidden = YES;
        self.smallVideoView.hidden = YES;
        
            self.jvJueButtn.hidden = YES;
            self.beiJiaoGuaDuanLable.hidden = YES;
            self.jieShouButton.hidden = YES;
            self.beiJiaoJieTongLable.hidden = YES;
            
            self.huJiaoGuaDuanButton.hidden = NO;
            self.huJiaoGuaDuanLable.hidden = NO;
            
    }
  
    
    
}
-(void)playAnchorVideo
{
    NSURL *url = [NSURL URLWithString:self.anchorVideoUrl];
    // 2.创建AVPlayerItem
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
    // 3.创建AVPlayer
    self.anchorAudioPlayer = [AVPlayer playerWithPlayerItem:item];
    // 4.添加AVPlayerLayer
    AVPlayerLayer * layer = [AVPlayerLayer playerLayerWithPlayer:self.anchorAudioPlayer];
    //设置视频大小和AVPlayerLayer的frame一样大(全屏播放)
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.anchorVideoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    [self.view addSubview:self.anchorVideoView];
    layer.frame = CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT);
    [self.anchorVideoView.layer addSublayer:layer];
    self.anchorAudioPlayer.volume = 0;//静音
    [self.anchorAudioPlayer play];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.anchorAudioPlayer.currentItem];
}
//  播放完成通知
-(void)playbackFinished:(NSNotification *)notification{
    
    // 播放完成后重复播放
    // 跳到最新的时间点开始播放
    [self.anchorAudioPlayer seekToTime:CMTimeMake(0, 1)];
    [self.anchorAudioPlayer play];
    
}
-(void)stopPlayAnchorVideo
{
    self.localView.hidden = NO;
    if (self.anchorAudioPlayer) {
        [self.anchorAudioPlayer pause];
        self.anchorAudioPlayer=nil;
    }
    [self.anchorVideoView removeFromSuperview];
}

//选择是否接听界面
- (void)waitToCallInterface{
    
    self.acceptBtn.hidden = YES;
    self.refuseBtn.hidden   = YES;
    self.hungUpBtn.hidden   = YES;
    self.muteBtn.hidden = YES;
    self.switchCameraBtn.hidden = YES;
    self.disableCameraBtn.hidden = YES;
    self.localRecordBtn.hidden = YES;
    self.localRecordingView.hidden = YES;
    self.lowMemoryView.hidden = YES;
    self.switchModelBtn.hidden = YES;
    
    
    ////////new add
    self.huJiaoOrJieShou = @"jieShou" ;
    
    self.openOrCloseCameraButton.hidden = YES;
    self.openOrCloseCameraLable.hidden = YES;
    self.quXiaoButton.hidden = YES;
    self.quXiaoLable.hidden = YES;
    
    self.jieShouButton.hidden = NO;
    self.jvJueButtn.hidden = NO;
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    if ([@"qunFaWaiting" isEqualToString:[defaults objectForKey:@"alsoQunFaWaiting"]]) {
        
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@"" forKey:@"alsoQunFaWaiting"];
        [defaults synchronize];
        
        self.alsoPopRoot = @"yes";

        self.jieShouButton.hidden = YES;
        self.jvJueButtn.hidden = YES;
         [self response:YES];
    }
    if([@"audio" isEqualToString:self.videoOrAudio])
    {
        self.jvJueButtn.hidden = NO;
        self.beiJiaoGuaDuanLable.hidden = NO;
        self.jieShouButton.hidden = NO;
        self.beiJiaoJieTongLable.hidden = NO;
        
        self.beiJiaoTipLable.text = @"邀请你进行语音聊天";
        self.huJiaoGuaDuanButton.hidden = YES;
        self.huJiaoGuaDuanLable.hidden = YES;

    }
   
}

//连接对方界面
- (void)connectingInterface{
    self.acceptBtn.hidden = YES;
    self.refuseBtn.hidden   = YES;
    self.hungUpBtn.hidden   = NO;
    self.connectingLabel.hidden = NO;
    //self.connectingLabel.text = @"正在连接对方...请稍后...";
    self.switchModelBtn.hidden = YES;
    self.switchCameraBtn.hidden = YES;
    self.muteBtn.hidden = YES;
    self.disableCameraBtn.hidden = YES;
    self.localRecordBtn.hidden = YES;
    self.localRecordingView.hidden = YES;
    self.lowMemoryView.hidden = YES;
   // [self.hungUpBtn removeTarget:self action:NULL forControlEvents:UIControlEventTouchUpInside];
    //[self.hungUpBtn addTarget:self action:@selector(hangup) forControlEvents:UIControlEventTouchUpInside];
    
    
    if([@"audio" isEqualToString:self.videoOrAudio])
    {
        self.jvJueButtn.hidden = YES;
        self.beiJiaoGuaDuanLable.hidden = YES;
        self.jieShouButton.hidden = YES;
        self.beiJiaoJieTongLable.hidden = YES;
        
        self.huJiaoGuaDuanButton.hidden = NO;
        self.huJiaoGuaDuanLable.hidden = NO;
        
    }
}

//接听中界面(视频)
- (void)videoCallingInterface{
    
  
    
    NIMNetCallNetStatus status = [[NIMAVChatSDK sharedSDK].netCallManager netStatus:self.peerUid];
    [self.netStatusView refreshWithNetState:status];
    self.acceptBtn.hidden = YES;
    self.refuseBtn.hidden   = YES;
    self.hungUpBtn.hidden   = NO;
    self.connectingLabel.hidden = YES;
    self.muteBtn.hidden = NO;
    self.switchCameraBtn.hidden = YES;
    self.disableCameraBtn.hidden = YES;
    self.localRecordBtn.hidden = NO;
    self.switchModelBtn.hidden = NO;
    
    self.muteBtn.enabled = YES;
    self.disableCameraBtn.enabled = YES;
    self.localRecordBtn.enabled = YES;
    
    self.muteBtn.selected = self.callInfo.isMute;
    self.disableCameraBtn.selected = self.callInfo.disableCammera;
    self.localRecordBtn.selected = ![self allRecordsStopped];

    self.localRecordingView.hidden = [self allRecordsStopped];

    self.lowMemoryView.hidden = YES;
    [self.switchModelBtn setTitle:@"语音模式" forState:UIControlStateNormal];
    self.localVideoLayer.hidden = NO;
    
    
    //////new add
    //隐藏原有按钮
    self.switchModelBtn.hidden = YES;
    self.connectingLabel.hidden = YES;
    self.switchCameraBtn.hidden = YES;
    self.disableCameraBtn.hidden = YES;
    
    //处理自定义按钮
    self.beiJiaoHeaderImageView.hidden = YES;
    self.beiJiaoTelImageView.hidden = YES;
    self.beiJiaoNameLable.hidden = YES;
    self.beiJiaoTipLable.hidden = YES;
    self.openOrCloseCameraLable.hidden = YES;
    self.openOrCloseCameraButton.hidden = YES;
    self.agreementTipLable.hidden = YES;
    self.agreementBottomView.hidden = YES;
    self.quXiaoLable.hidden = YES;
    self.quXiaoButton.hidden = YES;
    
    
    
    
    self.closeShiPinButton.hidden = NO;
    self.shiChangLableBottom.hidden = NO;
    self.shiChangLable.hidden = NO;
    self.jinBiLableBottom.hidden = NO;
    self.jinBiLable.hidden = NO;
    self.sendMessageButton.hidden = NO;
    self.openOrCloseVoiceButton.hidden = NO;
    self.qieHuanJingTouButton.hidden = NO;
    self.guanBiDaKaiCameraButton.hidden = NO;
    self.chongZhiBUtton.hidden = NO;
    self.songLiButton.hidden = NO;
    self.huDongButton.hidden = NO;
    
   
    if ([@"jieShou" isEqualToString:self.huJiaoOrJieShou]) {
        
        self.jieShouButton.hidden = YES;
        self.jvJueButtn.hidden = YES;
        self.songLiButton.hidden = YES;
        self.chongZhiBUtton.hidden = YES;
       
    }
    //主播隐藏送礼充值按钮
    if([@"2" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]])
    {
        self.songLiButton.hidden = NO;
        self.chongZhiBUtton.hidden = YES;

    }
    else
    {
        self.songLiButton.hidden = NO;
        self.chongZhiBUtton.hidden = NO;

    }
    [self initKouFeiFailureView];
    
    if (![@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
    {
        //主播端接受推送判断是否扣费成功
        if ([@"2" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]])
        {
            if (!alsoQiDongTenSecondsDingShiQi) {
                
                self.anchorAlsoKoFeiSuccessTimer = [NSTimer scheduledTimerWithTimeInterval:20 target:self selector:@selector(meiFenZhongKouFeiFailure) userInfo:nil repeats:NO];
                
            }
            
            
        }
        //视频开始时不是主播的一方生成一条订单
        if([@"1" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]])
        {
            
            NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
            NSString * recordId = [defaults objectForKey:@"tongHuaJiLuRecordId"];
            
            if ([self.callInfo.callee isEqualToString:[TanLiao_Common getNowUserID]]) {
                
                //发起视频时生成一条订单
                [self.cloudClient getVideoOrderId:@"8052"
                                         toUserId:self.callInfo.caller
                                         recordId:recordId
                                        call_type:self.call_type
                                         delegate:self
                                         selector:@selector(getOrderIdSuccess:)
                                    errorSelector:@selector(getOrderIdError:)];
            }
            else
            {
                //发起视频时生成一条订单
                [self.cloudClient getVideoOrderId:@"8052"
                                         toUserId:self.callInfo.callee
                                         recordId:recordId
                                        call_type:self.call_type
                                         delegate:self
                                         selector:@selector(getOrderIdSuccess:)
                                    errorSelector:@selector(getOrderIdError:)];
            }
            
        }
        else
        {
            if (![@"audio" isEqualToString:self.videoOrAudio]) {
                
                self.meiFenZhongKouFeiTimer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(mei15SecondsShangChuanJieTu) userInfo:nil repeats:YES];
                
            }
            
        }
    }
    
    
    self.localView.userInteractionEnabled = YES;
    
    //主播呼叫用户接通 caller是主叫方
    if([@"2" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]])
    {
        if ([self.callInfo.caller isEqualToString:[TanLiao_Common getNowUserID]]) {
            
            NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
            NSString * recordId = [defaults objectForKey:@"tongHuaJiLuRecordId"];
            
            [self.cloudClient zhuBoHuJiaoYongHuJieTong:@"8067"
                                              recordId:recordId
                                              delegate:self
                                              selector:@selector(huJiaoJieTongSuccess:)
                                         errorSelector:@selector(huJiaoJieTongError:)];
        }
    }
    
    self.bigVideoView.userInteractionEnabled = YES;
    
    
    UIButton * button = [[UIButton alloc] initWithFrame:self.smallVideoView.frame];
    [button addTarget:self action:@selector(smallVideoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    if ([@"audio" isEqualToString:self.videoOrAudio]) {
        
        self.localView.hidden = YES;
        self.localPreView.hidden = YES;
        self.smallVideoView.hidden = YES;
        self.bigVideoView.hidden = YES;
        
        self.beiJiaoHeaderImageView.hidden = NO;
        self.beiJiaoNameLable.hidden = NO;
        
        self.jingYinButton.hidden = NO;
        self.jingYinLable.hidden = NO;
        
        self.beiJiaoJieTongLable.hidden = YES;
        self.beiJiaoGuaDuanLable.hidden = YES;
        
        if ([@"1" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]])
        {
            
            self.jingYinButton.frame = CGRectMake((VIEW_WIDTH-100*BILI)/3, VIEW_HEIGHT-(308)*BILI/2, 50*BILI, 50*BILI);
            self.jingYinLable.frame = CGRectMake(self.jingYinButton.frame.origin.x, self.jingYinButton.frame.origin.y+self.jingYinButton.frame.size.height+7*BILI, self.jingYinButton.frame.size.width, 12*BILI);

            self.huJiaoGuaDuanButton.frame = CGRectMake(self.jingYinButton.frame.origin.x+self.jingYinButton.frame.size.width+self.jingYinButton.frame.origin.x, self.jingYinButton.frame.origin.y, self.jingYinButton.frame.size.width, self.jingYinButton.frame.size.height);
            self.huJiaoGuaDuanLable.frame = CGRectMake(self.huJiaoGuaDuanButton.frame.origin.x, self.huJiaoGuaDuanButton.frame.origin.y+self.huJiaoGuaDuanButton.frame.size.height+7*BILI, self.huJiaoGuaDuanButton.frame.size.width, 12*BILI);
            
        }
        else
        {
            
            self.jingYinButton.frame = CGRectMake((VIEW_WIDTH-60*BILI)/2, VIEW_HEIGHT-(138+120+40)*BILI/2, 60*BILI, 60*BILI);
            self.jingYinLable.frame = CGRectMake(self.jingYinButton.frame.origin.x, self.jingYinButton.frame.origin.y+self.jingYinButton.frame.size.height+10*BILI, self.jingYinButton.frame.size.width, 12*BILI);
            self.huJiaoGuaDuanButton.hidden = YES;
            self.huJiaoGuaDuanLable.hidden = YES;
            self.songLiButton.hidden = YES;
            self.authorGiftButton.hidden = NO;
        }
    }
    else
    {
        [self stopPlayAnchorVideo];
    }
    NSUserDefaults *  isShowAmountInVideoDefaults = [NSUserDefaults standardUserDefaults];
    NSString * showStr = [isShowAmountInVideoDefaults objectForKey:@"isShowAmountInVideo"];
    if([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
    {
        self.jinBiLableBottom.hidden = YES;
        self.jinBiLable.hidden = YES;

    }
    else
    {
        if ([@"1" isEqualToString:showStr]&&[@"1" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]]) {
            
            self.jinBiLableBottom.hidden = YES;
            self.jinBiLable.hidden = YES;
            
        }
    }
    
}
-(void)smallVideoButtonClick
{
    if (!firstCreateBigAndSmallVideo) {
        
        firstCreateBigAndSmallVideo = YES;
        self.bigAndSmallView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
        [NIMAVChatSDK sharedSDK].netCallManager.localPreview.frame = CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT);
        self.bigAndSmallView = [NIMAVChatSDK sharedSDK].netCallManager.localPreview;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bigViewChangeBig)];
        [self.bigAndSmallView addGestureRecognizer:tap];
        [self.bigAndSmallBottomView addSubview:self.bigAndSmallView];
    }
    else
    {
        self.bigAndSmallView.frame = CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT);
        [NIMAVChatSDK sharedSDK].netCallManager.localPreview.frame = CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT);
    }
    
 

}
-(void)bigViewChangeBig
{
    
    
    self.bigAndSmallView.frame = self.smallVideoView.frame;
    [NIMAVChatSDK sharedSDK].netCallManager.localPreview.frame = self.smallVideoView.frame;
    
   
    
}
-(void)cameraAlsoAllow
{
    
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        
        
        if(!cameraAlsoAllow)
        {
            cameraAlsoAllow = YES;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"相机权限受限,无法视频聊天"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        alert.tag =20;
        [alert show];
          
            //相机权限受限挂断
        if ([@"1" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]])
        {
                
            self.hangUpType = @"1";
        }
        [self hangup];
    }
        
    }
}
-(void)huJiaoJieTongSuccess:(NSDictionary *)info
{

}
-(void)huJiaoJieTongError:(NSDictionary *)info
{
    
}
-(void)initKouFeiFailureView
{
    self.kouFeiFailureView = [[UIView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-528*BILI/2)/2, (VIEW_HEIGHT-376*BILI/2)/2, 528*BILI/2, 376*BILI/2)];
    
    self.kouFeiFailureView.backgroundColor = UIColorFromRGB(0xE8E8E8 );
    self.kouFeiFailureView.layer.cornerRadius = 30*BILI;
    self.kouFeiFailureView.clipsToBounds = YES;
    [self.view addSubview:self.kouFeiFailureView];
    
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.kouFeiFailureView.frame.size.width, 40*BILI)];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.text = @"温馨提示";
    titleLable.backgroundColor = UIColorFromRGB(0xD7D7D7);
    titleLable.font = [UIFont systemFontOfSize:18*BILI];
    titleLable.textColor = [UIColor blackColor];
    titleLable.alpha = 0.4;
    [self.kouFeiFailureView addSubview:titleLable];
    
    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 78*BILI, self.kouFeiFailureView.frame.size.width, 15*BILI)];
    tipLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:15*BILI];
    tipLable.textColor = UIColorFromRGB(0x040404);
    tipLable.alpha = 0.6;
    tipLable.textAlignment = NSTextAlignmentCenter;
    tipLable.text = [NSString stringWithFormat:@"本次视频扣费异常,是否挂断"];
    [self.kouFeiFailureView addSubview:tipLable];
    
    UIButton * cancleButton = [[UIButton alloc] initWithFrame:CGRectMake(20*BILI, 236*BILI/2, (self.kouFeiFailureView.frame.size.width-40*BILI-10*BILI)/2, 40*BILI)];
    [cancleButton setBackgroundColor:[UIColor lightGrayColor]];
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancleButton.titleLabel.font = [UIFont systemFontOfSize:13*BILI];
    cancleButton.layer.cornerRadius = 20*BILI;
    [cancleButton addTarget:self action:@selector(cancleKouFeiFailure) forControlEvents:UIControlEventTouchUpInside];
    [self.kouFeiFailureView addSubview:cancleButton];
    
    UIButton * hangUpButton = [[UIButton alloc] initWithFrame:CGRectMake(cancleButton.frame.origin.x+cancleButton.frame.size.width+10*BILI,  cancleButton.frame.origin.y, cancleButton.frame.size.width, 40*BILI)];
    [hangUpButton setBackgroundColor:UIColorFromRGB(0xF85BA3)];
    hangUpButton.layer.cornerRadius = 20*BILI;
    [hangUpButton setTitle:@"确定" forState:UIControlStateNormal];
    [hangUpButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    hangUpButton.titleLabel.font = [UIFont systemFontOfSize:13*BILI];
    [hangUpButton addTarget:self action:@selector(hangUpKouFeiFailure) forControlEvents:UIControlEventTouchUpInside];
    [self.kouFeiFailureView addSubview:hangUpButton];
    
    self.kouFeiFailureView.hidden = YES;

}
-(void)cancleKouFeiFailure
{
    self.kouFeiFailureView.hidden = YES;
}
-(void)hangUpKouFeiFailure
{
    self.kouFeiFailureView.hidden = YES;
    if (self.anchorAlsoKoFeiSuccessTimer !=nil) {
        
        [self.anchorAlsoKoFeiSuccessTimer invalidate];
        self.anchorAlsoKoFeiSuccessTimer = nil;
        
    }
    self.hangUpType = @"10";
    [self hangup];
}
//主播端接收到扣费成功的消息
-(void)kouFeiSuccessNotification
{
    __weak typeof(self) weakSelf = self;
    dispatch_sync(dispatch_get_main_queue(), ^{
        
        
        [TanLiao_Common showToastView:@"扣费成功" view:self.view];
        
        alsoQiDongTenSecondsDingShiQi = YES;
        
        if (weakSelf.anchorAlsoKoFeiSuccessTimer!=nil) {
            
            [weakSelf.anchorAlsoKoFeiSuccessTimer invalidate];
            weakSelf.anchorAlsoKoFeiSuccessTimer = nil;

        }
        
        weakSelf.anchorAlsoKoFeiSuccessTimer = [NSTimer scheduledTimerWithTimeInterval:80 target:self selector:@selector(meiFenZhongKouFeiFailure) userInfo:nil repeats:NO];

        
    });
}
//首次10s,之后每70s,主播端收不到扣费成功的消息提示挂断
-(void)meiFenZhongKouFeiFailure
{
    
    if ([@"2" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]])
    {
        
        self.kouFeiFailureView.hidden = NO;
        
    }
    

}
//获取用户账户余额
-(void)getUserGoldNumber
{
    [self.cloudClient getWalletMes:[TanLiao_Common getNowUserID]
                             apiId:@"8005"
                          delegate:self
                          selector:@selector(getUserInformationSuccess:)
                     errorSelector:@selector(getUserInformationError:)];
}
-(void)getOrderIdSuccess:(NSDictionary *)info
{
    [self getUserGoldNumber];
    self.userOrderId = [info objectForKey:@"userOrderId"];
    self.anchorOrderId = [info objectForKey:@"anchorOrderId"];
    self.officialOrderId = [info objectForKey:@"officialOrderId"];
    self.brokerOrderId = [info objectForKey:@"brokerOrderId"];
        if(stopMeiFenZhongKouFei == YES)
        {
            self.meiFenZhongKouFeiTimer =[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(meiFenZhongKouFei) userInfo:nil repeats:YES];
        }
}
-(void)mei15SecondsShangChuanJieTu
{
    NSTimeInterval time = [NSDate date].timeIntervalSince1970;
    NSTimeInterval duration = time - self.callInfo.startTime;
    //每十五秒获取一次本地截图并上传  主播端
    
        if ((int)duration%15==0)
        {
            
            [[NIMAVChatSDK sharedSDK].netCallManager snapshotFromLocalVideoCompletion:^(UIImage * _Nullable image) {
                
                if (image) {
                    
                    NSData *data = UIImagePNGRepresentation(image);
                    NSString *encodedImageStr = [data base64EncodedStringWithOptions:0];
                    
                    NSString *imageType = [TanLiao_Common contentTypeForImageData:data];//图片类型
                    
                    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
                    NSString * recordId = [defaults objectForKey:@"tongHuaJiLuRecordId"];
                    
                    NSString * userId;
                    if ([[TanLiao_Common getNowUserID] isEqualToString:self.callInfo.callee])
                    {
                        userId = self.callInfo.caller;
                    }
                    else
                    {
                        userId = self.callInfo.callee;
                    }
                    [self.cloudClient uploadVideoJieTu:@"8900"
                                     picBody_base64Str:encodedImageStr
                                             picFormat:imageType
                                                userId:userId
                                              anchorId:[TanLiao_Common getNowUserID]
                                                billId:recordId
                                              delegate:self
                                              selector:@selector(uploadJieTuSuccess:)
                                         errorSelector:@selector(uploadJieTuError:)];
                    NSLog(@"imageType:%@,userId:%@,anchorId:%@,recordId:%@,duration:%d",imageType,userId,[TanLiao_Common getNowUserID],recordId,(int)duration);
                }
                
                
            }];
        }
}
-(void)uploadJieTuSuccess:(NSDictionary *)info
{
    
}
-(void)uploadJieTuError:(NSDictionary *)info
{
    
}
-(void)meiFenZhongKouFei
{
    NSTimeInterval time = [NSDate date].timeIntervalSince1970;
    NSTimeInterval duration = time - self.callInfo.startTime;
    NSLog(@"时长*************:%f,余数**********:%d",duration,(int)duration%60);
    if ((int)duration%60==0 && (int)duration>=60) {
        
        if ([self.callInfo.callee isEqualToString:[TanLiao_Common getNowUserID]]) {
            
            [self.cloudClient meiFenZhongKouFei:@"8051"
                                    userOrderId:self.userOrderId
                                  brokerOrderId:self.brokerOrderId
                                officialOrderId:self.officialOrderId
                                       toUserId:self.callInfo.caller
                                  anchorOrderId:self.anchorOrderId
                                      call_type:self.call_type
                                       delegate:self
                                       selector:@selector(kouFeiSuccess:)
                                  errorSelector:@selector(kouFeiError:)];
        }
        else
        {
            [self.cloudClient meiFenZhongKouFei:@"8051"
                                    userOrderId:self.userOrderId
                                  brokerOrderId:self.brokerOrderId
                                officialOrderId:self.officialOrderId
                                       toUserId:self.callInfo.callee
                                  anchorOrderId:self.anchorOrderId
                                      call_type:self.call_type
                                       delegate:self
                                       selector:@selector(kouFeiSuccess:)
                                  errorSelector:@selector(kouFeiError:)];
        }

        
        
    }

}
-(void)kouFeiSuccess:(NSDictionary *)info
{
    [self getUserGoldNumber];
//    [self.cloudClient getUserInformation:@"8029"
//                                delegate:self
//                                selector:@selector(getUserInformationSuccess:)
//                           errorSelector:@selector(getUserInformationError:)];
   
    NSLog(@"扣费成功*****************************");
}
-(void)kouFeiError:(NSDictionary *)info
{
    NSLog(@"扣费失败");
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:[info objectForKey:@"message"] delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
    [alertView show];
    [self.view addSubview:alertView];
    
    //扣费异常挂断
    self.hangUpType = @"6";
    [self hangup];
}
-(void)getOrderIdError:(NSDictionary *)info
{
    //扣费异常挂断
    self.hangUpType = @"6";
    [self hangup];
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:[info objectForKey:@"message"] delegate:self cancelButtonTitle:@"确认" otherButtonTitles: nil];
    [alertView show];
    [self.view addSubview:alertView];
}
//切换接听中界面(语音)
- (void)audioCallingInterface{
    
//    NTESAudioChatViewController *vc = [[NTESAudioChatViewController alloc] initWithCallInfo:self.callInfo];
//    [UIView  beginAnimations:nil context:NULL];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    [UIView setAnimationDuration:0.75];
//    [self.navigationController pushViewController:vc animated:NO];
//    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.navigationController.view cache:NO];
//    [UIView commitAnimations];
//    NSMutableArray * vcs = [self.navigationController.viewControllers mutableCopy];
//    [vcs removeObject:self];
//    self.navigationController.viewControllers = vcs;
}

- (void)udpateLowSpaceWarning:(BOOL)show {
    self.lowMemoryView.hidden = !show;
    self.localRecordingView.hidden = show;
}


#pragma mark - IBAction

- (IBAction)acceptToCall:(id)sender{
    BOOL accept = (sender == self.acceptBtn);
    //防止用户在点了接收后又点拒绝的情况
    [self response:accept];
}
-(void)jieShou:(id)sender{
    
    BOOL accept = (sender == self.jieShouButton);
    if(accept == NO)
    {
        [self quXiaoHangup];
        if ([@"1" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]]) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"是否5分钟内不收到小姐姐的视频邀请" delegate:nil cancelButtonTitle:@"否" otherButtonTitles:@"是 ", nil];
            alert.tag = 1001;
            alert.delegate = self;
            [alert show];

        }

    }
    //防止用户在点了接收后又点拒绝的情况
    [self response:accept];
}

- (IBAction)mute:(BOOL)sender{
//    self.callInfo.isMute = !self.callInfo.isMute;
//   werwerwrwerwerwerwrweqweqweqeqweqweqweqweqweertertertertertertertetr
//    [[NIMAVChatSDK sharedSDK].netCallManager setMute:self.callInfo.isMute];
//    self.muteBtn.selected = self.callInfo.isMute;
}

//- (IBAction)switchCamera:(id)sender{
//    if (self.cameraType == NIMNetCallCameraFront) {
//        self.cameraType = NIMNetCallCameraBack;
//    }else{
//        self.cameraType = NIMNetCallCameraFront;
//    }
//    [[NIMAVChatSDK sharedSDK].netCallManager switchCamera:self.cameraType];
//    self.switchCameraBtn.selected = (self.cameraType == NIMNetCallCameraBack);
//}

-(void)openOrCloseCameraButtonClick
{
    self.callInfo.disableCammera = !self.callInfo.disableCammera;
    [[NIMAVChatSDK sharedSDK].netCallManager setCameraDisable:self.callInfo.disableCammera];
    //self.disableCameraBtn.selected = self.callInfo.disableCammera;
    if (self.callInfo.disableCammera) {
       // [self.bufferDisplayer removeFromSuperlayer];
       // [self.localVideoLayer removeFromSuperlayer];
         [self.localPreView removeFromSuperview];
        [self.openOrCloseCameraButton setImage:[UIImage imageNamed:@"btn_open_video"] forState:UIControlStateNormal];
        self.openOrCloseCameraLable.text = @"打开摄像头";
        self.noCameraBottomView.hidden = NO;
        [[NIMAVChatSDK sharedSDK].netCallManager control:self.callInfo.callID type:NIMNetCallControlTypeCloseVideo];
    }else{
        self.noCameraBottomView.hidden = YES;
        //[self.localView.layer addSublayer:self.bufferDisplayer];

     //  [self.localView.layer addSublayer:self.localVideoLayer];
        [self.localView addSubview:self.localPreView];
        [self.openOrCloseCameraButton setImage:[UIImage imageNamed:@"btn_close_video"] forState:UIControlStateNormal];
        self.openOrCloseCameraLable.text = @"关闭摄像头";
        [[NIMAVChatSDK sharedSDK].netCallManager control:self.callInfo.callID type:NIMNetCallControlTypeOpenVideo];
    }
}


- (IBAction)localRecord:(id)sender {
    /*
    //出现录制选择框
    if ([self allRecordsStopped]) {
        [self showRecordSelectView:YES];
    }
    //同时停止所有录制
    else
    {
        //结束语音对话
        if (self.callInfo.audioConversation) {
            [self stopAudioRecording];
            if([self allRecordsStopped])
            {
                self.localRecordBtn.selected = NO;
                self.localRecordingView.hidden = YES;
                self.lowMemoryView.hidden = YES;
            }
        }
        [self stopRecordTaskWithVideo:YES];
    }
*/
}


- (IBAction)switchCallingModel:(id)sender{
    [[NIMAVChatSDK sharedSDK].netCallManager control:self.callInfo.callID type:NIMNetCallControlTypeToAudio];
    [self switchToAudio];
}


#pragma mark - NTESRecordSelectViewDelegate

-(void)onRecordWithAudioConversation:(BOOL)audioConversationOn myMedia:(BOOL)myMediaOn otherSideMedia:(BOOL)otherSideMediaOn
{
    if (audioConversationOn) {
        //开始语音对话
        if ([self startAudioRecording]) {
            self.callInfo.audioConversation = YES;
            self.localRecordBtn.selected = YES;
            self.localRecordingView.hidden = NO;
            self.lowMemoryView.hidden = YES;
        }
    }
    [self recordWithAudioConversation:audioConversationOn myMedia:myMediaOn otherSideMedia:otherSideMediaOn video:YES];
}


#pragma mark - NIMNetCallManagerDelegate


- (void)onLocalDisplayviewReady:(UIView *)displayView
{

    if (_calleeBasy) {
        return;
    }
    
    if (self.localPreView) {
        [self.localPreView removeFromSuperview];
    }
    
    self.localPreView = displayView;
    displayView.frame = self.localView.bounds;
    [self.localView addSubview:displayView];
    
    //视频通话并且由用户发起主叫
    if (![@"audio" isEqualToString:self.videoOrAudio]&&[self.callInfo.caller isEqualToString:[TanLiao_Common getNowUserID]]&&[@"1" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]]&&self.anchorVideoUrl)
    {
        if(!localViewAlsoHidden)
        {
            self.localView.hidden = YES;
            localViewAlsoHidden = YES;

        }
    }
    
    
}


#if defined(NTESUseGLView)
- (void)onRemoteYUVReady:(NSData *)yuvData
                   width:(NSUInteger)width
                  height:(NSUInteger)height
                    from:(NSString *)user
{
    if (([[UIApplication sharedApplication] applicationState] == UIApplicationStateActive) && !self.oppositeCloseVideo) {
        
        if (!_remoteGLView) {
            [self initRemoteGLView];
        }
        [_remoteGLView render:yuvData width:width height:height];
    }
    
    
}
#else
- (void)onRemoteImageReady:(CGImageRef)image{
    if (self.oppositeCloseVideo) {
        return;
    }
    self.bigVideoView.contentMode = UIViewContentModeScaleAspectFill;
    self.bigVideoView.image = [UIImage imageWithCGImage:image];
}
#endif

- (void)onControl:(UInt64)callID
             from:(NSString *)user
             type:(NIMNetCallControlType)control{
   
    [super onControl:callID from:user type:control];
    if(![@"audio" isEqualToString:self.videoOrAudio])
    {
    switch (control) {
        case NIMNetCallControlTypeToAudio:
            [self switchToAudio];
            break;
        case NIMNetCallControlTypeCloseVideo:
            [self resetRemoteImage];
            self.oppositeCloseVideo = YES;
            self.noCameraBottomView.hidden = NO;
            [self.view makeToast:@"对方关闭了摄像头"
                        duration:2
                        position:CSToastPositionCenter];
            break;
        case NIMNetCallControlTypeOpenVideo:
            self.oppositeCloseVideo = NO;
            self.noCameraBottomView.hidden = YES;
            [self.view makeToast:@"对方开启了摄像头"
                        duration:2
                        position:CSToastPositionCenter];
            break;
        default:
            break;
    }
    }
}


//-(void)onCallEstablished:(UInt64)callID
//{
//    if (self.callInfo.callID == callID) {
//        [super onCallEstablished:callID];
//        
//        self.durationLabel.hidden = YES;
//        self.durationLabel.text = self.durationDesc;
//        self.shiChangLable.text = self.durationDesc;
//        self.jinBiLable.text = [self jinBiDesc];
//        
//        if (self.localView == self.bigVideoView) {
//            self.localView = self.smallVideoView;
//            
//            if (self.localVideoLayer) {
//                [self onLocalPreviewReady:self.localVideoLayer];
//            }
//        }
//    }
//}
-(void)onCallEstablished:(UInt64)callID
{
    if (self.callInfo.callID == callID) {
        [super onCallEstablished:callID];
        
        self.durationLabel.hidden = YES;
        self.durationLabel.text = self.durationDesc;
        
        if (self.localView == self.bigVideoView) {
            self.localView = self.smallVideoView;
            
            if (self.localPreView) {
                [self onLocalDisplayviewReady:self.localPreView];
            }
        }
    }
}
- (void)onNetStatus:(NIMNetCallNetStatus)status user:(NSString *)user
{
  // if ([user isEqualToString:self.peerUid]) {
//    switch (status) {
//        case NIMNetCallNetStatusVeryGood:
//            netWorkQuality = 0;
//            break;
//        case NIMNetCallNetStatusGood:
//            netWorkQuality = 1;
//            break;
//        case NIMNetCallNetStatusBad:
//            netWorkQuality = 2;
//           // [Common showToastView:@"当前视频网络质量较差" view:self.view];
//            break;
//        case NIMNetCallNetStatusVeryBad:
//            // [Common showToastView:@"当前视频网络质量极差" view:self.view];
//            netWorkQuality = 3;
//            //网络质量
//          
//            break;
//            
//        default:
//            netWorkQuality = 1;
//            break;
//        }
    
  // }
   
    
    //不停刷新
//    if (![user isEqualToString:self.peerUid]&&status == NIMNetCallNetStatusVeryBad) {
//        //网络质量
//       // [self.netStatusView refreshWithNetState:status];
//        
//        [Common showToastView:@"当前视频网络质量差" view:self.view];
//
//    }
    if (continueNoWifi == NO) {
        
        NSString * netState = [TanLiao_Common netWorkState];
        if (![@"wifi连接" isEqualToString:netState]) {
            
            self.noWifiView.hidden = NO;
        }
    }
  
}


- (void)onRecordStarted:(UInt64)callID fileURL:(NSURL *)fileURL uid:(NSString *)userId
{
    [super onRecordStarted:callID fileURL:fileURL uid:userId];
    if (self.callInfo.callID == callID) {
        self.localRecordBtn.selected = YES;
        self.localRecordingView.hidden = NO;
        self.lowMemoryView.hidden = YES;
    }
}


- (void)onRecordError:(NSError *)error
                    callID:(UInt64)callID
                       uid:(NSString *)userId;

{
    [super onRecordError:error callID:callID uid:userId];
    if (self.callInfo.callID == callID) {
        //判断是否全部结束
        if([self allRecordsStopped])
        {
            self.localRecordBtn.selected = NO;
            self.localRecordingView.hidden = YES;
            self.lowMemoryView.hidden = YES;
        }
    }
}

- (void) onRecordStopped:(UInt64)callID
                      fileURL:(NSURL *)fileURL
                          uid:(NSString *)userId;

{
    [super onRecordStopped:callID fileURL:fileURL uid:userId];
    if (self.callInfo.callID == callID) {
        if([self allRecordsStopped])
        {
            self.localRecordBtn.selected = NO;
            self.localRecordingView.hidden = YES;
            self.lowMemoryView.hidden = YES;
        }
    }
}

#pragma mark - M80TimerHolderDelegate

- (void)onNTESTimerFired:(NTESTimerHolder *)holder{
    [super onNTESTimerFired:holder];
    self.durationLabel.text = self.durationDesc;
    self.shiChangLable.text = self.durationDesc;
    NSString * money = [self jinBiDesc];
    
    self.jinBiLable.text = [NSString stringWithFormat:@"金币%.2f",money.floatValue/JinBiBiLi];
}

#pragma mark - Misc
- (void)switchToAudio{
    [self audioCallingInterface];
}

- (NSString*)durationDesc{
    if (!self.callInfo.startTime) {
        return @"";
    }
    NSTimeInterval time = [NSDate date].timeIntervalSince1970;
    NSTimeInterval duration = time - self.callInfo.startTime;
    return [NSString stringWithFormat:@"%02d:%02d",(int)duration/60,(int)duration%60];
}
-(NSString *)jinBiDesc
{
    
    [self cameraAlsoAllow];
    
    //界面没有挂断
    if (viewMissStatus ==NO) {
        
        if (!self.callInfo.startTime) {
            return @"金币 0.00";
        }
        NSTimeInterval time = [NSDate date].timeIntervalSince1970;
        NSTimeInterval duration = time - self.callInfo.startTime;
        int price = self.price.intValue;
        if ([self.userOrderId isKindOfClass:[NSString class]]&&self.userOrderId.length>0)
        {
            
           // if (self.money.intValue-((int)duration/60*price+price)<=price) {
             if (self.money.intValue<=price) {
                if (yuErBuZu == NO) {
                    
                    TanLiaoLiao_YuEBuZuView * tipView = [[TanLiaoLiao_YuEBuZuView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
                    tipView.delegate = self;
                    [self.view addSubview:tipView];
                    yuErBuZu = YES;
                }
                
            }

            
        }
        return [NSString stringWithFormat:@"%d",(int)duration/60*price+price];
        

    }
    else
    {
        return @"";
    }
    

}
-(void)YuEBuZuPushToRechargeView
{
    self.chongZhiView.hidden = NO;
    self.closeChongZhiViewButton.hidden = NO;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 100)
    {
        if (buttonIndex == 0) {
            
        }
        else
        {
            self.chongZhiView.hidden = NO;
            self.closeChongZhiViewButton.hidden = NO;
        }

    }
    if(alertView.tag == 1000)
    {
        if (buttonIndex==0) {
            
        }
        else
        {
            
            if (self.anchorAlsoKoFeiSuccessTimer !=nil) {
                
                [self.anchorAlsoKoFeiSuccessTimer invalidate];
                self.anchorAlsoKoFeiSuccessTimer = nil;

            }
            [self hangup];
            
        }
    }
    if (alertView.tag == 1001)
    {
        if (buttonIndex==1)
        {
            NSUserDefaults * fiveMinutesDefaults = [NSUserDefaults standardUserDefaults];
            
            NSString * fiveMinutesDefaultsStr = [fiveMinutesDefaults objectForKey:FiveMinutesDefaultsKey];
            
            if (fiveMinutesDefaultsStr)
            {
                if([@"大于5分钟" isEqualToString:[TanLiao_Common shiJianDistanceAlsoDaYu5Minutes:fiveMinutesDefaultsStr distance:5]])
                {
                    NSDate *senddate = [NSDate date];
                    NSString *saveDate = [NSString stringWithFormat:@"%ld", (long)[senddate timeIntervalSince1970]];
                    [fiveMinutesDefaults setObject:saveDate forKey:FiveMinutesDefaultsKey];
                    [fiveMinutesDefaults synchronize];
                    
                }
                else
                {
                    
                }
                
            }
            else
            {
                NSDate *senddate = [NSDate date];
                NSString *saveDate = [NSString stringWithFormat:@"%ld", (long)[senddate timeIntervalSince1970]];
                [fiveMinutesDefaults setObject:saveDate forKey:FiveMinutesDefaultsKey];
                [fiveMinutesDefaults synchronize];
                
            }
            
        }
       
        
    }
    
   
}

- (void)resetRemoteImage{
#if defined (NTESUseGLView)
    [self.remoteGLView render:nil width:0 height:0];
#endif
  
    self.bigVideoView.image = [UIImage imageNamed:@"netcall_bkg.png"];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.wxinChongZhi = @"";
    viewMissStatus = NO;
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate setTabBarHidden];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
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
    float keyboardHeight = keyboardBounds.size.height;
    
    self.chatTextFieldBottomView.frame = CGRectMake(self.chatTextFieldBottomView.frame.origin.x, VIEW_HEIGHT-keyboardHeight-self.chatTextFieldBottomView.frame.size.height, self.chatTextFieldBottomView.frame.size.width, self.chatTextFieldBottomView.frame.size.height);
    
    self.faSongButton.frame = CGRectMake(self.faSongButton.frame.origin.x, self.chatTextFieldBottomView.frame.origin.y+10*BILI, self.faSongButton.frame.size.width, self.faSongButton.frame.size.height);
    
    self.chatTextField.frame = CGRectMake(self.chatTextField.frame.origin.x, VIEW_HEIGHT-keyboardHeight-self.chatTextField.frame.size.height, self.chatTextField.frame.size.width, self.chatTextField.frame.size.height);
}
- (void)keyboardWillHide
{
    self.chatTextFieldBottomView.frame = CGRectMake(self.chatTextFieldBottomView.frame.origin.x, VIEW_HEIGHT+self.chatTextFieldBottomView.frame.size.height, self.chatTextFieldBottomView.frame.size.width, self.chatTextFieldBottomView.frame.size.height);
    
    self.faSongButton.frame = CGRectMake(self.faSongButton.frame.origin.x, self.chatTextFieldBottomView.frame.origin.y+10*BILI, self.faSongButton.frame.size.width, self.faSongButton.frame.size.height);

    
    self.chatTextField.frame = CGRectMake(self.chatTextField.frame.origin.x, self.chatTextFieldBottomView.frame.origin.y, self.chatTextField.frame.size.width, self.chatTextField.frame.size.height);
}
-(void)viewWillDisappear:(BOOL)animated
{
    if (self.anchorAlsoKoFeiSuccessTimer !=nil) {
        
        [self.anchorAlsoKoFeiSuccessTimer invalidate];
        self.anchorAlsoKoFeiSuccessTimer = nil;
        
    }
    if (self.meiFenZhongKouFeiTimer != nil) {
        
        [self.meiFenZhongKouFeiTimer invalidate];
        self.meiFenZhongKouFeiTimer = nil;

    }
    
    stopMeiFenZhongKouFei = NO;
    viewMissStatus = YES;
    self.navigationController.navigationBarHidden = YES;
    
    
    [self tiJiaoDingDan];
  
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [RCIM sharedRCIM].disableMessageAlertSound = YES;
    
    
    
    //已接通挂断后弹出发送弹出评论的通知
    if (![@"wx" isEqualToString:self.wxinChongZhi])
    {
    if ([self.userOrderId isKindOfClass:[NSString class]]&&self.userOrderId.length>0)
    {
        if ([self.callInfo.callee isEqualToString:[TanLiao_Common getNowUserID]])
        {
            
            NSDictionary * info = [[NSDictionary alloc] initWithObjectsAndKeys:self.callInfo.callee,@"anchorId", self.userOrderId,@"userOrderId",[TanLiao_Common getobjectForKey:[self.anchorPingJiaInfo objectForKey:@"nick"]],@"nick",[TanLiao_Common getobjectForKey:[self.anchorPingJiaInfo objectForKey:@"cityName"]],@"cityName",[TanLiao_Common getobjectForKey:[self.anchorPingJiaInfo objectForKey:@"age"]],@"age",[TanLiao_Common getobjectForKey:[self.anchorPingJiaInfo objectForKey:@"avatarUrl"]],@"avatarUrl", nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"showAnchorPingJiaView" object:info];

        }
        else
        {
            NSDictionary * info = [[NSDictionary alloc] initWithObjectsAndKeys:self.callInfo.callee,@"anchorId", self.userOrderId,@"userOrderId",[TanLiao_Common getobjectForKey:[self.anchorPingJiaInfo objectForKey:@"nick"]],@"nick",[TanLiao_Common getobjectForKey:[self.anchorPingJiaInfo objectForKey:@"cityName"]],@"cityName",[TanLiao_Common getobjectForKey:[self.anchorPingJiaInfo objectForKey:@"age"]],@"age",[TanLiao_Common getobjectForKey:[self.anchorPingJiaInfo objectForKey:@"avatarUrl"]],@"avatarUrl", nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"showAnchorPingJiaView" object:info];

        }
    }
    else
    {
        if ([@"1" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]]&&[self.callInfo.caller isEqualToString:[TanLiao_Common getNowUserID]])
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"showAnchorTuiJianView" object:nil];

        }
    }
    }
    [super viewWillDisappear:animated];
    [self.player stop];
    [UIApplication sharedApplication].idleTimerDisabled = NO;
        //[[NSNotificationCenter defaultCenter]removeObserver:self name:@"showAnchorPingJiaView" object:nil];

}

-(void)tiJiaoDingDan
{
    
    
        if ([@"1" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]]) {
            
            NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
            NSString * recordId = [defaults objectForKey:@"tongHuaJiLuRecordId"];
            [defaults removeObjectForKey:@"tongHuaJiLuRecordId"];
            
            if ([self.callInfo.callee isEqualToString:[TanLiao_Common getNowUserID]]) {
                
                [self.cloudClient duanKaiShiPin:@"8053"
                                       toUserId:self.callInfo.caller
                                       recordId:recordId
                                     hangUpType:@"-1"
                                  newHangUpType:self.hangUpType
                                       delegate:self
                                       selector:@selector(tiJiaoSuccess:)
                                  errorSelector:@selector(tiJiaoError:)];
            }
            else
            {
                [self.cloudClient duanKaiShiPin:@"8053"
                                       toUserId:self.callInfo.callee
                                       recordId:recordId
                                     hangUpType:@"-1"
                                  newHangUpType:self.hangUpType
                                       delegate:self
                                       selector:@selector(tiJiaoSuccess:)
                                  errorSelector:@selector(tiJiaoError:)];
            }
            
        
        }

    
   

}
-(void)tiJiaoSuccess:(NSDictionary *)info
{

}
-(void)tiJiaoError:(NSDictionary *)info
{
    
}
@end
