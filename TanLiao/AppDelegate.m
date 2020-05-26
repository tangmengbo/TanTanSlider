//
//  AppDelegate.m
//  AppProduction
//
//  Created by mac on 16/7/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "AppDelegate.h"
#import "TanLiaoLiao_LoginViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import "OpenInstallSDK.h"
#import "UICKeyChainStore.h"
#import "NetworkManager.h"
#import "mjb_HomePageViewController.h"
#import "mjb_OwnerViewController.h"
#import "TalkingData.h"




NSString *NTESNotificationLogout = @"NTESNotificationLogout";

@interface AppDelegate ()


@end

@implementation AppDelegate

NSString *const shareSDKAppKey = SHARESDKAPPKEY;

//tmb
//shareSDK 注册方法
- (void)registerShare
{
    [ShareSDK registPlatforms:^(SSDKRegister *platformsRegister) {
        
        [platformsRegister setupQQWithAppId:QQAPPID appkey:QQAPPKey];
        [platformsRegister setupWeChatWithAppId:WXAPPID appSecret:WXAPPSecret];
        [platformsRegister setupSinaWeiboWithAppkey:WBAPPID appSecret:WBAPPSecret redirectUrl:@"http://www.sharesdk.cn"];
    }];

}

- (void)registerRongCloud {
    
    [[RongCloudManager getInstance] connectRongCloud];
}


-(void)registPushKit
{
    // nslog123
    UIUserNotificationSettings *userNotifiSetting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:userNotifiSetting];
    PKPushRegistry *pushRegistry = [[PKPushRegistry alloc] initWithQueue:nil];
    pushRegistry.delegate = self;
    pushRegistry.desiredPushTypes = [NSSet setWithObject:PKPushTypeVoIP];
    
}
//pushKit代理
- (void)pushRegistry:(PKPushRegistry *)registry didUpdatePushCredentials:(PKPushCredentials *)credentials forType:(NSString *)type{
    
    NSString * tokenString = [[[[credentials.token description] stringByReplacingOccurrencesOfString: @"<" withString: @""] stringByReplacingOccurrencesOfString: @">" withString: @""] stringByReplacingOccurrencesOfString: @" " withString: @""];
    NSData* token = [tokenString dataUsingEncoding:NSUTF8StringEncoding];
    [[NIMSDK sharedSDK] updateApnsToken:token];
    
}
 - (void)pushRegistry:(PKPushRegistry *)registry didReceiveIncomingPushWithPayload:(PKPushPayload *)payload forType:(NSString *)type
{

}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
    
    //网易注册app
    [[NIMSDK sharedSDK] registerWithAppID:WYYXAPPKey
                                  cerName:WYYCertificatePro];
    
    [[NIMSDK sharedSDK] currentLogFilepath];
    
    //注册talkingData
    [TalkingData sessionStarted:TalkingDataAppId withChannelId:@"TanLiao_1"];
    NSLog(@"网易云信sdk版本号%@",[[NIMSDK sharedSDK] sdkVersion]) ;
    //添加pushkit
    [self registPushKit];
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * userInfo = [defaults objectForKey:USERINFO];
    
    NSUserDefaults* loginStatusDefaults = [NSUserDefaults standardUserDefaults];
    NSString * loginStatusStr = [loginStatusDefaults objectForKey:LoginStatus];
    
    NSUserDefaults* introduceStatusDefaults = [NSUserDefaults standardUserDefaults];
    NSString * introducStatusStr = [introduceStatusDefaults objectForKey:IntroduceStatus];
    
    if (![@"introduce" isEqualToString:introducStatusStr]) {
        
        [self setIntroduceTabbar];
    }
    else
    {
    
    if ([userInfo isKindOfClass:[NSDictionary class]]&&[userInfo objectForKey:@"userId"] &&[@"1" isEqualToString:loginStatusStr]) {
        
        
        [self resetLoginTabBar];
        NSString *loginAccount = [userInfo objectForKey:@"userId"];
        NSString *loginToken   =  [userInfo objectForKey:@"face_token"];
        [[[NIMSDK sharedSDK] loginManager] login:loginAccount
                                           token:loginToken
                                      completion:^(NSError *error) {
                                          
                                          if (error == nil)
                                          {
                                              NSString *userID = [NIMSDK sharedSDK].loginManager.currentAccount;
                                              NSString *toast = [NSString stringWithFormat:@"网易云 登录成功 code: %zd",error.code];
                                              NSLog(@"%@||%@",toast,userID);
                                          }
                                          else
                                          {
                                              NSString *toast = [NSString stringWithFormat:@"网易云 登录失败 code: %zd",error.code];
                                              NSLog(@"%@",toast);                                      }
                                      }];
        
        [[RongCloudManager getInstance] connectRongCloud];

        
    }
    else
    {
        [self resetNotLoginTabBar];
    }
    
 }
    [self setupServices];
    [self registerAPNs];
    
    //注册shareSDK
    [self registerShare];
    
    
    //初始化OpenInstall
    [OpenInstallSDK setAppKey:OpenInstallAppKey withDelegate:self];
    [self.window makeKeyAndVisible];
    
    
     NSDictionary *remoteNotificationUserInfo = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
    
    if ([remoteNotificationUserInfo isKindOfClass:[NSDictionary class]]) {
        
         NSString *paramsStr = [NSString stringWithFormat:@"%@",[[remoteNotificationUserInfo objectForKey:@"aps"] objectForKey:@"alert"]];
        
       
        if ([paramsStr  containsString:@"等待你的回拨"]) {
            
            [self selectTabBarAtIndex:3];
            UINavigationController *  nav = [self.rootBar.viewControllers objectAtIndex:3];
            TanLiao_QiangBoViewController * photosVC = [[TanLiao_QiangBoViewController alloc] init];
            [nav pushViewController:photosVC animated:YES];

        }
    }
    
