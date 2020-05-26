//
//  BangDingTelViewController.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/7/20.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiao_BangDingTelViewController.h"

@interface TanLiao_BangDingTelViewController ()

@end

@implementation TanLiao_BangDingTelViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLale.text = @"手机号码绑定";
    self.lineView.hidden = YES;
    [self setTabBarHidden];
    
    self.cloudClient = [KuaiLiaoCloudClient getInstance];

    
    if (!self.mobel)
    {
        UIImageView * topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(80*BILI, self.navView.frame.origin.y+self.navView.frame.size.height+25*BILI, VIEW_WIDTH-160*BILI, 63*BILI)];
        topImageView.image = [UIImage imageNamed:@"bangDingTelAnQuan"];
        [self.view addSubview:topImageView];



        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap)];
        [self.view addGestureRecognizer:tap];
        
        
        UILabel * telTipLable = [[UILabel alloc] initWithFrame:CGRectMake(15*BILI, topImageView.frame.origin.y+topImageView.frame.size.height+40*BILI, 105*BILI, 50*BILI)];
        telTipLable.textColor = [UIColor blackColor];


 


        telTipLable.alpha = 0.2;
        telTipLable.font = [UIFont systemFontOfSize:15*BILI];
        telTipLable.text = @"请输入您的手机号";
        telTipLable.adjustsFontSizeToFitWidth = YES;
        [self.view addSubview:telTipLable];



 

        
        self.telTextField = [[UITextField alloc] initWithFrame:CGRectMake(telTipLable.frame.origin.x+telTipLable.frame.size.width+20*BILI, topImageView.frame.origin.y+topImageView.frame.size.height+40*BILI, VIEW_WIDTH-(telTipLable.frame.origin.x+telTipLable.frame.size.width+20*BILI+15*BILI), 50*BILI)];
        self.telTextField.font = [UIFont systemFontOfSize:18*BILI];
        self.telTextField.textColor = [UIColor blackColor];




        self.telTextField.alpha = 0.6;
        self.telTextField.keyboardType = UIKeyboardTypePhonePad;
        [self.view addSubview:self.telTextField];
        
        [self.telTextField becomeFirstResponder];



        
        UIView * lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, telTipLable.frame.origin.y+telTipLable.frame.size.height, VIEW_WIDTH, 1*BILI)];
        lineView1.backgroundColor = [UIColor blackColor];


 
