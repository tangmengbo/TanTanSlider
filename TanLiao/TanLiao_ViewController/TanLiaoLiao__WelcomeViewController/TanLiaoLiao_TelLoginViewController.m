//
//  TelLoginViewController.m
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/11.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiaoLiao_TelLoginViewController.h"

@interface TanLiaoLiao_TelLoginViewController ()

@end

@implementation TanLiaoLiao_TelLoginViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];

   // [self.cloudClient setToastView:self.view];


    
    self.titleLale.text = @"手机号码登录";
    self.titleLale.alpha = 0.9;
    
    agree = 1;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap)];
    [self.view addGestureRecognizer:tap];
    
    UIImageView * logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-90*BILI)/2,self.navView.frame.origin.y+self.navView.frame.size.height+36*BILI, 90*BILI, 90*BILI)];
    logoImageView.image = [UIImage imageNamed:@"logo"];
    [self.view addSubview:logoImageView];
    
    UIView * telBottomView = [[UIView alloc] initWithFrame:CGRectMake(125*BILI/2, logoImageView.frame.origin.y+logoImageView.frame.size.height+40*BILI, 250*BILI, 40*BILI)];
    telBottomView.layer.borderColor = [UIColorFromRGB(0x979797) CGColor];
    telBottomView.layer.borderWidth = 1;
    telBottomView.layer.cornerRadius = 20*BILI;
    [self.view addSubview:telBottomView];



    self.telTextField = [[UITextField alloc] initWithFrame:CGRectMake(27*BILI/2, 0, telBottomView.frame.size.width-27*BILI, 40*BILI)];
    self.telTextField.font = [UIFont systemFontOfSize:15*BILI];
    self.telTextField.placeholder = @"+86 请输入手机号码";
    self.telTextField.keyboardType = UIKeyboardTypeNumberPad;
    [telBottomView addSubview:self.telTextField];
    
    UIView * checkNumberBottomView = [[UIView alloc] initWithFrame:CGRectMake(125*BILI/2, telBottomView.frame.origin.y+telBottomView.frame.size.height+15*BILI, 250*BILI, 40*BILI)];
    checkNumberBottomView.layer.borderColor = [UIColorFromRGB(0x979797) CGColor];
    checkNumberBottomView.layer.borderWidth = 1;
    checkNumberBottomView.layer.cornerRadius = 20*BILI;
    [self.view addSubview:checkNumberBottomView];

    self.checkNumberTextField = [[UITextField alloc] initWithFrame:CGRectMake(27*BILI/2, 0, telBottomView.frame.size.width-27*BILI-60*BILI-27*BILI/2, 40*BILI)];
    self.checkNumberTextField.font = [UIFont systemFontOfSize:15*BILI];
    self.checkNumberTextField.placeholder = @"请输入验证码";
    self.checkNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    [checkNumberBottomView addSubview:self.checkNumberTextField];
    
    self.getCheckNumberButton = [[UIButton alloc] initWithFrame:CGRectMake(checkNumberBottomView.frame.size.width-27*BILI/2-80*BILI, 0, 80*BILI, 40*BILI)];
    [self.getCheckNumberButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    [self.getCheckNumberButton setTitleColor:UIColorFromRGB(0xF85BA3) forState:UIControlStateNormal];
    [self.getCheckNumberButton addTarget:self action:@selector(getCheckNumberButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.getCheckNumberButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.getCheckNumberButton.titleLabel.font = [UIFont systemFontOfSize:12.5*BILI];
    [checkNumberBottomView addSubview:self.getCheckNumberButton];
    
    UIButton * agreeButton = [[UIButton alloc] initWithFrame:CGRectMake(checkNumberBottomView.frame.origin.x, checkNumberBottomView.frame.origin.y+checkNumberBottomView.frame.size.height+9*BILI, 18*BILI, 18*BILI)];
    [agreeButton addTarget:self action:@selector(agreeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [agreeButton setBackgroundColor:UIColorFromRGB(0xFF5C93)];
    agreeButton.titleLabel.font = [UIFont systemFontOfSize:12*BILI];
    agreeButton.layer.cornerRadius = 9*BILI;
    [agreeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [agreeButton setTitle:@"√" forState:UIControlStateNormal];
    [self.view addSubview:agreeButton];
    
    UIButton * agreeMentButton = [[UIButton alloc] initWithFrame:CGRectMake( agreeButton.frame.origin.x+agreeButton.frame.size.width+10*BILI, checkNumberBottomView.frame.origin.y+checkNumberBottomView.frame.size.height,130*BILI, 12*BILI+21*BILI)];
    agreeMentButton.titleLabel.font = [UIFont systemFontOfSize:12*BILI];
    [agreeMentButton setTitleColor:UIColorFromRGB(0xF85BA3) forState:UIControlStateNormal];
    [agreeMentButton setTitle:@"《探聊用户协议》" forState:UIControlStateNormal];
    agreeMentButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [agreeMentButton addTarget:self action:@selector(agreeMentButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:agreeMentButton];

    UIButton * loginBUtton  = [[UIButton alloc] initWithFrame:CGRectMake(checkNumberBottomView.frame.origin.x, checkNumberBottomView.frame.origin.y+checkNumberBottomView.frame.size.height+50*BILI, checkNumberBottomView.frame.size.width, 40*BILI)];
    loginBUtton.backgroundColor= UIColorFromRGB(0xFF5C93);
    loginBUtton.layer.cornerRadius = 20*BILI;
    [loginBUtton setTitle:@"登录" forState:UIControlStateNormal];
    [loginBUtton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [loginBUtton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBUtton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
    [self.view addSubview:loginBUtton];
}
-(void)agreeButtonClick:(id)sender
{
    UIButton * button  = (UIButton *)sender;
    if (agree == 1) {
        agree=-1;
        button.backgroundColor = [UIColor lightGrayColor];
    }
    else
    {
        agree=1;
        button.backgroundColor = UIColorFromRGB(0xFF5C93);
    }
}
-(void)agreeMentButtonClick
{
    TanLiaoLiao_AgreementWebViewController * agreementWebVC = [[TanLiaoLiao_AgreementWebViewController alloc] init];
    [self.navigationController pushViewController:agreementWebVC animated:YES];
}
-(void)loginButtonClick
{
    

    if (self.telTextField.text.length!=11) {
        
        [TanLiao_Common showToastView:@"请输入正确的手机号码" view:self.view];

        return;
    }
    if (self.checkNumberTextField.text==0) {
        
        [TanLiao_Common showToastView:@"请输入验证码" view:self.view];
        return;
    }
    
    [self showNewLoadingView:nil view:nil];
    [self.cloudClient phoneLogin:@"8047"
                     phoneNumber:self.telTextField.text
                        authCode:self.checkNumberTextField.text
                        delegate:self
                        selector:@selector(loginSuccess:)
                   errorSelector:@selector(loginError:)];
    
}
-(void)loginSuccess:(NSDictionary *)info
{
    
    NSUserDefaults* loginStatusDefaults = [NSUserDefaults standardUserDefaults];


 
    [loginStatusDefaults setObject:@"1" forKey:LoginStatus];
    [loginStatusDefaults synchronize];

    [self hideNewLoadingView];

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


                                          NSLog(@"%@",toast);                                      }
                                  }];
    
    [[RongCloudManager getInstance] connectRongCloud];
     [[NSNotificationCenter defaultCenter] removeObserver:self name:ZhuBoHuJiaoNotification object:nil];
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate resetLoginTabBar];


}
-(void)loginError:(NSDictionary *)info
{
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        
        UITextView * pccregY97329 = [[UITextView alloc]initWithFrame:CGRectMake(61,31,89,25)];
        pccregY97329.backgroundColor = [UIColor whiteColor];
        pccregY97329.layer.borderColor = [[UIColor greenColor] CGColor];
        pccregY97329.layer.cornerRadius =7;
        [self.view addSubview:pccregY97329];
        
    }
    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];
    [self hideNewLoadingView];
}


-(void)getCheckNumberButtonClick
{
    if (self.telTextField.text.length == 11) {
        [self.telTextField resignFirstResponder];

        [self.checkNumberTextField resignFirstResponder];
        self.getCheckNumberButton.enabled = NO;
        
        stepSeconds = 60;
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(daoShu) userInfo:nil repeats:YES];
    }
    else
    {
        UIButton * tipButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-200)/2,VIEW_HEIGHT-100, 200, 40)];
        tipButton.enabled = NO;
        tipButton.alpha = 0.8;
        tipButton.layer.cornerRadius = 20;
        tipButton.backgroundColor = [UIColor blackColor];
        [tipButton setTitle:@"请输入正确的手机号码" forState:UIControlStateNormal];
        [tipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        tipButton.titleLabel.font = [UIFont systemFontOfSize:15];
        tipButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:tipButton];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:3];
        tipButton.alpha = 0;
        [UIView commitAnimations];
    }
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        UIView * EctvQihk = [[UIView alloc]initWithFrame:CGRectMake(89,22,43,91)];
        EctvQihk.layer.cornerRadius =8;
        EctvQihk.layer.cornerRadius =9;
        EctvQihk.userInteractionEnabled = YES;
        EctvQihk.layer.masksToBounds = YES;
        [self.view addSubview:EctvQihk];
    }

}
-(void)daoShu
{
 
    
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:@(643)];
        [array addObject:@(946)];
        [array addObject:@(943)];
        [array addObject:@(941)];
        
    }
    stepSeconds --;
    [self.getCheckNumberButton setTitle:[NSString stringWithFormat:@"%d秒",stepSeconds] forState:UIControlStateNormal];
    if(stepSeconds == 0)
    {
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

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
