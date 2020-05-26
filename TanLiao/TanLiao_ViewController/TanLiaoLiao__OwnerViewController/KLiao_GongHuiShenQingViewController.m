//
//  GongHuiShenQingViewController.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/4/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiao_GongHuiShenQingViewController.h"

@interface TanLiao_GongHuiShenQingViewController ()

@end

@implementation TanLiao_GongHuiShenQingViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLale.text = @"公会申请";
    
    self.cloudClient = [KuaiLiaoCloudClient getInstance];



 

    
    [self setTabBarHidden];
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH,VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height))];
    self.mainScrollView.delegate = self;
    [self.view addSubview:self.mainScrollView];




    
    [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height)+20)];
    
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    bottomView.backgroundColor = [UIColor blackColor];



   

    bottomView.alpha = 0.05;
    [self.mainScrollView addSubview:bottomView];


 

    
    //姓名
    UIView * nameBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, VIEW_WIDTH, 45*BILI)];
    nameBottomView.backgroundColor = [UIColor whiteColor];


 


    [self.mainScrollView addSubview:nameBottomView];




    
    UIImageView * nameImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12*BILI, 13*BILI, 19*BILI, 19*BILI)];
    nameImageView.image = [UIImage imageNamed:@"icon_ghsq_name"];
    [nameBottomView addSubview:nameImageView];




    
    self.nameLable = [[UITextField alloc] initWithFrame:CGRectMake(37*BILI, 0, VIEW_WIDTH-49*BILI, 45*BILI)];
    self.nameLable.placeholder = @"请输入您的姓名";
    self.nameLable.font = [UIFont systemFontOfSize:15*BILI];
    self.nameLable.textColor = [UIColor blackColor];


 

    self.nameLable.alpha = 0.9;
    [nameBottomView addSubview:self.nameLable];


 


    
    //联系方式
    UIView * telBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, nameBottomView.frame.origin.y+nameBottomView.frame.size.height+1, VIEW_WIDTH, 45*BILI)];
    telBottomView.backgroundColor = [UIColor whiteColor];



    [self.mainScrollView addSubview:telBottomView];



 

    
    UIImageView * telmageView = [[UIImageView alloc] initWithFrame:CGRectMake(12*BILI, 13*BILI, 19*BILI, 19*BILI)];
    telmageView.image = [UIImage imageNamed:@"icon_ghsq_phone"];
    [telBottomView addSubview:telmageView];



    
    self.telLable = [[UITextField alloc] initWithFrame:CGRectMake(37*BILI, 0, VIEW_WIDTH-49*BILI, 45*BILI)];
    self.telLable.placeholder = @"请输入您的联系方式";
    self.telLable.font = [UIFont systemFontOfSize:15*BILI];
    self.telLable.textColor = [UIColor blackColor];


 

    self.telLable.alpha = 0.9;
    self.telLable.keyboardType = UIKeyboardTypeNumberPad;
    [telBottomView addSubview:self.telLable];



    
    //微信
    UIView * wxBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, telBottomView.frame.origin.y+telBottomView.frame.size.height+1, VIEW_WIDTH, 45*BILI)];
    wxBottomView.backgroundColor = [UIColor whiteColor];



   

    [self.mainScrollView addSubview:wxBottomView];


 

    
    UIImageView * wxImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12*BILI, 13*BILI, 19*BILI, 19*BILI)];
    wxImageView.image = [UIImage imageNamed:@"icon_ghsq_weixin"];
    [wxBottomView addSubview:wxImageView];


 

    
    self.wxLable = [[UITextField alloc] initWithFrame:CGRectMake(37*BILI, 0, VIEW_WIDTH-49*BILI, 45*BILI)];
    self.wxLable.placeholder = @"请输入您的微信";
    self.wxLable.font = [UIFont systemFontOfSize:15*BILI];
    self.wxLable.textColor = [UIColor blackColor];



    self.wxLable.alpha = 0.9;
    [wxBottomView addSubview:self.wxLable];


 

 

    
    
    //您旗下有多少主播
    UIView * anchorNumberBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, wxBottomView.frame.origin.y+wxBottomView.frame.size.height+5, VIEW_WIDTH, 45*BILI)];
    anchorNumberBottomView.backgroundColor = [UIColor whiteColor];



   

    [self.mainScrollView addSubview:anchorNumberBottomView];


 
