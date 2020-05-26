////
//  LoginViewController.m
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/11.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiaoLiao_LoginViewController.h"
// 导入头文件
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>
#import "UICKeyChainStore.h"
#import <AdSupport/AdSupport.h>
#import <CoreTelephony/CTCellularData.h>


@interface TanLiaoLiao_LoginViewController ()

@end

@implementation TanLiaoLiao_LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navView.hidden = YES;
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];

    [self.cloudClient setToastView:self.view];


    self.loadingViewAlsoFullScreen = @"yes";
    
    self.cityName = @"火星";
    
    self.bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    //self.bottomImageView.image = [UIImage imageNamed:@"login_bgip6s"];
    [self.view addSubview:self.bottomImageView];


    UIView * clickView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    clickView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:clickView];


    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bottomTap)];
    [clickView addGestureRecognizer:tap];
    
    //[self leftSlider];

    
    UIImageView * logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-216*BILI/2)/2, 54*BILI, 216*BILI/2,300*BILI/2)];
    logoImageView.image = [UIImage imageNamed:@"login_logo"];
    [self.view addSubview:logoImageView];

    
//    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
//    NSString *firstIn = [defaults objectForKey:@"firstIn"];
//    if([@"firstIn" isEqualToString:firstIn])
//    {
//        [self getShenHeStatus];

//    }
//    else
//    {
//        [self getWangLuoQuanXian];
//    }
    [self getShenHeStatus];

}
-(void)leftSlider
{
    [UIView animateWithDuration:5
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         self.bottomImageView.frame = CGRectMake(-80, 0, VIEW_WIDTH+80, VIEW_HEIGHT);
                         
                     } completion:^(BOOL finished) {
                         
                         [self rightSlider];

                     }];
}
-(void)rightSlider
{
    [UIView animateWithDuration:5
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         self.bottomImageView.frame = CGRectMake(0, 0, VIEW_WIDTH+80, VIEW_HEIGHT);
                         
                     } completion:^(BOOL finished) {
                         
                         [self leftSlider];


                         
                     }];
}


-(void)getWangLuoQuanXian
{
    


    CTCellularData *cellularData = [[CTCellularData alloc]init];

    cellularData.cellularDataRestrictionDidUpdateNotifier =  ^(CTCellularDataRestrictedState state){
        //状态改变时进行相关操作
        switch (state) {
            case kCTCellularDataRestricted:
                NSLog(@"受限");
                 [TanLiao_Common showAlert:@"网络访问权限未打开" message:@"请在设置中打开探聊的网络访问权限"];
                //[self getWangLuoQuanXian];
                break;
            case kCTCellularDataNotRestricted:
                NSLog(@"不受限");
                [self getShenHeStatus];

                break;
            case kCTCellularDataRestrictedStateUnknown:
                NSLog(@"未知");
                [self getWangLuoQuanXian];
                break;
            default:
                break;
        }
        
    };
}


-(void)getShenHeStatus
{
    NSString *versionAgent = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
    NSLog(@"当前应用软件版本:%@",versionAgent);
    
    [self.cloudClient shenHeStatus:@"8200"
                           version:versionAgent
                            chanel:@"appstore"
                           appName:APPNAME
                          delegate:self
                          selector:@selector(getShenHeStatusSuccess:)
                     errorSelector:@selector(getShenHeStatusError:)];
}
-(void)bottomTap
{
    


    [self.passWorldTextField resignFirstResponder];
    [self.accountTextField resignFirstResponder];

}

