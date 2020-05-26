//
//  BoFangShiPinViewController.m
//  ZhangYu
//
//  Created by 周璟琳 on 2017/6/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "KuaiLiao_BoFangShiPinViewController.h"



@interface KuaiLiao_BoFangShiPinViewController ()
{
    
    //播放视频开始前
    BOOL cameraOpen;
    //播放视频开始后
    BOOL alreadCameraOpen;
    
    BOOL voiceStatus;
    
    //开始播放视频前的等待时间
    int dengDaiTime;
    //视频播放的时间
    int boFangTime;
    
    BOOL appPayTotast;
    
    BOOL isFront;


}


@property (nonatomic, strong)AVPlayer *player;

@property(nonatomic,strong)AVPlayerLayer *layer;

@property(nonatomic,strong)UIView * containerView;

//视频上的按钮,图片文字  未接通
//关闭摄像头时的背景
@property(nonatomic,strong)UIView * noCameraBottomView;

//被叫头像
@property(nonatomic,strong) TanLiaoCustomImageView * beiJiaoHeaderImageView;

//被叫name
@property(nonatomic,strong) UILabel * beiJiaoNameLable;

//电话图片
@property(nonatomic,strong)UIImageView * beiJiaoTelImageView;

//等待接通lable
@property(nonatomic,strong)UILabel * beiJiaoTipLable;

//协议背景
@property(nonatomic,strong)UIView * agreementBottomView;

//协议文字lable
@property(nonatomic,strong)UILabel * agreementTipLable;

//打开或关闭摄像头button
@property(nonatomic,strong)UIButton * openOrCloseCameraButton;

//打开或关闭摄像头Lable
@property(nonatomic,strong)UILabel * openOrCloseCameraLable;
//取消通话button
@property(nonatomic,strong)UIButton * quXiaoButton;

@property(nonatomic,strong)UILabel * quXiaoLable;

//视频上的按钮,图片文字  已经接通
//关闭视频
@property(nonatomic,strong)UIButton * closeShiPinButton;


//记录时间底背景
@property(nonatomic,strong)UIButton * shiChangLableBottom;

//记录时间
@property(nonatomic,strong)UILabel * shiChangLable;


//记录所花jinbi底背景
@property(nonatomic,strong)UIButton * jinBiLableBottom;
//记录所花jinbi
@property(nonatomic,strong)UILabel * jinBiLable;

//添加好友
@property(nonatomic,strong)UIButton * addFriendBUtton;

//静音
@property(nonatomic,strong)UIButton * openOrCloseVoiceButton;

//切换镜头
@property(nonatomic,strong)UIButton * qieHuanJingTouButton;

//打开关闭摄像头
@property(nonatomic,strong)UIButton * guanBiDaKaiCameraButton;

//充钱
@property(nonatomic,strong)UIButton * chongZhiBUtton;

//送礼
@property(nonatomic,strong)UIButton * songLiButton;


/////// 送礼物界面
//打赏界面
@property(nonatomic,strong)UIScrollView * daShangView;
//打赏界面的半透明背景
@property(nonatomic,strong)UIView * daShangBottomView;
//打赏界面的底部放按钮界面
@property(nonatomic,strong)UIView * daShangBottomButtonView;
//打赏界面的jinbi Lable
@property(nonatomic,strong)UILabel *daShangViewJinBiLable;
//打赏界面关闭按钮
@property(nonatomic,strong)UIButton * closeDaShangViewButton;
//礼物数组
@property(nonatomic,strong)NSMutableArray * liWuButtonArray;
@property(nonatomic,strong)NSArray * giftArray;

@property(nonatomic,strong)NSDictionary * selectGift;

//充值界面

@property(nonatomic,strong)UIView * chongZhiView;
//金额选项button数组
@property(nonatomic,strong)NSMutableArray * buttonArray;
//充值金额lable
@property(nonatomic,strong)UILabel * chongZhiJinErLable;
//充值界面关闭按钮
@property(nonatomic,strong)UIButton * closeChongZhiViewButton;
//充值金额
@property(nonatomic,strong)NSString * chongZhiMoney;

//appPay

@property(nonatomic,strong)NSString * productID;
@property(nonatomic,strong)NSArray * productIDArray;

//切换滤镜界面

@property(nonatomic,strong)UIView * nvJingView;
//滤镜值
@property(nonatomic,strong)NSString * lvJing;



@property(nonatomic,strong)NSTimer * dengDaiTimer;

@property(nonatomic,strong)NSTimer * boFangShiPinTimer;

@end

@implementation KuaiLiao_BoFangShiPinViewController





- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.loadingViewAlsoFullScreen = @"yes";
    
    isFront = NO;
    
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];


    
    self.navView.hidden = YES;
    [self setTabBarHidden];

    self.view.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.bottomView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    [self.bottomView setBackgroundColor:[UIColor blackColor]];
    self.bottomView.contentMode = UIViewContentModeScaleAspectFill;
    self.bottomView.autoresizingMask = UIViewAutoresizingNone;
    
    self.bottomView.urlPath = [self.anchorInfo objectForKey:@"picUrl"];
    [self.view addSubview:self.bottomView];



    ////设置耳机声音和扬声器音
    
    if ([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]]) {
        
        // 告诉app支持后台播放
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];

        [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
        [audioSession setActive:YES error:nil];
        
        
    }
    else
    {
        AVAudioSession *session = [AVAudioSession sharedInstance];



 



        [session setCategory:AVAudioSessionCategoryPlayback
                 withOptions:AVAudioSessionCategoryOptionMixWithOthers
                       error:nil];
    }    ////设置耳机声音和扬声器音
   // [self initAVCaptureSession];//初始化本地摄像头界面
   // [self startSession];


    
}



-(void)initPLayer
{
    NSURL *url = [NSURL URLWithString:[self.anchorInfo objectForKey:@"videoUrl"]];
    
    
    // 2.创建AVPlayerItem
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
    // 3.创建AVPlayer
    self.player = [AVPlayer playerWithPlayerItem:item];
    // 4.添加AVPlayerLayer
    self.layer = [AVPlayerLayer playerLayerWithPlayer:self.player];


    //设置视频大小和AVPlayerLayer的frame一样大(全屏播放)
    self.layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    
    
    
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    [self.view addSubview:self.containerView];






    self.layer.frame = self.view.bounds;
    [self.containerView.layer addSublayer:self.layer];


 

   


    
    
    UIView * hiddenKeyBoardTapView = [[UIView alloc] initWithFrame:CGRectMake(0, 90*BILI, VIEW_WIDTH, VIEW_HEIGHT-150*BILI)];
    [self.view addSubview:hiddenKeyBoardTapView];


    UITapGestureRecognizer * hiddenKeyboard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyboard)];
    [hiddenKeyBoardTapView addGestureRecognizer:hiddenKeyboard];
    
    if (![@"chat" isEqualToString:self.fromWhere])
    {
        [self initJieTongView];

    }
    else
    {
        hiddenKeyBoardTapView.hidden = YES;
        
        self.closeShiPinButton = [[UIButton alloc] initWithFrame:CGRectMake(12*BILI, 30*BILI, 30*BILI, 30*BILI)];
        [self.closeShiPinButton setBackgroundImage:[UIImage imageNamed:@"shipinxiu_btn_close"] forState:UIControlStateNormal];
        [self.closeShiPinButton addTarget:self action:@selector(quXiaoHangup) forControlEvents:UIControlEventTouchUpInside];


        [self.view addSubview:self.closeShiPinButton];

    }
    

}
-(void)playVideo
{
    [self.player play];
    alsoPlay = YES;
    self.previewLayer.frame = self.view.bounds;

}
-(void)hiddenKeyboard
{
    [self.pingLunTextField resignFirstResponder];

}
-(void)viewWillAppear:(BOOL)animated
{
   //[super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;

    
    [self initPLayer];
    NSLog(@"%@,%@",self.indexStr,self.anchorInfo);
    if([@"2" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]])
    {
        [self playVideo];
    }
    else
    {
        if (self.indexStr.intValue>1&&[@"0" isEqualToString:[self.anchorInfo objectForKey:@"isPayed"]]) {
            //获取用户是否是vip
            [self.cloudClient getVIPDetailMessage:@"8903"
                                         delegate:self
                                         selector:@selector(getVipMessageSuccess:)
                                    errorSelector:@selector(getVipMessageError:)];
            
        }
        else
        {
            [self playVideo];
        }
    }
    
    [self addNotification];
    
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = YES;

    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(keyboardWillShow:)
     name:UIKeyboardWillShowNotification
     object:self.view.window];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];


}
-(void)getVipMessageSuccess:(NSDictionary *)info
{
    //不是vip展示 展示提示小视频扣费弹窗
    if (![@"true" isEqualToString:[info objectForKey:@"isVip"]])
    {
        
        NSString * smallVideoPrice = [info objectForKey:@"smallVideoPrice"];
        if (![@"0" isEqualToString:smallVideoPrice]) {
            
            self.kouJinBiButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-474*BILI/2)/2, 382*BILI/2, 474*BILI/2, 250*BILI/2)];
            [self.kouJinBiButton setBackgroundImage:[UIImage imageNamed:@"videoshow_btn_putong"] forState:UIControlStateNormal];
            [self.kouJinBiButton addTarget:self action:@selector(kouJinBiButtonClick) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:self.kouJinBiButton];

            UILabel * jinBiLable = [[UILabel alloc] initWithFrame:CGRectMake(192*BILI/2, 176*BILI/2, 40*BILI, 18*BILI)];
            jinBiLable.textColor = [UIColor whiteColor];
            jinBiLable.font = [UIFont systemFontOfSize:18*BILI];
            jinBiLable.text = [NSString stringWithFormat:@"%.1f",smallVideoPrice.floatValue/100];
            [self.kouJinBiButton addSubview:jinBiLable];
            
            
            self.kaiTongVipButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-474*BILI/2)/2, self.kouJinBiButton.frame.size.height+self.kouJinBiButton.frame.origin.y+30*BILI, 474*BILI/2, 250*BILI/2)];
            [self.kaiTongVipButton setBackgroundImage:[UIImage imageNamed:@"videoshow_btn_VIP"] forState:UIControlStateNormal];
            [self.kaiTongVipButton addTarget:self action:@selector(kaiTongVipButtonClick) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:self.kaiTongVipButton];
            

            
        }
        
    }
    else
    {
        [self playVideo];
    }
    
}