//每次启动摄像头如果关闭提示摄像头关闭
    NSUserDefaults * defaultsCamera = [NSUserDefaults standardUserDefaults];
    [defaultsCamera setObject:@"cameraCloesd" forKey:@"defaultsCamera"];
    [defaultsCamera synchronize];
    
    return YES;
}

#pragma mark - misc
- (void)registerAPNs
{
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    UIUserNotificationType types = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types
                                                                             categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
   
}

#pragma mark - ApplicationDelegate
- (void)applicationWillResignActive:(UIApplication *)application {
    
}

#pragma mark - logic impl
- (void)setupServices
{
    [[NTESNotificationCenter sharedCenter] start];
}
-(void)setTabBarHidden
{
    self.rootBar.bottomView.hidden = YES;
}
-(void)setTabBarShow
{
    self.rootBar.bottomView.hidden = NO;
}
-(void)selectTabBarAtIndex:(int)index
{
    [self.rootBar setItemSelected:index];
}
-(void)resetLoginTabBar
{
    
    //注册融云IMKit
   // [self registerRongCloud];
    if( [@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
    {
        
        mjb_HomePageViewController * homeVC = [[mjb_HomePageViewController alloc] init];
        UINavigationController * nav1 = [[UINavigationController alloc] initWithRootViewController:homeVC];
        
        TanLL_NoticeViewController * spxVC = [[TanLL_NoticeViewController alloc] init];
        UINavigationController * nav2 = [[UINavigationController alloc] initWithRootViewController:spxVC];
        
        ShenHeTrendsListViewController * centerVC = [[ShenHeTrendsListViewController alloc] init];
        UINavigationController * nav3 = [[UINavigationController alloc] initWithRootViewController:centerVC];
        
        mjb_OwnerViewController * chaterVC = [[mjb_OwnerViewController alloc] init];
        UINavigationController * nav4 = [[UINavigationController alloc] initWithRootViewController:chaterVC];
        
//        mjb_OwnerViewController * ownerVC = [[mjb_OwnerViewController alloc] init];
//        UINavigationController * nav5 = [[UINavigationController alloc] initWithRootViewController:ownerVC];
        
        NSArray * array = [[NSArray alloc] initWithObjects:nav1,nav2,nav3,nav4,nil];
        self.rootBar = [[SJTabBarController alloc] init];
        
        self.rootBar.viewControllers = array;
        self.window.rootViewController = self.rootBar;
    }
    else
    {
        UINavigationController * nav1;
        if ([@"2" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]])
        {
            HomePageViewController * homeVC = [[HomePageViewController alloc] init];
            nav1 = [[UINavigationController alloc] initWithRootViewController:homeVC];
            
        }
        else
        {
            TanLiaoLiao_NewHomeViewController * homeVC = [[TanLiaoLiao_NewHomeViewController alloc] init];
            nav1 = [[UINavigationController alloc] initWithRootViewController:homeVC];
            
        }
        TanLL_ShiPinXiuViewController * spxVC = [[TanLL_ShiPinXiuViewController alloc] init];
        UINavigationController * nav2 = [[UINavigationController alloc] initWithRootViewController:spxVC];
        
        TanLiaoLiao_RankingListViewController * centerVC = [[TanLiaoLiao_RankingListViewController alloc] init];
        UINavigationController * nav3 = [[UINavigationController alloc] initWithRootViewController:centerVC];
        
        TanLL_NoticeViewController * chaterVC = [[TanLL_NoticeViewController alloc] init];
        UINavigationController * nav4 = [[UINavigationController alloc] initWithRootViewController:chaterVC];
        
        TanLiao_OwnerViewController * ownerVC = [[TanLiao_OwnerViewController alloc] init];
        UINavigationController * nav5 = [[UINavigationController alloc] initWithRootViewController:ownerVC];
        
        NSArray * array = [[NSArray alloc] initWithObjects:nav1,nav2,nav3,nav4,nav5, nil];
        self.rootBar = [[SJTabBarController alloc] init];
        
        self.rootBar.viewControllers = array;
        self.window.rootViewController = self.rootBar;
        
    }
    

    
}
-(void)resetNotLoginTabBar
{
    
   TanLiaoLiao_LoginViewController   * loginVC = [[TanLiaoLiao_LoginViewController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
       self.window.rootViewController = nav;
}
-(void)setIntroduceTabbar
{
    TanLiaoLiao_IntroduceViewController   * introduceVC = [[TanLiaoLiao_IntroduceViewController alloc] init];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:introduceVC];
    self.window.rootViewController = nav;
}
- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary *)options {
    
    //判断是否通过OpenInstall URL Scheme 唤起App
    if ([[url description] rangeOfString:@"openlink.cc"].location != NSNotFound) {
        
        return   [OpenInstallSDK handLinkURL:url];
    }else{
        //自行处理；
        return YES;
    }
}
//注册用户通知设置
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[NIMSDK sharedSDK] updateApnsToken:deviceToken];
    NSString *token = [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<"
                                                                             withString:@""]
                        stringByReplacingOccurrencesOfString:@">"
                        withString:@""]
                       stringByReplacingOccurrencesOfString:@" "
                       withString:@""];
    
    [[RCIMClient sharedRCIMClient] setDeviceToken:token];
    
    
}
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
}
-(void)applicationDidEnterBackground:(UIApplication *)application
{

}
-(void)applicationWillEnterForeground:(UIApplication *)application
{

    
    [RCIM sharedRCIM].disableMessageAlertSound = YES;
     [[NSNotificationCenter defaultCenter] postNotificationName:@"CHECKNOWVERSION" object:nil];

}
- (void)applicationProtectedDataDidBecomeAvailable:(UIApplication *)application
{
   // [[NSNotificationCenter defaultCenter] postNotificationName:@"GETPUSHERBECOMEAVAILABLE" object:nil];

}
//openinstall 方法