-(void)getShenHeStatusSuccess:(NSDictionary *)info
{
    
    NSUserDefaults * jinbiDefaults = [NSUserDefaults standardUserDefaults];
    [jinbiDefaults setObject:[info objectForKey:@"iosCheckParameter1"] forKey:@"iosCheckParameter1"];//jinbi
    [jinbiDefaults synchronize];

    
    
    NSUserDefaults * fenZhongDefaults = [NSUserDefaults standardUserDefaults];

    [fenZhongDefaults setObject:[info objectForKey:@"iosCheckParameter2"] forKey:@"iosCheckParameter2"];//fenzhong
    [fenZhongDefaults synchronize];


    
    
    NSUserDefaults * chongZhiDefaults = [NSUserDefaults standardUserDefaults];
    [chongZhiDefaults setObject:[info objectForKey:@"iosCheckParameter3"] forKey:@"iosCheckParameter3"];//chongzhi
    [chongZhiDefaults synchronize];

    
    NSUserDefaults * yuErDefaults = [NSUserDefaults standardUserDefaults];

    [yuErDefaults setObject:[info objectForKey:@"iosCheckParameter4"] forKey:@"iosCheckParameter4"];//余额
    [yuErDefaults synchronize];


    
    
    NSUserDefaults * getIpParameterDefaults = [NSUserDefaults standardUserDefaults];
    [getIpParameterDefaults setObject:[info objectForKey:@"getIpParameter1"] forKey:@"getIpParameterDefaultsKey"];//搜狐的获取ip连接
    [getIpParameterDefaults synchronize];
    
    NSString * iosV = [info objectForKey:@"status"];
    
    UIImageView * accountImageView = [[UIImageView alloc] initWithFrame:CGRectMake(133*BILI/2, 566*BILI/2, 17*BILI, 20*BILI)];
    accountImageView.image = [UIImage imageNamed:@"icon_zhanghu"];
    accountImageView.alpha = 0.6;
    [self.view addSubview:accountImageView];

    
    self.accountTextField = [[UITextField alloc] initWithFrame:CGRectMake(accountImageView.frame.origin.x+accountImageView.frame.size.width+12*BILI, accountImageView.frame.origin.y, 244*BILI-(accountImageView.frame.origin.x+accountImageView.frame.size.width+12*BILI), 20*BILI)];
    self.accountTextField.font = [UIFont systemFontOfSize:15*BILI];
    self.accountTextField.placeholder = @"请输入您的账号";
    self.accountTextField.textColor = UIColorFromRGB(0x333333);
    [self.accountTextField setValue:UIColorFromRGB(0xc6c6c6) forKeyPath:@"_placeholderLabel.textColor"];
    [self.view addSubview:self.accountTextField];
    
    UIView * telBottomLineView = [[UIView alloc] initWithFrame:CGRectMake(130*BILI/2, 617*BILI/2, 244*BILI, 1*BILI)];
    telBottomLineView.alpha = 0.1;
    telBottomLineView.backgroundColor = [UIColor blackColor];

    [self.view addSubview:telBottomLineView];
    
    UIImageView * pwImageView = [[UIImageView alloc] initWithFrame:CGRectMake(accountImageView.frame.origin.x, telBottomLineView.frame.origin.y+telBottomLineView.frame.size.height+59*BILI/2, 17*BILI, 20*BILI)];
    pwImageView.image = [UIImage imageNamed:@"icon_mima"];
    pwImageView.alpha = 0.6;
    [self.view addSubview:pwImageView];

    
    self.passWorldTextField = [[UITextField alloc] initWithFrame:CGRectMake(pwImageView.frame.origin.x+pwImageView.frame.size.width+12*BILI, pwImageView.frame.origin.y, 244*BILI-(pwImageView.frame.origin.x+pwImageView.frame.size.width+12*BILI), 20*BILI)];
    self.passWorldTextField.font = [UIFont systemFontOfSize:15*BILI];
    self.passWorldTextField.placeholder = @"请输入您的密码";
    self.passWorldTextField.secureTextEntry = YES;
    self.passWorldTextField.textColor = UIColorFromRGB(0x333333);
    [self.passWorldTextField setValue:UIColorFromRGB(0xc6c6c6) forKeyPath:@"_placeholderLabel.textColor"];
    [self.view addSubview:self.passWorldTextField];
    
    UIButton * forgetPassWorldButton = [[UIButton alloc] initWithFrame:CGRectMake(498*BILI/2, telBottomLineView.frame.origin.y+telBottomLineView.frame.size.height+25*BILI, 70*BILI, 30*BILI)];
    [forgetPassWorldButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    forgetPassWorldButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [forgetPassWorldButton setTitleColor:UIColorFromRGB(0x959595) forState:UIControlStateNormal];
    [forgetPassWorldButton addTarget:self action:@selector(forgetPassWorldButtonClick) forControlEvents:UIControlEventTouchUpInside];



    forgetPassWorldButton.alpha = 0.6;
    forgetPassWorldButton.titleLabel.font = [UIFont systemFontOfSize:15*BILI];
    [self.view addSubview:forgetPassWorldButton];
    
    
    UIView * checkNumberBottomView = [[UIView alloc] initWithFrame:CGRectMake(telBottomLineView.frame.origin.x, telBottomLineView.frame.origin.y+telBottomLineView.frame.size.height+111*BILI/2, 244*BILI, 1*BILI)];
    checkNumberBottomView.alpha = 0.1;
    checkNumberBottomView.backgroundColor = [UIColor blackColor];

    [self.view addSubview:checkNumberBottomView];

    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];


    NSDictionary * accountInfo = [defaults objectForKey:UserAccountAndPassWorld];
    if (accountInfo)
    {
        
        self.accountTextField.text = [accountInfo objectForKey:@"userId"];
        self.passWorldTextField.text =  [accountInfo objectForKey:@"password"];
    }
    
    UIButton * registerButton = [[UIButton alloc] initWithFrame:CGRectMake(64*BILI, checkNumberBottomView.frame.origin.y+ checkNumberBottomView.frame.size.height+27*BILI, 100*BILI, 40*BILI)];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    [registerButton setBackgroundColor:UIColorFromRGB(0xE1E1E1)];
    registerButton.layer.cornerRadius = 20*BILI;
    registerButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
    [registerButton addTarget:self action:@selector(registerButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerButton];
    
    
    self.telLoginButton = [[UIButton alloc] initWithFrame:CGRectMake(211*BILI, checkNumberBottomView.frame.origin.y+ checkNumberBottomView.frame.size.height+27*BILI, 100*BILI, 40*BILI)];
    self.telLoginButton.backgroundColor = UIColorFromRGB(0xFF9D56);
    self.telLoginButton.layer.cornerRadius = 20*BILI;
    [self.telLoginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.telLoginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.telLoginButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
    [self.telLoginButton addTarget:self action:@selector(telLoginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.telLoginButton];
    
    if (![@"1" isEqualToString:iosV]) {//1是审核中
        
        NSUserDefaults * shenHeDefaults = [NSUserDefaults standardUserDefaults];
        [shenHeDefaults setObject:@"shenHeFinish" forKey:@"appAlsoInreview"];
        [shenHeDefaults synchronize];
        self.ipInfo = [TanLiao_Common deviceWANIPAdress];
        if(self.ipInfo)
        {
            NSString *appcode = [info objectForKey:@"android_get_ip_key"];
            NSString *url = [NSString stringWithFormat:@"%@%@",[info objectForKey:@"getIpParameter2"],[self.ipInfo objectForKey:@"cip"]];
            //getIpParameter2 阿里云根据ip获取国家名连接,cip app的key,在阿里云市场创建app获取到
            //@"getIpParameter2" : @"https://dm-81.data.aliyun.com/rest/160601/ip/getIpInfo.json?ip="
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: url]  cachePolicy:1  timeoutInterval:  5];
            request.HTTPMethod  =  @"GET";
            [request addValue:  [NSString  stringWithFormat:@"APPCODE %@" ,  appcode]  forHTTPHeaderField:  @"Authorization"];
            NSURLSession *requestSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
            __weak typeof(self) weakSelf = self;
            
            NSURLSessionDataTask *task = [requestSession dataTaskWithRequest:request
                                                           completionHandler:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                               NSLog(@"Response object: %@" , response);
                                                               NSString *bodyString = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
                                                               NSDictionary * info = [TanLiao_Common dictionaryWithJsonString:bodyString];
                                                               weakSelf.ipInfo = [info objectForKey:@"data"];
                                                               NSString * country = [weakSelf.ipInfo objectForKey:@"country"];
                                                               //打印应答中的body
                                                               if(![@"美国" isEqualToString:country])
                                                               {
                                                                   dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                                                                       
                                                                       [weakSelf addSanFangDengLu];
                                                                   });
                                                                   
                                                               }
                                                               else
                                                               {
                                                                   NSUserDefaults * shenHeDefaults = [NSUserDefaults standardUserDefaults];

                                                                   [shenHeDefaults setObject:@"shenHeZhong" forKey:@"appAlsoInreview"];
                                                                   [shenHeDefaults synchronize];
                                                               }
                                                           }];
            
            [task resume];

        }
        else
        {
            [self addSanFangDengLu];
        }
        
    }
    else
    {
        NSUserDefaults * shenHeDefaults = [NSUserDefaults standardUserDefaults];

        [shenHeDefaults setObject:@"shenHeZhong" forKey:@"appAlsoInreview"];
        [shenHeDefaults synchronize];

        
    }
    
    UILabel * xieYiLiuLanLable = [[UILabel alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT-50*BILI,VIEW_WIDTH, 50*BILI)];
    xieYiLiuLanLable.textColor = UIColorFromRGB(0xFF9D56);
    xieYiLiuLanLable.font = [UIFont systemFontOfSize:12*BILI];
    xieYiLiuLanLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:xieYiLiuLanLable];

    
    NSString * str = @"登录即代表您同意《探聊用户协议》";
    NSAttributedString * str1 = [[NSAttributedString alloc] initWithString:str];

    NSMutableAttributedString * text1 = [[NSMutableAttributedString alloc] initWithAttributedString:str1];
    
    [text1 addAttribute:NSForegroundColorAttributeName
                  value:UIColorFromRGB(0x959595)
                  range:NSMakeRange(0, 8)];
    xieYiLiuLanLable.attributedText = text1;
    
    UIButton * yongHuXieYiButton = [[UIButton alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT-50*BILI,VIEW_WIDTH, 50*BILI)];
    yongHuXieYiButton.titleLabel.font = [UIFont systemFontOfSize:12*BILI];
    [yongHuXieYiButton addTarget:self action:@selector(agreeMentButtonClick) forControlEvents:UIControlEventTouchUpInside];
    yongHuXieYiButton.backgroundColor = [UIColor clearColor];
    [self.view addSubview:yongHuXieYiButton];

    
}
-(void)addSanFangDengLu
{
    [self getCurrentLocation];
    
    UIView * lineView1 = [[UIView alloc] initWithFrame:CGRectMake(31*BILI, VIEW_HEIGHT-143*BILI-40*BILI+40*BILI+26*BILI-20*BILI, 107*BILI, 1*BILI)];
    lineView1.backgroundColor = UIColorFromRGB(0xD5D5D5);
    [self.view addSubview:lineView1];
    
    UIView * lineView2 = [[UIView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-107*BILI-31*BILI, lineView1.frame.origin.y, 107*BILI, 1*BILI)];
    lineView2.backgroundColor = UIColorFromRGB(0xD5D5D5);
    [self.view addSubview:lineView2];
    
    UILabel * loginLable = [[UILabel alloc] initWithFrame:CGRectMake(lineView1.frame.origin.x+lineView1.frame.size.width, VIEW_HEIGHT-143*BILI-40*BILI+40*BILI+17*BILI-20*BILI, 72*BILI+13*BILI*2, 18*BILI)];
    loginLable.font = [UIFont systemFontOfSize:18*BILI];
    loginLable.textAlignment = NSTextAlignmentCenter;
    loginLable.alpha = 0.5;
    loginLable.textColor = UIColorFromRGB(0x333333);
    loginLable.text = @"一键登录";
    [self.view addSubview:loginLable];



    
    UIButton * faceButton = [[UIButton alloc] initWithFrame:CGRectMake(163*BILI/2, VIEW_HEIGHT-87*BILI/2-40*BILI-20*BILI, 40*BILI, 40*BILI)];
    [faceButton setBackgroundImage:[UIImage imageNamed:@"btn_key_QQ_n"] forState:UIControlStateNormal];
    [faceButton addTarget:self action:@selector(qqButtonClick) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:faceButton];
    
    UIButton * twitterButton = [[UIButton alloc] initWithFrame:CGRectMake(163*BILI/2+40*BILI+46*BILI+40*BILI+46*BILI, VIEW_HEIGHT-87*BILI/2-40*BILI-20*BILI, 40*BILI, 40*BILI)];
    [twitterButton setBackgroundImage:[UIImage imageNamed:@"btn_key_weibo_n"] forState:UIControlStateNormal];
    [twitterButton addTarget:self action:@selector(sinaButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:twitterButton];
    
    
    UIButton * wechatButton = [[UIButton alloc] initWithFrame:CGRectMake(163*BILI/2+40*BILI+46*BILI, VIEW_HEIGHT-87*BILI/2-40*BILI-20*BILI, 40*BILI, 40*BILI)];
    [wechatButton setBackgroundImage:[UIImage imageNamed:@"btn_wexin"] forState:UIControlStateNormal];
    [wechatButton addTarget:self action:@selector(wechatButtonClick) forControlEvents:UIControlEventTouchUpInside];


    [self.view addSubview:wechatButton];
}


-(void)getShenHeStatusError:(NSDictionary *)info
{
    


    UIImageView * accountImageView = [[UIImageView alloc] initWithFrame:CGRectMake(133*BILI/2, 566*BILI/2, 17*BILI, 20*BILI)];
    accountImageView.image = [UIImage imageNamed:@"icon_zhanghu"];
    accountImageView.alpha = 0.6;
    [self.view addSubview:accountImageView];

    
    self.accountTextField = [[UITextField alloc] initWithFrame:CGRectMake(accountImageView.frame.origin.x+accountImageView.frame.size.width+12*BILI, accountImageView.frame.origin.y, 244*BILI-(accountImageView.frame.origin.x+accountImageView.frame.size.width+12*BILI), 20*BILI)];
    self.accountTextField.font = [UIFont systemFontOfSize:15*BILI];
    self.accountTextField.placeholder = @"请输入您的账号";
    self.accountTextField.textColor = UIColorFromRGB(0x333333);
    [self.accountTextField setValue:UIColorFromRGB(0xc6c6c6) forKeyPath:@"_placeholderLabel.textColor"];
    [self.view addSubview:self.accountTextField];
    
    UIView * telBottomLineView = [[UIView alloc] initWithFrame:CGRectMake(130*BILI/2, 617*BILI/2, 244*BILI, 1*BILI)];
    telBottomLineView.alpha = 0.1;
    telBottomLineView.backgroundColor = [UIColor blackColor];


 
    [self.view addSubview:telBottomLineView];
    
    
    UIImageView * pwImageView = [[UIImageView alloc] initWithFrame:CGRectMake(accountImageView.frame.origin.x, telBottomLineView.frame.origin.y+telBottomLineView.frame.size.height+59*BILI/2, 17*BILI, 20*BILI)];
    pwImageView.image = [UIImage imageNamed:@"icon_mima"];
    pwImageView.alpha = 0.6;
    [self.view addSubview:pwImageView];

    self.passWorldTextField = [[UITextField alloc] initWithFrame:CGRectMake(pwImageView.frame.origin.x+pwImageView.frame.size.width+12*BILI, pwImageView.frame.origin.y, 244*BILI-(pwImageView.frame.origin.x+pwImageView.frame.size.width+12*BILI), 20*BILI)];
    self.passWorldTextField.font = [UIFont systemFontOfSize:15*BILI];
    self.passWorldTextField.placeholder = @"请输入您的密码";
    self.passWorldTextField.secureTextEntry = YES;
    self.passWorldTextField.textColor = UIColorFromRGB(0x333333);
    [self.passWorldTextField setValue:UIColorFromRGB(0xc6c6c6) forKeyPath:@"_placeholderLabel.textColor"];
    [self.view addSubview:self.passWorldTextField];
    
    UIButton * forgetPassWorldButton = [[UIButton alloc] initWithFrame:CGRectMake(498*BILI/2, telBottomLineView.frame.origin.y+telBottomLineView.frame.size.height+25*BILI, 70*BILI, 30*BILI)];
    [forgetPassWorldButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    forgetPassWorldButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [forgetPassWorldButton setTitleColor:UIColorFromRGB(0x959595) forState:UIControlStateNormal];
    [forgetPassWorldButton addTarget:self action:@selector(forgetPassWorldButtonClick) forControlEvents:UIControlEventTouchUpInside];

    forgetPassWorldButton.alpha = 0.6;
    forgetPassWorldButton.titleLabel.font = [UIFont systemFontOfSize:15*BILI];
    [self.view addSubview:forgetPassWorldButton];
    
    
    UIView * checkNumberBottomView = [[UIView alloc] initWithFrame:CGRectMake(telBottomLineView.frame.origin.x, telBottomLineView.frame.origin.y+telBottomLineView.frame.size.height+111*BILI/2, 244*BILI, 1*BILI)];
    checkNumberBottomView.alpha = 0.1;
    checkNumberBottomView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:checkNumberBottomView];


    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];

    NSDictionary * accountInfo = [defaults objectForKey:UserAccountAndPassWorld];
    if (accountInfo)
    {
        
        self.accountTextField.text = [accountInfo objectForKey:@"userId"];
        self.passWorldTextField.text =  [accountInfo objectForKey:@"password"];
    }
    
    UIButton * registerButton = [[UIButton alloc] initWithFrame:CGRectMake(64*BILI, checkNumberBottomView.frame.origin.y+ checkNumberBottomView.frame.size.height+27*BILI, 100*BILI, 40*BILI)];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton setTitleColor:UIColorFromRGB(0x333333) forState:UIControlStateNormal];
    [registerButton setBackgroundColor:UIColorFromRGB(0xE1E1E1)];
    registerButton.layer.cornerRadius = 20*BILI;
    registerButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
    [registerButton addTarget:self action:@selector(registerButtonClick) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:registerButton];
    

    self.telLoginButton = [[UIButton alloc] initWithFrame:CGRectMake(211*BILI, checkNumberBottomView.frame.origin.y+ checkNumberBottomView.frame.size.height+27*BILI, 100*BILI, 40*BILI)];
    self.telLoginButton.backgroundColor = UIColorFromRGB(0x569FFF);
    self.telLoginButton.layer.cornerRadius = 20*BILI;
    [self.telLoginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.telLoginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.telLoginButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
    [self.telLoginButton addTarget:self action:@selector(telLoginButtonClick) forControlEvents:UIControlEventTouchUpInside];


 

    [self.view addSubview:self.telLoginButton];
    
    
    UILabel * xieYiLiuLanLable = [[UILabel alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT-50*BILI,VIEW_WIDTH, 50*BILI)];
    xieYiLiuLanLable.textColor = UIColorFromRGB(0xFF9D56);
    xieYiLiuLanLable.font = [UIFont systemFontOfSize:12*BILI];
    xieYiLiuLanLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:xieYiLiuLanLable];


    NSString * str = @"登录即代表您同意《探聊用户协议》";
    NSAttributedString * str1 = [[NSAttributedString alloc] initWithString:str];

    
    NSMutableAttributedString * text1 = [[NSMutableAttributedString alloc] initWithAttributedString:str1];
    
    [text1 addAttribute:NSForegroundColorAttributeName
                  value:UIColorFromRGB(0x959595)
                  range:NSMakeRange(0, 8)];
    xieYiLiuLanLable.attributedText = text1;
    
    UIButton * yongHuXieYiButton = [[UIButton alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT-50*BILI,VIEW_WIDTH, 50*BILI)];
    yongHuXieYiButton.titleLabel.font = [UIFont systemFontOfSize:12*BILI];
    [yongHuXieYiButton addTarget:self action:@selector(agreeMentButtonClick) forControlEvents:UIControlEventTouchUpInside];
    yongHuXieYiButton.backgroundColor = [UIColor clearColor];

    [self.view addSubview:yongHuXieYiButton];

 
    

}
-(void)forgetPassWorldButtonClick
{
    TanLiaoLiao_TelephoneRegistViewController * telRegisterVC = [[TanLiaoLiao_TelephoneRegistViewController alloc] init];
    telRegisterVC.alsoForgetPassWorld = @"forget";
    [self.navigationController pushViewController:telRegisterVC animated:YES];

}
-(void)registerButtonClick
{
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        UILabel * WawlqyWrkflf = [[UILabel alloc]initWithFrame:CGRectMake(33,83,72,53)];
        WawlqyWrkflf.layer.cornerRadius =10;
        WawlqyWrkflf.backgroundColor = [UIColor whiteColor];
        WawlqyWrkflf.layer.borderColor = [[UIColor greenColor] CGColor];
        WawlqyWrkflf.layer.cornerRadius =7;
        [self.view addSubview:WawlqyWrkflf];
    }
    
    AgreementViewController * agreementVC = [[AgreementViewController alloc] init];
    agreementVC.cityName = self.cityName;
    agreementVC.fromWhere = @"login";
    [self.navigationController pushViewController:agreementVC animated:YES];
    
}
-(void)agreeMentButtonClick
{
    AgreementViewController * agreementVC = [[AgreementViewController alloc] init];
    agreementVC.fromWhere = @"liuLan";
    [self.navigationController pushViewController:agreementVC animated:YES];
}