-(void)kaiTongVipButtonClick
{
    [self.kouJinBiButton removeFromSuperview];
    [self.kaiTongVipButton removeFromSuperview];
    TanLiao_VipViewController * vc = [[TanLiao_VipViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}
-(void)kouJinBiButtonClick
{
    [self shiPinKouFei];
}
-(void)getVipMessageError:(NSDictionary *)info
{
    [self playVideo];
}
-(void)shiPinKouFei
{
    [self.cloudClient xiaoShiPinKouFei:@"8158"
                               videoId:[self.anchorInfo objectForKey:@"videoId"]
                              delegate:self
                              selector:@selector(koFeiSuccess:)
                         errorSelector:@selector(koFeiError:)];
}
-(void)koFeiSuccess:(NSDictionary *)info
{
    for (int i=0; i<self.sourceArray.count; i++) {
        
        NSDictionary * sourceInfo = [self.sourceArray objectAtIndex:i];
        if ([[sourceInfo objectForKey:@"videoId"] isEqualToString:[self.anchorInfo objectForKey:@"videoId"]])
        {
            NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:sourceInfo];
            [dic setObject:@"1" forKey:@"isPayed"];
            [self.sourceArray replaceObjectAtIndex:i withObject:dic];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"alreadyPayedVideo" object:dic];
        }
    }
    NSLog(@"扣费成功,播放视频...................");
    [self.kouJinBiButton removeFromSuperview];
    [self.kaiTongVipButton removeFromSuperview];
    [self playVideo];
}
-(void)koFeiError:(NSDictionary *)info
{
    if ([@"-969" isEqualToString:[info objectForKey:@"code"]])
    {
      
            TanLiao_RechargeViewController * rechargeVC = [[TanLiao_RechargeViewController alloc] init];
            rechargeVC.payChannel = @"appPay";
            rechargeVC.delegate = self;
            [self.navigationController pushViewController:rechargeVC animated:YES];
            
        
    
    }
    else
    {
        [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];
    }
}
-(void)chongZhiSuccess
{
     [self getUserInfo];
    [TanLiao_Common showToastView:@"充值成功" view:self.view];
}
#pragma mark--键盘弹出时的监听事件
- (void)keyboardWillShow:(NSNotification *) notification
{
    CGRect keyboardBounds;
    [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];



   



    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    //键盘高度
     float keyboardHeight = keyboardBounds.size.height;
    
    self.pingLunTextFieldBottomView.frame = CGRectMake(self.pingLunTextFieldBottomView.frame.origin.x,VIEW_HEIGHT-keyboardHeight-44*BILI,VIEW_WIDTH,44*BILI);
    
    
    
}
-(void)keyboardWillHide
{
    self.pingLunTextFieldBottomView.frame = CGRectMake(self.pingLunTextFieldBottomView.frame.origin.x,VIEW_HEIGHT-44*BILI,VIEW_WIDTH,44*BILI);

}
//  添加播放器通知
-(void)addNotification{
    //给AVPlayerItem添加播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
    
    
}
-(void)removeNotification
{
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
//  播放完成通知
 -(void)playbackFinished:(NSNotification *)notification{
    
    // 播放完成后重复播放
    // 跳到最新的时间点开始播放
    [self.player seekToTime:CMTimeMake(0, 1)];
    [self.player play];
     
}

-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    
    if(![@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
    {
        //向下滑动
        if(recognizer.direction==UISwipeGestureRecognizerDirectionDown) {
            
            if (self.indexStr.intValue-1>=0) {
                
                KuaiLiao_BoFangShiPinViewController * boFangVC = [[KuaiLiao_BoFangShiPinViewController alloc] init];
                boFangVC.anchorInfo = [self.sourceArray objectAtIndex:self.indexStr.intValue-1];
                boFangVC.sourceArray = self.sourceArray;
                boFangVC.fromWhere = @"shiPinXiuList";
                boFangVC.indexStr = [NSString stringWithFormat:@"%d",self.indexStr.intValue-1];
                boFangVC.pageIndexStr = self.pageIndexStr;
                CATransition *transition = [CATransition animation];
                transition.duration = 0.25;
                transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
                transition.type = kCATransitionPush;
                transition.subtype = kCATransitionFromBottom;
                [self.navigationController.view.layer addAnimation:transition forKey:nil];
                self.navigationController.navigationBarHidden = YES;
                [self.navigationController pushViewController:boFangVC animated:NO];
            }
            else
            {
                CATransition *transition = [CATransition animation];
                transition.duration = 0.25;
                transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
                transition.type = kCATransitionPush;
                transition.subtype = kCATransitionFromBottom;
                [self.navigationController.view.layer addAnimation:transition forKey:nil];
                self.navigationController.navigationBarHidden = YES;
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }
        //向上滑动
        if(recognizer.direction==UISwipeGestureRecognizerDirectionUp) {
            
            if (self.sourceArray.count>self.indexStr.intValue+1) {
                
                KuaiLiao_BoFangShiPinViewController * boFangVC = [[KuaiLiao_BoFangShiPinViewController alloc] init];





                boFangVC.anchorInfo = [self.sourceArray objectAtIndex:self.indexStr.intValue+1];
                boFangVC.sourceArray = self.sourceArray;
                boFangVC.fromWhere = @"shiPinXiuList";
                boFangVC.indexStr = [NSString stringWithFormat:@"%d",self.indexStr.intValue+1];
                boFangVC.pageIndexStr = self.pageIndexStr;
                CATransition *transition = [CATransition animation];
                transition.duration = 0.25;
                transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];



 


                transition.type = kCATransitionPush;
                transition.subtype = kCATransitionFromTop;
                [self.navigationController.view.layer addAnimation:transition forKey:nil];
                self.navigationController.navigationBarHidden = YES;
                [self.navigationController pushViewController:boFangVC animated:NO];
            }
            else
            {
                [self showNewLoadingView:@"加载更多...." view:self.view];


 

 



                [self.cloudClient getShiPinQiangList:@"8077"
                                            pageSize:@"10"
                                           pageIndex:[NSString stringWithFormat:@"%d",self.pageIndexStr.intValue]
                                            delegate:self
                                            selector:@selector(getMoreListSuccess:)
                                       errorSelector:@selector(getListError:)];
                
            }
            
            
        }
        
        //向左滑动
        if(recognizer.direction==UISwipeGestureRecognizerDirectionLeft)
        {
            TanLiaoLiao_AnchorDetailMessageViewController * anchorDetailVC = [[TanLiaoLiao_AnchorDetailMessageViewController alloc] init];


 

 

            anchorDetailVC.anchorId = [self.anchorInfo objectForKey:@"anchorId"];
            anchorDetailVC.fromVideoId = [self.anchorInfo objectForKey:@"videoId"];
            [self.navigationController pushViewController:anchorDetailVC animated:YES];
            
        }
        
    }
   
}




-(void)getMoreListSuccess:(NSArray *)array
{
    [self hideNewLoadingView];


 
if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
{
  UITableView * pkgrfI0034 = [[UITableView alloc]initWithFrame:CGRectMake(71,90,61,29)];
  pkgrfI0034.layer.borderWidth = 1;
  pkgrfI0034.clipsToBounds = YES;
  pkgrfI0034.layer.cornerRadius =5;
    UITextView * zgumtC8343 = [[UITextView alloc]initWithFrame:CGRectMake(64,57,30,18)];
    zgumtC8343.backgroundColor = [UIColor whiteColor];
    zgumtC8343.layer.borderColor = [[UIColor greenColor] CGColor];
    zgumtC8343.layer.cornerRadius =7;
    UITextView * ahksT715 = [[UITextView alloc]initWithFrame:CGRectMake(22,53,29,66)];
    ahksT715.layer.borderWidth = 1;
    ahksT715.clipsToBounds = YES;
    ahksT715.layer.cornerRadius =7;
    UITableView * bneqpU9453 = [[UITableView alloc]initWithFrame:CGRectMake(54,69,98,65)];
    bneqpU9453.backgroundColor = [UIColor whiteColor];
    bneqpU9453.layer.borderColor = [[UIColor greenColor] CGColor];
    bneqpU9453.layer.cornerRadius =7;
    UIScrollView * dkuaO222 = [[UIScrollView alloc]initWithFrame:CGRectMake(81,30,44,45)];
    dkuaO222.backgroundColor = [UIColor whiteColor];
    dkuaO222.layer.borderColor = [[UIColor greenColor] CGColor];
    dkuaO222.layer.cornerRadius =9;
    
    UIView * hunvD280 = [[UIView alloc]initWithFrame:CGRectMake(21,35,64,50)];
    hunvD280.layer.cornerRadius =10;
    hunvD280.userInteractionEnabled = YES;
    hunvD280.layer.masksToBounds = YES;
    
    UIImageView * pxtrfS8523 = [[UIImageView alloc]initWithFrame:CGRectMake(91,96,26,16)];
    pxtrfS8523.backgroundColor = [UIColor whiteColor];
    pxtrfS8523.layer.borderColor = [[UIColor greenColor] CGColor];
    pxtrfS8523.layer.cornerRadius =5;
    
    UITableView * gswsngA60988 = [[UITableView alloc]initWithFrame:CGRectMake(72,12,27,13)];
    gswsngA60988.backgroundColor = [UIColor whiteColor];
    gswsngA60988.layer.borderColor = [[UIColor greenColor] CGColor];
    gswsngA60988.layer.cornerRadius =9;

}
 


    if(array.count>0)
    {
    self.pageIndexStr = [NSString stringWithFormat:@"%d",self.pageIndexStr.intValue+1];
    NSMutableArray * sourceArray = [[NSMutableArray alloc] initWithArray:self.sourceArray];
    for (int i=0; i<array.count; i++) {
        
        NSDictionary * info = [array objectAtIndex:i];
        
        [sourceArray addObject:info];
    }
   
    self.sourceArray = sourceArray;
    if (self.sourceArray.count>self.indexStr.intValue+1) {
        
        KuaiLiao_BoFangShiPinViewController * boFangVC = [[KuaiLiao_BoFangShiPinViewController alloc] init];


 


        boFangVC.anchorInfo = [self.sourceArray objectAtIndex:self.indexStr.intValue+1];
        boFangVC.sourceArray = self.sourceArray;
        boFangVC.pageIndexStr = self.pageIndexStr;
        boFangVC.fromWhere = @"shiPinXiuList";
        boFangVC.indexStr = [NSString stringWithFormat:@"%d",self.indexStr.intValue+1];
        CATransition *transition = [CATransition animation];
        transition.duration = 0.25;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];


 



        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromTop;
        [self.navigationController.view.layer addAnimation:transition forKey:nil];
        self.navigationController.navigationBarHidden = YES;
        [self.navigationController pushViewController:boFangVC animated:NO];
    }
    }
    else
    {
        [TanLiao_Common showToastView:@"没有更多啦" view:self.view];


 

 


    }
    
}



-(void)getListError:(NSDictionary *)info
{
    [self hideNewLoadingView];







}



-(void)initJieTongView
{
    //已经接通
    
    if ([@"shiPinXiuList" isEqualToString:self.fromWhere]) {
        
        UISwipeGestureRecognizer *recognizer;
        recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
        [recognizer setDirection:(UISwipeGestureRecognizerDirectionUp)];
        [self.view addGestureRecognizer:recognizer];


        recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
        [recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
        [self.view addGestureRecognizer:recognizer];

    }
    
    UISwipeGestureRecognizer *recognizer;
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.view addGestureRecognizer:recognizer];




    
    UIImageView * bottomView = [[UIImageView alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT-297*BILI/2, VIEW_WIDTH, 297*BILI/2)];
    bottomView.userInteractionEnabled = YES;
    bottomView.image = [UIImage imageNamed:@"shiPinXiu_pic_mask_input"];
    [self.view addSubview:bottomView];


 
    
    CGSize  namesSize = [TanLiao_Common setSize:[self.anchorInfo objectForKey:@"nick"] withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_WIDTH) withFontSize:18*BILI];
    
    
    UILabel * nameLbale = [[UILabel alloc] initWithFrame:CGRectMake(32*BILI/2, 37*BILI, namesSize.width, 25*BILI)];
    nameLbale.textAlignment = NSTextAlignmentCenter;
    nameLbale.textColor = [UIColor whiteColor];





    nameLbale.font = [UIFont systemFontOfSize:18*BILI];
    nameLbale.text = [self.anchorInfo objectForKey:@"nick"];
    [bottomView addSubview:nameLbale];



 



    
    UIImageView * freeOrBusyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(nameLbale.frame.origin.x+nameLbale.frame.size.width+6*BILI, 42*BILI, 35*BILI, 15*BILI)];
    [bottomView addSubview:freeOrBusyImageView];


 



    
    if ([@"1" isEqualToString:[self.anchorInfo objectForKey:@"onlineStatus"]])
    {
        freeOrBusyImageView.image = [UIImage imageNamed:@"icon_kongxian"];
    }
    else
    {
        freeOrBusyImageView.image = [UIImage imageNamed:@"icon_manglu"];
    }
    
    
    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(nameLbale.frame.origin.x, nameLbale.frame.size.height+nameLbale.frame.origin.y+2*BILI,452*BILI/2 , 33*BILI/2)];
    tipLable.font = [UIFont systemFontOfSize:12*BILI];
    tipLable.textColor = [UIColor whiteColor];


 
   



    [bottomView addSubview:tipLable];





    tipLable.text = [self.anchorInfo objectForKey:@"signature"];
    
    UIButton * shiPinButton = [[UIButton alloc] initWithFrame:CGRectMake(16*BILI, tipLable.frame.origin.y+tipLable.frame.size.height+12*BILI, VIEW_WIDTH-32*BILI, 44*BILI)];
    [shiPinButton setBackgroundImage:[UIImage imageNamed:@"shiPinXiu_ZhaoWoShiPin"] forState:UIControlStateNormal];
    [shiPinButton addTarget:self action:@selector(zhaoWoShiPinButtonClick) forControlEvents:UIControlEventTouchUpInside];

 

    [bottomView addSubview:shiPinButton];
    
    
    
    
    self.closeShiPinButton = [[UIButton alloc] initWithFrame:CGRectMake(16*BILI, SafeAreaTopHeight+17.5*BILI, 30*BILI, 30*BILI)];
    [self.closeShiPinButton setBackgroundImage:[UIImage imageNamed:@"shipinxiu_btn_close"] forState:UIControlStateNormal];
    [self.closeShiPinButton addTarget:self action:@selector(quXiaoHangup) forControlEvents:UIControlEventTouchUpInside];



    [self.view addSubview:self.closeShiPinButton];
    
    UIButton * jvBaoButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-16*BILI-23*BILI, self.closeShiPinButton.frame.origin.y, 23*BILI+16*BILI, 30*BILI)];
    [jvBaoButton setImage:[UIImage imageNamed:@"shiPinXiu_jubao"] forState:UIControlStateNormal];
    [jvBaoButton addTarget:self action:@selector(jvBoaButtonClcik) forControlEvents:UIControlEventTouchUpInside];


 


    [self.view addSubview:jvBaoButton];

    
    TanLiaoCustomImageView * headerImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-98*BILI/2-14*BILI,577*BILI/2, 98*BILI/2, 98*BILI/2)];
    headerImageView.imgType = IMAGEVIEW_TYPE_CENTER;
    headerImageView.urlPath = [self.anchorInfo objectForKey:@"avatarUrl"];
    headerImageView.layer.borderWidth = 2;
    headerImageView.layer.borderColor = [[UIColor whiteColor] CGColor];


 



    headerImageView.userInteractionEnabled = YES;
    headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    headerImageView.autoresizingMask = UIViewAutoresizingNone;
    headerImageView.clipsToBounds = YES;
    [self.view addSubview:headerImageView];


 


    
    UITapGestureRecognizer * headerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shiPinButtonClick)];
    [headerImageView addGestureRecognizer:headerTap];
    
    self.guanZhuImageView = [[UIImageView alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x+(94*BILI/2-20*BILI)/2, headerImageView.frame.origin.y+headerImageView.frame.size.height-10*BILI, 20*BILI, 20*BILI)];
    [self.view addSubview:self.guanZhuImageView];

    if ([@"1" isEqualToString:[self.anchorInfo objectForKey:@"attentionStatus"]])
    {
        self.guanZhuImageView.image = [UIImage imageNamed:@"shiPinXiu_addConcer"];
        self.guanZhuImageView.tag = 1;

    }
    else
    {
        self.guanZhuImageView.image = [UIImage imageNamed:@"shiPinXiu_selected"];
        self.guanZhuImageView.tag = 2;

    }
    
    UIButton * guanZhuButton = [[UIButton alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x, headerImageView.frame.origin.y+40*BILI, 94*BILI/2, 30*BILI)];
    guanZhuButton.backgroundColor = [UIColor clearColor];





    [guanZhuButton addTarget:self action:@selector(guanZhuButtonClick) forControlEvents:UIControlEventTouchUpInside];


 

 

    [self.view addSubview:guanZhuButton];
    
    
    self.dianZanButton = [[UIButton alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x+(98*BILI/2-30*BILI)/2, headerImageView.frame.origin.y+headerImageView.frame.size.height+63*BILI/2, 30*BILI, 30*BILI)];
    [self.dianZanButton addTarget:self action:@selector(dianZan) forControlEvents:UIControlEventTouchUpInside];


 



    [self.view addSubview:self.dianZanButton];
    
    self.likeStatus = [self.anchorInfo objectForKey:@"likeStatus"];
    
    if ([@"1" isEqualToString:[self.anchorInfo objectForKey:@"likeStatus"]]) {
        
        [self.dianZanButton setBackgroundImage:[UIImage imageNamed:@"shipinxiu_icon_love_red"] forState:UIControlStateNormal];
        
    }
    else
    {
        [self.dianZanButton setBackgroundImage:[UIImage imageNamed:@"shipinxiu_icon_love"] forState:UIControlStateNormal];
        
    }
    
    self.dianZanNumberLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x, self.dianZanButton.frame.origin.y+self.dianZanButton.frame.size.height+0*BILI, headerImageView.frame.size.width, 37*BILI/2)];
    self.dianZanNumberLable.font = [UIFont systemFontOfSize:13*BILI];
    self.dianZanNumberLable.textColor = [UIColor whiteColor];




    self.dianZanNumberLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.dianZanNumberLable];




    self.dianZanNumberLable.text = [self.anchorInfo objectForKey:@"totalLikes"];
    
    UIImageView * liuLanNumberImageView = [[UIImageView alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x+(98*BILI/2-59*BILI/2)/2, self.dianZanButton.frame.origin.y+self.dianZanButton.frame.size.height+35*BILI, 59*BILI/2, 59*BILI/2)];
    liuLanNumberImageView.image = [UIImage imageNamed:@"shiPinXiu_guankan"];
    [self.view addSubview:liuLanNumberImageView];


 




    
    UILabel * LiuLanNumberLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x, liuLanNumberImageView.frame.origin.y+liuLanNumberImageView.frame.size.height+0*BILI, headerImageView.frame.size.width, 37*BILI/2)];
    LiuLanNumberLable.font = [UIFont systemFontOfSize:13*BILI];
    LiuLanNumberLable.textColor = [UIColor whiteColor];


 


    LiuLanNumberLable.textAlignment = NSTextAlignmentCenter;
    LiuLanNumberLable.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:LiuLanNumberLable];





    
    LiuLanNumberLable.text = [NSString stringWithFormat:@"%@",[self.anchorInfo objectForKey:@"clicks"]];
    
    UIImageView * pingLunNumberImageView = [[UIImageView alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x+(98*BILI/2-49*BILI/2)/2, liuLanNumberImageView.frame.origin.y+liuLanNumberImageView.frame.size.height+37*BILI, 49*BILI/2, 23*BILI)];
    pingLunNumberImageView.image = [UIImage imageNamed:@"shiPinXiu_pinglun "];
    [self.view addSubview:pingLunNumberImageView];

 



    
    
    self.pingLunNumberLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x, pingLunNumberImageView.frame.origin.y+pingLunNumberImageView.frame.size.height+0*BILI, headerImageView.frame.size.width, 37*BILI/2)];
    self.pingLunNumberLable.font = [UIFont systemFontOfSize:13*BILI];
    self.pingLunNumberLable.textColor = [UIColor whiteColor];



   



    self.pingLunNumberLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.pingLunNumberLable];


 

 


    
    UIButton * pingLunButton = [[UIButton alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x, pingLunNumberImageView.frame.origin.y, 94*BILI/2, 94*BILI/2+6*BILI+37*BILI)];
    [pingLunButton addTarget:self action:@selector(pingLunButtonClick) forControlEvents:UIControlEventTouchUpInside];


 

 



    [self.view addSubview:pingLunButton];
    
    self.songLiButton = [[UIButton alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x+(98*BILI/2-88*BILI/2)/2, self.pingLunNumberLable.frame.origin.y+self.pingLunNumberLable.frame.size.height+27*BILI/2, 44*BILI, 44*BILI)];
    [self.songLiButton setImage:[UIImage imageNamed:@"btn_lw"] forState:UIControlStateNormal];
    [self.songLiButton addTarget:self action:@selector(songLi) forControlEvents:UIControlEventTouchUpInside];



 

    [self.view addSubview:self.songLiButton];

    if([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
    {
        freeOrBusyImageView.hidden = YES;
        self.guanZhuImageView.hidden = YES;
        guanZhuButton.hidden = YES;
        pingLunNumberImageView.hidden = YES;
        self.pingLunNumberLable.hidden = YES;
        pingLunButton.hidden = YES;
//        self.songLiButton.hidden = YES;//@3x
        self.songLiButton.frame = CGRectMake(self.songLiButton.frame.origin.x, LiuLanNumberLable.frame.origin.y+LiuLanNumberLable.frame.size.height+20*BILI, self.songLiButton.frame.size.width, self.songLiButton.frame.size.height);
        [shiPinButton setBackgroundImage:[UIImage imageNamed:@"mmt_button_yiduiyishipin"] forState:UIControlStateNormal];
    }
    
    self.pingLunTableView = [[UITableView alloc] initWithFrame:CGRectMake(0*BILI, VIEW_HEIGHT+384*BILI/2, VIEW_WIDTH, VIEW_HEIGHT-384*BILI/2-44*BILI)];
    self.pingLunTableView.delegate = self;
    self.pingLunTableView.dataSource = self;
    self.pingLunTableView.separatorStyle = NO;
    self.pingLunTableView.backgroundColor = UIColorFromRGB(0x555555);
    [self.view addSubview:self.pingLunTableView];


 



    UITapGestureRecognizer * tableViewTap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableviewTapClick)];
    [self.pingLunTableView addGestureRecognizer:tableViewTap];
    
    self.pingLunTextFieldBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT, VIEW_WIDTH, 44*BILI)];
    self.pingLunTextFieldBottomView.backgroundColor = UIColorFromRGB(0x2E2E2E);
    [self.view addSubview:self.pingLunTextFieldBottomView];

    self.pingLunTextField = [[UITextField alloc] initWithFrame:CGRectMake(22*BILI, 0, VIEW_WIDTH-44*BILI, 44*BILI)];
    self.pingLunTextField.backgroundColor = [UIColor clearColor];
    self.pingLunTextField.font = [UIFont systemFontOfSize:11*BILI];
    self.pingLunTextField.textColor = [UIColor whiteColor];
    self.pingLunTextField.placeholder = @"有爱评论，说点儿好听的给小姐姐们哦...";
    self.pingLunTextField.returnKeyType=UIReturnKeySend;
    self.pingLunTextField.delegate = self;
    [self.pingLunTextField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.pingLunTextFieldBottomView addSubview:self.pingLunTextField];
    
    
    
    [self initChongZhiView];



 


    if (![@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]]) {
        
        NSUserDefaults * boFangShiPinIntroduceDefauts = [NSUserDefaults standardUserDefaults];




        NSString * alsoShowIntroduceStr =[boFangShiPinIntroduceDefauts objectForKey:@"boFangShiPinIntroduce"];
        if (![@"showed" isEqualToString:alsoShowIntroduceStr])
        {
            self.introduceBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
            self.introduceBottomView.backgroundColor = [UIColor blackColor];





            self.introduceBottomView.alpha = 0.7;
            [self.view addSubview:self.introduceBottomView];




            self.introduceImageView = [[UIImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-617*BILI/2)/2, 118*BILI/2, 617*BILI/2, 914*BILI/2)];
            self.introduceImageView.image = [UIImage imageNamed:@"shiPInXiuBitmap"];
            [self.view addSubview:self.introduceImageView];




            self.introduceButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-237*BILI/2)/2, self.introduceImageView.frame.origin.y+self.introduceImageView.frame.size.height+30*BILI, 237*BILI/2, 129*BILI/2)];
            [self.introduceButton setBackgroundImage:[UIImage imageNamed:@"shiPInXiuBitmap_button"] forState:UIControlStateNormal];
            [self.introduceButton addTarget:self action:@selector(introduceButtonClick) forControlEvents:UIControlEventTouchUpInside];


 



            [self.view addSubview:self.introduceButton];
        }

    }
    
    
  
    [self getCommitList];


 



    [self.cloudClient getGiftList:@"8019"
                         delegate:self
                         selector:@selector(getGiftListSuccess:)
                    errorSelector:@selector(getGiftListError:)];
    
   
}




