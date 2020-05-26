//
//  FinishRegisterViewController.m
//  tcmy
//
//  Created by 唐蒙波 on 2017/11/27.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiaoLiao_FinishRegisterViewController.h"

@interface TanLiaoLiao_FinishRegisterViewController ()

@end

@implementation TanLiaoLiao_FinishRegisterViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];
    self.titleLale.text = @"注册";
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT)];
    self.mainScrollView.backgroundColor =[UIColor whiteColor];

    [self.view addSubview:self.mainScrollView];


    UILabel * titleTipLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 61*BILI, VIEW_WIDTH, 20*BILI)];
    titleTipLable.textColor = UIColorFromRGB(0xFF4E87);
    titleTipLable.textAlignment = NSTextAlignmentCenter;
    titleTipLable.font = [UIFont systemFontOfSize:20*BILI];
    titleTipLable.text = @"您已成功注册为探聊用户";
    [self.mainScrollView addSubview:titleTipLable];

    UILabel * accountTipLable = [[UILabel alloc] initWithFrame:CGRectMake(0, titleTipLable.frame.origin.y+titleTipLable.frame.size.height+60*BILI, VIEW_WIDTH, 15*BILI)];
    accountTipLable.textColor = UIColorFromRGB(0xFF4E87);
    accountTipLable.textAlignment = NSTextAlignmentCenter;
    accountTipLable.font = [UIFont systemFontOfSize:15*BILI];
    accountTipLable.text = @"登录账户";
    [self.mainScrollView addSubview:accountTipLable];
    UILabel * accountLable = [[UILabel alloc] initWithFrame:CGRectMake(125*BILI/2, accountTipLable.frame.origin.y+accountTipLable.frame.size.height+10*BILI, VIEW_WIDTH-125*BILI, 40*BILI)];
    accountLable.layer.borderColor = [UIColorFromRGB(0x979797) CGColor];

    accountLable.layer.borderWidth = 1;
    accountLable.layer.cornerRadius = 20*BILI;
    accountLable.textColor = UIColorFromRGB(0x666666);
    accountLable.font = [UIFont systemFontOfSize:18*BILI];
    accountLable.textAlignment = NSTextAlignmentCenter;
    accountLable.text = [self.userInfo objectForKey:@"userId"];
    [self.mainScrollView addSubview:accountLable];
    
    UILabel * pwTipLable = [[UILabel alloc] initWithFrame:CGRectMake(0, accountLable.frame.origin.y+accountLable.frame.size.height+15*BILI, VIEW_WIDTH, 15*BILI)];
    pwTipLable.textColor = UIColorFromRGB(0xFF4E87);
    pwTipLable.textAlignment = NSTextAlignmentCenter;
    pwTipLable.font = [UIFont systemFontOfSize:15*BILI];
    pwTipLable.text = @"登录密码";
    [self.mainScrollView addSubview:pwTipLable];

    
    UILabel * pwLable = [[UILabel alloc] initWithFrame:CGRectMake(125*BILI/2, pwTipLable.frame.origin.y+pwTipLable.frame.size.height+10*BILI, VIEW_WIDTH-125*BILI, 40*BILI)];
    pwLable.layer.borderColor = [UIColorFromRGB(0x979797) CGColor];


    pwLable.layer.borderWidth = 1;
    pwLable.layer.cornerRadius = 20*BILI;
    pwLable.textColor = UIColorFromRGB(0x666666);
    pwLable.font = [UIFont systemFontOfSize:18*BILI];
    pwLable.textAlignment = NSTextAlignmentCenter;
    pwLable.text = [self.userInfo objectForKey:@"password"];
    [self.mainScrollView addSubview:pwLable];

    UILabel * tipLable1 = [[UILabel alloc] initWithFrame:CGRectMake(pwLable.frame.origin.x, pwLable.frame.origin.y+pwLable.frame.size.height+25*BILI, 200*BILI, 12*BILI)];
    tipLable1.font = [UIFont systemFontOfSize:18*BILI];
    tipLable1.textColor = UIColorFromRGB(0xFF4E87);
    tipLable1.text = @"温馨提示";
    [self.mainScrollView addSubview:tipLable1];
    
    UILabel * tipLable2 = [[UILabel alloc] initWithFrame:CGRectMake(tipLable1.frame.origin.x, tipLable1.frame.origin.y+tipLable1.frame.size.height+10*BILI, 300*BILI, 12*BILI)];
    tipLable2.font = [UIFont systemFontOfSize:12*BILI];
    tipLable2.textColor =  UIColorFromRGB(0x999999);
    tipLable2.text = @"1:请妥善保存账号密码 以免造成不必要的损失";
    [self.mainScrollView addSubview:tipLable2];
    
    
    UILabel * tipLable3 = [[UILabel alloc] initWithFrame:CGRectMake(tipLable1.frame.origin.x, tipLable2.frame.origin.y+tipLable2.frame.size.height+10*BILI, 400*BILI, 12*BILI)];
    tipLable3.font = [UIFont systemFontOfSize:12*BILI];
    tipLable3.textColor =  UIColorFromRGB(0x999999);
    tipLable3.text = @"2:进入探聊后，可前往“我”页面修改密码";
    [self.mainScrollView addSubview:tipLable3];
    
    UIButton * finishButton = [[UIButton alloc] initWithFrame:CGRectMake(125*BILI/2, tipLable3.frame.origin.y+tipLable3.frame.size.height+24*BILI, VIEW_WIDTH-125*BILI, 40*BILI)];
    finishButton.backgroundColor = UIColorFromRGB(0xFF5C93);
    finishButton.layer.cornerRadius = 20*BILI;
    [finishButton setTitle:@"进入探聊" forState:UIControlStateNormal];
    [finishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [finishButton addTarget:self action:@selector(startButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:finishButton];
    
}
-(void)leftClick
{
    
    
    
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:@(484)];
        [array addObject:@(537)];
        [array addObject:@(708)];
        [array addObject:@(508)];
        
    }
    

    [self.navigationController popToRootViewControllerAnimated:YES];
}


