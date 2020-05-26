//
//  AppDelegate.h
//  AppProduction
//
//  Created by mac on 16/7/28.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import "RongCloudManager.h"
//微信SDK头文件
#import "WXApi.h"
#import "WeiboSDK.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <PushKit/PushKit.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate,PKPushRegistryDelegate,UIWebViewDelegate>
{
    int count;
}

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong)SJTabBarController * rootBar;

@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;


- (void)setTabBarHidden;
-(void)setTabBarShow;
-(void)selectTabBarAtIndex:(int)index;

-(void)resetLoginTabBar;
-(void)resetNotLoginTabBar;

- (void)registerRongCloud;


@property(nonatomic,strong)UIView * bottomView;
@property(nonatomic,strong)UIView * sliderScrollBottomView;
@property(nonatomic,strong)UIScrollView * sliderScrollView;
@property(nonatomic,strong)UIButton * allButton ;

@property(nonatomic,assign)BOOL allowRotation;//是否允许转向

@end

