//
//  TelephoneRegistViewController.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/1/22.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiaoLiao_TelephoneRegistViewController.h"
#import <AdSupport/AdSupport.h>

@interface TanLiaoLiao_TelephoneRegistViewController ()

@end

@implementation TanLiaoLiao_TelephoneRegistViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    

    
    self.titleLale.text = @"手机号码注册";
    
    self.lineView.hidden = YES;
    
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];


    [self.cloudClient setToastView:self.view];

    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap)];
    [self.view addGestureRecognizer:tap];

    
    UILabel * telTipLable = [[UILabel alloc] initWithFrame:CGRectMake(15*BILI, self.navView.frame.origin.y+self.navView.frame.size.height, 105*BILI, 50*BILI)];
    telTipLable.textColor = [UIColor blackColor];
    telTipLable.alpha = 0.2;
    telTipLable.font = [UIFont systemFontOfSize:15*BILI];
    telTipLable.text = @"请输入您的手机号";
    telTipLable.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:telTipLable];



    
    self.telTextField = [[UITextField alloc] initWithFrame:CGRectMake(telTipLable.frame.origin.x+telTipLable.frame.size.width+20*BILI, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH-(telTipLable.frame.origin.x+telTipLable.frame.size.width+20*BILI+15*BILI), 50*BILI)];
    self.telTextField.font = [UIFont systemFontOfSize:18*BILI];
    self.telTextField.textColor = [UIColor blackColor];
    self.telTextField.alpha = 0.6;
    self.telTextField.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:self.telTextField];
    
    [self.telTextField becomeFirstResponder];

    UIView * lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, telTipLable.frame.origin.y+telTipLable.frame.size.height, VIEW_WIDTH, 1*BILI)];
    lineView1.backgroundColor = [UIColor blackColor];
    lineView1.alpha = 0.1;
    [self.view addSubview:lineView1];
    
    UILabel * checkNumberipLable = [[UILabel alloc] initWithFrame:CGRectMake(15*BILI, lineView1.frame.origin.y+lineView1.frame.size.height, 105*BILI, 50*BILI)];
    checkNumberipLable.textColor = [UIColor blackColor];

    checkNumberipLable.alpha = 0.2;
    checkNumberipLable.font = [UIFont systemFontOfSize:15*BILI];
    checkNumberipLable.text = @"请输验证码";
    [self.view addSubview:checkNumberipLable];


    
    self.checkNumberTextField = [[UITextField alloc] initWithFrame:CGRectMake(telTipLable.frame.origin.x+telTipLable.frame.size.width+20*BILI, lineView1.frame.origin.y+lineView1.frame.size.height, VIEW_WIDTH-(telTipLable.frame.origin.x+telTipLable.frame.size.width+20*BILI+100*BILI), 50*BILI)];
    self.checkNumberTextField.font = [UIFont systemFontOfSize:18*BILI];
    self.checkNumberTextField.textColor = [UIColor blackColor];

    self.checkNumberTextField.alpha = 0.6;
    self.checkNumberTextField.keyboardType = UIKeyboardTypePhonePad;
    [self.view addSubview:self.checkNumberTextField];
    
    self.getCheckNumberButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-90*BILI, checkNumberipLable.frame.origin.y, 75*BILI, 50*BILI)];
    self.getCheckNumberButton.titleLabel.font = [UIFont systemFontOfSize:15*BILI];
    [self.getCheckNumberButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.getCheckNumberButton addTarget:self action:@selector(getCheckNumberButtonClick) forControlEvents:UIControlEventTouchUpInside];




    [self.getCheckNumberButton setTitleColor:UIColorFromRGB(0xFF5C93) forState:UIControlStateNormal];
    self.getCheckNumberButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:self.getCheckNumberButton];
    
    UIView * lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, checkNumberipLable.frame.origin.y+checkNumberipLable.frame.size.height, VIEW_WIDTH, 1*BILI)];
    lineView2.backgroundColor = [UIColor blackColor];
    lineView2.alpha = 0.1;
    [self.view addSubview:lineView2];
    
    UILabel * passWorldTipLable = [[UILabel alloc] initWithFrame:CGRectMake(15*BILI, lineView2.frame.origin.y+lineView2.frame.size.height, 105*BILI, 50*BILI)];
    passWorldTipLable.textColor = [UIColor blackColor];


    passWorldTipLable.alpha = 0.2;
    passWorldTipLable.font = [UIFont systemFontOfSize:15*BILI];
    passWorldTipLable.text = @"请设置新密码";
    [self.view addSubview:passWorldTipLable];

    self.passWorldRextField = [[UITextField alloc] initWithFrame:CGRectMake(passWorldTipLable.frame.origin.x+passWorldTipLable.frame.size.width+20*BILI, lineView2.frame.origin.y+lineView2.frame.size.height, VIEW_WIDTH-(passWorldTipLable.frame.origin.x+passWorldTipLable.frame.size.width+40*BILI), 50*BILI)];
    self.passWorldRextField.font = [UIFont systemFontOfSize:18*BILI];
    self.passWorldRextField.textColor = [UIColor blackColor];
    self.passWorldRextField.alpha = 0.6;
    self.passWorldRextField.secureTextEntry = YES;
    [self.view addSubview:self.passWorldRextField];
    
    UIView * lineView3 = [[UIView alloc] initWithFrame:CGRectMake(0, passWorldTipLable.frame.origin.y+passWorldTipLable.frame.size.height, VIEW_WIDTH, 1*BILI)];
    lineView3.backgroundColor = [UIColor blackColor];

    lineView3.alpha = 0.1;
    [self.view addSubview:lineView3];
    
    UILabel * passWorldAgainTipLable = [[UILabel alloc] initWithFrame:CGRectMake(15*BILI, lineView3.frame.origin.y+lineView3.frame.size.height, 105*BILI, 50*BILI)];
    passWorldAgainTipLable.textColor = [UIColor blackColor];



    passWorldAgainTipLable.alpha = 0.2;
    passWorldAgainTipLable.font = [UIFont systemFontOfSize:15*BILI];
    passWorldAgainTipLable.text = @"请确定新密码";
    [self.view addSubview:passWorldAgainTipLable];
    
    self.passWorldAgainTextField = [[UITextField alloc] initWithFrame:CGRectMake(passWorldTipLable.frame.origin.x+passWorldTipLable.frame.size.width+20*BILI, lineView3.frame.origin.y+lineView3.frame.size.height, VIEW_WIDTH-(passWorldTipLable.frame.origin.x+passWorldTipLable.frame.size.width+40*BILI), 50*BILI)];
    self.passWorldAgainTextField.font = [UIFont systemFontOfSize:18*BILI];
    self.passWorldAgainTextField.textColor = [UIColor blackColor];


    self.passWorldAgainTextField.alpha = 0.6;
    self.passWorldAgainTextField.secureTextEntry = YES;
    [self.view addSubview:self.passWorldAgainTextField];
    
    UIView * lineView4 = [[UIView alloc] initWithFrame:CGRectMake(0, passWorldAgainTipLable.frame.origin.y+passWorldAgainTipLable.frame.size.height, VIEW_WIDTH, 1*BILI)];
    lineView4.backgroundColor = [UIColor blackColor];



    lineView4.alpha = 0.1;
    [self.view addSubview:lineView4];
    
    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(15*BILI,lineView4.frame.origin.y+35*BILI/2, VIEW_WIDTH-30*BILI, 32*BILI)];
    tipLable.textColor = [UIColor blackColor];


    tipLable.font = [UIFont systemFontOfSize:15*BILI];
    tipLable.alpha = 0.6;
    tipLable.adjustsFontSizeToFitWidth = YES;
    tipLable.text = @"温馨提示: 注册成功,此账号和密码将作为您的登录账号和密码,请妥善保存";
    [self.view addSubview:tipLable];

    
    UIButton * registerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, tipLable.frame.origin.y+tipLable.frame.size.height+35*BILI/2, VIEW_WIDTH, 45*BILI)];
    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerButton setTitle:@"确定并注册" forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(registerButtonClick) forControlEvents:UIControlEventTouchUpInside];




    registerButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
    registerButton.backgroundColor = UIColorFromRGB(0xFF5C93);
    [self.view addSubview:registerButton];
    
    
    if ([@"forget" isEqualToString:self.alsoForgetPassWorld]) {
        
        self.titleLale.text = @"找回密码";
        checkNumberipLable.hidden = YES;
        self.checkNumberTextField.hidden = YES;
        self.getCheckNumberButton.hidden = YES;
        lineView2.hidden = YES;
        passWorldTipLable.hidden = YES;
        self.passWorldRextField.hidden = YES;
        lineView3.hidden = YES;
        passWorldAgainTipLable.hidden = YES;
        self.passWorldAgainTextField.hidden = YES;
        lineView4.hidden = YES;
        [registerButton setTitle:@"找回密码" forState:UIControlStateNormal];
        tipLable.text = @"温馨提示: 输入注册时的手机号码,密码会以短信的形式发送到对应的手机";
    }
}


