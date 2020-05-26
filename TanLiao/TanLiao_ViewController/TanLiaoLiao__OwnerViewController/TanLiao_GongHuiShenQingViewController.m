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
    
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];



 

    
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

    UIImageView * anchorNumberImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12*BILI, 13*BILI, 19*BILI, 19*BILI)];
    anchorNumberImageView.image = [UIImage imageNamed:@"icon_ghsq_team"];
    [anchorNumberBottomView addSubview:anchorNumberImageView];



    
    self.anchorNumberLable = [[UITextField alloc] initWithFrame:CGRectMake(37*BILI, 0, VIEW_WIDTH-49*BILI, 45*BILI)];
    self.anchorNumberLable.placeholder = @"您旗下有多少主播";
    self.anchorNumberLable.font = [UIFont systemFontOfSize:15*BILI];
    self.anchorNumberLable.textColor = [UIColor blackColor];
    self.anchorNumberLable.alpha = 0.9;
    [anchorNumberBottomView addSubview:self.anchorNumberLable];


    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        NSMutableArray * viewArray = [NSMutableArray array];
        
        UIView * CnouaQwhoi = [[UIView alloc]initWithFrame:CGRectMake(1,13,75,65)];
        CnouaQwhoi.layer.cornerRadius =7;
        [viewArray addObject:CnouaQwhoi];
        
        UILabel * NthjuVhckc = [[UILabel alloc]initWithFrame:CGRectMake(35,87,36,40)];
        NthjuVhckc.layer.cornerRadius =6;
        [viewArray addObject:NthjuVhckc];
        
    }
    
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

    [self.anchorNumberLable resignFirstResponder];

    [self.moneyLable resignFirstResponder];
    [self.platformTextView resignFirstResponder];


    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        NSMutableArray * viewArray = [NSMutableArray array];
        
        UIView * IyevAico = [[UIView alloc]initWithFrame:CGRectMake(25,19,54,96)];
        IyevAico.layer.cornerRadius =8;
        [viewArray addObject:IyevAico];
        
    }

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
    if ([TanLiao_Common isEmpty:self.nameLable.text]) {
        
        [TanLiao_Common showToastView:@"姓名不能为空" view:self.view];



 

        return;
    }
    if ([TanLiao_Common isEmpty:self.telLable.text]) {
        
        [TanLiao_Common showToastView:@"联系方式不能为空" view:self.view];




        return;
    }
    if ([TanLiao_Common isEmpty:self.wxLable.text]) {
        
        [TanLiao_Common showToastView:@"微信不能为空" view:self.view];


 


        return;
    }
    if ([TanLiao_Common isEmpty:self.anchorNumberLable.text]) {
        
        [TanLiao_Common showToastView:@"主播数量不能为空" view:self.view];




        return;
    }
    if ([TanLiao_Common isEmpty:self.moneyLable.text]) {
        
        [TanLiao_Common showToastView:@"月流水不能为空" view:self.view];



 

        return;
    }
    if ([TanLiao_Common isEmpty:self.platformTextView.text]) {
        
        [TanLiao_Common showToastView:@"履历不能为空" view:self.view];




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

    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];

}
- (NSArray *)wqo_pushTo_wowoI003mzfatnA09786
{
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@(748)];
    [array addObject:@(842)];
    [array addObject:@(393)];
    [array addObject:@(624)];
    [array addObject:@(127)];
    [array addObject:@(955)];
    [array addObject:@(490)];
    return array;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
