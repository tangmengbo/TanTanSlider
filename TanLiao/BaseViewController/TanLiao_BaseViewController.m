//
//  BaseViewController.m
//  SajiaoShopping
//
//  Created by 鸣 王 on 15/9/14.
//  Copyright (c) 2015年 唐蒙波. All rights reserved.
//

#import "TanLiao_BaseViewController.h"
#import "NTESVideoChatViewController.h"
#import "UIImage+GIF.h"

@interface TanLiao_BaseViewController ()

@end

@implementation TanLiao_BaseViewController

-(id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.baseCloudClient = [TanLiaoLiao_CloudClient getInstance];
    
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.rootBar = delegate.rootBar;
    
    self.statusBarView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 20)];
    self.statusBarView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.statusBarView];
    
    [self.navigationController setNavigationBarHidden:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navView = [[UIView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, VIEW_WIDTH, 44)];
    self.navView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.navView];
    
    
    self.titleLale = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 44)];
    self.titleLale.textColor = [UIColor blackColor];
    self.titleLale.textAlignment = NSTextAlignmentCenter;
    self.titleLale.font = [UIFont fontWithName:@"Helvetica-Bold" size:18*BILI];
    [self.navView addSubview:self.titleLale];
    
    
    self.leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0,  0, 60, 40)];
    [self.leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];
    self.leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.navView addSubview:self.leftButton];
    
    self.backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12*BILI, (40-18)/2, 18, 18)];
    self.backImageView.image = [UIImage imageNamed:@"btn_back_n"];
    [self.leftButton addSubview:self.backImageView];
    
    
    self.rightButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-40-10, 0, 50, 40)];
    [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.rightButton addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:self.rightButton];
    
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5, VIEW_WIDTH, 0.5)];
    self.lineView.backgroundColor = [UIColor blackColor];
    self.lineView.alpha = 0.2;
    [self.navView addSubview:self.lineView];
    
    self.loadingBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-60)];
    self.loadingBottomView.backgroundColor = [UIColor blackColor];
    self.loadingBottomView.alpha = 0.5;
    
    self.loadingView = [[UIView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-200)/2, (VIEW_HEIGHT-60-80)/2, 200, 70)];
    self.loadingView.backgroundColor = [UIColor blackColor];
    self.loadingView.layer.cornerRadius = 10;
    self.loadingView.alpha = 0.8;
    
    UIActivityIndicatorView * activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [activityView startAnimating];
    activityView.frame = CGRectMake(20, 25, 20, 20);
    [self.loadingView addSubview:activityView];
    
    self.tipLable = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 300, 70)];
     self.tipLable.text = @"正在加载...";
     self.tipLable.textColor = [UIColor whiteColor];
     self.tipLable.font = [UIFont systemFontOfSize:15];
    [self.loadingView addSubview: self.tipLable];
    
    self.gifLoadingImageView = [[UIImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-50*BILI)/2, (VIEW_HEIGHT-50*BILI)/2, 50*BILI, 50*BILI)];
    self.gifLoadingImageView.image = [UIImage imageNamed:@"loadingData"];
    
   

    
    
    

    
}
-(void)initQiangBoView
{
    [self.bottomView removeFromSuperview];
    [self.sliderScrollView removeFromSuperview];
    [self.allButton removeFromSuperview];
    //抢拨蒙层页面
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    self.bottomView.backgroundColor = [UIColor blackColor];
    self.bottomView.alpha = 0.6;
    [[UIApplication sharedApplication].keyWindow addSubview:self.bottomView];
    
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bottomViewTap)];
    [self.bottomView addGestureRecognizer:tap];
    
    self.sliderScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-260*BILI)/2, 222*BILI, 260*BILI, (183+77+2.5)*BILI)];
    self.sliderScrollView.showsVerticalScrollIndicator = FALSE;
    self.sliderScrollView.showsHorizontalScrollIndicator = FALSE;
    self.sliderScrollView.pagingEnabled = YES;
    self.sliderScrollView.clipsToBounds = NO;
    [[UIApplication sharedApplication].keyWindow addSubview:self.sliderScrollView];
    
    
    
    
    self.allButton = [[UIButton alloc] initWithFrame:CGRectMake(62.5*BILI, self.sliderScrollView.frame.origin.y+183*BILI+37*BILI/2, 45*BILI, 45*BILI)];
    [self.allButton addTarget:self action:@selector(allButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.allButton setBackgroundColor:[UIColor blackColor]];
    self.allButton.layer.cornerRadius = 45*BILI/2;
    self.allButton.alpha = 0.8;
    [self.allButton setTitle:@"全部" forState:UIControlStateNormal];
    [self.allButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.allButton.titleLabel.font = [UIFont systemFontOfSize:12*BILI];
    [[UIApplication sharedApplication].keyWindow addSubview:self.allButton];
    
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    
    if ([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]]) {
        
       // return UIStatusBarStyleLightContent;
         return UIStatusBarStyleDefault;

    }
    else
    {
        return UIStatusBarStyleDefault;

    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    //主播抢拨弹框
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushList) name:@"GETPUSHER" object:nil];

    //主播呼叫弹框
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showZhuBoHuJiaoView:) name:ZhuBoHuJiaoNotification object:nil];
    //主播推荐弹框
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(threeTuiJianPushToAnchorDetail:) name:@"threeTuiJianPushToAnchorDetail" object:nil];
    
    //主播端收到推送用户 不在首页时展示
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(baseViewuserCallWaitingNotification:) name:@"baseViewuserCallWaitingNotification" object:nil];


}
-(void)baseViewuserCallWaitingNotification:(NSNotification *)notification
{
    __weak typeof(self) wself = self;
    dispatch_sync(dispatch_get_main_queue(), ^{
        
        NSDictionary * detailInfo = [notification object];
        NSNumber * userId = [detailInfo objectForKey:@"userId"];
        [wself.hjView removeFromSuperview];
        wself.hjView = [[TanLiaoLiao_HuJiaoQingQiuView alloc] initWithFrame:CGRectMake(-VIEW_WIDTH, SafeAreaTopHeight+20*BILI, VIEW_WIDTH, 198*BILI/2)];
        wself.hjView.tag = userId.intValue;
        wself.hjView.delegate = self;
        [wself.hjView initHuJiaoTongJiView:detailInfo typeStr:@"baseViewFromNotification" tag:userId.intValue];
        [wself.view addSubview:self.hjView];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        wself.hjView.frame = CGRectMake(0, self.hjView.frame.origin.y, self.hjView.frame.size.width, self.hjView.frame.size.height);
        [UIView commitAnimations];
        
        UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:wself action:@selector(panGRAct:)];
        [wself.hjView setUserInteractionEnabled:YES];
        [wself.hjView addGestureRecognizer:panGR];


        [wself performSelector:@selector(removeFromSuperView:) withObject:userId afterDelay:5];
    });
    
    
    
}
-(void)removeFromSuperView:(NSNumber *)tagNumber
{
    if (tagNumber.intValue==self.hjView.tag) {
        __weak typeof(self) wself = self;
        [UIView animateWithDuration:0.5 animations:^{
            
            wself.hjView.frame = CGRectMake(VIEW_WIDTH, wself.hjView.frame.origin.y, wself.hjView.frame.size.width, wself.hjView.frame.size.height);
            
        } completion:^(BOOL finished) {
            
            [wself.hjView removeFromSuperview];
        }];

    }
}