if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
{
  UIImageView * czwzqZ1472 = [[UIImageView alloc]initWithFrame:CGRectMake(13,78,7,10)];
  czwzqZ1472.layer.borderWidth = 1;
  czwzqZ1472.clipsToBounds = YES;
  czwzqZ1472.layer.cornerRadius =8;
    UIScrollView * dilaikO53606 = [[UIScrollView alloc]initWithFrame:CGRectMake(25,49,68,88)];
    dilaikO53606.backgroundColor = [UIColor whiteColor];
    dilaikO53606.layer.borderColor = [[UIColor greenColor] CGColor];
    dilaikO53606.layer.cornerRadius =6;
    UIView * jimoR167 = [[UIView alloc]initWithFrame:CGRectMake(18,2,0,20)];
    jimoR167.backgroundColor = [UIColor whiteColor];
    jimoR167.layer.borderColor = [[UIColor greenColor] CGColor];
    jimoR167.layer.cornerRadius =7;
    UITextView * szonbO0953 = [[UITextView alloc]initWithFrame:CGRectMake(4,35,3,52)];
    szonbO0953.layer.borderWidth = 1;
    szonbO0953.clipsToBounds = YES;
    szonbO0953.layer.cornerRadius =8;
    UIScrollView * rapwH803 = [[UIScrollView alloc]initWithFrame:CGRectMake(50,94,91,86)];
    rapwH803.layer.borderWidth = 1;
    rapwH803.clipsToBounds = YES;
    rapwH803.layer.cornerRadius =8;
    UIView * ddrotoT66653 = [[UIView alloc]initWithFrame:CGRectMake(14,73,52,59)];
    ddrotoT66653.layer.borderWidth = 1;
    ddrotoT66653.clipsToBounds = YES;
    ddrotoT66653.layer.cornerRadius =7;

}
 

    
    UIImageView * anchorNumberImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12*BILI, 13*BILI, 19*BILI, 19*BILI)];
    anchorNumberImageView.image = [UIImage imageNamed:@"icon_ghsq_team"];
    [anchorNumberBottomView addSubview:anchorNumberImageView];



    
    self.anchorNumberLable = [[UITextField alloc] initWithFrame:CGRectMake(37*BILI, 0, VIEW_WIDTH-49*BILI, 45*BILI)];
    self.anchorNumberLable.placeholder = @"您旗下有多少主播";
    self.anchorNumberLable.font = [UIFont systemFontOfSize:15*BILI];
    self.anchorNumberLable.textColor = [UIColor blackColor];



   

    self.anchorNumberLable.alpha = 0.9;
    [anchorNumberBottomView addSubview:self.anchorNumberLable];



    
    //您的月流水大致是多少
    UIView * moneyBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, anchorNumberBottomView.frame.origin.y+anchorNumberBottomView.frame.size.height+1, VIEW_WIDTH, 45*BILI)];
    moneyBottomView.backgroundColor = [UIColor whiteColor];


 

   

    [self.mainScrollView addSubview:moneyBottomView];


    
    UIImageView * moneyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12*BILI, 13*BILI, 19*BILI, 19*BILI)];
    moneyImageView.image = [UIImage imageNamed:@"icon_ghsq_liushui"];
    [moneyBottomView addSubview:moneyImageView];


 

    
    self.moneyLable = [[UITextField alloc] initWithFrame:CGRectMake(37*BILI, 0, VIEW_WIDTH-49*BILI, 45*BILI)];
    self.moneyLable.placeholder = @"您的月流水大致是多少";
    self.moneyLable.font = [UIFont systemFontOfSize:15*BILI];
    self.moneyLable.textColor = [UIColor blackColor];


   

    self.moneyLable.alpha = 0.9;
    [moneyBottomView addSubview:self.moneyLable];


 
    
    
    //您以前入驻过哪些平台
    UIView * platformBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, moneyBottomView.frame.origin.y+moneyBottomView.frame.size.height+1, VIEW_WIDTH, 150*BILI)];
    platformBottomView.backgroundColor = [UIColor whiteColor];



    [self.mainScrollView addSubview:platformBottomView];




    
    UIImageView * platformImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12*BILI, 13*BILI, 19*BILI, 19*BILI)];
    platformImageView.image = [UIImage imageNamed:@"icon_ghsq_pingtai"];
    [platformBottomView addSubview:platformImageView];




    
    self.wenZiTipTextField = [[UITextField alloc] initWithFrame:CGRectMake(37*BILI, platformImageView.frame.origin.y+2*BILI, VIEW_WIDTH-49*BILI, 15*BILI)];
    self.wenZiTipTextField.placeholder = @"您以前入驻过哪些平台(简明履历)";
    self.wenZiTipTextField.font = [UIFont systemFontOfSize:15*BILI];
    self.wenZiTipTextField.textColor = [UIColor blackColor];


    self.wenZiTipTextField.alpha = 0.9;
    [platformBottomView addSubview:self.wenZiTipTextField];
    
    self.platformTextView = [[UITextView alloc] initWithFrame:CGRectMake(37*BILI, 5, VIEW_WIDTH-49*BILI, 150*BILI-5)];
    self.platformTextView.backgroundColor = [UIColor clearColor];


 

   

    self.platformTextView.font = [UIFont systemFontOfSize:15*BILI];
    self.platformTextView.textColor = [UIColor blackColor];




    self.platformTextView.alpha = 0.9;
    self.platformTextView.delegate = self;
    [platformBottomView addSubview:self.platformTextView];



    
    UIButton * shenQingButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-340*BILI)/2, platformBottomView.frame.origin.y+platformBottomView.frame.size.height+12*BILI, 340*BILI, 40*BILI)];
    [shenQingButton setTitle:@"立即申请" forState:UIControlStateNormal];
    [shenQingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shenQingButton setBackgroundColor:UIColorFromRGB(0xFF5C93)];
    shenQingButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
    shenQingButton.layer.cornerRadius = 4*BILI;
    [shenQingButton addTarget:self action:@selector(shenQingButtonClick) forControlEvents:UIControlEventTouchUpInside];


 

 

    [self.mainScrollView addSubview:shenQingButton];
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.nameLable resignFirstResponder];


 
 

    [self.telLable resignFirstResponder];


 

   

    [self.wxLable resignFirstResponder];


 