-(void)getCheckNumberButtonClick
{
    

    [self viewTap];
    if (self.telTextField.text.length==11)
    {
        [self showNewLoadingView:@"验证码获取中..." view:self.view];

        [self.cloudClient getCheckNumber:@"8096"
                             phoneNumber:self.telTextField.text
                                 channel:nil
                                delegate:self
                                selector:@selector(getCheckNumberSuccess:)
                           errorSelector:@selector(getError:)];
      
    }
    else
    {
        [TanLiao_Common showToastView:@"请输入正确的手机号码" view:self.view];


    }
    
    
}


-(void)getCheckNumberSuccess:(NSDictionary *)info
{
    self.getCheckNumberButton.enabled = NO;
    stepSeconds = 60;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(daoShu) userInfo:nil repeats:YES];
    [self hideNewLoadingView];

    [TanLiao_Common showToastView:@"验证码已发送,请注意查收" view:self.view];

    
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        UITableView * dxpgkM0069 = [[UITableView alloc]initWithFrame:CGRectMake(69,45,62,0)];
        dxpgkM0069.layer.cornerRadius =9;
        dxpgkM0069.userInteractionEnabled = YES;
        dxpgkM0069.layer.masksToBounds = YES;
        [self.view addSubview:dxpgkM0069];
        
    }
    
}


