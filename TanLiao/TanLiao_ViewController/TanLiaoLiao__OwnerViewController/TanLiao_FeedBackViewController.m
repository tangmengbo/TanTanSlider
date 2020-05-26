//
//  FeedBackViewController.m
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_FeedBackViewController.h"

@interface TanLiao_FeedBackViewController ()

@end

@implementation TanLiao_FeedBackViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.titleLale.text = @"反馈";
    self.titleLale.alpha = 0.9;
    
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];
 

    [self.cloudClient setToastView:self.view];


 

 

    
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(18*BILI, self.navView.frame.origin.y+self.navView.frame.size.height+12*BILI, VIEW_WIDTH-(18*BILI*2),(VIEW_WIDTH-(18*BILI*2))*390/680)];
    bottomView.alpha = 0.3;
    bottomView.layer.borderWidth = 1;
    bottomView.layer.borderColor = [[UIColor blackColor] CGColor];



    bottomView.layer.cornerRadius = 4;
    bottomView.userInteractionEnabled = YES;
    [self.view addSubview:bottomView];



    
    UITapGestureRecognizer * viewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap)];
    [self.view addGestureRecognizer:viewTap];
    
    self.tipsLable = [[UILabel alloc] initWithFrame:CGRectMake(18*BILI+15*BILI, self.navView.frame.origin.y+self.navView.frame.size.height+12*BILI+15*BILI,VIEW_WIDTH-(18*BILI*2+15*BILI*2),15*BILI)];
    self.tipsLable.text =@"请输入您的意见和建议(不支持emoji)";
    self.tipsLable.alpha = 0.3;
    self.tipsLable.font = [UIFont systemFontOfSize:15*BILI];
    self.tipsLable.textColor = [UIColor blackColor];


   

    [self.view addSubview:self.tipsLable];


 

    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(18*BILI+15*BILI, self.navView.frame.origin.y+self.navView.frame.size.height+12*BILI+15*BILI/2, VIEW_WIDTH-(18*BILI*2+15*BILI*2),bottomView.frame.size.height-30*BILI+15*BILI/2)];
    self.textView.font = [UIFont systemFontOfSize:15*BILI];
    self.textView.delegate = self;
    self.textView.backgroundColor = [UIColor clearColor];



    self.textView.textColor = [UIColor blackColor];


    [self.view addSubview:self.textView];


    
    self.submitButton = [[UIButton alloc] initWithFrame:CGRectMake(bottomView.frame.origin.x, bottomView.frame.size.height+bottomView.frame.origin.y+12.5*BILI, bottomView.frame.size.width, 40*BILI)];
    [self.submitButton setBackgroundColor:UIColorFromRGB(0x569FFF)];
    
    self.submitButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
    [self.submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.submitButton setTitle:@"提交" forState:UIControlStateNormal];
    self.submitButton.layer.cornerRadius = 4;
    [self.submitButton addTarget:self action:@selector(submitButtonClick) forControlEvents:UIControlEventTouchUpInside];


 


    [self.view addSubview:self.submitButton];

    UILabel * tipLable1 = [[UILabel alloc] initWithFrame:CGRectMake(self.submitButton.frame.origin.x,self.submitButton.frame.origin.y+self.submitButton.frame.size.height+10*BILI,self.submitButton.frame.size.width,10*BILI)];
    tipLable1.text = @"如在使用过程中遇到紧急问题请在此反馈";
    tipLable1.font = [UIFont systemFontOfSize:10*BILI];
    tipLable1.textColor = UIColorFromRGB(0x201722);
    [self.view addSubview:tipLable1];
    
    
    
}


-(void)submitButtonClick
{
    
    if ([TanLiao_Common isEmpty:self.textView.text])
    {
        [TanLiao_Common showToastView:@"反馈内容不符合要求" view:self.view];


 


        return;
    }
    [self.textView resignFirstResponder];


 

   

    
       
    [self showNewLoadingView:nil view:nil];
    [self.cloudClient yiJianFanKui:@"8044"
                           content:self.textView.text
                          delegate:self
                          selector:@selector(tiJiaoSuccess:)
                     errorSelector:@selector(tiJiaoError:)];
}



-(void)tiJiaoSuccess:(NSDictionary *)info
{
    [self hideNewLoadingView];

    TanLiao_TiJiaoSuccessViewController * tijiaoVC = [[TanLiao_TiJiaoSuccessViewController alloc] init];
    tijiaoVC.fromWhere = @"意见反馈";
    [self.navigationController pushViewController:tijiaoVC animated:YES];
    
}


-(void)tiJiaoError:(NSDictionary *)info
{
    [self hideNewLoadingView];
     [TanLiao_Common showToastView:@"反馈失败,请重试" view:self.view];

}


-(void)textViewDidChange:(UITextView *)textView
{
    if ([@"" isEqualToString:textView.text]) {
        
        self.tipsLable.text = @"请输入您的意见和建议(不支持emoji)";
    }
    else
    {
        self.tipsLable.text = @"";
    }
}
-(void)viewTap
{
    [self.textView resignFirstResponder];




}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setTabBarHidden];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