-(void)introduceButtonClick
{
    NSUserDefaults * boFangShiPinIntroduceDefauts = [NSUserDefaults standardUserDefaults];



    [boFangShiPinIntroduceDefauts setObject:@"showed" forKey:@"boFangShiPinIntroduce"];
    [boFangShiPinIntroduceDefauts synchronize];


 

    [self.introduceBottomView removeFromSuperview];


 

 

    [self.introduceImageView removeFromSuperview];





    [self.introduceButton removeFromSuperview];


 





}


-(void)tableviewTapClick
{
    [self.pingLunTextField resignFirstResponder];


 



}



-(void)shiPinButtonClick
{
    if ([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
    {
//
        MJUserDetailViewController * vc = [[MJUserDetailViewController alloc] init];





        vc.anchorId = [self.anchorInfo objectForKey:@"anchorId"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        TanLiaoLiao_AnchorDetailMessageViewController * anchorDetailVC = [[TanLiaoLiao_AnchorDetailMessageViewController alloc] init];



 

        anchorDetailVC.anchorId = [self.anchorInfo objectForKey:@"anchorId"];
        anchorDetailVC.fromVideoId = [self.anchorInfo objectForKey:@"videoId"];
        [self.navigationController pushViewController:anchorDetailVC animated:YES];
    }
    
}
-(void)zhaoWoShiPinButtonClick
{
    if ([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
    {
        
        ChatViewController *chatVC = [[ChatViewController alloc] initWithConversationType:
                                      ConversationType_PRIVATE targetId:[self.anchorInfo objectForKey:@"anchorId"]];
        
        chatVC.conversationType = ConversationType_PRIVATE;
        chatVC.targetId = [self.anchorInfo objectForKey:@"anchorId"];
        chatVC.title = [self.anchorInfo objectForKey:@"nick"];
        [self.navigationController pushViewController:chatVC animated:YES];
        
    }
    else
    {
        TanLiaoLiao_AnchorDetailMessageViewController * anchorDetailVC = [[TanLiaoLiao_AnchorDetailMessageViewController alloc] init];


 

 


        anchorDetailVC.anchorId = [self.anchorInfo objectForKey:@"anchorId"];
        anchorDetailVC.fromVideoId = [self.anchorInfo objectForKey:@"videoId"];
        [self.navigationController pushViewController:anchorDetailVC animated:YES];

    }

}
-(void)dianZan
{
    if ([@"1" isEqualToString:self.likeStatus]) {
        [self.cloudClient videoLove:@"8080"
                            videoId:[self.anchorInfo objectForKey:@"videoId"]
                             status:@"2"
                           delegate:self
                           selector:@selector(dianZanSuccess:)
                      errorSelector:@selector(dianZanError:)];
    }
    else
    {
        [self.cloudClient videoLove:@"8080"
                            videoId:[self.anchorInfo objectForKey:@"videoId"]
                             status:@"1"
                           delegate:self
                           selector:@selector(dianZanSuccess:)
                      errorSelector:@selector(dianZanError:)];

    }
    
}
-(void)dianZanSuccess:(NSDictionary *)info
{
    if ([@"1" isEqualToString:self.likeStatus])
    {
        NSString * dianZanNmberStr = self.dianZanNumberLable.text;
        self.dianZanNumberLable.text  = [NSString stringWithFormat:@"%d",dianZanNmberStr.intValue-1];

        self.likeStatus = @"2";
        [self.dianZanButton setBackgroundImage:[UIImage imageNamed:@"shipinxiu_icon_love"] forState:UIControlStateNormal];
        
        
    }
    else
    {
        NSString * dianZanNmberStr = self.dianZanNumberLable.text;
        self.dianZanNumberLable.text  = [NSString stringWithFormat:@"%d",dianZanNmberStr.intValue+1];
        self.likeStatus= @"1";
        [self.dianZanButton setBackgroundImage:[UIImage imageNamed:@"shipinxiu_icon_love_red"] forState:UIControlStateNormal];
    }
    
    [self.anchorInfo setObject:self.likeStatus forKey:@"likeStatus"];
    [self.anchorInfo setObject:self.dianZanNumberLable.text forKey:@"totalLikes"];
    
}
-(void)dianZanError:(NSDictionary *)info
{
    
}

-(void)getCommitList
{
    
[self.cloudClient getVideoCommitList:@"8078"
                                    pageSize:@"50"
                                   pageIndex:@"1"
                                     videoId:[self.anchorInfo objectForKey:@"videoId"]
                                    delegate:self
                                    selector:@selector(getCommitListScuss:)
                               errorSelector:@selector(getCommitListError:)];
}
-(void)getCommitListScuss:(NSArray *)array
{
    self.commitList = array;
    self.pingLunNumberLable.text = [NSString stringWithFormat:@"%d",(int)array.count];


 

 

    [self.pingLunTableView scrollsToTop];
    [self.pingLunTableView reloadData];
    
    
    
}





-(void)getCommitListError:(NSArray *)info
{
}



-(void)guanZhuButtonClick
{
    
    NSNumber * userId = [self.anchorInfo objectForKey:@"anchorId"];
    if(self.guanZhuImageView.tag ==1)
    {
        [self.cloudClient addConcern:[NSString stringWithFormat:@"%d",userId.intValue]
                               apiId:@"8017"
                            delegate:self
                            selector:@selector(addConcernSuccess:)
                       errorSelector:@selector(addConcernError:)];
    }
    else
    {
        [self.cloudClient removeConcern:[NSString stringWithFormat:@"%d",userId.intValue]
                                  apiId:@"8018"
                               delegate:self
                               selector:@selector(removeConcernSuccess:)
                          errorSelector:@selector(addConcernError:)];
    }

}
-(void)addConcernSuccess:(NSDictionary *)info
{
    
    [self.anchorInfo setObject:@"0" forKey:@"attentionStatus"];
    
    UIButton * tipButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-200)/2,VIEW_HEIGHT-100, 200, 40)];
    tipButton.enabled = NO;
    tipButton.alpha = 0.8;
    tipButton.layer.cornerRadius = 20;
    tipButton.backgroundColor = [UIColor blackColor];







    [tipButton setTitle:@"关注成功" forState:UIControlStateNormal];
    [tipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tipButton.titleLabel.font = [UIFont systemFontOfSize:15];
    tipButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:tipButton];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3];
    tipButton.alpha = 0;
    [UIView commitAnimations];






    
    self.guanZhuImageView.image = [UIImage imageNamed:@"shiPinXiu_selected"];
    self.guanZhuImageView.tag =2;
    
}
-(void)removeConcernSuccess:(NSDictionary *)info
{
    
    [self.anchorInfo setObject:@"1" forKey:@"attentionStatus"];
    
    UIButton * tipButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-200)/2,VIEW_HEIGHT-100, 200, 40)];
    tipButton.enabled = NO;
    tipButton.alpha = 0.8;
    tipButton.layer.cornerRadius = 20;
    tipButton.backgroundColor = [UIColor blackColor];





    [tipButton setTitle:@"已取消关注" forState:UIControlStateNormal];
    [tipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tipButton.titleLabel.font = [UIFont systemFontOfSize:15];
    tipButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:tipButton];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3];
    tipButton.alpha = 0;
    [UIView commitAnimations];


 





    
    self.guanZhuImageView.image = [UIImage imageNamed:@"shiPinXiu_addConcer"];
    self.guanZhuImageView.tag =1;
    
}
-(void)addConcernError:(NSDictionary *)info
{
    UIButton * tipButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-200)/2,VIEW_HEIGHT-100, 200, 40)];
    tipButton.enabled = NO;
    tipButton.alpha = 0.8;
    tipButton.layer.cornerRadius = 20;
    tipButton.backgroundColor = [UIColor blackColor];


 



    [tipButton setTitle:[info objectForKey:@"message"] forState:UIControlStateNormal];
    [tipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tipButton.titleLabel.font = [UIFont systemFontOfSize:15];
    tipButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:tipButton];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:3];
    tipButton.alpha = 0;
    [UIView commitAnimations];



   



}