if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
{
    UIView * czhpP591 = [[UIView alloc]initWithFrame:CGRectMake(84,43,28,47)];
    czhpP591.layer.cornerRadius =5;
    czhpP591.userInteractionEnabled = YES;
    czhpP591.layer.masksToBounds = YES;
    
    UITableView * qsrlwvS74754 = [[UITableView alloc]initWithFrame:CGRectMake(42,86,58,70)];
    qsrlwvS74754.backgroundColor = [UIColor whiteColor];
    qsrlwvS74754.layer.borderColor = [[UIColor greenColor] CGColor];
    qsrlwvS74754.layer.cornerRadius =10;
    
    UILabel * cuoqV398 = [[UILabel alloc]initWithFrame:CGRectMake(90,80,39,8)];
    cuoqV398.backgroundColor = [UIColor whiteColor];
    cuoqV398.layer.borderColor = [[UIColor greenColor] CGColor];
    cuoqV398.layer.cornerRadius =5;

  UIImageView * xjfutsS54477 = [[UIImageView alloc]initWithFrame:CGRectMake(82,81,21,49)];
  xjfutsS54477.backgroundColor = [UIColor whiteColor];
  xjfutsS54477.layer.borderColor = [[UIColor greenColor] CGColor];
 xjfutsS54477.layer.cornerRadius =10;
}
   

    [self.anchorNumberLable resignFirstResponder];


 


    [self.moneyLable resignFirstResponder];


 

    [self.platformTextView resignFirstResponder];


 

}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.wenZiTipTextField.hidden = YES;
    return  YES;
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (self.platformTextView.text.length==0) {
        
        self.wenZiTipTextField.hidden = NO;
    }
}

-(void)shenQingButtonClick
{
    if ([Common isEmpty:self.nameLable.text]) {
        
        [Common showToastView:@"姓名不能为空" view:self.view];



 

        return;
    }
    if ([Common isEmpty:self.telLable.text]) {
        
        [Common showToastView:@"联系方式不能为空" view:self.view];




        return;
    }
    if ([Common isEmpty:self.wxLable.text]) {
        
        [Common showToastView:@"微信不能为空" view:self.view];


 


        return;
    }
    if ([Common isEmpty:self.anchorNumberLable.text]) {
        
        [Common showToastView:@"主播数量不能为空" view:self.view];




        return;
    }
    if ([Common isEmpty:self.moneyLable.text]) {
        
        [Common showToastView:@"月流水不能为空" view:self.view];



 

        return;
    }
    if ([Common isEmpty:self.platformTextView.text]) {
        
        [Common showToastView:@"履历不能为空" view:self.view];




        return;
    }
    [self showLoadingView:@"提交中..." view:self.view];




    [self.cloudClient gongHuiShenQing:@"8907"
                                 name:self.nameLable.text
                               mobile:self.telLable.text
                               wechat:self.wxLable.text
                         anchorsCount:self.anchorNumberLable.text
                        monthlyIncome:self.moneyLable.text
                               record:self.platformTextView.text
                             delegate:self
                             selector:@selector(tiJiaoSuccess:)
                        errorSelector:@selector(tiJiaoError:)];
   
}
-(void)tiJiaoSuccess:(NSDictionary *)info
{
    [self hideNewLoadingView];


 

 

    TanLiao_TiJiaoSuccessViewController * tijiaoVC = [[TanLiao_TiJiaoSuccessViewController alloc] init];



    [self.navigationController pushViewController:tijiaoVC animated:YES];
}


-(void)tiJiaoError:(NSDictionary *)info
{
    [self hideNewLoadingView];


 

 

    [Common showToastView:[info objectForKey:@"message"] view:self.view];


 


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
