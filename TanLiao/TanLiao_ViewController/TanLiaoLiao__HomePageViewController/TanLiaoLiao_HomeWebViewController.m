//
//  HomeWebViewController.m
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/5/2.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiaoLiao_HomeWebViewController.h"

@interface TanLiaoLiao_HomeWebViewController ()

@end

@implementation TanLiaoLiao_HomeWebViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height))];
    //self.webView.delegate = self;
    // self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
    [self.webView setMediaPlaybackRequiresUserAction:NO];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.url]]];
    [self.view addSubview: self.webView];


 


    self.webView.backgroundColor = [UIColor whiteColor];


    [self.webView loadRequest:request];


 

    /*
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.allowRotation = YES;//(以上2行代码,可以理解为打开横屏开关)
    [self setNewOrientation:YES];//调用转屏代码
    */

}
- (void)setNewOrientation:(BOOL)fullscreen{
    if (fullscreen) {
        NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
        [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
        NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeRight];


 
 

        [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
    }else{
        NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
        [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
        NSNumber *orientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];


 

 

        [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
    }
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.allowRotation = NO;//关闭横屏仅允许竖屏
    [self setNewOrientation:NO];
}
-(void)leftClick
{
    //是否可返回
//    BOOL state = [self.webView canGoBack];


//    if (state == YES)
//    {
//        [self.webView goBack];


 
if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
{
  UITableView * wpopaQ8913 = [[UITableView alloc]initWithFrame:CGRectMake(57,1,10,63)];
  wpopaQ8913.backgroundColor = [UIColor whiteColor];
  wpopaQ8913.layer.borderColor = [[UIColor greenColor] CGColor];
  wpopaQ8913.layer.cornerRadius =10;
    UILabel * sgxknaS94217 = [[UILabel alloc]initWithFrame:CGRectMake(14,23,37,0)];
    sgxknaS94217.backgroundColor = [UIColor whiteColor];
    sgxknaS94217.layer.borderColor = [[UIColor greenColor] CGColor];
    sgxknaS94217.layer.cornerRadius =6;
    UIImageView * atzbxB0906 = [[UIImageView alloc]initWithFrame:CGRectMake(86,77,53,20)];
    atzbxB0906.layer.borderWidth = 1;
    atzbxB0906.clipsToBounds = YES;
    atzbxB0906.layer.cornerRadius =10;
    UIScrollView * ijairC2009 = [[UIScrollView alloc]initWithFrame:CGRectMake(75,6,91,22)];
    ijairC2009.layer.borderWidth = 1;
    ijairC2009.clipsToBounds = YES;
    ijairC2009.layer.cornerRadius =8;


}
   

//    }
//    else
//    {
        [self.navigationController popViewControllerAnimated:YES];
   // }
    
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    [self showLoadingGifView];



 

    
    return YES;
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    [self hideNewLoadingView];

 

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setTabBarHidden];
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
