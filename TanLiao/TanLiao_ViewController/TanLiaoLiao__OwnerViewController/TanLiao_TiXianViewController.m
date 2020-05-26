//
//  TiXianViewController.m
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/5/5.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_TiXianViewController.h"

@interface TanLiao_TiXianViewController ()

@end

@implementation TanLiao_TiXianViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLale.text = @"提现";
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];




    [self.cloudClient setToastView:self.view];



 

    [self setTabBarHidden];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap)];
    
    UILabel * moneyLable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height,12*BILI+108*BILI/2, 45*BILI)];
    moneyLable.font = [UIFont systemFontOfSize:18*BILI];
    moneyLable.textColor = [UIColor blackColor];




    moneyLable.alpha = 0.9;
    moneyLable.textAlignment = NSTextAlignmentRight;
    moneyLable.text = @"金额:";
    moneyLable.backgroundColor = [UIColor whiteColor];


 


    [self.view addSubview:moneyLable];


 


    
    self.moneyTextField = [[UITextField alloc] initWithFrame:CGRectMake(12*BILI+108*BILI/2+5*BILI, moneyLable.frame.origin.y, VIEW_WIDTH-(12*BILI+216*BILI/2+12*BILI), 45*BILI)];
    self.moneyTextField.backgroundColor = [UIColor whiteColor];


 

   

    self.moneyTextField.textColor = [UIColor blackColor];



   

    self.moneyTextField.alpha = 0.9;
    self.moneyTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.moneyTextField.placeholder = @"请输入提现金额";
    self.moneyTextField.font = [UIFont systemFontOfSize:18*BILI];
    [self.view addSubview:self.moneyTextField];
    
    if ([@"shareJiangLi" isEqualToString:self.fromWhere]) {
        
        self.moneyTextField.text = self.tiXianMoney;
        self.moneyTextField.enabled = NO;
    }
    UIView * lineView0 = [[UIView alloc] initWithFrame:CGRectMake(0, moneyLable.frame.origin.y+moneyLable.frame.size.height, VIEW_WIDTH, 1)];
    lineView0.backgroundColor = [UIColor blackColor];


 
 

    lineView0.alpha = 0.05;
    [self.view addSubview:lineView0];
    [self.view addGestureRecognizer:tap];
    
    UILabel * accountLable = [[UILabel alloc] initWithFrame:CGRectMake(0, moneyLable.frame.origin.y+moneyLable.frame.size.height+1, 12*BILI+216*BILI/2, 45*BILI)];
    accountLable.font = [UIFont systemFontOfSize:18*BILI];
    accountLable.textColor = [UIColor blackColor];



   

    accountLable.alpha = 0.9;
    accountLable.textAlignment = NSTextAlignmentRight;
    accountLable.text = @"支付宝账号:";
    accountLable.backgroundColor = [UIColor whiteColor];


 

   

    [self.view addSubview:accountLable];



 


    self.acountTextField = [[UITextField alloc] initWithFrame:CGRectMake(12*BILI+216*BILI/2+5*BILI, accountLable.frame.origin.y, VIEW_WIDTH-(12*BILI+216*BILI/2+12*BILI), 45*BILI)];
     self.acountTextField.backgroundColor = [UIColor whiteColor];


 

   

    self.acountTextField.textColor = [UIColor blackColor];




    self.acountTextField.alpha = 0.9;
    self.acountTextField.placeholder = @"请输入账号";
    self.acountTextField.font = [UIFont systemFontOfSize:18*BILI];
    [self.view addSubview:self.acountTextField];
    
    if (![TanLiao_Common isEmpty:[self.info objectForKey:@"accountId"]])
    {
        self.acountTextField.text = [self.info objectForKey:@"accountId"];
    }

    UIView * lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, accountLable.frame.origin.y+accountLable.frame.size.height, VIEW_WIDTH, 1)];
    lineView1.backgroundColor = [UIColor blackColor];




    lineView1.alpha = 0.05;
    [self.view addSubview:lineView1];
    
    UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(0, accountLable.frame.origin.y+accountLable.frame.size.height+1, 12*BILI+108*BILI/2, 45*BILI)];
     nameLable.backgroundColor = [UIColor whiteColor];



   

    nameLable.font = [UIFont systemFontOfSize:18*BILI];
    nameLable.textColor = [UIColor blackColor];




    nameLable.alpha = 0.9;
    nameLable.textAlignment = NSTextAlignmentRight;
    nameLable.text = @"姓名:";
    [self.view addSubview:nameLable];



 

    
    self.nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(12*BILI+108*BILI/2+5*BILI, nameLable.frame.origin.y, VIEW_WIDTH-(12*BILI+108*BILI/2+12*BILI), 45*BILI)];
     self.nameTextField.backgroundColor = [UIColor whiteColor];


 

    self.nameTextField.textColor = [UIColor blackColor];
    

    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        UIScrollView * RkspPwut = [[UIScrollView alloc]initWithFrame:CGRectMake(78,79,51,60)];
        RkspPwut.layer.cornerRadius =8;
        [self.view addSubview:RkspPwut];
        
    }
    


    self.nameTextField.alpha = 0.9;
    self.nameTextField.placeholder = @"请输入姓名";
    self.nameTextField.font = [UIFont systemFontOfSize:18*BILI];
    [self.view addSubview:self.nameTextField];
    
    if (![TanLiao_Common isEmpty:[self.info objectForKey:@"name"]])
    {
        self.nameTextField.text = [self.info objectForKey:@"name"];
    }

    
    UIView * lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, nameLable.frame.origin.y+nameLable.frame.size.height, VIEW_WIDTH, 1)];
    lineView2.backgroundColor = [UIColor blackColor];
    lineView2.alpha = 0.05;
    [self.view addSubview:lineView2];


 
    UILabel * telLable = [[UILabel alloc] initWithFrame:CGRectMake(0, nameLable.frame.origin.y+nameLable.frame.size.height+1, 12*BILI+108*BILI/2, 45*BILI)];
     telLable.backgroundColor = [UIColor whiteColor];
    telLable.font = [UIFont systemFontOfSize:18*BILI];
    telLable.textColor = [UIColor blackColor];
    telLable.alpha = 0.9;
    telLable.text = @"电话:";
    telLable.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:telLable];


 
    
    self.telTextField = [[UITextField alloc] initWithFrame:CGRectMake(12*BILI+108*BILI/2+5*BILI, telLable.frame.origin.y, VIEW_WIDTH-(12*BILI+108*BILI/2+12*BILI), 45*BILI)];
     self.telTextField.backgroundColor = [UIColor whiteColor];



    self.telTextField.textColor = [UIColor blackColor];
    self.telTextField.alpha = 0.9;
    self.telTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.telTextField.font = [UIFont systemFontOfSize:18*BILI];
    self.telTextField.placeholder = @"请输入手机号";
    [self.view addSubview:self.telTextField];
    
    if (![TanLiao_Common isEmpty:[self.info objectForKey:@"phoneNumber"]])
    {
        self.telTextField.text = [self.info objectForKey:@"phoneNumber"];
    }
    
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.telTextField.frame.origin.y+self.telTextField.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT)];
    bottomView.backgroundColor = [UIColor blackColor];
    bottomView.alpha = 0.05;
    [self.view addSubview:bottomView];




    
    UILabel * tipLable2 = [[UILabel alloc] initWithFrame:CGRectMake(0, self.telTextField.frame.origin.y+self.telTextField.frame.size.height+33*BILI/2, VIEW_WIDTH, 12*BILI)];
    tipLable2.font = [UIFont systemFontOfSize:12*BILI];
    tipLable2.textColor = [UIColor blackColor];
    tipLable2.textAlignment = NSTextAlignmentCenter;
     NSString * withDrawAmount = [self.info objectForKey:@"withDrawAmount"];
    tipLable2.text = [NSString stringWithFormat:@"Tip:提现金额不能少于%d元",withDrawAmount.intValue/100];
    tipLable2.alpha = 0.3;
    [self.view addSubview:tipLable2];
    
    UIButton  * tiJiaoButton = [[UIButton alloc] initWithFrame:CGRectMake(35*BILI/2, telLable.frame.origin.y+telLable.frame.size.height+40*BILI, VIEW_WIDTH-36*BILI, 40*BILI)];
    tiJiaoButton.backgroundColor = UIColorFromRGB(0xFF5C93);
    tiJiaoButton.layer.cornerRadius = 4;
    [tiJiaoButton setTitle:@"提交" forState:UIControlStateNormal];
    [tiJiaoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tiJiaoButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
    [tiJiaoButton addTarget:self action:@selector(tiJiaoButtonClick) forControlEvents:UIControlEventTouchUpInside];




    [self.view addSubview:tiJiaoButton];
    
   
    UITextView * tipTextView = [[UITextView alloc] initWithFrame:CGRectMake(35*BILI/2, tiJiaoButton.frame.origin.y+tiJiaoButton.frame.size.height+20*BILI, VIEW_WIDTH-35*BILI, 200)];
    tipTextView.text = @"提现温馨提示：\n1.  提现时间处理为每周一下午3点；\n2. 提现到账时间为下午3点到下午5点（如有特殊情况无法按规定时间到账平台会另行通知）\n3. 主播账户显示的余额等于可提现金额";
    tipTextView.backgroundColor = [UIColor clearColor];
    tipTextView.font = [UIFont systemFontOfSize:12*BILI];
    tipTextView.editable = NO;
    tipTextView.scrollEnabled = NO;
    [self.view addSubview:tipTextView];

}