-(void)telLoginButtonClick
{
    
    


        if ([TanLiao_Common isEmpty:self.accountTextField.text] )
        {
            [TanLiao_Common showToastView:@"账号格式有误" view:self.view];
            return;
        }
        if([TanLiao_Common isEmpty:self.passWorldTextField.text])
        {
            [TanLiao_Common showToastView:@"密码格式有误" view:self.view];

            return;
        }
        [self showNewLoadingView:@"登录中..." view:self.view];

        [self bottomTap];
    
    
    if([self.ipInfo isKindOfClass:[NSDictionary class]])
    {
        [self.cloudClient telPhoneLogin:@"8098"
                              accountId:self.accountTextField.text
                               password:self.passWorldTextField.text
                               cityName:self.cityName
                                     ip:[self.ipInfo objectForKey:@"ip"]
                                country:[self.ipInfo objectForKey:@"country"]
                               delegate:self
                               selector:@selector(accountLoginSuccess:)
                          errorSelector:@selector(accountLoginError:)];
    }
    else
    {
        [self.cloudClient telPhoneLogin:@"8098"
                              accountId:self.accountTextField.text
                               password:self.passWorldTextField.text
                               cityName:self.cityName
                                     ip:@""
                                country:@""
                               delegate:self
                               selector:@selector(accountLoginSuccess:)
                          errorSelector:@selector(accountLoginError:)];
    }
    
    

        
    
}
-(void)accountLoginSuccess:(NSDictionary *)info
{
    [self hideNewLoadingView];

    NSUserDefaults* isShowAtHomeDefaults = [NSUserDefaults standardUserDefaults];
    [isShowAtHomeDefaults setObject:[info objectForKey:@"isShowAtHome"] forKey:@"isShowAtHomeDefaultsKey"];
    [isShowAtHomeDefaults synchronize];

    if ([@"-1" isEqualToString:[info objectForKey:@"accountStatus"]]) {
        
        [TanLiao_Common showToastView:@"您的账号已经被冻结" view:self.view];
    }
    if ([@"0" isEqualToString:[info objectForKey:@"accountStatus"]]) {
        
        NSUserDefaults* loginStatusDefaults = [NSUserDefaults standardUserDefaults];
        [loginStatusDefaults setObject:@"1" forKey:LoginStatus];
        [loginStatusDefaults synchronize];


        NSUserDefaults* accountDefaults = [NSUserDefaults standardUserDefaults];
        NSDictionary * accountInfo = [[NSDictionary alloc] initWithObjectsAndKeys:self.accountTextField.text,@"userId",self.passWorldTextField.text,@"password", nil];
        [accountDefaults setObject:accountInfo forKey:UserAccountAndPassWorld];
        [accountDefaults synchronize];

        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:info forKey:USERINFO];
        [defaults synchronize];

        //本地存认证资料
        NSDictionary * authentication = [info  objectForKey:@"authentication"];
        if ([authentication isKindOfClass:[NSDictionary class]]&&[authentication allKeys].count>0) {
            
            NSUserDefaults * authenticationDefaults = [NSUserDefaults standardUserDefaults];
            [authenticationDefaults setObject:[TanLiao_Common removeNullFromDictionary:authentication] forKey:@"DefaultsAuthentication"];
            [authenticationDefaults synchronize];
            
        }
        
        NSString *loginAccount = [info objectForKey:@"userId"];
        NSString *loginToken   = [info objectForKey:@"face_token"];
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
                                              NSLog(@"%@",toast);
                                          }
                                      }];
        [[RongCloudManager getInstance] connectRongCloud];
        [TanLiao_Common showToastView:@"登陆成功" view:self.view];

        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:ZhuBoHuJiaoNotification object:nil];
        
        AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate resetLoginTabBar];

    }
    if ([@"1" isEqualToString:[info objectForKey:@"accountStatus"]])
    {
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:info forKey:USERINFO];
        [defaults synchronize];


        
        NSUserDefaults* accountStatusDefaults = [NSUserDefaults standardUserDefaults];
        [accountStatusDefaults setObject:@"new" forKey:@"accountStatusDefaultsKey"];
        [accountStatusDefaults synchronize];
        
        TanLiaoLiao_AddInformationViewController * addInformationVC = [[TanLiaoLiao_AddInformationViewController alloc] init];
        addInformationVC.userInfoDic = info;
        addInformationVC.cityName = self.cityName;
        addInformationVC.phoneNumber = self.accountTextField.text;
        addInformationVC.passWorld = self.passWorldTextField.text;
        addInformationVC.formWhere = @"loginVC";
        addInformationVC.alsoAccountRegist = @"YES";
        [self.navigationController pushViewController:addInformationVC animated:YES];
    }
    
}
-(void)accountLoginError:(NSDictionary *)info
{
    [self hideNewLoadingView];

}
-(void)qqButtonClick
{
    //QQ登录
     [self showLoginLoadingView:@"正在登陆..." view:nil];
    [ShareSDK getUserInfo:SSDKPlatformTypeQQ
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             
             [ShareSDK cancelAuthorize:SSDKPlatformTypeQQ result:^(NSError *error) {
                 
             }];
             
             UICKeyChainStore *keychainStore = [UICKeyChainStore keyChainStore];

             NSString * keychainUserId = [keychainStore stringForKey:@"keychainUserId"];
             
             NSLog(@"%@==%@",user,user.uid);
             
             NSDictionary * info= user.rawData;
             
             self.userInfoDic = [[NSMutableDictionary alloc] init];


             [self.userInfoDic setObject:[TanLiao_Common getobjectForKey:[info objectForKey:@"figureurl_qq_2"]] forKey:@"avatarUrl"];
            [self.userInfoDic setObject:[TanLiao_Common getobjectForKey:[info objectForKey:@"nickname"]] forKey:@"nick"];
             
             NSUserDefaults * uniqueIdDefaults = [NSUserDefaults standardUserDefaults];
             NSString * authCode = [uniqueIdDefaults objectForKey:UNIQUEID];
             if (![authCode isKindOfClass:[NSString class]]) {
                 authCode = @"";
             }
             [self.cloudClient loginByQQ:user.uid
                                    nick:[info objectForKey:@"nickname"]
                                   apiId:@"8055"
                               avatarUrl:[info objectForKey:@"figureurl"]
                                cityName:self.cityName
                                authCode:authCode
                               old_qq_id:keychainUserId
                                delegate:self
                                selector:@selector(loginSuccess:)
                           errorSelector:@selector(loginError:)];
             
         }
         
         else
         {
             [self hideNewLoadingView];

         }
         
     }];
    

}
-(void)sinaButtonClick
{
    //新浪微博登录
     [self showLoginLoadingView:@"正在登陆..." view:nil];
    [ShareSDK getUserInfo:SSDKPlatformTypeSinaWeibo
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
            
             [ShareSDK cancelAuthorize:SSDKPlatformTypeSinaWeibo result:^(NSError *error) {
                 
             }];
             
             NSDictionary * info= user.rawData;
            
             self.userInfoDic = [[NSMutableDictionary alloc] init];


 

             [self.userInfoDic setObject:[TanLiao_Common getobjectForKey:[info objectForKey:@"avatar_large"]] forKey:@"avatarUrl"];
             [self.userInfoDic setObject:[TanLiao_Common getobjectForKey:[info objectForKey:@"name"]] forKey:@"nick"];
             
             NSUserDefaults * uniqueIdDefaults = [NSUserDefaults standardUserDefaults];
             NSString * authCode = [uniqueIdDefaults objectForKey:UNIQUEID];
             if (![authCode isKindOfClass:[NSString class]]) {
                 authCode = @"";
             }
             
             [self.cloudClient loginByWB:[info objectForKey:@"idstr"]
                                    nick:[info objectForKey:@"name"]
                                   apiId:@"8056"
                               avatarUrl:[info objectForKey:@"avatar_hd"]
                                cityName:self.cityName
                                authCode:authCode
                                delegate:self
                                selector:@selector(loginSuccess:)
                           errorSelector:@selector(loginError:)];
             
            
             
         }
         
         else
         {
             [self hideNewLoadingView];

         }
         
     }];
    
   
    
}

