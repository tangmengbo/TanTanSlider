//
//  IntroduceViewController.m
//  SajiaoShopping
//
//  Created by 鸣 王 on 15/10/23.
//  Copyright © 2015年 唐蒙波. All rights reserved.
//

#import "TanLiaoLiao_IntroduceViewController.h"

@interface TanLiaoLiao_IntroduceViewController ()

@end

@implementation TanLiaoLiao_IntroduceViewController



- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];


    self.navView.hidden = YES;
    
    NSString *versionAgent = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
    NSLog(@"当前应用软件版本:%@",versionAgent);
    
    [self.cloudClient shenHeStatus:@"8200"
                           version:versionAgent
                            chanel:@"appstore"
                           appName:APPNAME
                          delegate:self
                          selector:@selector(getShenHeStatusSuccess:)
                     errorSelector:@selector(getShenHeStatusError:)];
    
    
    self.view.backgroundColor = [UIColor whiteColor];

    
    
    UIScrollView * mainScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    mainScroll.contentSize = CGSizeMake(VIEW_WIDTH *3, VIEW_HEIGHT);
    mainScroll.showsVerticalScrollIndicator = NO;
    mainScroll.showsHorizontalScrollIndicator = NO;
    mainScroll.pagingEnabled = YES;
    [self.view addSubview:mainScroll];
    
    UIImageView * imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    imageView1.image = [UIImage imageNamed:@"introduce1"];
    imageView1.contentMode = UIViewContentModeScaleAspectFill;
    imageView1.autoresizingMask = UIViewAutoresizingNone;
    imageView1.clipsToBounds = YES;
    imageView1.userInteractionEnabled = YES;
    [mainScroll addSubview:imageView1];
    UIButton * button1 = [[UIButton alloc] initWithFrame:CGRectMake(45*BILI, imageView1.frame.size.height-95*BILI, VIEW_WIDTH-90*BILI, 50*BILI)];
    [button1 setBackgroundImage:[UIImage imageNamed:@"seeyou_btn_jinru"] forState:UIControlStateNormal];
    [imageView1 addSubview:button1];
    [button1 addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];

    
    UIImageView * imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    imageView2.image = [UIImage imageNamed:@"introduce2"];
    imageView2.contentMode = UIViewContentModeScaleAspectFill;
    imageView2.autoresizingMask = UIViewAutoresizingNone;
    imageView2.clipsToBounds = YES;
    imageView2.userInteractionEnabled = YES;
    [mainScroll addSubview:imageView2];
    
    UIButton * button2 = [[UIButton alloc] initWithFrame:CGRectMake(45*BILI, imageView2.frame.size.height-95*BILI, VIEW_WIDTH-90*BILI, 50*BILI)];
    [button2 setBackgroundImage:[UIImage imageNamed:@"seeyou_btn_jinru"] forState:UIControlStateNormal];
    [imageView2 addSubview:button2];
    [button2 addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];

    
    
    UIImageView * imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH * 2, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    imageView3.image = [UIImage imageNamed:@"introduce3"];
    imageView3.contentMode = UIViewContentModeScaleAspectFill;
    imageView3.autoresizingMask = UIViewAutoresizingNone;
    imageView3.clipsToBounds = YES;
    imageView3.userInteractionEnabled = YES;
    [mainScroll addSubview:imageView3];
    
    
    UIButton * button3 = [[UIButton alloc] initWithFrame:CGRectMake(45*BILI, imageView3.frame.size.height-95*BILI, VIEW_WIDTH-90*BILI, 50*BILI)];
    [button3 setBackgroundImage:[UIImage imageNamed:@"seeyou_btn_jinru"] forState:UIControlStateNormal];
    [imageView3 addSubview:button3];
    [button3 addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];


    
}


-(void)getShenHeStatusSuccess:(NSDictionary *)info
{
}


-(void)getShenHeStatusError:(NSDictionary *)info
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)buttonClick
{
    NSUserDefaults* introduceStatusDefaults = [NSUserDefaults standardUserDefaults];
    [introduceStatusDefaults setObject:@"introduce" forKey:IntroduceStatus];
    [introduceStatusDefaults synchronize];

//123435345

    [[NSNotificationCenter defaultCenter] removeObserver:self name:ZhuBoHuJiaoNotification object:nil];
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate resetNotLoginTabBar];

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
