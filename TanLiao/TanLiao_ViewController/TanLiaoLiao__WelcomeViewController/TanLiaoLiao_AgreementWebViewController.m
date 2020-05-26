//
//  AgreementWebViewController.m
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/11.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiaoLiao_AgreementWebViewController.h"

@interface TanLiaoLiao_AgreementWebViewController ()

@end

@implementation TanLiaoLiao_AgreementWebViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLale.text = @"用户协议";
    self.titleLale.alpha = 0.9;
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height))];
    //self.webView.delegate = self;
   // self.webView.scalesPageToFit = YES;
    [self.webView setMediaPlaybackRequiresUserAction:NO];
    self.webView.delegate = self;
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.51find.me/term.html"]];
    [self.view addSubview: self.webView];

    self.webView.backgroundColor = [UIColor whiteColor];
    [self.webView loadRequest:request];
    

}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    

    [self showNewLoadingView:nil view:nil];
    
    
    return YES;
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        UIScrollView * OncfhaQpwrzz = [[UIScrollView alloc]initWithFrame:CGRectMake(27,21,12,94)];
        OncfhaQpwrzz.layer.cornerRadius =6;
        OncfhaQpwrzz.layer.borderWidth = 1;
        OncfhaQpwrzz.clipsToBounds = YES;
        OncfhaQpwrzz.layer.cornerRadius =5;
        [self.view addSubview:OncfhaQpwrzz];
    }
    
    [self hideNewLoadingView];

}

-(void)rasqI3617
{
    UIScrollView * VqfvrGunep = [[UIScrollView alloc]initWithFrame:CGRectMake(71,6,76,76)];
    VqfvrGunep.layer.cornerRadius =6;
    [self.view addSubview:VqfvrGunep];
    
    UIView * AasbwNgvjp = [[UIView alloc]initWithFrame:CGRectMake(76,65,8,49)];
    AasbwNgvjp.layer.cornerRadius =6;
    [self.view addSubview:AasbwNgvjp];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
