//
//  AboutUsViewController.m
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/17.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_AboutUsViewController.h"

@interface TanLiao_AboutUsViewController ()

@end

@implementation TanLiao_AboutUsViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLale.text = @"关于我们";
    
    UIImageView * iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-80*BILI)/2, self.navView.frame.origin.y+self.navView.frame.size.height+65*BILI, 80*BILI, 80*BILI)];
    iconImageView.image = [UIImage imageNamed:@"1024"];
    [self.view addSubview:iconImageView];


 


    
    UIButton * versionBottom = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-118*BILI/2)/2, iconImageView.frame.origin.y+iconImageView.frame.size.height+20*BILI, 118*BILI/2, 17*BILI)];
    versionBottom.backgroundColor = [UIColor blackColor];




    versionBottom.alpha = 0.3;
    versionBottom.layer.cornerRadius = 17*BILI/2;
    [self.view addSubview:versionBottom];
    
    UILabel * versionLable = [[UILabel alloc] initWithFrame:CGRectMake((VIEW_WIDTH-118*BILI/2)/2, iconImageView.frame.origin.y+iconImageView.frame.size.height+20*BILI, 118*BILI/2, 17*BILI)];
    versionLable.font = [UIFont systemFontOfSize:12*BILI];
    versionLable.textAlignment = NSTextAlignmentCenter;
    NSString *versionAgent = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
    versionLable.text = [NSString stringWithFormat:@"v%@",versionAgent];


 


    versionLable.backgroundColor = [UIColor clearColor];;


 


    [self.view addSubview:versionLable];


 

 

    
    if(![@"910008" isEqualToString:[TanLiao_Common getNowUserID]])
    {
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];


 

        NSString * iosv = [defaults objectForKey:@"ios_v"];
        NSString *versionAgent = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
        if (![versionAgent isEqualToString:iosv]) {
            
            UILabel * tuiJianRenDescribleLable1 = [[UILabel alloc]initWithFrame:CGRectMake(0, versionLable.frame.origin.y+versionLable.frame.size.height+40*BILI, VIEW_WIDTH, 15*BILI)];
            tuiJianRenDescribleLable1.text = @"系统检测到新的版本";
            tuiJianRenDescribleLable1.textColor = [UIColor blackColor];



            tuiJianRenDescribleLable1.alpha = 0.5;
            tuiJianRenDescribleLable1.font = [UIFont systemFontOfSize:15*BILI];
            tuiJianRenDescribleLable1.textAlignment = NSTextAlignmentCenter;
            [self.view addSubview:tuiJianRenDescribleLable1];
            
            UILabel * tuiJianRenDescribleLable2 = [[UILabel alloc]initWithFrame:CGRectMake(0, tuiJianRenDescribleLable1.frame.origin.y+tuiJianRenDescribleLable1.frame.size.height+3*BILI, VIEW_WIDTH, 15*BILI)];
            tuiJianRenDescribleLable2.text = [NSString stringWithFormat:@"为了让您拥有更完美的体验"];
            tuiJianRenDescribleLable2.textColor = [UIColor blackColor];




            tuiJianRenDescribleLable2.alpha = 0.5;
            tuiJianRenDescribleLable2.font = [UIFont systemFontOfSize:15*BILI];
            tuiJianRenDescribleLable2.textAlignment = NSTextAlignmentCenter;
            [self.view addSubview:tuiJianRenDescribleLable2];
            
            UILabel * tuiJianRenDescribleLable3 = [[UILabel alloc]initWithFrame:CGRectMake(0, tuiJianRenDescribleLable2.frame.origin.y+tuiJianRenDescribleLable2.frame.size.height+3*BILI, VIEW_WIDTH, 15*BILI)];
            tuiJianRenDescribleLable3.text = [NSString stringWithFormat:@"请升级为最新版本"];
            tuiJianRenDescribleLable3.textColor = [UIColor blackColor];




            tuiJianRenDescribleLable3.alpha = 0.5;
            tuiJianRenDescribleLable3.font = [UIFont systemFontOfSize:15*BILI];
            tuiJianRenDescribleLable3.textAlignment = NSTextAlignmentCenter;
            [self.view addSubview:tuiJianRenDescribleLable3];
            
            UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-270*BILI/2)/2, tuiJianRenDescribleLable3.frame.origin.y+tuiJianRenDescribleLable3.frame.size.height+20*BILI, 270*BILI/2, 44*BILI)];
            [button setBackgroundColor:UIColorFromRGB(0x569FFF)];
            button.layer.cornerRadius = 4*BILI;
            [button setTitle:@"立即升级" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
            [self.view addSubview:button];
            [button addTarget:self action:@selector(shengJiButtonClick) forControlEvents:UIControlEventTouchUpInside];




        }
        
        
    }
    
    
    UILabel * bottomLable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT-(95+31)*BILI/2, VIEW_WIDTH, 31*BILI/2)];
    bottomLable1.font = [UIFont systemFontOfSize:15*BILI];
    bottomLable1.textAlignment = NSTextAlignmentCenter;
    bottomLable1.textColor = [UIColor blackColor];




    bottomLable1.alpha = 0.5;
    bottomLable1.text = @"欢迎使用探聊";
    [self.view addSubview:bottomLable1];
    
    UILabel* bottomLable2 = [[UILabel alloc] initWithFrame:CGRectMake(0, bottomLable1.frame.origin.y+bottomLable1.frame.size.height+29*BILI/2, VIEW_WIDTH, 23*BILI)];
    bottomLable2.textColor = [UIColor blackColor];




    bottomLable2.font = [UIFont systemFontOfSize:12*BILI];
    bottomLable2.alpha = 0.5;
    bottomLable2.textAlignment = NSTextAlignmentCenter;
    bottomLable2.text = @"Have a good time at FQSQ";
    [self.view addSubview:bottomLable2];
    
}


-(void)shengJiButtonClick
{
    NSString *str = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@", APP_STORE_ID];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
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
