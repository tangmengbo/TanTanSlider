//
//  EditAnchorNameViewController.m
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/27.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiaoLiao_EditAnchorNameViewController.h"

@interface TanLiaoLiao_EditAnchorNameViewController ()

@end

@implementation TanLiaoLiao_EditAnchorNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titleLale.text = @"备注好友";
    self.titleLale.alpha = 0.9;
    
    
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


 
if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
{
    UIImageView * kzakN613 = [[UIImageView alloc]initWithFrame:CGRectMake(94,0,63,85)];
    kzakN613.backgroundColor = [UIColor whiteColor];
    kzakN613.layer.borderColor = [[UIColor greenColor] CGColor];
    kzakN613.layer.cornerRadius =6;

  UIView * pamczcA93966 = [[UIView alloc]initWithFrame:CGRectMake(82,82,36,84)];
  pamczcA93966.layer.borderWidth = 1;
  pamczcA93966.clipsToBounds = YES;
  pamczcA93966.layer.cornerRadius =7;
    UIView * zhcnG731 = [[UIView alloc]initWithFrame:CGRectMake(53,26,54,80)];
    zhcnG731.backgroundColor = [UIColor whiteColor];
    zhcnG731.layer.borderColor = [[UIColor greenColor] CGColor];
    zhcnG731.layer.cornerRadius =9;
    
    UIImageView * vwxakbS95891 = [[UIImageView alloc]initWithFrame:CGRectMake(26,75,97,92)];
    vwxakbS95891.layer.cornerRadius =6;
    vwxakbS95891.userInteractionEnabled = YES;
    vwxakbS95891.layer.masksToBounds = YES;


}
 

    
    UIView * nameBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navView.frame.size.height+self.navView.frame.origin.y+15*BILI, VIEW_WIDTH, 45*BILI)];
    nameBottomView.backgroundColor = [UIColor whiteColor];




    [self.view addSubview:nameBottomView];



    
    self.nameTF = [[UITextField alloc] initWithFrame:CGRectMake(12*BILI, 0, VIEW_WIDTH, 45*BILI)];
    self.nameTF.textColor = [UIColor blackColor];



   

    self.nameTF.font = [UIFont systemFontOfSize:15*BILI];
    self.nameTF.text = self.name;
    self.nameTF.delegate = self;
    [nameBottomView addSubview:self.nameTF];
    
    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI, nameBottomView.frame.origin.y+nameBottomView.frame.size.height, VIEW_WIDTH, 45*BILI)];
    tipLable.text = @"给Ta设置备注可以让你更容易记住Ta哦";
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
    else if ([self convertToInt:self.nameTF.text]>16)
    {
        [TanLiao_Common showAlert:nil message:@"用户名不能超过8个汉字"];
    }
    else
    {
        [self.delegate changeName:self.nameTF.text];

        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    
    if ([self convertToInt:textField.text]>=16 && ![@"" isEqualToString:string]) {
        
        return NO;
    }
    else
    {
        return YES;
    }
    
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