-(void)wechatButtonClick
{
    

    [self weiXinLogin];
    [self showLoginLoadingView:@"正在登陆..." view:nil];
    
}
- (void)getCurrentLocation
{
    self.myLocation = [[CLLocationManager alloc]init];
    self.myLocation.delegate = self;
    if ([self.myLocation respondsToSelector:@selector(requestWhenInUseAuthorization)])
    {
        [self.myLocation requestWhenInUseAuthorization];
    }
    self.myLocation.desiredAccuracy = kCLLocationAccuracyBest;
    self.myLocation.distanceFilter = kCLDistanceFilterNone;
    [self.myLocation startUpdatingLocation];
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    CLLocation *currlocation = [locations objectAtIndex:0];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:currlocation.coordinate.latitude longitude:currlocation.coordinate.longitude];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];

    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray * placemarks, NSError * error)
     {
         if (placemarks.count > 0) {
             CLPlacemark *plmark = [placemarks objectAtIndex:0];
             NSString *city = plmark.locality;
             self.cityName = [city substringToIndex:(city.length -1)];
         }
     }];
    [manager stopUpdatingLocation];
    
}
//获取定位失败回调方法
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
}
-(void)weiXinLogin
{
    [ShareSDK getUserInfo:SSDKPlatformTypeWechat
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             [ShareSDK cancelAuthorize:SSDKPlatformTypeWechat result:^(NSError *error) {
                 
             }];
             NSDictionary * info= user.rawData;
             self.userInfoDic = [[NSMutableDictionary alloc] init];

             [self.userInfoDic setObject:[TanLiao_Common getobjectForKey:[info objectForKey:@"headimgurl"]] forKey:@"avatarUrl"];
             [self.userInfoDic setObject:[TanLiao_Common getobjectForKey:[info objectForKey:@"nickname"]] forKey:@"nick"];
             
             NSUserDefaults * uniqueIdDefaults = [NSUserDefaults standardUserDefaults];


             NSString * authCode = [uniqueIdDefaults objectForKey:UNIQUEID];
             if (![authCode isKindOfClass:[NSString class]]) {
                 authCode = @"";
             }
             
             [self.cloudClient loginByWX:[info objectForKey:@"unionid"]
                                    nick:[info objectForKey:@"nickname"]
                                   apild:@"8002"
                               avatarUrl:[info objectForKey:@"headimgurl"]
                                cityName:self.cityName
                                authCode:authCode
                                delegate:self
                                selector:@selector(loginSuccess:)
                           errorSelector:@selector(loginError:)];
             
             
         }
         
         else
         {
             [self hideNewLoadingView];

         }
         
     }];
    
}