-(void)jvBoaButtonClcik
{
    UIActionSheet * action = [[UIActionSheet alloc] initWithTitle:@"举报" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"资料不当",@"频繁骚扰",@"其他", nil];
    action.tag = 20;
    [action showInView:self.view];



    
}

-(void)jvBaoSuccess:(NSDictionary *)info
{
    
    
    [self hideNewLoadingView];







    NSLog(@"%@",[info objectForKey:@"message"] );
    [TanLiao_Common showToastView:@"已成功举报该用户" view:self.view];







}




-(void)getUserInfo
{
    
    
    [self.cloudClient getUserInformation:@"8029"
                                delegate:self
                                selector:@selector(getUserInformationSuccess:)
                           errorSelector:@selector(getUserInformationError:)];

}




-(void)getUserInformationSuccess:(NSDictionary *)info
{
    self.yuEr = [info objectForKey:@"gold_number"];
    self.daShangViewJinBiLable.text = [NSString stringWithFormat:@"%.2f%@",self.yuEr.floatValue/JinBiBiLi,[TanLiao_Common getParamStr1]];
    
    
}





-(void)getUserInformationError:(NSDictionary *)info
{
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [self.pingLunTextField resignFirstResponder];


    if (textField.text.length>0)
    {
            [self.cloudClient videoCommit:@"8079"
                                  videoId:[self.anchorInfo objectForKey:@"videoId"]
                                  content:textField.text
                                 delegate:self
                                 selector:@selector(commitSuccess:)
                            errorSelector:@selector(commitError:)];
        
    }
    else
    {
        [TanLiao_Common showToastView:@"评论内容不能为空" view:self.view];





    }
    return YES;
}
-(void)commitSuccess:(NSDictionary *)info
{
    self.pingLunTextField.text = nil;
    [self getCommitList];





    
}
-(void)commitError:(NSDictionary *)info
{
}



