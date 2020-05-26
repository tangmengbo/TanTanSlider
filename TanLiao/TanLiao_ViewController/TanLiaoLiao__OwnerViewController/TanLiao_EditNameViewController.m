//
//  EditNameViewController.m
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_EditNameViewController.h"

@interface TanLiao_EditNameViewController ()

@end

@implementation TanLiao_EditNameViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLale.text = @"昵称";
    self.titleLale.alpha = 0.9;
    
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];



    [self.cloudClient setToastView:self.view];



 

    
    
    self.rightButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-60-12*BILI,  20, 60, 44)];
    self.rightButton.titleLabel.textAlignment = NSTextAlignmentRight;
    [self.rightButton setTitle:@"完成" forState:UIControlStateNormal];
    self.rightButton.alpha = 0.9;
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
    [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];



    [self.view addSubview:self.rightButton];
    
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT)];
    bottomView.backgroundColor = [UIColor blackColor];




    bottomView.alpha = 0.05;
    [self.view addSubview:bottomView];




    
    UIView * nameBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navView.frame.size.height+self.navView.frame.origin.y+15*BILI, VIEW_WIDTH, 45*BILI)];
    nameBottomView.backgroundColor = [UIColor whiteColor];


 

   

    [self.view addSubview:nameBottomView];


    
    self.nameTF = [[UITextField alloc] initWithFrame:CGRectMake(12*BILI, 0, VIEW_WIDTH, 45*BILI)];
    self.nameTF.textColor = [UIColor blackColor];


 


    self.nameTF.font = [UIFont systemFontOfSize:15*BILI];
    self.nameTF.text = self.name;
    self.nameTF.delegate = self;
    self.nameTF.placeholder = @"昵称1-8个字符";
    [nameBottomView addSubview:self.nameTF];
    
    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI, nameBottomView.frame.origin.y+nameBottomView.frame.size.height, VIEW_WIDTH, 45*BILI)];
    tipLable.text = @"好的昵称可以让Ta人更容易找到你哦";
    tipLable.font = [UIFont systemFontOfSize:12*BILI];
    tipLable.textColor = [UIColor blackColor];


 


    tipLable.alpha = 0.7;
    [self.view addSubview:tipLable];




}
-(void)rightClick
{
    if(self.nameTF.text.length == 0)
    {
         [TanLiao_Common showAlert:nil message:@"昵称不能为空"];
        
    }
    else if (self.nameTF.text.length>8)
    {
    [TanLiao_Common showAlert:nil message:@"昵称不能超过8个字符"];
    }
    else
    {
        [self showNewLoadingView:@"正在修改..." view:nil];
        [self.cloudClient editUserMessage:@"8030"
                                     nick:self.nameTF.text
                                avatarUrl:@""
                                     sign:@""
                                    price:@""
                         pendingAvatarUrl:@""
                                 birthday:@""
                                 delegate:self
                                 selector:@selector(editNameSuccess:)
                            errorSelector:@selector(editNameError:)];
        
        
    }
}
-(void)editNameSuccess:(NSDictionary *)info
{
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:@(277)];
        [array addObject:@(174)];
        [array addObject:@(389)];
        [array addObject:@(836)];
        [array addObject:@(424)];
        [array addObject:@(441)];
        [array addObject:@(793)];
        
    }
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * userInfo = [defaults objectForKey:USERINFO];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:userInfo];
    [dic removeObjectForKey:@"nick"];
    [dic setObject:self.nameTF.text forKey:@"nick"];
    [defaults removeObjectForKey:USERINFO];
    [defaults setObject:dic forKey:USERINFO];
    [defaults synchronize];

    
    [self hideNewLoadingView];


    [TanLiao_Common showToastView:@"昵称修改成功" view:self.view];


 

    [self.delegate changeName:self.nameTF.text];

    [self.navigationController popViewControllerAnimated:YES];
}
-(void)editNameError:(NSDictionary *)info
{
    [self hideNewLoadingView];

    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];


}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}
- (int)convertToInt:(NSString*)strtemp
{
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
        
    }
    return strlength;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initDataCnouaQwhoiVC:(NSDictionary *)info
{
    
    NSMutableArray * viewArray = [NSMutableArray array];
    UIView * IyevAico = [[UIView alloc]initWithFrame:CGRectMake(25,19,54,96)];
    IyevAico.layer.cornerRadius =8;
    [viewArray addObject:IyevAico];

}

@end