-(void)tiJiaoButtonClick
{
    
    if ([@"shareJiangLi" isEqualToString:self.fromWhere])
    {
        if (self.acountTextField.text.length ==0) {
            
            [TanLiao_Common showToastView:@"请输入支付宝账号" view:self.view];




            return;
        }
        
        if (self.nameTextField.text.length ==0) {
            
            [TanLiao_Common showToastView:@"请输入姓名" view:self.view];


 


            return;
        }
        
        if (self.telTextField.text.length ==0) {
            
            [TanLiao_Common showToastView:@"请输入电话号码" view:self.view];


 

 

            return;
        }
         [self showNewLoadingView:nil view:nil];
        [self.cloudClient lingQuDaoZfb:@"8085"
                             accountId:self.acountTextField.text
                                  name:self.nameTextField.text
                              idNumber:@""
                           phoneNumber:self.telTextField.text
                              delegate:self
                              selector:@selector(tiXianSuccess:)
                         errorSelector:@selector(tiXianError:)];
    }
    else
    {
        NSString * withDrawAmount = [self.info objectForKey:@"withDrawAmount"];

        if ( [TanLiao_Common isEmpty:self.moneyTextField.text]) {
            
            [TanLiao_Common showToastView:@"请输入提现金额" view:self.view];




            return;
        }
        else if(self.moneyTextField.text.intValue<withDrawAmount.intValue/100)
        {
            [TanLiao_Common showToastView:[NSString stringWithFormat:@"提现金额不能少于%d元",withDrawAmount.intValue/100] view:self.view];



             ;
            return;
        }
        else if (self.moneyTextField.text.intValue*100>self.money.intValue)
        {
            [TanLiao_Common showToastView:@"提现金额不能大于账户余额" view:self.view];


 


            return;
        }
        
        if (self.acountTextField.text.length ==0) {
            
            [TanLiao_Common showToastView:@"请输入支付宝账号" view:self.view];


 


            return;
        }
        
        if (self.nameTextField.text.length ==0) {
            
            [TanLiao_Common showToastView:@"请输入姓名" view:self.view];


 

            return;
        }
        
        
        if (self.telTextField.text.length ==0) {
            
            [TanLiao_Common showToastView:@"请输入电话号码" view:self.view];


 

            return;
        }
        NSString * moneyGold = [NSString stringWithFormat:@"%d",self.moneyTextField.text.intValue*JinBiBiLi];
        [self showNewLoadingView:nil view:nil];
        [self.cloudClient tiXian:@"8045"
                       accountId:self.acountTextField.text
                     phoneNumber:self.telTextField.text
                     accountType:@"1"
                            name:self.nameTextField.text
                        idNumber:@""
                      goldNumber:moneyGold
                        delegate:self
                        selector:@selector(tiXianSuccess:)
                   errorSelector:@selector(tiXianError:)];

    }
    

}

-(void)tiXianSuccess:(NSDictionary *)info
{
    [self hideNewLoadingView];



 

    [TanLiao_Common showToastView:@"提现请求处理成功" view:self.view];




    [self performSelector:@selector(tiXianSuccess) withObject:nil afterDelay:0.5];
}

-(void)tiXianSuccess
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)tiXianError:(NSDictionary *)info
{
     [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];


 

 

    [self hideNewLoadingView];


 

}
-(void)viewTap
{
    [self.acountTextField resignFirstResponder];


 


    [self.nameTextField resignFirstResponder];


 


    [self.telTextField resignFirstResponder];




    [self.shenFenNumberTextField resignFirstResponder];


 
if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
{
    UIView * NthjuVhckc = [[UIView alloc]initWithFrame:CGRectMake(37,79,68,81)];
    NthjuVhckc.layer.cornerRadius =8;
    [self.view addSubview:NthjuVhckc];
}
   

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (NSArray *)gpy_swlcY344xyhxV705
{
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@(120)];
    [array addObject:@(360)];
    [array addObject:@(495)];
    [array addObject:@(859)];
    [array addObject:@(553)];
    [array addObject:@(173)];
    [array addObject:@(263)];
    return array;
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
