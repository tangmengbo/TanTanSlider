//
//  SettingViewController.m
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/8.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_SettingViewController.h"
#import "TanLiao_EditPassWorldViewController.h"

@interface TanLiao_SettingViewController ()

@end

@implementation TanLiao_SettingViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLale.text = @"设置";
    self.titleLale.alpha = 0.9;
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];
    huanCun = [self readCacheSize];

    
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT)];
    bottomView.backgroundColor = [UIColor blackColor];
    bottomView.alpha = 0.05;
    [self.view addSubview:bottomView];


    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, bottomView.frame.origin.y+ 5*BILI, VIEW_WIDTH, VIEW_HEIGHT-(bottomView.frame.origin.y+5*BILI))];
    [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, VIEW_HEIGHT+20)];
    [self.view addSubview:self.mainScrollView];

 

    
    UIButton * noticeButton = [[UIButton alloc] initWithFrame:CGRectMake(0,0, VIEW_WIDTH, 45*BILI)];
    noticeButton.backgroundColor = [UIColor whiteColor];
    [self.mainScrollView addSubview:noticeButton];
    
    UILabel * noticeLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI, (45*BILI-15*BILI)/2, 15*BILI*4.5, 15*BILI)];
    noticeLable.font = [UIFont systemFontOfSize:15*BILI];
    noticeLable.textColor = [UIColor blackColor];
    noticeLable.alpha = 0.9;
    noticeLable.text = @"消息提醒";
    [noticeButton addSubview:noticeLable];


 

 

    
    UILabel * noticeLable1 = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_WIDTH-12*BILI-40, (45*BILI-15*BILI)/2, 200, 15*BILI)];
    noticeLable1.font = [UIFont systemFontOfSize:15*BILI];
    noticeLable1.textColor = [UIColor blackColor];
    noticeLable1.textAlignment = NSTextAlignmentRight;
    noticeLable1.alpha = 0.3;
    noticeLable1.text = @"已开启";
    [noticeButton addSubview:noticeLable1];
    
    UILabel * acountLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI, (45*BILI-15*BILI)/2, 15*BILI*4.5, 15*BILI)];
    acountLable.font = [UIFont systemFontOfSize:15*BILI];
    acountLable.textColor = [UIColor blackColor];
    acountLable.alpha = 0.9;
    acountLable.text = @"消息提醒";
    [noticeButton addSubview:acountLable];


    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(9*BILI, noticeButton.frame.origin.y+noticeButton.frame.size.height+15*BILI, VIEW_WIDTH-18*BILI, 40*BILI)];
    tipLable.text = @"在iphone的 “设置-通知中心” 功能,找到应用程序 “探聊”,可以更改新消息提醒设置";
    tipLable.font = [UIFont systemFontOfSize:12*BILI];
    tipLable.alpha = 0.5;
    tipLable.numberOfLines = 2;
    [self.mainScrollView addSubview:tipLable];


    
    UIButton * editPassWorldButton = [[UIButton alloc] initWithFrame:CGRectMake(0, tipLable.frame.origin.y+tipLable.frame.size.height+15*BILI, VIEW_WIDTH, 45*BILI)];
    editPassWorldButton.backgroundColor = [UIColor whiteColor];
    [editPassWorldButton addTarget:self action:@selector(editPassWorldButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:editPassWorldButton];
    
    UILabel * editPassWorldButtonLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI, (45*BILI-15*BILI)/2, 15*BILI*4.5, 15*BILI)];
    editPassWorldButtonLable.font = [UIFont systemFontOfSize:15*BILI];
    editPassWorldButtonLable.textColor = [UIColor blackColor];
    editPassWorldButtonLable.alpha = 0.9;
    editPassWorldButtonLable.text = @"修改密码";
    [editPassWorldButton addSubview:editPassWorldButtonLable];

    UIImageView * editPassWorldLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(12+18)*BILI, (45*BILI-18*BILI)/2, 18*BILI, 18*BILI)];
    editPassWorldLeftImageView.image = [UIImage imageNamed:@"btn_back_nr_n"];
    [editPassWorldButton addSubview:editPassWorldLeftImageView];

    
    UIButton * bangDingTelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, editPassWorldButton.frame.origin.y+editPassWorldButton.frame.size.height+15*BILI, VIEW_WIDTH, 45*BILI)];
    bangDingTelButton.backgroundColor = [UIColor whiteColor];
    [bangDingTelButton addTarget:self action:@selector(bangDingTelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:bangDingTelButton];
    
    UILabel * bangDingTelButtonLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI, (45*BILI-15*BILI)/2, 15*BILI*4.5, 15*BILI)];
    bangDingTelButtonLable.font = [UIFont systemFontOfSize:15*BILI];
    bangDingTelButtonLable.textColor = [UIColor blackColor];
    bangDingTelButtonLable.alpha = 0.9;
    bangDingTelButtonLable.text = @"手机绑定";
    [bangDingTelButton addSubview:bangDingTelButtonLable];
    
    UILabel * bangDingTelLable = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(12+18)*BILI-11*BILI-50, (45*BILI-14*BILI)/2, 50, 14*BILI)];
    bangDingTelLable.text = @"去绑定";
    bangDingTelLable.adjustsFontSizeToFitWidth = YES;
    bangDingTelLable.font = [UIFont systemFontOfSize:14*BILI];
    bangDingTelLable.textColor = [UIColor blackColor];
    bangDingTelLable.alpha = 0.3;
    [bangDingTelButton addSubview:bangDingTelLable];
    
    if ([self.userInfo objectForKey:@"mobile"]==nil || [@"" isEqualToString:[self.userInfo objectForKey:@"mobile"]])
    {
        bangDingTelLable.text = @"去绑定";
        
    }
    else
    {
        bangDingTelLable.text = @"已绑定";
    }

    
    UIImageView * bangDingTelLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(12+18)*BILI, (45*BILI-18*BILI)/2, 18*BILI, 18*BILI)];
    bangDingTelLeftImageView.image = [UIImage imageNamed:@"btn_back_nr_n"];
    [bangDingTelButton addSubview:bangDingTelLeftImageView];
    
   

    UIButton * blackListButton =[[UIButton alloc] initWithFrame:CGRectMake(0, bangDingTelButton.frame.origin.y+bangDingTelButton.frame.size.height+15*BILI, VIEW_WIDTH, 45*BILI)];
    blackListButton.backgroundColor = [UIColor whiteColor];
    [blackListButton addTarget:self action:@selector(blackListButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:blackListButton];
        
    if([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
    {
        blackListButton.frame = bangDingTelButton.frame;
    }
    
    UILabel * blackListLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI, (45*BILI-15*BILI)/2, 15*BILI*4.5, 15*BILI)];
    blackListLable.font = [UIFont systemFontOfSize:15*BILI];
    blackListLable.textColor = [UIColor blackColor];
    blackListLable.alpha = 0.9;
    blackListLable.text = @"黑名单";
    [blackListButton addSubview:blackListLable];

    UIImageView * blackLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(12+18)*BILI, (45*BILI-18*BILI)/2, 18*BILI, 18*BILI)];
    blackLeftImageView.image = [UIImage imageNamed:@"btn_back_nr_n"];
    [blackListButton addSubview:blackLeftImageView];

    
    UIButton * pingFenButton =[[UIButton alloc] initWithFrame:CGRectMake(0, blackListButton.frame.origin.y+blackListButton.frame.size.height+15*BILI, VIEW_WIDTH, 45*BILI)];
    pingFenButton.backgroundColor = [UIColor whiteColor];
    [pingFenButton addTarget:self action:@selector(pingFenButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:pingFenButton];
    
    
    
    UILabel * pingFenLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI, (45*BILI-15*BILI)/2, 15*BILI*4.5, 15*BILI)];
    pingFenLable.font = [UIFont systemFontOfSize:15*BILI];
    pingFenLable.textColor = [UIColor blackColor];
    pingFenLable.alpha = 0.9;
    pingFenLable.text = @"评分";
    [pingFenButton addSubview:pingFenLable];
    
    UIImageView * pingFenLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(12+18)*BILI, (45*BILI-18*BILI)/2, 18*BILI, 18*BILI)];
    pingFenLeftImageView.image = [UIImage imageNamed:@"btn_back_nr_n"];
    [pingFenButton addSubview:pingFenLeftImageView];



    UIButton * cleanButton = [[UIButton alloc] initWithFrame:CGRectMake(0, pingFenButton.frame.origin.y+pingFenButton.frame.size.height+15*BILI, VIEW_WIDTH, 45*BILI)];
    cleanButton.backgroundColor = [UIColor whiteColor];
    [cleanButton addTarget:self action:@selector(cleabButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:cleanButton];

    self.cleanLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI, (45*BILI-14*BILI)/2, 300, 15*BILI)];
    self.cleanLable.font = [UIFont systemFontOfSize:15*BILI];
    self.cleanLable.textColor = [UIColor blackColor];
    self.cleanLable.alpha = 0.9;
    self.cleanLable.text = [NSString stringWithFormat:@"清理缓存(%.2fM)",huanCun];
    [cleanButton addSubview:self.cleanLable];

    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:@(692)];
        [array addObject:@(288)];
        [array addObject:@(847)];
        [array addObject:@(389)];
        [array addObject:@(722)];
    }

    
    UIImageView * cleanLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(12+18)*BILI, (45*BILI-18*BILI)/2, 18*BILI, 18*BILI)];
    cleanLeftImageView.image = [UIImage imageNamed:@"btn_back_nr_n"];
    [cleanButton addSubview:cleanLeftImageView];


    UIButton * aboutButton = [[UIButton alloc] initWithFrame:CGRectMake(0, cleanButton.frame.origin.y+cleanButton.frame.size.height+15*BILI, VIEW_WIDTH, 45*BILI)];
    aboutButton.backgroundColor = [UIColor whiteColor];
    [aboutButton addTarget:self action:@selector(aboutButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:aboutButton];
    
    UILabel * aboutLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI, (45*BILI-14*BILI)/2, 15*BILI*4.5, 15*BILI)];
    aboutLable.font = [UIFont systemFontOfSize:15*BILI];
    aboutLable.textColor = [UIColor blackColor];
    aboutLable.alpha = 0.9;
    aboutLable.text = @"关于";
    [aboutButton addSubview:aboutLable];

    
    if( ![@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
    {
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];



        NSString * iosv = [defaults objectForKey:@"ios_v"];
        NSString *versionAgent = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
        if (![versionAgent isEqualToString:iosv]) {
            
            UIView * pointView = [[UIView alloc] initWithFrame:CGRectMake(426*BILI/2, (45-7)*BILI/2, 7*BILI, 7*BILI)];
            pointView.layer.masksToBounds = YES;
            pointView.layer.cornerRadius = 3.5*BILI;
            pointView.backgroundColor = UIColorFromRGB(0xff0000);
            [aboutButton addSubview:pointView];

            UILabel * pingFenLable1 = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(12+18)*BILI-11*BILI-200, (45*BILI-14*BILI)/2, 200, 14*BILI)];
            pingFenLable1.text = @"检测到版本更新";
            pingFenLable1.textAlignment = NSTextAlignmentRight;
            pingFenLable1.font = [UIFont systemFontOfSize:14*BILI];
            pingFenLable1.textColor = [UIColor blackColor];
            pingFenLable1.alpha = 0.3;
            [aboutButton addSubview:pingFenLable1];
        }
        
      
        
    }
    
    UIImageView * aboutLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(12+18)*BILI, (45*BILI-18*BILI)/2, 18*BILI, 18*BILI)];
    aboutLeftImageView.image = [UIImage imageNamed:@"btn_back_nr_n"];
    [aboutButton addSubview:aboutLeftImageView];


 


    
    
    UIButton * exitButton = [[UIButton alloc] initWithFrame:CGRectMake(0, aboutButton.frame.origin.y+aboutButton.frame.size.height+15*BILI, VIEW_WIDTH, 45*BILI)];
    exitButton.backgroundColor = [UIColor whiteColor];
    [exitButton addTarget:self action:@selector(exitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.mainScrollView addSubview:exitButton];
    
    UILabel * exitLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI, (45*BILI-14*BILI)/2, 15*BILI*4.5, 15*BILI)];
    exitLable.font = [UIFont systemFontOfSize:15*BILI];
    exitLable.textColor = [UIColor blackColor];
    exitLable.alpha = 0.9;
    exitLable.text = @"退出登录";
    [exitButton addSubview:exitLable];


 


    
    UIImageView * exitLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(12+18)*BILI, (45*BILI-18*BILI)/2, 18*BILI, 18*BILI)];
    exitLeftImageView.image = [UIImage imageNamed:@"btn_back_nr_n"];
    [exitButton addSubview:exitLeftImageView];


    UILabel * loginStateLable = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(12+18)*BILI-11*BILI-200, (45*BILI-14*BILI)/2, 200, 14*BILI)];
    
    loginStateLable.textAlignment = NSTextAlignmentRight;
    loginStateLable.font = [UIFont systemFontOfSize:14*BILI];
    loginStateLable.textColor = [UIColor blackColor];
    loginStateLable.alpha = 0.3;
    [exitButton addSubview:loginStateLable];



    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];

    NSDictionary * info = [defaults objectForKey:USERINFO];
    if ([@"2" isEqualToString:[info objectForKey:@"loginType"]]) {
        
        loginStateLable.text = @"当前微信登录";
    }
    else if([@"3" isEqualToString:[info objectForKey:@"loginType"]])
    {
        loginStateLable.text = @"当前QQ登录";
    }
    else if([@"4" isEqualToString:[info objectForKey:@"loginType"]])
    {
         loginStateLable.text = @"当前微博登录";
    }
    else if([@"5" isEqualToString:[info objectForKey:@"loginType"]])
    {
        loginStateLable.text = @"当前手机登录";
    }
    
    if( [@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
     {
        
         loginStateLable.text = @"当前手机登录";
    }
    [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, exitButton.frame.origin.y+exitButton.frame.size.height+50*BILI)];
}
-(void)cleabButtonClick
{
    [self clearFile];


    huanCun = [self readCacheSize];

    self.cleanLable.text = [NSString stringWithFormat:@"清理缓存(%.2fM)",huanCun];
}
//1. 获取缓存文件的大小
-( float )readCacheSize
{
    
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES) firstObject];

    
    return [ self folderSizeAtPath :cachePath];
}


