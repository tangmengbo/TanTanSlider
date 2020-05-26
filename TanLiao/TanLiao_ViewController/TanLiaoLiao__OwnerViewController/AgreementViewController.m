//
//  AgreementViewController.m
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/5/24.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "AgreementViewController.h"

@interface AgreementViewController ()

@end

@implementation AgreementViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLale.text = @"用户协议";
    self.titleLale.alpha = 0.9;
    
    [self setTabBarHidden];
    
    UIButton * agreeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT-40*BILI, VIEW_WIDTH, 40*BILI)];
    agreeButton.backgroundColor = UIColorFromRGB(0xFF5C93);
    [agreeButton setTitle:@"同意" forState:UIControlStateNormal];
    [agreeButton addTarget:self action:@selector(agreeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [agreeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    agreeButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
    [self.view addSubview:agreeButton];

    
    UITextView * textView = [[UITextView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height+40*BILI))];
    textView.text = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"kuaiLiao_LAWYER"];
    textView.editable = NO;
    [self.view addSubview:textView];




    
    
    if([@"liuLan" isEqualToString:self.fromWhere])
    {
        textView.frame = CGRectMake(0,self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height));
    }
    
    if([@"login" isEqualToString:self.fromWhere]||[@"liuLan" isEqualToString:self.fromWhere])
    {
        textView.text = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"KuaiLiaoRegisterLawyer"];
    }
    else
    {
        textView.text = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"kuaiLiao_LAWYER"];
    }

}
-(void)agreeButtonClick
{
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        UIView * NthjuVhckc = [[UIView alloc]initWithFrame:CGRectMake(97,78,42,84)];
        NthjuVhckc.layer.cornerRadius =7;
        [self.view addSubview:NthjuVhckc];
        
    }
    if([@"login" isEqualToString:self.fromWhere])
    {
        TanLiaoLiao_TelephoneRegistViewController * telRegisterVC = [[TanLiaoLiao_TelephoneRegistViewController alloc] init];
        telRegisterVC.cityName = self.cityName;
        [self.navigationController pushViewController:telRegisterVC animated:YES];
    }
    else
    {
        TanLiao_IndificationViewController * indificationVC = [[TanLiao_IndificationViewController alloc] init];

        [self.navigationController pushViewController:indificationVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSArray *)gsc_fopgU955metooyA15315
{
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@(474)];
    [array addObject:@(743)];
    [array addObject:@(101)];
    [array addObject:@(168)];
    [array addObject:@(528)];
    [array addObject:@(602)];
    [array addObject:@(247)];
    [array addObject:@(908)];
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
