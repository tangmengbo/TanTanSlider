//
//  QunFaWaitingViewController.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/1/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLL_QunFaWaitingViewController.h"
#import "GFWaterView.h"

@interface TanLL_QunFaWaitingViewController ()

@end

@implementation TanLL_QunFaWaitingViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTabBarHidden];
    

    
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];


 

 

    minutes = 2;
    seconds = 0;
    numberChangeJianGe = 2;
    timeLength = 0;
    
    NSArray * array = [[NSArray alloc] initWithObjects:@"13",@"20", nil];
    NSString * maxNumberStr = [array objectAtIndex:arc4random() % 2];
    maxNumber = maxNumberStr.intValue;
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];



    [defaults setObject:@"qunFaWaiting" forKey:@"alsoQunFaWaiting"];
    [defaults synchronize];



 

    
    UIImageView * bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    bottomImageView.image = [UIImage imageNamed:@"qunFaWaiting_bg"];
    [self.view addSubview:bottomImageView];


 


    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap)];
    [bottomImageView addGestureRecognizer:tap];
    
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 40*BILI, VIEW_WIDTH, 20*BILI)];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.textColor = [UIColor whiteColor];


 

   

    titleLable.font = [UIFont systemFontOfSize:20*BILI];
    titleLable.text = @"视频邀请群发中";
    [self.view addSubview:titleLable];


 

 


    
    self.boWenBottomView = [[UIView alloc] initWithFrame:self.view.frame];




    self.boWenBottomView.backgroundColor = [UIColor clearColor];


 

   

    [self.view addSubview:self.boWenBottomView];


 

    //启动水波动画
    
    self.shuiBoTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(clickAnimation:) userInfo:nil repeats:YES];
    //启动倒计时
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(daoShu) userInfo:nil repeats:YES];
   //  [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(daoShu) userInfo:nil repeats:YES];
    
    UIImageView * headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-180*BILI)/2, 130*BILI, 180*BILI, 180*BILI)];
    headerImageView.image = [UIImage imageNamed:@"qunFaWaiting_zhuanpan"];
    [self.view addSubview:headerImageView];



    
    self.timeLable = [[UILabel alloc] initWithFrame:CGRectMake(68*BILI, 443*BILI, 172*BILI/2, 32*BILI)];
    self.timeLable.font = [UIFont systemFontOfSize:32*BILI];
    self.timeLable.textColor = [UIColor whiteColor];



   

    self.timeLable.adjustsFontSizeToFitWidth = YES;
    self.timeLable.text = @"02:00";
    [self.view addSubview:self.timeLable];



 

    
    UILabel * lable1 = [[UILabel alloc] initWithFrame:CGRectMake(self.timeLable.frame.origin.x+self.timeLable.frame.size.width+5*BILI,self.timeLable.frame.origin.y+2.5*BILI , 27*BILI*3, 27*BILI)];
    lable1.font = [UIFont systemFontOfSize:27*BILI];
    lable1.textAlignment = NSTextAlignmentCenter;
    lable1.textColor = [UIColor whiteColor];


 

    lable1.text = @"已发送";
    lable1.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:lable1];
    
    self.numberLable = [[UILabel alloc] initWithFrame:CGRectMake(lable1.frame.origin.x+lable1.frame.size.width, self.timeLable.frame.origin.y, 64*BILI, 32*BILI)];
    self.numberLable.font = [UIFont systemFontOfSize:32*BILI];
    self.numberLable.textColor = UIColorFromRGB(0xFF6596);
    self.numberLable.text = @"1";
    self.numberLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.numberLable];




    
    UILabel * lable2 = [[UILabel alloc] initWithFrame:CGRectMake(self.numberLable.frame.origin.x+self.numberLable.frame.size.width,self.timeLable.frame.origin.y+2.5*BILI , 27*BILI, 27*BILI)];
    lable2.font = [UIFont systemFontOfSize:27*BILI];
    lable2.textAlignment = NSTextAlignmentCenter;
    lable2.textColor = [UIColor whiteColor];


   

    lable2.text = @"人";
    [self.view addSubview:lable2];
    
    UILabel * lable3 = [[UILabel alloc] initWithFrame:CGRectMake(0,self.timeLable.frame.origin.y+self.timeLable.frame.size.height+15*BILI , VIEW_WIDTH, 15*BILI)];
    lable3.font = [UIFont systemFontOfSize:15*BILI];
    lable3.textAlignment = NSTextAlignmentCenter;
    lable3.textColor = [UIColor whiteColor];




    lable3.text = @"2分钟内 用户接受邀请 将为您自动接通视频";
    [self.view addSubview:lable3];
    
    UILabel * lable4 = [[UILabel alloc] initWithFrame:CGRectMake(0,lable3.frame.origin.y+lable3.frame.size.height+3*BILI , VIEW_WIDTH, 15*BILI)];
    lable4.font = [UIFont systemFontOfSize:15*BILI];
    lable4.textAlignment = NSTextAlignmentCenter;
    lable4.textColor = UIColorFromRGB(0xFF6596);
    lable4.text = @"请不要远离手机";
    [self.view addSubview:lable4];
    
    self.leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0,  SafeAreaTopHeight, 60, 40)];
    [self.leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(leftBackButtonClick) forControlEvents:UIControlEventTouchUpInside];


 
 

    self.leftButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:self.leftButton];
    
    self.backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12*BILI, (40-18)/2, 18, 18)];
    self.backImageView.image = [UIImage imageNamed:@"shouHu_btn_back_n"];
    [self.leftButton addSubview:self.backImageView];





}