if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
{
    UITableView * zumlakJ27961 = [[UITableView alloc]initWithFrame:CGRectMake(33,18,96,47)];
    zumlakJ27961.layer.borderWidth = 1;
    zumlakJ27961.clipsToBounds = YES;
    zumlakJ27961.layer.cornerRadius =7;

  UIScrollView * jrrokeU32895 = [[UIScrollView alloc]initWithFrame:CGRectMake(89,50,100,64)];
  jrrokeU32895.backgroundColor = [UIColor whiteColor];
  jrrokeU32895.layer.borderColor = [[UIColor greenColor] CGColor];
 jrrokeU32895.layer.cornerRadius =10;
    UITextView * tfbbavD06992 = [[UITextView alloc]initWithFrame:CGRectMake(7,48,8,14)];
    tfbbavD06992.backgroundColor = [UIColor whiteColor];
    tfbbavD06992.layer.borderColor = [[UIColor greenColor] CGColor];
    tfbbavD06992.layer.cornerRadius =5;
    
    UITextView * pcnycC6729 = [[UITextView alloc]initWithFrame:CGRectMake(41,18,96,44)];
    pcnycC6729.layer.borderWidth = 1;
    pcnycC6729.clipsToBounds = YES;
    pcnycC6729.layer.cornerRadius =7;
    UIView * xtkyN198 = [[UIView alloc]initWithFrame:CGRectMake(28,29,7,78)];
    xtkyN198.layer.borderWidth = 1;
    xtkyN198.clipsToBounds = YES;
    xtkyN198.layer.cornerRadius =10;
    UIImageView * cdsplS9731 = [[UIImageView alloc]initWithFrame:CGRectMake(6,35,94,42)];
    cdsplS9731.layer.borderWidth = 1;
    cdsplS9731.clipsToBounds = YES;
    cdsplS9731.layer.cornerRadius =6;
    UIView * fgihwQ7301 = [[UIView alloc]initWithFrame:CGRectMake(5,78,85,49)];
    fgihwQ7301.backgroundColor = [UIColor whiteColor];
    fgihwQ7301.layer.borderColor = [[UIColor greenColor] CGColor];
    fgihwQ7301.layer.cornerRadius =10;

}
   

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
        
        UIButton * registerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, lineView2.frame.origin.y+lineView2.frame.size.height+35*BILI/2, VIEW_WIDTH, 45*BILI)];
        [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [registerButton setTitle:@"立即绑定" forState:UIControlStateNormal];
        [registerButton addTarget:self action:@selector(registerButtonClick) forControlEvents:UIControlEventTouchUpInside];




        registerButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
        registerButton.backgroundColor = UIColorFromRGB(0xFF5C93);
        [self.view addSubview:registerButton];
    }
    else
    {
        
        UIImageView * topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(79*BILI, self.navView.frame.origin.y+self.navView.frame.size.height+70*BILI, VIEW_WIDTH-158*BILI, 365*BILI/2)];
        topImageView.image = [UIImage imageNamed:@"yiBangDingGroup 4"];
        [self.view addSubview:topImageView];




        
        
        UILabel * telTipLable = [[UILabel alloc] initWithFrame:CGRectMake(0, topImageView.frame.origin.y+topImageView.frame.size.height+50*BILI, VIEW_WIDTH, 25*BILI)];
        telTipLable.textColor = UIColorFromRGB(0x4C4C4C);
        telTipLable.alpha = 0.2;
        telTipLable.font = [UIFont systemFontOfSize:18*BILI];
        telTipLable.text = @"已绑定手机号码";
        telTipLable.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:telTipLable];




        
        UILabel * telLable = [[UILabel alloc] initWithFrame:CGRectMake(0, telTipLable.frame.origin.y+telTipLable.frame.size.height+2.5*BILI, VIEW_WIDTH, 35*BILI)];
        telLable.textColor = UIColorFromRGB(0x191919);
        telLable.font = [UIFont systemFontOfSize:25*BILI];
        telLable.text = self.mobel;
        telLable.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:telLable];


 

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
                                 channel:@"1"
                                delegate:self
                                selector:@selector(getCheckNumberSuccess:)
                           errorSelector:@selector(getError:)];
        
    }
    else
    {
        [Common showToastView:@"请输入正确的手机号码" view:self.view];


 

 

    }
    
    
}

-(void)getCheckNumberSuccess:(NSDictionary *)info
{
    self.getCheckNumberButton.enabled = NO;
    stepSeconds = 60;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(daoShu) userInfo:nil repeats:YES];
    [self hideNewLoadingView];


 


    [Common showToastView:@"验证码已发送,请注意查收" view:self.view];



 

}

-(void)getError:(NSDictionary *)info
{
    [self hideNewLoadingView];



 

    [Common showToastView:[info objectForKey:@"message"] view:self.view];


 


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


 

   

}
-(void)registerButtonClick
{
    if (self.telTextField.text.length!=11) {
        
        [Common showToastView:@"请输入正确的手机号码" view:self.view];



 

        return;
    }
    if ([Common isEmpty:self.checkNumberTextField.text]) {
        
        [Common showToastView:@"验证码不能为空" view:self.view];


 


        return;
    }
    [self.cloudClient bangDingTel:@"8154"
                      phoneNumber:self.telTextField.text
                    loginAuthCode:self.checkNumberTextField.text
                         delegate:self
                         selector:@selector(bangDingSuccess:)
                    errorSelector:@selector(bangDingError:)];
}
-(void)bangDingSuccess:(NSDictionary *)info
{
    [Common showToastView:@"绑定成功" view:self.view];



    [self performSelector:@selector(successPop) withObject:self afterDelay:0.5];
}


-(void)successPop
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)bangDingError:(NSDictionary *)info
{
    [Common showToastView:[info objectForKey:@"message"] view:self.view];



    
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