//由于缓存文件存在沙箱中，我们可以通过NSFileManager API来实现对缓存文件大小的计算。
// 遍历文件夹获得文件夹大小，返回多少 M
- ( float ) folderSizeAtPath:( NSString *) folderPath{
    
    NSFileManager * manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator];
    NSString * fileName;
    long long folderSize = 0 ;
    while ((fileName = [childFilesEnumerator nextObject]) != nil ){
        //获取文件全路径
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        folderSize += [ self fileSizeAtPath :fileAbsolutePath];
    }
    return folderSize/( 1024.0 * 1024.0);
    
}

// 计算 单个文件的大小
- ( long long ) fileSizeAtPath:( NSString *) filePath{
    NSFileManager * manager = [NSFileManager defaultManager];


    if ([manager fileExistsAtPath :filePath]){
        return [[manager attributesOfItemAtPath :filePath error : nil] fileSize];
    }
    return 0;
}
//2. 清除缓存
- (void)clearFile
{
    NSString * cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES ) firstObject];

    NSArray * files = [[NSFileManager defaultManager ] subpathsAtPath :cachePath];
    for ( NSString * p in files) {
        
        NSError * error = nil ;
        //获取文件全路径
        NSString * fileAbsolutePath = [cachePath stringByAppendingPathComponent :p];
        
        if ([[NSFileManager defaultManager ] fileExistsAtPath :fileAbsolutePath]) {
            [[NSFileManager defaultManager ] removeItemAtPath :fileAbsolutePath error :&error];


        }
    }
    
       
}
-(void)editPassWorldButtonClick
{
    TanLiao_EditPassWorldViewController * editVC = [[TanLiao_EditPassWorldViewController alloc] init];
    [self.navigationController pushViewController:editVC animated:YES];
}
-(void)bangDingTelButtonClick
{
    if ([self.userInfo objectForKey:@"mobile"]==nil || [@"" isEqualToString:[self.userInfo objectForKey:@"mobile"]])
    {
        TanLiao_BangDingTelViewController * vc = [[TanLiao_BangDingTelViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        TanLiao_BangDingTelViewController * vc = [[TanLiao_BangDingTelViewController alloc] init];
        vc.mobel = [self.userInfo objectForKey:@"mobile"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)aboutButtonClick
{
    TanLiao_AboutUsViewController * aboutUsVC = [[TanLiao_AboutUsViewController alloc] init];
    [self.navigationController pushViewController:aboutUsVC animated:YES];
}
-(void)exitButtonClick
{
    
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:@"确认退出登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出", nil];
    [alertView show];

    [self.view addSubview:alertView];


    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        UIView * ZbvnvuCsjfqg = [[UIView alloc]initWithFrame:CGRectMake(56,48,91,49)];
        ZbvnvuCsjfqg.layer.cornerRadius =7;
        [self.view addSubview:ZbvnvuCsjfqg];
        
        UIScrollView * WawlqyWrkflf = [[UIScrollView alloc]initWithFrame:CGRectMake(83,73,96,53)];
        WawlqyWrkflf.layer.cornerRadius =9;
        [self.view addSubview:WawlqyWrkflf];
        
    }
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
    }
    else
    {
        //退出融云
        [[RCIM sharedRCIM] logout];

        [[RCIM sharedRCIM] disconnect];


        //退出网易云登录
        [[[NIMSDK sharedSDK] loginManager] logout:^(NSError *error)
         {
             extern NSString *NTESNotificationLogout;
             [[NSNotificationCenter defaultCenter] postNotificationName:NTESNotificationLogout object:nil];
         }];
        
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:nil forKey:USERINFO];
        [defaults synchronize];


 

        
        NSUserDefaults* loginStatusDefaults = [NSUserDefaults standardUserDefaults];
        [loginStatusDefaults setObject:nil forKey:LoginStatus];
        [loginStatusDefaults synchronize];


 

        
        NSUserDefaults* fiveMinutesDefaults = [NSUserDefaults standardUserDefaults];
        [fiveMinutesDefaults setObject:nil forKey:FiveMinutesDefaultsKey];
        [fiveMinutesDefaults synchronize];




        
        NSUserDefaults *  alsoShowedDefaults = [NSUserDefaults standardUserDefaults];
        [alsoShowedDefaults setObject:nil forKey:@"alsoShowedDefaultsKey"];
        [alsoShowedDefaults synchronize];


 

        
        NSUserDefaults *  accountStatusDefaults = [NSUserDefaults standardUserDefaults];
        [accountStatusDefaults setObject:nil forKey:@"accountStatusDefaultsKey"];
        [accountStatusDefaults synchronize];


        NSUserDefaults* authenticationDefaults = [NSUserDefaults standardUserDefaults];
        [authenticationDefaults setObject:nil forKey:@"DefaultsAuthentication"];
        [authenticationDefaults synchronize];


        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:ZhuBoHuJiaoNotification object:nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"removeNotification" object:nil];
        
        AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate resetNotLoginTabBar];


 

   

        

    }
    
}
-(void)blackListButtonClick
{
    TanLiao_BlackListViewController * vc = [[TanLiao_BlackListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)pingFenButtonClick
{
    NSString *str = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@", APP_STORE_ID];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

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
- (NSArray *)gsc_qzccB465wovurH7767
{
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@(390)];
    [array addObject:@(451)];
    return array;
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
