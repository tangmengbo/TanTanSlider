//
//  TiJiaoSuccessViewController.m
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/5/24.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_TiJiaoSuccessViewController.h"

@interface TanLiao_TiJiaoSuccessViewController ()

@end

@implementation TanLiao_TiJiaoSuccessViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTabBarHidden];
    
    self.titleLale.text = @"申请认证";
    self.titleLale.alpha = 0.9;
    
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT)];
    bottomView.backgroundColor = [UIColor blackColor];
    bottomView.alpha = 0.03;
    [self.view addSubview:bottomView];


    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:@(400)];
        [array addObject:@(398)];
        [array addObject:@(956)];
        [array addObject:@(488)];
        
    }
 


    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 174*BILI+self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, 24*BILI)];
    tipLable.textColor = UIColorFromRGB(0xFF3572);
    tipLable.text = @"提交成功";
    tipLable.textAlignment = NSTextAlignmentCenter;
    tipLable.font = [UIFont systemFontOfSize:24*BILI];
    [self.view addSubview:tipLable];

    UILabel * messageLable = [[UILabel alloc] initWithFrame:CGRectMake((VIEW_WIDTH-300*BILI)/2, tipLable.frame.origin.y+tipLable.frame.size.height+28*BILI, 300*BILI, 40*BILI)];
    messageLable.numberOfLines = 2;
    messageLable.textColor = [UIColor blackColor];
    messageLable.alpha = 0.5;
    messageLable.text = @"工作人员会在一个工作日内完成审核,审核结果请留意系统消息";
    messageLable.font = [UIFont systemFontOfSize:15*BILI];
    messageLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:messageLable];

   
    if ( [@"意见反馈" isEqualToString:self.fromWhere]) {
        
        self.titleLale.text = @"意见反馈";
        messageLable.text = @"您的反馈信息已经提交成功，谢谢您的参与！";
        
    }

}
-(void)leftClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)initDataRdyiHkvjVC:(NSDictionary *)info
{
    NSMutableArray * viewArray = [NSMutableArray array];
    UIView * KywwunBiqvgl = [[UIView alloc]initWithFrame:CGRectMake(57,94,47,80)];
    KywwunBiqvgl.layer.cornerRadius =9;
    [viewArray addObject:KywwunBiqvgl];
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
