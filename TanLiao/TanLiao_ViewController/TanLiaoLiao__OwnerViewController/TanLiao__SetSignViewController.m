//
//  SetSignViewController.m
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao__SetSignViewController.h"

@interface TanLiao__SetSignViewController ()

@end

@implementation TanLiao__SetSignViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];


 

 

    [self.cloudClient setToastView:self.view];


 


    
    self.titleLale.text = @"个性签名";
    self.titleLale.alpha = 0.9;
    
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(18*BILI, self.navView.frame.origin.y+self.navView.frame.size.height+12*BILI, VIEW_WIDTH-(18*BILI*2),(VIEW_WIDTH-(18*BILI*2))*390/680)];
    bottomView.alpha = 0.3;
    bottomView.layer.borderWidth = 1;
    bottomView.layer.borderColor = [[UIColor blackColor] CGColor];



    bottomView.layer.cornerRadius = 4;
    [self.view addSubview:bottomView];




    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap)];
    [self.view addGestureRecognizer:tap];
    
    self.tipsLable = [[UILabel alloc] initWithFrame:CGRectMake(18*BILI+15*BILI, self.navView.frame.origin.y+self.navView.frame.size.height+12*BILI+15*BILI,VIEW_WIDTH-(18*BILI*2+15*BILI*2),15*BILI)];
    self.tipsLable.text =@"输入您的个性签名(1-25个字符)";
    self.tipsLable.alpha = 0.3;
    self.tipsLable.font = [UIFont systemFontOfSize:15*BILI];
    self.tipsLable.textColor = [UIColor blackColor];



    [self.view addSubview:self.tipsLable];



 

    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(18*BILI+15*BILI, self.navView.frame.origin.y+self.navView.frame.size.height+12*BILI+15*BILI/2, VIEW_WIDTH-(18*BILI*2+15*BILI*2),bottomView.frame.size.height-30*BILI+15*BILI/2)];
    self.textView.font = [UIFont systemFontOfSize:15*BILI];
    self.textView.delegate = self;
    self.textView.backgroundColor = [UIColor clearColor];




    self.textView.textColor = [UIColor blackColor];




    [self.view addSubview:self.textView];


 


    if (![@"" isEqualToString:self.sign]) {
        
        self.textView.text = self.sign;
        self.tipsLable.text = @"";
    }
    
    self.submitButton = [[UIButton alloc] initWithFrame:CGRectMake(bottomView.frame.origin.x, bottomView.frame.size.height+bottomView.frame.origin.y+12.5*BILI, bottomView.frame.size.width, 40*BILI)];
    [self.submitButton setBackgroundColor:UIColorFromRGB(0xFF5C93)];
    
    self.submitButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
    [self.submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.submitButton setTitle:@"提交" forState:UIControlStateNormal];
    self.submitButton.layer.cornerRadius = 4;
    [self.submitButton addTarget:self action:@selector(submitButtonClick) forControlEvents:UIControlEventTouchUpInside];



    [self.view addSubview:self.submitButton];

}



-(void)submitButtonClick
{
    
    if ([@"" isEqualToString:self.textView.text])
    {
        [TanLiao_Common showAlert:nil message:@"签名不能为空"];
        return;
    }
    if (self.textView.text.length>25) {
        [TanLiao_Common showAlert:nil message:@"签名为1-25个字符"];
        return;
    }
    
    [self showNewLoadingView:@"正在修改..." view:nil];
    [self.cloudClient editUserMessage:@"8030"
                                 nick:@""
                            avatarUrl:@""
                                 sign:self.textView.text
                                price:@""
                     pendingAvatarUrl:@""
                             birthday:@""
                             delegate:self
                             selector:@selector(editSignSuccess:)
                        errorSelector:@selector(editSignError:)];
 
    
}
-(void)editSignSuccess:(NSDictionary *)info
{
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];


    NSDictionary * userInfo = [defaults objectForKey:USERINFO];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:userInfo];
    [dic removeObjectForKey:@"sign"];
    [dic setObject:self.textView.text forKey:@"sign"];
    [defaults removeObjectForKey:USERINFO];
    [defaults setObject:dic forKey:USERINFO];
    [defaults synchronize];


    
    [self hideNewLoadingView];




    [TanLiao_Common showToastView:@"签名设置成功" view:self.view];
    [self.delegate setSign:self.textView.text];


 

    [self.navigationController popViewControllerAnimated:YES];
}
-(void)editSignError:(NSDictionary *)info
{
    [self hideNewLoadingView];


    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];


 
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        UIScrollView * ZbvnvuCsjfqg = [[UIScrollView alloc]initWithFrame:CGRectMake(48,98,12,32)];
        ZbvnvuCsjfqg.layer.cornerRadius =5;
        [self.view addSubview:ZbvnvuCsjfqg];
        
        UIScrollView * WawlqyWrkflf = [[UIScrollView alloc]initWithFrame:CGRectMake(7,51,77,31)];
        WawlqyWrkflf.layer.cornerRadius =8;
        [self.view addSubview:WawlqyWrkflf];
        
    }
    
 

}


-(void)textViewDidChange:(UITextView *)textView
{
    if ([@"" isEqualToString:textView.text]) {
        
        self.tipsLable.text = @"输入您的个性签名(1-25个字符)";
    }
    else
    {
        self.tipsLable.text = @"";
    }
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
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

-(void)viewTap
{
    [self.textView resignFirstResponder];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSArray *)wqo_pushTo_qowzaj
{
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@(389)];
    [array addObject:@(231)];
    [array addObject:@(288)];
    [array addObject:@(813)];
    [array addObject:@(964)];
    [array addObject:@(854)];
    [array addObject:@(909)];
    [array addObject:@(378)];
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