- (void)panGRAct: (UIPanGestureRecognizer *)rec{
    
    
    CGPoint point = [rec translationInView:self.view];
    NSLog(@"%f,%f",point.x,point.y);
    rec.view.center = CGPointMake(rec.view.center.x + point.x, rec.view.center.y + point.y);
    [rec setTranslation:CGPointMake(0, 0) inView:self.view];
    
    if(rec.state == UIGestureRecognizerStateEnded || rec.state == UIGestureRecognizerStateCancelled)//拖动结束
    {

            [UIView animateWithDuration:0.5 animations:^{
                
                rec.view.frame = CGRectMake(VIEW_WIDTH,rec.view.frame.origin.y, rec.view.frame.size.width, rec.view.frame.size.height);
                
            } completion:^(BOOL finished) {
                
                [rec.view removeFromSuperview];
            }];

        
    }
}
-(void)jieTingHuJiaoView:(NSDictionary *)info
{
    [self.hjView removeFromSuperview];
        self.huJiaoUserInfo = info;
        NSNumber * userId = [info objectForKey:@"userId"];
        [self.baseCloudClient huJiaoTongJiTongHuaJiLu:@"8066"
                                         toUserId:[NSString stringWithFormat:@"%d",userId.intValue]
                                        call_type:@"B"
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
    
    NSNumber * userId = [self.huJiaoUserInfo objectForKey:@"userId"];
    NTESVideoChatViewController *vc = [[NTESVideoChatViewController alloc] initWithCallee:[NSString stringWithFormat:@"%d",userId.intValue]];
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
-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ZhuBoHuJiaoNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"threeTuiJianPushToAnchorDetail" object:nil];
    //主播抢拨弹框
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GETPUSHER" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"baseViewuserCallWaitingNotification" object:nil];

    
    
}
-(void)showZhuBoHuJiaoView:(NSNotification *)notification
{
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        
            UIApplicationState state = [UIApplication sharedApplication].applicationState;
            BOOL result = (state == UIApplicationStateActive);
            BOOL result1 = (state == UIApplicationStateBackground);
            if (result) {
                
                if (!alsoShowHuiBo) {
                    alsoShowHuiBo = YES;
                    
                    ////设置耳机声音和扬声器音
                    AVAudioSession *session = [AVAudioSession sharedInstance];
                    //默认打开扬声器
                    [session setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionMixWithOthers error:nil];
                    ////设置耳机声音和扬声器音
                    
                    NSDictionary * info = [notification object];
                    [self initLaiDianView:info];
                    NSURL *url = [[NSBundle mainBundle] URLForResource:@"wx" withExtension:@"mp3"];
                    self.player1 = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
                    self.player1.numberOfLoops = 200;
                    [self.player1 play];
                }
            }
            if (result1) {
                if (!alsoShowHuiBo) {
                    alsoShowHuiBo = YES;
                    NSDictionary * info = [notification object];
                    [self initLaiDianView:info];
                }
            }
      //  }
        
  
        
    });
    
}