//通过OpenInstall 获取自定义参数。
- (void)getInstallParamsFromOpenInstall:(NSDictionary *) params withError: (NSError *) error {
    if (!error) {
        NSLog(@"OpenInstall 自定义数据：%@", [params description]);
        
        if (params) {
           // NSString *paramsStr = [NSString stringWithFormat:@"%@",params];
            
            NSString * uniqueId = [params objectForKey:@"content"];
            NSUserDefaults * uniqueIdDefaults = [NSUserDefaults standardUserDefaults];
            [uniqueIdDefaults setObject:uniqueId forKey:UNIQUEID];
            [uniqueIdDefaults synchronize];
            
            
            NSString * channel = [params objectForKey:@"openinstallChannelCode"];
            //存储渠道号到本地,注册时提交给服务器
            NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:channel forKey:CHANNEL];
            [defaults synchronize];
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"安装参数" message:uniqueId preferredStyle:  UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }]];
            
            //弹出提示框(便于调试，调试完成后删除此代码)
          //  [self.window.rootViewController presentViewController:alert animated:true completion:nil];
            
        }
    } else {
        NSLog(@"OpenInstall error %@", error);
    }
}



//Universal Links 通用链接实现深度链接技术
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler
{
    //判断是否通过OpenInstall Universal Links 唤起App
    if ([[userActivity.webpageURL description] rangeOfString:@"openlink.cc"].location != NSNotFound) {
        
        return  [OpenInstallSDK continueUserActivity:userActivity];
        
    }else{
        //自行处理；
        return YES;
    }
}


//通过OpenInstall获取已经安装App被唤醒时的参数（如果是通过渠道页面唤醒App时，会返回渠道编号）,返回的数据中channelCode为渠道编号，bind为自定义参数
- (void)getWakeUpParamsFromOpenInstall: (NSMutableDictionary *) params withError: (NSError *) error{
    NSLog(@"OpenInstall 唤醒参数：%@",params );
    
    //弹出提示框(便于调试，调试完成后删除此代码)
    if (params) {
        NSString *paramsStr = [NSString stringWithFormat:@"%@",params];
        UIAlertController *testAlert = [UIAlertController alertControllerWithTitle:@"唤醒参数" message:paramsStr preferredStyle:  UIAlertControllerStyleAlert];
        [testAlert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        
        //[self.window.rootViewController presentViewController:testAlert animated:true completion:nil];
        
    }
    
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(nullable UIWindow *)window{
    if (_allowRotation == YES) {   // 如果属性值为YES,仅允许屏幕向左旋转,否则仅允许竖屏
        return UIInterfaceOrientationMaskLandscapeRight;  // 这里是屏幕要旋转的方向
    }else{
        return (UIInterfaceOrientationMaskPortrait);
    }
}

@end