-(void)getGiftListSuccess:(NSArray *)info
{
    
    
    NSLog(@"%@",[info objectAtIndex:0]);
    self.giftArray = [NSArray arrayWithArray:info];
    [self initDaShangView];


 





   
}




-(void)getGiftListError:(NSDictionary *)info
{
}
#pragma mark---UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    
    return self.commitList.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return  133*BILI/2;
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    NSString *tableIdentifier = [NSString stringWithFormat:@"ShiPinXiuPingLunTableViewCell%d",(int)[indexPath row]] ;
    TanLiaoLiao_NewShiPinXiuPingLunTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];


 




    if (cell == nil)
    {
        cell = [[TanLiaoLiao_NewShiPinXiuPingLunTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];


 

    }
    cell.backgroundColor = [UIColor clearColor];


 




    [cell initData:[self.commitList objectAtIndex:indexPath.row]];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 73*BILI/2;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 73*BILI/2)];
    headerView.backgroundColor = UIColorFromRGB(0x555555);
    
    UILabel * pingLunNumberLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 73*BILI/2)];
    pingLunNumberLable.textAlignment = NSTextAlignmentCenter;
    pingLunNumberLable.font = [UIFont systemFontOfSize:12*BILI];
    pingLunNumberLable.textColor = UIColorFromRGB(0xA0A0A0);
    pingLunNumberLable.text = [NSString stringWithFormat:@"%d条评论",(int)self.commitList.count];


 





    [headerView addSubview:pingLunNumberLable];







    
    UIButton * closePingLunListButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-30*BILI, 0, 30*BILI, 73*BILI/2)];
    [closePingLunListButton setTitle:@"×" forState:UIControlStateNormal];
    [closePingLunListButton setTitleColor:UIColorFromRGB(0xA0A0A0) forState:UIControlStateNormal];
    closePingLunListButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
    [closePingLunListButton addTarget:self action:@selector(cloePingLunListButtonClick) forControlEvents:UIControlEventTouchUpInside];


 






    [headerView addSubview:closePingLunListButton];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 73*BILI/2-1, VIEW_WIDTH, 1)];
    lineView.backgroundColor = UIColorFromRGB(0x979797);
    [headerView addSubview:lineView];







    
    return headerView;
}
-(void)pushToAnchorDatailVC:(NSString *)idStr
{
   TanLiaoLiao_AnchorDetailMessageViewController * anchorDetailVC = [[TanLiaoLiao_AnchorDetailMessageViewController alloc] init];
    anchorDetailVC.anchorId = idStr;
    [self.navigationController pushViewController:anchorDetailVC animated:YES];

}
-(void)pingLunButtonClick
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.pingLunTableView.frame = CGRectMake(self.pingLunTableView.frame.origin.x, 384*BILI/2, VIEW_WIDTH, self.pingLunTableView.frame.size.height);
    self.pingLunTextFieldBottomView.frame = CGRectMake(0, VIEW_HEIGHT-self.pingLunTextFieldBottomView.frame.size.height, VIEW_WIDTH, self.pingLunTextFieldBottomView.frame.size.height);
    [UIView commitAnimations];


 


}
-(void)cloePingLunListButtonClick
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.pingLunTableView.frame = CGRectMake(self.pingLunTableView.frame.origin.x, VIEW_HEIGHT+384*BILI/2, VIEW_WIDTH, self.pingLunTableView.frame.size.height);
    self.pingLunTextFieldBottomView.frame = CGRectMake(0, VIEW_HEIGHT, VIEW_WIDTH, self.pingLunTextFieldBottomView.frame.size.height);
    [UIView commitAnimations];


 

   

}