-(void)tingZhiHuJiao
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"no" forKey:@"alsoShowHuiBo"];
    [defaults synchronize];
    alsoShowHuiBo = NO;
    [RCIM sharedRCIM].disableMessageAlertSound = YES;
    [self.player1 stop];
    self.player1 = nil;
    [self.laiDianBottomView removeFromSuperview];
    [self.laiDianView removeFromSuperview];
}
-(void)initLaiDianView:(NSDictionary *)info
{
    self.laiDianInfo = info;
    self.laiDianBottomView = [[UIView alloc] initWithFrame:CGRectMake(12*BILI, VIEW_HEIGHT-49-58*BILI, VIEW_WIDTH-24*BILI, 50*BILI)];
    self.laiDianBottomView.backgroundColor = [UIColor blackColor];
    self.laiDianBottomView.alpha = 0.7;
    self.laiDianBottomView.layer.cornerRadius = 8*BILI;
    self.laiDianBottomView.layer.masksToBounds = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:self.laiDianBottomView];
    
    self.laiDianView = [[UIView alloc] initWithFrame:CGRectMake(12*BILI, VIEW_HEIGHT-49-58*BILI, VIEW_WIDTH-24*BILI, 50*BILI)];
    self.laiDianView.backgroundColor = [UIColor clearColor];
    self.laiDianView.layer.cornerRadius = 8*BILI;
    self.laiDianView.layer.masksToBounds = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:self.laiDianView];
    
    TanLiaoCustomImageView * headerImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(12*BILI, 7*BILI, 36*BILI, 36*BILI)];
    headerImageView.urlPath = [info objectForKey:@"avatarUrl"];
    headerImageView.layer.cornerRadius = 18*BILI;
    headerImageView.layer.masksToBounds = YES;
    [self.laiDianView addSubview:headerImageView];
    
    UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x+headerImageView.frame.size.width+10*BILI, 17*BILI/2, 100, 15*BILI)];
    nameLable.textColor = [UIColor whiteColor];
    nameLable.font = [UIFont systemFontOfSize:15*BILI];
    nameLable.text = [info objectForKey:@"nick"];
    [self.laiDianView addSubview:nameLable];
    
    CGSize size = [TanLiao_Common setSize:[info objectForKey:@"nick"] withCGSize: CGSizeMake(VIEW_WIDTH, VIEW_HEIGHT) withFontSize:15*BILI];
    nameLable.frame = CGRectMake(nameLable.frame.origin.x, nameLable.frame.origin.y, size.width, nameLable.frame.size.height);
    
    UIImageView * sexAgeView = [[UIImageView alloc] initWithFrame:CGRectMake(nameLable.frame.origin.x+nameLable.frame.size.width+5*BILI, nameLable.frame.origin.y, 32*BILI, 15*BILI)];
    if ([@"0" isEqualToString:@"0"]) {
        
        sexAgeView.image = [UIImage imageNamed:@"pic_old_woman"];
        
    }
    else
    {
        sexAgeView.image = [UIImage imageNamed:@"pic_old_man"];
        
    }
    [self.laiDianView addSubview:sexAgeView];
    
    UILabel * ageLable = [[UILabel alloc] initWithFrame:CGRectMake(3, (sexAgeView.frame.size.height-(10*BILI))/2, 20, 10*BILI)];
    ageLable.font = [UIFont systemFontOfSize:10*BILI];
    ageLable.textColor = [UIColor whiteColor];
    [sexAgeView addSubview:ageLable];
    ageLable.adjustsFontSizeToFitWidth = YES;
    NSNumber * number = [info objectForKey:@"age"];
    ageLable.text = [NSString stringWithFormat:@"%d",number.intValue];
    
    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(nameLable.frame.origin.x, nameLable.frame.origin.y+nameLable.frame.size.height+4*BILI, 300*BILI, 9*BILI)];
    tipLable.textColor = [UIColor whiteColor];
    tipLable.font = [UIFont systemFontOfSize:9*BILI];
    tipLable.text = @"美女主播来电了";
    [self.laiDianView addSubview:tipLable];
    
    
    UIButton * jieShouButton = [[UIButton alloc] initWithFrame:CGRectMake(300*BILI, 7*BILI, 36*BILI, 36*BILI)];
    [jieShouButton setBackgroundImage:[UIImage imageNamed:@"btn_pop-up_connect"] forState:UIControlStateNormal];
    [jieShouButton addTarget:self action:@selector(jieShouButton) forControlEvents:UIControlEventTouchUpInside];
    [self.laiDianView addSubview:jieShouButton];
    
    UIButton * jvJueButton = [[UIButton alloc] initWithFrame:CGRectMake(492*BILI/2, 7*BILI, 36*BILI, 36*BILI)];
    [jvJueButton setBackgroundImage:[UIImage imageNamed:@"btn_pop-up_dropped"] forState:UIControlStateNormal];
    [jvJueButton addTarget:self action:@selector(jvJueButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.laiDianView addSubview:jvJueButton];
    
}
-(void)jieShouButton
{

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        
       // [self tingZhiHuJiao];
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@"no" forKey:@"alsoShowHuiBo"];
        [defaults synchronize];
        alsoShowHuiBo = NO;
        [RCIM sharedRCIM].disableMessageAlertSound = YES;
        [self.player1 stop];
        self.player1 = nil;
        [self.laiDianBottomView removeFromSuperview];
        [self.laiDianView removeFromSuperview];

        
        
        NSUserDefaults * nowMoneyDefaults = [NSUserDefaults standardUserDefaults];
        NSString * nowMoney = [nowMoneyDefaults objectForKey:@"nowMoneyNumber"];
        if (nowMoney.floatValue/JinBiBiLi>=3)
        {
            NSNumber * number = [self.laiDianInfo objectForKey:@"userId"];
            NTESVideoChatViewController *vc = [[NTESVideoChatViewController alloc] initWithCallee:[NSString stringWithFormat:@"%d",number.intValue]];
            CATransition *transition = [CATransition animation];
            transition.duration = 0.25;
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromTop;
            [self.navigationController.view.layer addAnimation:transition forKey:nil];
            self.navigationController.navigationBarHidden = YES;
            [self.navigationController pushViewController:vc animated:NO];
        }
        else
        {
            [TanLiao_Common showToastView:@"余额不足请充值" view:self.view];
            TanLiaoLiao_YuEBuZuView * tipView = [[TanLiaoLiao_YuEBuZuView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
            tipView.delegate = self;
            [self.view addSubview:tipView];
            
            
        }
        
});
    
    
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
    [self.baseCloudClient getWalletMes:[TanLiao_Common getNowUserID]
                             apiId:@"8005"
                          delegate:self
                          selector:@selector(getUserInformationSuccess:)
                     errorSelector:@selector(getUserInformationError:)];
    [TanLiao_Common showToastView:@"充值成功" view:self.view];
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
-(void)jvJueButtonClick
{
    //[self tingZhiHuJiao];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"no" forKey:@"alsoShowHuiBo"];
    [defaults synchronize];
    alsoShowHuiBo = NO;
    [RCIM sharedRCIM].disableMessageAlertSound = YES;
    [self.player1 stop];
    self.player1 = nil;
    [self.laiDianBottomView removeFromSuperview];
    [self.laiDianView removeFromSuperview];

    
}
-(void)threeTuiJianPushToAnchorDetail:(NSNotification *)notification
{
    NSString * userId = [notification object];
    TanLiaoLiao_AnchorDetailMessageViewController * vc = [[TanLiaoLiao_AnchorDetailMessageViewController alloc] init];
    vc.anchorId = userId;
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)leftClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightClick
{
    
}