-(void)leftBackButtonClick
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.25;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];


 

    transition.type = kCATransitionPush;
    transition.subtype  = kCATransitionFromBottom;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:NO];

}
-(void)viewTap
{
    [self.idTextField resignFirstResponder];



   

}
-(void)huJiaoButtonClick
{
    [self.cloudClient zhuBoHuJiaoYongHu:@"8086"
                               toUserId:self.idTextField.text
                               delegate:self
                               selector:@selector(huJiaoSuccess:)
                          errorSelector:@selector(huJiaoError:)];
}
-(void)huJiaoSuccess:(NSDictionary *)info
{
    [TanLiao_Common showToastView:@"success" view:self.view];


 


}
-(void)huJiaoError:(NSDictionary *)info
{
    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];


 


}
-(void)daoShu
{
    if (seconds==0&&minutes==0)
    {
        
        CATransition *transition = [CATransition animation];
        transition.duration = 0.25;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];


 

        transition.type = kCATransitionPush;
        transition.subtype  = kCATransitionFromBottom;
        [self.navigationController.view.layer addAnimation:transition forKey:nil];
        self.navigationController.navigationBarHidden = YES;
        [self.navigationController popViewControllerAnimated:NO];

        return;
    }
    if (seconds==0)
    {
        seconds=59;
        minutes = minutes-1;
    }
    else
    {
        seconds = seconds-1;
    }
    if (seconds>=10) {
        
        self.timeLable.text = [NSString stringWithFormat:@"0%d:%d",minutes,seconds];


 


    }
    else
    {
        self.timeLable.text = [NSString stringWithFormat:@"0%d:0%d",minutes,seconds];





    }
    timeLength = timeLength+1;
    
    int number = self.numberLable.text.intValue;
    if (number>=maxNumber) {
        
       if( timeLength%4==0)
       {
           number = number+ arc4random() % 2;
           self.numberLable.text = [NSString stringWithFormat:@"%d",number];


 
   

       }
    }
    else
    {
    if (timeLength%numberChangeJianGe==0) {
        
        number = number+ arc4random() % 3;
        self.numberLable.text = [NSString stringWithFormat:@"%d",number];


 

    }
    }

}
//水波纹动画
- (IBAction)clickAnimation:(id)sender {
    
    __block GFWaterView *waterView ;
    
    waterView = [[GFWaterView alloc]initWithFrame:CGRectMake((VIEW_WIDTH-200*BILI)/2, 120*BILI, 200*BILI, 200*BILI)];
    waterView.backgroundColor = [UIColor clearColor];


 


    waterView.fromWhere = @"waitingQunFa";
    waterView.alpha = 0.2;
    [self.boWenBottomView addSubview:waterView];




    
    
    [UIView animateWithDuration:5 animations:^{
        
        //设置扩散的圆圈的大小
        waterView.transform = CGAffineTransformScale(waterView.transform, 5, 5);
        
        waterView.alpha = 0;
        
    } completion:^(BOOL finished) {
        [waterView removeFromSuperview];



 

    }];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self.timer invalidate];

    self.timer = nil;
    [self.shuiBoTimer invalidate];


 

    self.shuiBoTimer = nil;
    NSUserDefaults * alsoQunFaWaitingDefaults = [NSUserDefaults standardUserDefaults];
    [alsoQunFaWaitingDefaults setObject:@"" forKey:@"alsoQunFaWaiting"];
    [alsoQunFaWaitingDefaults synchronize];


    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        UILabel * spjpuuR13579 = [[UILabel alloc]initWithFrame:CGRectMake(74,20,29,23)];
        spjpuuR13579.backgroundColor = [UIColor whiteColor];
        spjpuuR13579.layer.borderColor = [[UIColor greenColor] CGColor];
        spjpuuR13579.layer.cornerRadius =6;
        
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