-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    
    if (scrollView.contentOffset.y <= -35) {
   
        canRefresh = YES;
    }
    else
    {
        canRefresh = NO;
    }
    
}
//即将结束拖拽

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    
    if (canRefresh)
    {
        
        [self getCommitList];


    }
    
}

//充值界面




-(void)initChongZhiView
{
    self.chongZhiView = [[UIView alloc] initWithFrame:CGRectMake(75*BILI/2, 330*BILI/2, VIEW_WIDTH-75*BILI, 300*BILI)];
    
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




    
    self.buttonArray = [NSMutableArray array];
    NSArray * array;
  
    array = [[NSArray alloc] initWithObjects:@"5",@"42",@"68",@"138",@"271",@"698", nil];
        
    
    
    self.productIDArray = [[NSArray alloc] initWithObjects:@"lwb5",@"lwb42",@"lwb68",@"lwb138",@"lwb271",@"lwb698", nil];
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
        [button setTitle:[NSString stringWithFormat:@"%@%@",money,[TanLiao_Common getParamStr1]] forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromRGB(0xFF9000) forState:UIControlStateNormal];
        [button addTarget:self action:@selector(moneyButtonClick:) forControlEvents:UIControlEventTouchUpInside];

        [self.chongZhiView addSubview:button];
        [self.buttonArray addObject:button];
        
    }
    
    
    
    
    UIButton * chongZhiButton = [[UIButton alloc] initWithFrame:CGRectMake(19*BILI, 240*BILI, 262*BILI, 40*BILI)];
    chongZhiButton.backgroundColor = UIColorFromRGB(0xFF5C93);
    chongZhiButton.layer.cornerRadius = 20*BILI;
    chongZhiButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
    [chongZhiButton setTitle:[NSString stringWithFormat:@"充值"] forState:UIControlStateNormal];
    [chongZhiButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [chongZhiButton addTarget:self action:@selector(chongZhi) forControlEvents:UIControlEventTouchUpInside];




    [self.chongZhiView addSubview:chongZhiButton];
    
    self.closeChongZhiViewButton = [[UIButton alloc] initWithFrame:CGRectMake(332*BILI/2,VIEW_HEIGHT-124*BILI-43*BILI, 43*BILI, 43*BILI)];
    [self.closeChongZhiViewButton setImage:[UIImage imageNamed:@"btn_close1"] forState:UIControlStateNormal];
    [self.closeChongZhiViewButton addTarget:self action:@selector(closeChongZhiViewButtonClick) forControlEvents:UIControlEventTouchUpInside];






    [self.view addSubview:self.closeChongZhiViewButton];
    
    self.chongZhiView.hidden = YES;
    self.closeChongZhiViewButton.hidden = YES;
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


        [tipButton setTitle:[NSString stringWithFormat:[NSString stringWithFormat:@"请选择要充值的%@",[TanLiao_Common getParamStr1]],[TanLiao_Common getParamStr1]] forState:UIControlStateNormal];
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

#pragma UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag==20) {
        
        
        if (buttonIndex != 3) {
            
            [self showNewLoadingView:nil view:nil];
            
            [self.cloudClient jvBao:@"8043"
                            content:@""
                           toUserId:[self.anchorInfo objectForKey:@"anchorId"]
                           delegate:self
                           selector:@selector(jvBaoSuccess:)
                      errorSelector:@selector(jvBaoSuccess:)];
        }
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
-(void)getResultSuccess:(NSDictionary *)info
{
        [self hideNewLoadingView];

    
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
    
        [self getUserInfo];



}

-(void)getResultError:(NSDictionary *)info
{
    [self hideNewLoadingView];
}

//交易结束
- (void)completeTransaction:(SKPaymentTransaction *)transaction{
    NSLog(@"交易结束");
    
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}
////  苹果内购结束

-(void)finishZf:(NSString *)alsoSuccess
{
    if ([@"success" isEqualToString:alsoSuccess]) {
        
        [TanLiao_Common showToastView:@"充值成功" view:self.view];


    }
    [self getUserInfo];
}






-(void)getPayReturnSuccess:(NSDictionary *)info
{
    
    
    
    if ([[info objectForKey:@"gold_number"] isKindOfClass:[NSString class]]) {
        
        NSString * money = [info objectForKey:@"gold_number"];
        
        self.yuEr = money;
        
        self.daShangViewJinBiLable.text = [NSString stringWithFormat:@"%.2f%@",self.yuEr.floatValue/JinBiBiLi,[TanLiao_Common getParamStr1]];
        
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
//送礼物界面





-(void)initDaShangView
{
    self.daShangBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT-270*BILI, VIEW_WIDTH, 270*BILI)];
    self.daShangBottomView.backgroundColor = UIColorFromRGB(0x000000);
    self.daShangBottomView.alpha = 0.8;
    [self.view addSubview:self.daShangBottomView];


 
if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
{
  UILabel * plywalX18720 = [[UILabel alloc]initWithFrame:CGRectMake(18,86,34,96)];
  plywalX18720.layer.borderWidth = 1;
  plywalX18720.clipsToBounds = YES;
  plywalX18720.layer.cornerRadius =10;
    UIImageView * axqmzA2461 = [[UIImageView alloc]initWithFrame:CGRectMake(22,18,41,92)];
    axqmzA2461.backgroundColor = [UIColor whiteColor];
    axqmzA2461.layer.borderColor = [[UIColor greenColor] CGColor];
    axqmzA2461.layer.cornerRadius =5;
    UITextView * kzbsxV5855 = [[UITextView alloc]initWithFrame:CGRectMake(24,97,1,62)];
    kzbsxV5855.backgroundColor = [UIColor whiteColor];
    kzbsxV5855.layer.borderColor = [[UIColor greenColor] CGColor];
    kzbsxV5855.layer.cornerRadius =6;
    UIView * vzjmulV67119 = [[UIView alloc]initWithFrame:CGRectMake(86,46,47,4)];
    vzjmulV67119.layer.borderWidth = 1;
    vzjmulV67119.clipsToBounds = YES;
    vzjmulV67119.layer.cornerRadius =10;
    UIScrollView * rinqI858 = [[UIScrollView alloc]initWithFrame:CGRectMake(44,51,9,79)];
    rinqI858.layer.borderWidth = 1;
    rinqI858.clipsToBounds = YES;
    rinqI858.layer.cornerRadius =5;
    UILabel * ggxxyD4015 = [[UILabel alloc]initWithFrame:CGRectMake(76,12,55,14)];
    ggxxyD4015.layer.cornerRadius =5;
    ggxxyD4015.userInteractionEnabled = YES;
    ggxxyD4015.layer.masksToBounds = YES;
    UIView * rhrqP082 = [[UIView alloc]initWithFrame:CGRectMake(74,26,99,64)];
    rhrqP082.layer.cornerRadius =7;
    rhrqP082.userInteractionEnabled = YES;
    rhrqP082.layer.masksToBounds = YES;
    UIImageView * eeueO126 = [[UIImageView alloc]initWithFrame:CGRectMake(60,15,89,1)];
    eeueO126.layer.borderWidth = 1;
    eeueO126.clipsToBounds = YES;
    eeueO126.layer.cornerRadius =6;
    UITextView * jxauhzT93151 = [[UITextView alloc]initWithFrame:CGRectMake(38,80,87,62)];
    jxauhzT93151.backgroundColor = [UIColor whiteColor];
    jxauhzT93151.layer.borderColor = [[UIColor greenColor] CGColor];
    jxauhzT93151.layer.cornerRadius =5;
    
    UIView * zcapyeW02481 = [[UIView alloc]initWithFrame:CGRectMake(99,61,36,15)];
    zcapyeW02481.layer.borderWidth = 1;
    zcapyeW02481.clipsToBounds = YES;
    zcapyeW02481.layer.cornerRadius =8;

}
 





    
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
    self.daShangViewJinBiLable.text =[NSString stringWithFormat:@"%@%@",self.yuEr,[TanLiao_Common getParamStr1]];
    [self.daShangBottomButtonView addSubview:self.daShangViewJinBiLable];


 




    
    UIButton * chongZhiButton = [[UIButton alloc] initWithFrame:CGRectMake(120*BILI, 33*BILI, 75*BILI, 30*BILI)];
    [chongZhiButton setTitle:@"充值" forState:UIControlStateNormal];
    [chongZhiButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    chongZhiButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
    chongZhiButton.backgroundColor = UIColorFromRGB(0xF5A623);
    chongZhiButton.layer.cornerRadius = 15*BILI;
    [chongZhiButton addTarget:self action:@selector(daShangChongZhiButtonClick) forControlEvents:UIControlEventTouchUpInside];


 





    [self.daShangBottomButtonView addSubview:chongZhiButton];
    
    UIButton * zengSongButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(24+75)*BILI, 33*BILI, 75*BILI, 30*BILI)];
    [zengSongButton setTitle:@"赠送" forState:UIControlStateNormal];
    [zengSongButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    zengSongButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
    zengSongButton.backgroundColor = UIColorFromRGB(0xFF5C93);
    zengSongButton.layer.cornerRadius = 15*BILI;
    [zengSongButton addTarget:self action:@selector(zengSongButtonClick) forControlEvents:UIControlEventTouchUpInside];



 




    [self.daShangBottomButtonView addSubview:zengSongButton];
    
    
    
    
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

   





                [view addSubview:titleLable];


 

 



                
                NSString * money = [giftInfo objectForKey:@"amount"];
                if(money.intValue%JinBiBiLi==0)
                {
                    titleLable.text = [NSString stringWithFormat:@"%.0f%@",money.floatValue/JinBiBiLi,[TanLiao_Common getParamStr1]];
                    
                }
                else
                {
                    titleLable.text = [NSString stringWithFormat:@"%.2f%@",money.floatValue/JinBiBiLi,[TanLiao_Common getParamStr1]];
                }

                
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
                    titleLable.text = [NSString stringWithFormat:@"%.0f%@",money.floatValue/JinBiBiLi,[TanLiao_Common getParamStr1]];
                    
                }
                else
                {
                    titleLable.text = [NSString stringWithFormat:@"%.2f%@",money.floatValue/JinBiBiLi,[TanLiao_Common getParamStr1]];
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
    
    self.daShangView.hidden = YES;
    self.daShangBottomButtonView.hidden = YES;
    self.daShangBottomView.hidden = YES;
    self.closeDaShangViewButton.hidden = YES;
    
    [self getUserInfo];
    
}
-(void)daShangChongZhiButtonClick
{
    self.daShangView.hidden = YES;
    self.daShangBottomButtonView.hidden = YES;
    self.daShangBottomView.hidden = YES;
    self.closeDaShangViewButton.hidden = YES;
    
    
    
    
    self.chongZhiView.hidden = NO;
    self.closeChongZhiViewButton.hidden = NO;
}
-(void)zengSongButtonClick
{
    self.daShangView.hidden = YES;
    self.daShangBottomButtonView.hidden = YES;
    self.daShangBottomView.hidden = YES;
    self.closeDaShangViewButton.hidden = YES;
    if([self.selectGift isKindOfClass:[NSDictionary class]])
    {
        
        NSString * giftMoney = [self.selectGift objectForKey:@"goodsWorth"];
        if (self.yuEr.intValue<giftMoney.intValue) {
            
            [TanLiao_Common showToastView:@"余额不足请充值" view:self.view];






            self.chongZhiView.hidden = NO;
            self.closeChongZhiViewButton.hidden = NO;

            return;
        }
        
        
        
         //赠送礼物
            [self.cloudClient sendGift:@"8139"
                              anchorId:[self.anchorInfo objectForKey:@"anchorId"]
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
    
    [self getUserInfo];
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
    
    [TanLiao_Common showToastView:@"赠送礼物失败" view:self.view];








}
-(void)closeDaShangViewButtonClick
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
//-(void)boFang
//{
//    
//    NSNumber * money = [self.anchorInfo objectForKey:@"price"];
//    
//    NSString * moneyStr = [NSString stringWithFormat:@"%d",money.intValue*(boFangTime/60+1)];
//    
//    self.jinBiLable.text = [NSString stringWithFormat:@"%@%@",moneyStr,[Common getParamStr1]];
//    
//    boFangTime = boFangTime+1;
//    if (boFangTime<10) {
//        self.shiChangLable.text = [NSString stringWithFormat:@"00:0%d",boFangTime];


//    }
//    else
//    {
//    self.shiChangLable.text = [NSString stringWithFormat:@"00:%d",boFangTime];

//    }
//    if (boFangTime>endTime) {
//        
//        [self quXiaoHangup];
//    }
//}
//-(void)openOrCloseCameraButtonClick
//{
//    if (cameraOpen == YES) {
//        cameraOpen = NO;
//        [self.openOrCloseCameraButton setImage:[UIImage imageNamed:@"btn_open_video"] forState:UIControlStateNormal];
//        self.openOrCloseCameraLable.text = @"打开摄像头";
//        self.noCameraBottomView.hidden = NO;
//    }else{
//        self.noCameraBottomView.hidden = YES;
//        cameraOpen = YES;
//        // [self.localView.layer addSublayer:self.localVideoLayer];
   

//        [self.openOrCloseCameraButton setImage:[UIImage imageNamed:@"btn_close_video"] forState:UIControlStateNormal];
//        self.openOrCloseCameraLable.text = @"关闭摄像头";
//    }
//
//}
-(void)quXiaoHangup
{
    
    [self.delegate boFangShiPinFinished:self.anchorInfo];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.25;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    transition.type = kCATransitionPush;
    transition.subtype  = kCATransitionFromBottom;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popToRootViewControllerAnimated:NO];

    
//    if([@"shiPinXiuList" isEqualToString:self.fromWhere])
//    {
//        CATransition *transition = [CATransition animation];
//        transition.duration = 0.25;
//        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
//
//        transition.type = kCATransitionPush;
//        transition.subtype  = kCATransitionFromBottom;
//        [self.navigationController.view.layer addAnimation:transition forKey:nil];
//        self.navigationController.navigationBarHidden = YES;
//        [self.navigationController popViewControllerAnimated:NO];
//    }
//    else
//    {
//    CATransition *transition = [CATransition animation];
//    transition.duration = 0.25;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
//    transition.type = kCATransitionPush;
//    transition.subtype  = kCATransitionFromBottom;
//    [self.navigationController.view.layer addAnimation:transition forKey:nil];
//    self.navigationController.navigationBarHidden = YES;
//    [self.navigationController popViewControllerAnimated:NO];
//    }
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self removeNotification];
    //[self stopSession];
    [self.player pause];


    alsoPlay = NO;
    [self.layer removeFromSuperlayer];


    self.layer=nil;
    self.player=nil;
    
    [self.kouJinBiButton removeFromSuperview];
    [self.kaiTongVipButton removeFromSuperview];

}
-(void)addFriend
{
    self.nvJingView.hidden = NO;
}
-(void)openOrCloseVoice
{
    if (YES == voiceStatus) {
        [self.openOrCloseVoiceButton setImage:[UIImage imageNamed:@"btn_mac_close"] forState:UIControlStateNormal];
        voiceStatus = NO;
    }
    else
    {
        [self.openOrCloseVoiceButton setImage:[UIImage imageNamed:@"btn_mac_open"] forState:UIControlStateNormal];
        voiceStatus = YES;
        
    }

}
-(void)qieHuanJIngTou
{
    NSUInteger cameraCount = [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count];


 




    if (cameraCount > 1) {
        NSError *error;
        AVCaptureDeviceInput *newVideoInput;
        AVCaptureDevicePosition position = [[_videoInput device] position];
        
        if (position == AVCaptureDevicePositionBack)
            newVideoInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self frontCamera] error:&error];




        else if (position == AVCaptureDevicePositionFront)
            newVideoInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self backCamera] error:&error];






        else
            return;
        
        if (newVideoInput != nil) {
            [self.session beginConfiguration];
            [self.session removeInput:self.videoInput];


 





            if ([self.session canAddInput:newVideoInput]) {
                [self.session addInput:newVideoInput];


 

 



                [self setVideoInput:newVideoInput];




            } else {
                [self.session addInput:self.videoInput];






                
            }
            [self.session commitConfiguration];
        } else if (error) {
            NSLog(@"toggle carema failed, error = %@", error);
        }
    }
}
//返回前置摄像头
- (AVCaptureDevice *)frontCamera {
    return [self cameraWithPosition:AVCaptureDevicePositionFront];


 

 



}