-(void)loginSuccess:(NSDictionary *)info
{
    [self hideNewLoadingView];

    
    NSUserDefaults* isShowAtHomeDefaults = [NSUserDefaults standardUserDefaults];
    [isShowAtHomeDefaults setObject:[info objectForKey:@"isShowAtHome"] forKey:@"isShowAtHomeDefaultsKey"];
    [isShowAtHomeDefaults synchronize];


    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:info forKey:USERINFO];
    [defaults synchronize];
    
    //本地存认证资料
    NSDictionary * authentication = [info  objectForKey:@"authentication"];
    if ([authentication isKindOfClass:[NSDictionary class]]&&[authentication allKeys].count>0) {
        
        NSUserDefaults * authenticationDefaults = [NSUserDefaults standardUserDefaults];
        [authenticationDefaults setObject:[TanLiao_Common removeNullFromDictionary:authentication] forKey:@"DefaultsAuthentication"];
        [authenticationDefaults synchronize];
        
    }


    NSString * deviceId;
    if ( [[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
        
       deviceId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        
    }
    else
    {
        deviceId = @"";
    }
    
    if ([@"1" isEqualToString:[info objectForKey:@"accountStatus"]]) {
        
        
        NSUserDefaults* accountStatusDefaults = [NSUserDefaults standardUserDefaults];
        [accountStatusDefaults setObject:@"new" forKey:@"accountStatusDefaultsKey"];
        [accountStatusDefaults synchronize];
        
      
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:info forKey:USERINFO];
        [defaults synchronize];
        
        
        TanLiaoLiao_AddInformationViewController * addInformationVC = [[TanLiaoLiao_AddInformationViewController alloc] init];
        addInformationVC.userInfoDic = info;
        addInformationVC.cityName = self.cityName;
        addInformationVC.phoneNumber = self.accountTextField.text;
        addInformationVC.passWorld = self.passWorldTextField.text;
        addInformationVC.formWhere = @"loginVC";
        addInformationVC.alsoAccountRegist = @"NO";
        [self.navigationController pushViewController:addInformationVC animated:YES];

        

    }
   if([@"0" isEqualToString:[info objectForKey:@"accountStatus"]]){
       
       NSUserDefaults* loginStatusDefaults = [NSUserDefaults standardUserDefaults];
       [loginStatusDefaults setObject:@"1" forKey:LoginStatus];
       [loginStatusDefaults synchronize];

       
       NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
       [defaults setObject:info forKey:USERINFO];
       [defaults synchronize];

        NSString *loginAccount = [info objectForKey:@"userId"];
        NSString *loginToken   = [info objectForKey:@"face_token"];
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

                                              NSLog(@"%@",toast);
                                          }
                                      }];
        
        [[RongCloudManager getInstance] connectRongCloud];
        [TanLiao_Common showToastView:@"登陆成功" view:self.view];

       
         [[NSNotificationCenter defaultCenter] removeObserver:self name:ZhuBoHuJiaoNotification object:nil];
            AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            [appDelegate resetLoginTabBar];

       
    }
    if ([@"-1" isEqualToString:[info objectForKey:@"accountStatus"]])
    {
        
        [TanLiao_Common showToastView:@"您的账号已经被冻结" view:self.view];

    }
    
}
-(void)addMessageSuccess:(NSDictionary *)info
{
    [self hideNewLoadingView];

    
    NSUserDefaults* loginStatusDefaults = [NSUserDefaults standardUserDefaults];
    [loginStatusDefaults setObject:@"1" forKey:LoginStatus];
    [loginStatusDefaults synchronize];


    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:USERINFO];
    [defaults setObject:info forKey:USERINFO];
    [defaults synchronize];


    NSDictionary * userInfo = [defaults objectForKey:USERINFO];
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

                                          NSLog(@"%@",toast);
                                      }
                                  }];
    
    [[RongCloudManager getInstance] connectRongCloud];
    
    [TanLiao_Common showToastView:@"登陆成功" view:self.view];


    
     [[NSNotificationCenter defaultCenter] removeObserver:self name:ZhuBoHuJiaoNotification object:nil];
        AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate resetLoginTabBar];


    
    
}
-(void)addMessageError:(NSDictionary *)info
{
    [self hideNewLoadingView];

}

-(void)loginError:(NSDictionary *)info
{
    [self hideNewLoadingView];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setTabBarHidden];
     [[NSNotificationCenter defaultCenter] removeObserver:self name:ZhuBoHuJiaoNotification object:nil];
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];

    NSDictionary * accountInfo = [defaults objectForKey:UserAccountAndPassWorld];
    if (accountInfo)
    {
        
        self.accountTextField.text = [accountInfo objectForKey:@"userId"];
        self.passWorldTextField.text =  [accountInfo objectForKey:@"password"];
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    CTCellularData *cellularData = [[CTCellularData alloc]init];
    cellularData.cellularDataRestrictionDidUpdateNotifier = nil;
}
- (NSArray *)vcs_vhoaX617zxwaQ817
{
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@(484)];
    [array addObject:@(537)];
    [array addObject:@(708)];
    [array addObject:@(508)];
    return array;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