-(void)startButtonClick
{
    [self showNewLoadingView:@"登录中..." view:self.view];
    NSUserDefaults * authCodeDefaults = [NSUserDefaults standardUserDefaults];

    NSString * authCode = [authCodeDefaults objectForKey:UNIQUEID];
    
    

    [self.cloudClient youKeLogin:@"8089"
                       accountId:[self.userInfo objectForKey:@"userId"]
                        password:[self.userInfo objectForKey:@"password"]
                        authCode:authCode
                        delegate:self
                        selector:@selector(loginSuccess:)
                   errorSelector:@selector(loginError:)];
}
-(void)loginSuccess:(NSDictionary *)info
{
    [self hideNewLoadingView];


    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:info forKey:USERINFO];
    [defaults synchronize];
    NSUserDefaults* defaults1 = [NSUserDefaults standardUserDefaults];
    NSDictionary * acocuntInfo = [[NSDictionary alloc] initWithObjectsAndKeys:[self.userInfo objectForKey:@"userId"],@"userId",[self.userInfo objectForKey:@"password"],@"password" ,nil];
    [defaults1 setObject:acocuntInfo forKey:UserAccountAndPassWorld];
    [defaults1 synchronize];

    
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

    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        UITableView * uiButton = [[UITableView alloc]initWithFrame:CGRectMake(99,49,10,75)];
        uiButton.backgroundColor = [UIColor whiteColor];
        uiButton.layer.borderColor = [[UIColor greenColor] CGColor];
        uiButton.layer.cornerRadius =9;
        [self.view addSubview:uiButton];
    }
 
   

}
-(void)loginError:(NSDictionary *)info
{
    [self hideNewLoadingView];
    
    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];

}
-(void)push_jiqx
{
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:@(166)];
        [array addObject:@(862)];
        [array addObject:@(824)];
        [array addObject:@(803)];
        
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