-(void)showLoadingView:(NSString *)message view:(UIView *)view
{
   
    [self.view addSubview:self.loadingView];
    self.loadingView.hidden = NO;
    
}
-(void)hideLoadingView
{
    self.loadingView.hidden = YES;
}
-(void)showNewLoadingView:(NSString *)message view:(UIView *)view
{
    if ([message isKindOfClass:[NSString class]]) {
        
        self.tipLable.text = message;
    }
    else
    {
        self.tipLable.text = @"正在加载...";
    }
    self.loadingBottomView.frame = CGRectMake(0, self.loadingBottomView.frame.origin.y, VIEW_WIDTH, VIEW_HEIGHT-self.loadingBottomView.frame.origin.y);
    

    if ([@"yes" isEqualToString:self.loadingViewAlsoFullScreen]) {
        
        self.loadingBottomView.frame = CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT);
    }
    [self.view addSubview:self.loadingBottomView];
    [self.view addSubview:self.loadingView];
}
-(void)showApplicationLoadingView:(NSString *)message
{
    if ([message isKindOfClass:[NSString class]]) {
        
        self.tipLable.text = message;
    }
    else
    {
        self.tipLable.text = @"正在加载...";
    }
    self.loadingBottomView.frame = CGRectMake(0, self.loadingBottomView.frame.origin.y, VIEW_WIDTH, VIEW_HEIGHT-self.loadingBottomView.frame.origin.y);
    
    if ([@"910008" isEqualToString:[TanLiao_Common getNowUserID]]) {
        
        self.loadingBottomView.frame = CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT);
    }
    if ([@"yes" isEqualToString:self.loadingViewAlsoFullScreen]) {
        
        self.loadingBottomView.frame = CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT);
    }
    [[UIApplication sharedApplication].keyWindow addSubview:self.loadingBottomView];
    [[UIApplication sharedApplication].keyWindow addSubview:self.loadingView];

}
-(void)showLoginLoadingView:(NSString *)message view:(UIView *)view
{
    if ([message isKindOfClass:[NSString class]]) {
        
        self.tipLable.text = message;
    }
    else
    {
        self.tipLable.text = @"正在加载...";
    }
    self.loadingBottomView.frame = CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT);
    [self.view addSubview:self.loadingBottomView];
    [self.view addSubview:self.loadingView];
}
-(void)showLoadingGifView
{
    
    self.loadingBottomView.frame = CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT);
    [self.view addSubview:self.loadingBottomView];
    [self.view addSubview:self.gifLoadingImageView];
    
    CABasicAnimation* rotationAnimation;
    
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    
    rotationAnimation.duration = 9;
    
    rotationAnimation.cumulative = NO;
    
    //一直重复
    rotationAnimation.repeatCount = ULLONG_MAX;
    
    [self.gifLoadingImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];

}
-(void)hideNewLoadingView
{
    [self.loadingView removeFromSuperview];
    [self.loadingBottomView removeFromSuperview];
    [self.gifLoadingImageView removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)setTabBarHidden
{
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate setTabBarHidden];
}
-(void)setTabBarShow
{
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate setTabBarShow];
}
-(void)setSelectItem:(int)index
{
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate selectTabBarAtIndex:index];
}


