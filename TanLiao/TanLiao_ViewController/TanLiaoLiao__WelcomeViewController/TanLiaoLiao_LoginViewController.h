//
//  LoginViewController.h
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/11.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface TanLiaoLiao_LoginViewController : TanLiao_BaseViewController<CLLocationManagerDelegate,UIWebViewDelegate>
{
    BOOL getSignStatus;
    BOOL alsoCreateLoginButton;



    BOOL alsoShenHe;
}


@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;
@property(nonatomic,strong)UIButton * telLoginButton;


@property(nonatomic,strong)UILabel * telLoginLable;

@property(nonatomic,strong)NSString * authCode;

@property(nonatomic, strong) CLLocationManager *myLocation;




@property(nonatomic,strong)NSMutableDictionary * userInfoDic;

@property(nonatomic,strong)NSString * cityName;

@property(nonatomic,strong)UITextField * accountTextField;
@property(nonatomic,strong)UITextField * passWorldTextField;

@property(nonatomic,strong)UIImageView  * bottomImageView;

@property(nonatomic,strong)NSDictionary * ipInfo;



@end
