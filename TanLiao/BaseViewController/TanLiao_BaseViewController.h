//
//  BaseViewController.h
//  SajiaoShopping
//
//  Created by 鸣 王 on 15/9/14.
//  Copyright (c) 2015年 唐蒙波. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SJTabBarController.h"
#import "Header.h"
#import <AVFoundation/AVFoundation.h>
#import "TanLiaoLiao_YuEBuZuView.h"
#import "TanLiaoLiao_HuJiaoQingQiuView.h"

@interface TanLiao_BaseViewController : UIViewController<UIGestureRecognizerDelegate,YuEBuZuViewDelegate,HuJiaoQingQiuViewDelegate>
{
    //是否展示回拨提示
    BOOL alsoShowHuiBo;
}
@property (nonatomic, strong)TanLiaoLiao_CloudClient * baseCloudClient;
@property (nonatomic, strong)UIView * navView;
@property (nonatomic,strong)UIView  * statusBarView;
@property (nonatomic,strong)UIButton * leftButton;
@property (nonatomic,strong)UIImageView * backImageView;
@property (nonatomic,strong)UIButton * rightButton;
@property (nonatomic,strong)UILabel * titleLale;
@property (nonatomic,strong)SJTabBarController * rootBar;
@property (nonatomic,strong)UIView * lineView;

@property (nonatomic,strong)UILabel * tipLable;
@property (nonatomic,strong)UIView * loadingView;

@property (nonatomic,strong)UIView * loadingBottomView;

@property(nonatomic,strong)NSString * loadingViewAlsoFullScreen;

-(void)showHUDWithMessage:(NSString *)message view:(UIView *)view;
-(void)hideHUD;
-(void)showLoadingView:(NSString *)message view:(UIView *)view;
-(void)hideLoadingView;

-(void)showNewLoadingView:(NSString *)message view:(UIView *)view;
-(void)showApplicationLoadingView:(NSString *)message ;
-(void)showLoginLoadingView:(NSString *)message view:(UIView *)view;
-(void)hideNewLoadingView;

-(void)setTabBarHidden;
-(void)setTabBarShow;
-(void)setSelectItem:(int)index;

@property(nonatomic,strong)UIImageView * gifLoadingImageView;
-(void)showLoadingGifView;
-(void)hideLoadingGifView;

@property(nonatomic,strong)UIView * laiDianBottomView;
@property(nonatomic,strong)UIView * laiDianView;

@property(nonatomic,strong)NSDictionary * laiDianInfo;

@property(nonatomic,strong)AVAudioPlayer * player1;

//主播抢拨

@property(nonatomic,strong)UIView * bottomView;
@property(nonatomic,strong)UIScrollView * sliderScrollView;
@property(nonatomic,strong)UIButton * allButton ;
@property(nonatomic,strong)NSString * qiangBoIdStr;
@property(nonatomic,strong)NSArray * sourceArray;
//主播抢拨

//用户推送
@property(nonatomic,strong)NSDictionary * huJiaoUserInfo;
@property(nonatomic,strong)TanLiaoLiao_HuJiaoQingQiuView *  hjView;


@end