-(void)getError:(NSDictionary *)info
{
    [self hideNewLoadingView];

    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];

}
-(void)registerButtonClick
{
    if ([@"forget" isEqualToString:self.alsoForgetPassWorld])
    {
        if (self.telTextField.text.length!=11) {
            
            [TanLiao_Common showToastView:@"请输入正确的手机号码" view:self.view];




            return;
        }
        [self.telTextField resignFirstResponder];

        [self showNewLoadingView:@"正在找回密码..." view:self.view];


        [self.cloudClient zhaoHuiPassWorld:@"8099"
                               phoneNumber:self.telTextField.text
                                  delegate:self
                                  selector:@selector(getPassWorldSuccess:)
                             errorSelector:@selector(getError:)];
    }
    else
    {
    NSString * deviceId;
    if ( [[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
        
        deviceId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        
    }
    else
    {
        deviceId = @"";
    }
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];

    NSString * channel = [defaults objectForKey:CHANNEL];
    
    NSUserDefaults * authCodeDefaults = [NSUserDefaults standardUserDefaults];

    NSString * authCode = [authCodeDefaults objectForKey:UNIQUEID];

    if (self.telTextField.text.length!=11) {
        
        [TanLiao_Common showToastView:@"请输入正确的手机号码" view:self.view];
        return;
    }
    if ([TanLiao_Common isEmpty:self.checkNumberTextField.text]) {
        
        [TanLiao_Common showToastView:@"验证码不能为空" view:self.view];



 

        return;
    }
    if ([TanLiao_Common isEmpty:self.passWorldRextField.text]||[TanLiao_Common isEmpty:self.passWorldAgainTextField.text]) {
        
        [TanLiao_Common showToastView:@"密码不能为空" view:self.view];

        return;
    }
    if (![self.passWorldRextField.text isEqualToString:self.passWorldAgainTextField.text]) {
        
        [TanLiao_Common showToastView:@"两次输入的密码不一致" view:self.view];

        return;
    }
    [self viewTap];
    [self showNewLoadingView:@"注册中..." view:self.view];


    [self.cloudClient telPhoneRegist:@"8097"
                         phoneNumber:self.telTextField.text
                       loginAuthCode:self.checkNumberTextField.text
                             appName:APPNAME
                            deviceId:deviceId
                            authCode:authCode
                          deviceType:@"2"
                            password:self.passWorldRextField.text
                            sourceNo:channel
                            delegate:self
                            selector:@selector(registerSuccess:)
                       errorSelector:@selector(getError:)];
    }
}


-(void)getPassWorldSuccess:(NSDictionary *)info
{
    

    
    [self hideNewLoadingView];


    [TanLiao_Common showToastView:@"密码已发送请注意查收" view:self.view];


}
-(void)registerSuccess:(NSDictionary *)info
{
    [self hideNewLoadingView];


        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];

        [defaults setObject:info forKey:USERINFO];
        [defaults synchronize];

    
        TanLiaoLiao_AddInformationViewController * addInformationVC = [[TanLiaoLiao_AddInformationViewController alloc] init];


        addInformationVC.userInfoDic = info;
        addInformationVC.cityName = self.cityName;
        addInformationVC.phoneNumber = self.telTextField.text;
        addInformationVC.passWorld = self.passWorldRextField.text;
        addInformationVC.formWhere = @"registerVC";
        [self.navigationController pushViewController:addInformationVC animated:YES];
}
-(void)daoShu
{
    stepSeconds --;
    [self.getCheckNumberButton setTitleColor:UIColorFromRGB(0xcdcdcd) forState:UIControlStateNormal];
    [self.getCheckNumberButton setTitle:[NSString stringWithFormat:@"%d秒",stepSeconds] forState:UIControlStateNormal];
    if(stepSeconds == 0)
    {
        [self.getCheckNumberButton setTitleColor:UIColorFromRGB(0xFF5C93) forState:UIControlStateNormal];
        [self.getCheckNumberButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.getCheckNumberButton.enabled = YES;
        [self.timer invalidate];



        return;
    }
    
    
}
-(void)viewTap
{
    
    
    [self.telTextField resignFirstResponder];


    [self.checkNumberTextField resignFirstResponder];



    [self.passWorldRextField resignFirstResponder];


    [self.passWorldAgainTextField resignFirstResponder];

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self.timer invalidate];
    self.timer = nil;
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:@(312)];
        [array addObject:@(588)];
        [array addObject:@(815)];
        [array addObject:@(836)];
        [array addObject:@(927)];
        [array addObject:@(344)];
        
    }
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