-(void)pushList
{
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        if (![@"qunFaWaiting" isEqualToString:[defaults objectForKey:@"alsoQunFaWaiting"]])
        {
            
            [self initPushUserView];
            
            
        }
    });
    
}


-(void)initPushUserView
{
    
    [self initQiangBoView];
    
    NSUserDefaults * defaultsPush = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray * array = [defaultsPush objectForKey:@"pushList"];
    self.sourceArray = [defaultsPush objectForKey:@"pushList"];
    
    if (array.count>0) {
        
        for (int i=0; i<array.count; i++) {
            
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake((260*BILI)*i, 0, 250*BILI, 183*BILI)];
            imageView.image = [UIImage imageNamed:@"pic_qb"];
            [self.sliderScrollView addSubview:imageView];
            
            
            
            NSDictionary * info = [array objectAtIndex:i];
            
            TanLiaoCustomImageView * headerImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(80*BILI, 16*BILI, 90*BILI, 90*BILI)];
            headerImageView.imgType = IMAGEVIEW_TYPE_CENTER;
            headerImageView.urlPath = [info objectForKey:@"avatarUrl"];
            headerImageView.contentMode = UIViewContentModeScaleAspectFill;
            [imageView addSubview:headerImageView];
            
            
            
            
            CGSize size = [TanLiao_Common setSize:[info objectForKey:@"nick"] withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_HEIGHT) withFontSize:15*BILI];
            UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(16*BILI, 116*BILI, size.width, 15*BILI)];
            nameLable.font = [UIFont systemFontOfSize:15*BILI];
            nameLable.textColor = UIColorFromRGB(0x291A33);
            nameLable.text = [info objectForKey:@"nick"];
            [imageView addSubview:nameLable];
            
            
            
            UIImageView * sexAgeView = [[UIImageView alloc] initWithFrame:CGRectMake(nameLable.frame.origin.x+nameLable.frame.size.width+3*BILI, nameLable.frame.origin.y, 32*BILI, 15*BILI)];
            if ([@"0" isEqualToString:[info objectForKey:@"sex"]]) {
                
                sexAgeView.image = [UIImage imageNamed:@"pic_old_woman"];
                
            }
            else
            {
                sexAgeView.image = [UIImage imageNamed:@"pic_old_man"];
                
            }
            [imageView addSubview:sexAgeView];
            
            
            
            
            UILabel * ageLable = [[UILabel alloc] initWithFrame:CGRectMake(3, (sexAgeView.frame.size.height-(10*BILI))/2, 20, 10*BILI)];
            ageLable.font = [UIFont systemFontOfSize:10*BILI];
            ageLable.textColor = [UIColor whiteColor];
            [sexAgeView addSubview:ageLable];
            
            
            ageLable.adjustsFontSizeToFitWidth = YES;
            NSNumber * number = [info objectForKey:@"age"];
            ageLable.text = [NSString stringWithFormat:@"%d",number.intValue];
            
            UILabel * cityLable = [[UILabel alloc] initWithFrame:CGRectMake(nameLable.frame.origin.x, nameLable.frame.size.height+nameLable.frame.origin.y+5*BILI, 200, 12*BILI)];
            cityLable.font = [UIFont systemFontOfSize:12*BILI];
            cityLable.textColor = UIColorFromRGB(0x291A33);
            cityLable.text = [info objectForKey:@"cityName"];
            [imageView addSubview:cityLable];
            
            
            
            
            UIButton * qiangBoButton = [[UIButton alloc] initWithFrame:CGRectMake(imageView.frame.origin.x+(imageView.frame.size.width-77*BILI)/2, imageView.frame.origin.y+imageView.frame.size.height+2.5*BILI, 77*BILI, 77*BILI)];
            [qiangBoButton setBackgroundImage:[UIImage imageNamed:@"btn_qb"] forState:UIControlStateNormal];
            [qiangBoButton setTitle:@"抢拨" forState:UIControlStateNormal];
            [qiangBoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            qiangBoButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
            qiangBoButton.tag = i;
            [qiangBoButton addTarget:self action:@selector(qiangDanButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            
            
            
            [self.sliderScrollView addSubview:qiangBoButton];
            
            [self.sliderScrollView setContentSize:CGSizeMake(array.count*(260*BILI)+10*BILI, self.sliderScrollView.frame.size.height)];
            if (array.count>=3) {
                
                [self.sliderScrollView setContentOffset:CGPointMake(260*BILI, 0) animated:YES];
            }
        }
        
    }
    
    
}
-(void)bottomViewTap
{
    NSUserDefaults * defaultsPush = [NSUserDefaults standardUserDefaults];
    [defaultsPush removeObjectForKey:@"pushList"];
    [defaultsPush synchronize];
    
    
    
    
    [self.bottomView removeFromSuperview];
    [self.sliderScrollView removeFromSuperview];
    [self.allButton removeFromSuperview];
    
    
}
-(void)allButtonClick
{
    
    
    NSUserDefaults * defaultsPush = [NSUserDefaults standardUserDefaults];
    [defaultsPush removeObjectForKey:@"pushList"];
    [defaultsPush synchronize];
    
    [self.bottomView removeFromSuperview];
    [self.sliderScrollView removeFromSuperview];
    [self.allButton removeFromSuperview];
    
    
    
    TanLiao_QiangBoViewController * photosVC = [[TanLiao_QiangBoViewController alloc] init];
    [self.navigationController pushViewController:photosVC animated:YES];
    
    
}
-(void)qiangDanButtonClick:(id)sender
{
    
    [self.bottomView removeFromSuperview];
    [self.sliderScrollView removeFromSuperview];
    [self.allButton removeFromSuperview];
    
    NSUserDefaults * defaultsPush = [NSUserDefaults standardUserDefaults];
    [defaultsPush removeObjectForKey:@"pushList"];
    [defaultsPush synchronize];
    
    
    UIButton * button = (UIButton *)sender;
    NSDictionary * info = [self.sourceArray objectAtIndex:button.tag];
    
    NSNumber * idNumber = [info objectForKey:@"from_userId"];
    self.qiangBoIdStr = [NSString stringWithFormat:@"%d",idNumber.intValue];
    
    
    if ([@"C" isEqualToString:[TanLiao_Common getRoleStatus]])
    {
        
        [self.baseCloudClient huJiaoTongJiTongHuaJiLu:@"8066"
                                             toUserId:self.qiangBoIdStr
                                            call_type:@"C"
                                             delegate:self
                                             selector:@selector(huJiaoSuccess:)
                                        errorSelector:@selector(huJiaoError:)];
    }
    else
    {
        [self.baseCloudClient huJiaoTongJiTongHuaJiLu:@"8066"
                                             toUserId:self.qiangBoIdStr
                                            call_type:@"B"
                                             delegate:self
                                             selector:@selector(huJiaoSuccess:)
                                        errorSelector:@selector(huJiaoError:)];
    }
    
    
    
    
    
    
}
-(void)huJiaoSuccess:(NSDictionary *)info
{
    
    NSString *  recordId = [info objectForKey:@"recordId"];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:recordId forKey:@"tongHuaJiLuRecordId"];
    [defaults synchronize];
    
    
    NTESVideoChatViewController *vc = [[NTESVideoChatViewController alloc] initWithCallee:self.qiangBoIdStr];
    
    if ([@"C" isEqualToString:[TanLiao_Common getRoleStatus]]) {
        
        vc.videoOrAudio = @"audio";
    }
    else
    {
        vc.videoOrAudio = @"video";
    }
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.25;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController pushViewController:vc animated:NO];
    
    
    
}
-(void)huJiaoError:(NSDictionary *)info
{
    
    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];
}


@end