//返回后置摄像头
- (AVCaptureDevice *)backCamera {
    return [self cameraWithPosition:AVCaptureDevicePositionBack];







}
//用来返回是前置摄像头还是后置摄像头
- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition) position {
    
    if (AVCaptureDevicePositionFront == position) {
        
        NSLog(@"前边");
        isFront = YES;
    }
    else
    {
        isFront = NO;
    }
    //返回和视频录制相关的所有默认设备
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    //遍历这些设备返回跟position相关的设备
    for (AVCaptureDevice *device in devices) {
        if ([device position] == position) {
            return device;
        }
    }
    return nil;
}




-(void)guanBiDaKaiCamera
{
    
    
    if (alreadCameraOpen == YES) {
        alreadCameraOpen = NO;
        [self.previewLayer removeFromSuperlayer];


 





    }
    else
    {
        alreadCameraOpen = YES;
        [self.containerView.layer addSublayer:self.previewLayer];



   




    }
}
-(void)beginChongZhi
{
    
    
    self.chongZhiView.hidden = NO;
    self.closeChongZhiViewButton.hidden = NO;
}





-(void)songLi
{
    self.chongZhiView.hidden = YES;
    self.closeChongZhiViewButton.hidden = YES;
    
    
    
    
    self.daShangView.hidden = NO;
    self.daShangBottomButtonView.hidden = NO;
    self.daShangBottomView.hidden = NO;
    self.closeDaShangViewButton.hidden = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
