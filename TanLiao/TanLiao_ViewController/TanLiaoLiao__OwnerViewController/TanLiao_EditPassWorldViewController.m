//
//  EditPassWorldViewController.m
//  tcmy
//
//  Created by 唐蒙波 on 2017/11/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_EditPassWorldViewController.h"

@interface TanLiao_EditPassWorldViewController ()

@end

@implementation TanLiao_EditPassWorldViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];



 

    self.titleLale.text = @"修改密码";
    
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT)];
    bottomView.backgroundColor = [UIColor blackColor];


 

   

    bottomView.alpha = 0.05;
    [self.view addSubview:bottomView];


 

 

    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap)];
    [bottomView addGestureRecognizer:tap];
    
    UIButton * oldPassWorldButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height+5*BILI, VIEW_WIDTH, 45*BILI)];
    oldPassWorldButton.backgroundColor = [UIColor whiteColor];


 

   

    [self.view addSubview:oldPassWorldButton];


    UILabel * settingLable = [[UILabel alloc] initWithFrame:CGRectMake(35*BILI/2, 0, 15*BILI*4.5, 45*BILI)];
    settingLable.font = [UIFont systemFontOfSize:15*BILI];
    settingLable.textColor = [UIColor blackColor];


 

    settingLable.alpha = 0.9;
    settingLable.text = @"旧密码：";
    [oldPassWorldButton addSubview:settingLable];


 

 


    self.oldPassWorldTextField = [[UITextField alloc] initWithFrame:CGRectMake(154*BILI/2, 0, 300*BILI, 45*BILI)];
    self.oldPassWorldTextField.placeholder = @"输入您的旧密码";
    self.oldPassWorldTextField.font = [UIFont systemFontOfSize:15*BILI];
    self.oldPassWorldTextField.textColor = [UIColor blackColor];



   

    self.oldPassWorldTextField.alpha = 0.5;
    [oldPassWorldButton addSubview:self.oldPassWorldTextField];
    
    UIButton * newPassWorldButton1 = [[UIButton alloc] initWithFrame:CGRectMake(0, oldPassWorldButton.frame.origin.y+oldPassWorldButton.frame.size.height+1*BILI, VIEW_WIDTH, 45*BILI)];
    newPassWorldButton1.backgroundColor = [UIColor whiteColor];



   

    [self.view addSubview:newPassWorldButton1];
    
    
    UILabel * newPassWorld1 = [[UILabel alloc] initWithFrame:CGRectMake(35*BILI/2, 0, 15*BILI*4.5, 45*BILI)];
    newPassWorld1.font = [UIFont systemFontOfSize:15*BILI];
    newPassWorld1.textColor = [UIColor blackColor];



    newPassWorld1.alpha = 0.9;
    newPassWorld1.text = @"新密码：";
    [newPassWorldButton1 addSubview:newPassWorld1];
    
    self.xinPWTextField1 = [[UITextField alloc] initWithFrame:CGRectMake(154*BILI/2, 0, 300*BILI, 45*BILI)];
    self.xinPWTextField1.placeholder = @"输入您的新密码(密码只能包含字母和数字)";
    self.xinPWTextField1.font = [UIFont systemFontOfSize:15*BILI];
    self.xinPWTextField1.textColor = [UIColor blackColor];


 


    self.xinPWTextField1.alpha = 0.5;
    [newPassWorldButton1 addSubview:self.xinPWTextField1];
    
    UIButton * newPassWorldButton2 = [[UIButton alloc] initWithFrame:CGRectMake(0, newPassWorldButton1.frame.origin.y+newPassWorldButton1.frame.size.height+1*BILI, VIEW_WIDTH, 45*BILI)];
    newPassWorldButton2.backgroundColor = [UIColor whiteColor];



    [self.view addSubview:newPassWorldButton2];
    
    
    UILabel * newPassWorld2 = [[UILabel alloc] initWithFrame:CGRectMake(35*BILI/2, 0, 15*BILI*4.5, 45*BILI)];
    newPassWorld2.font = [UIFont systemFontOfSize:15*BILI];
    newPassWorld2.textColor = [UIColor blackColor];



    newPassWorld2.alpha = 0.9;
    newPassWorld2.text = @"新密码：";
    [newPassWorldButton2 addSubview:newPassWorld2];
    
    self.xinPWTextField2 = [[UITextField alloc] initWithFrame:CGRectMake(154*BILI/2, 0, 300*BILI, 45*BILI)];
    self.xinPWTextField2.placeholder = @"确认您的新密码";
    self.xinPWTextField2.font = [UIFont systemFontOfSize:15*BILI];
    self.xinPWTextField2.textColor = [UIColor blackColor];


 


    self.xinPWTextField2.alpha = 0.5;
    [newPassWorldButton2 addSubview:self.xinPWTextField2];
    
    UIButton * editButton = [[UIButton alloc] initWithFrame:CGRectMake(35*BILI/2, 154*BILI/2+newPassWorldButton2.frame.origin.y+newPassWorldButton2.frame.size.height, 680*BILI/2, 40*BILI)];
    editButton.layer.cornerRadius = 8*BILI;
    editButton.backgroundColor = UIColorFromRGB(0xFF5C93);
    [editButton setTitle:@"确定修改" forState:UIControlStateNormal];
    [editButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [editButton addTarget:self action:@selector(editPassWorldButtonClick) forControlEvents:UIControlEventTouchUpInside];



    [self.view addSubview:editButton];
}
-(void)viewTap
{
    [self.oldPassWorldTextField resignFirstResponder];




    [self.xinPWTextField1 resignFirstResponder];


    [self.xinPWTextField2 resignFirstResponder];


    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        UIView * NthjuVhckc = [[UIView alloc]initWithFrame:CGRectMake(76,40,53,37)];
        NthjuVhckc.layer.cornerRadius =8;
        [self.view addSubview:NthjuVhckc];
        
    }

}
-(void)editPassWorldButtonClick
{
    if ([TanLiao_Common isEmpty:self.oldPassWorldTextField.text]||[TanLiao_Common isEmpty:self.xinPWTextField1.text]||[TanLiao_Common isEmpty:self.xinPWTextField2.text]) {
        
        [TanLiao_Common showToastView:@"密码格式有误" view:self.view];


 


        return;
    }
    if (![self.xinPWTextField1.text isEqualToString:self.xinPWTextField2.text]) {
        
        [TanLiao_Common showToastView:@"新密码不一致" view:self.view];

        return;
    }
    if(! [TanLiao_Common validateUserName:self.oldPassWorldTextField.text]|| ![TanLiao_Common validateUserName:self.xinPWTextField1.text]|| ![TanLiao_Common validateUserName:self.xinPWTextField1.text])
    {
        [TanLiao_Common showToastView:@"密码只能包含字母和数字" view:self.view];




        return;
    }
    
    [self.cloudClient editPassWorld:@"8090"
                          accountId:[TanLiao_Common getNowUserID]
                           password:self.oldPassWorldTextField.text
                        newPassword:self.xinPWTextField1.text
                           delegate:self
                           selector:@selector(editSuccess:)
                      errorSelector:@selector(editError:)];
   
}
-(void)editSuccess:(NSDictionary *) info
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:UserAccountAndPassWorld];
    NSDictionary * accountInfo = [[NSDictionary alloc] initWithObjectsAndKeys:[TanLiao_Common getNowUserID],@"userId",self.xinPWTextField1.text,@"password", nil];
    [defaults setObject:accountInfo forKey:UserAccountAndPassWorld];
    [defaults synchronize];
    [TanLiao_Common showToastView:@"密码修改成功" view:self.view];

}
-(void)editError:(NSDictionary *)info
{
    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];

}
- (void)initDataUpvgkhUrefdtVC:(NSDictionary *)info
{
    UIView * IyevAico = [[UIView alloc]initWithFrame:CGRectMake(47,40,74,60)];
    IyevAico.layer.cornerRadius =6;
    [self.view addSubview:IyevAico];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
