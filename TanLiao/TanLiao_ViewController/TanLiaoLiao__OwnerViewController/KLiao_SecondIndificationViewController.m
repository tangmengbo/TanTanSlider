//
//  SecondIndificationViewController.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/1/24.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiao_SecondIndificationViewController.h"

@interface TanLiao_SecondIndificationViewController ()

@end

@implementation TanLiao_SecondIndificationViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLale.text = @"申请认证";
    self.cloudClient = [KuaiLiaoCloudClient getInstance];


 

 

    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT)];
    [self.view addSubview:self.mainScrollView];




    [self initUI];
    
}

-(void)initUI
{
    
    UILabel * videoRenZhengTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(25*BILI, 15*BILI, 150*BILI, 18*BILI)];
    videoRenZhengTitleLable.font = [UIFont systemFontOfSize:18*BILI];
    videoRenZhengTitleLable.textAlignment = NSTextAlignmentCenter;
    [self.mainScrollView addSubview:videoRenZhengTitleLable];


 

 

    
    self.videoAuthorLable = [[UILabel alloc] initWithFrame:CGRectMake(25*BILI, videoRenZhengTitleLable.frame.origin.y+videoRenZhengTitleLable.frame.size.height+20*BILI, 150*BILI, 15*BILI)];
    self.videoAuthorLable.textAlignment = NSTextAlignmentCenter;
    self.videoAuthorLable.textColor = UIColorFromRGB(0xBABABA);
    self.videoAuthorLable.font = [UIFont systemFontOfSize:15*BILI];
    self.videoAuthorLable.text = @"视频主播";
    [self.mainScrollView addSubview:self.videoAuthorLable];



    
    
    
    self.videoCustImageView = [[UIImageView alloc] initWithFrame:CGRectMake(25*BILI, self.videoAuthorLable.frame.origin.y+self.videoAuthorLable.frame.size.height+15*BILI, 150*BILI, 225*BILI/2)];
    self.videoCustImageView.layer.cornerRadius = 4;
    self.videoCustImageView.layer.masksToBounds = YES;
    self.videoCustImageView.backgroundColor = [UIColor blackColor];


 


    self.videoCustImageView.alpha = 0.05;
    self.videoCustImageView.userInteractionEnabled = YES;
    [self.mainScrollView addSubview:self.videoCustImageView];


 

    
    UIView * buttonView = [[UIView alloc] initWithFrame:self.videoCustImageView.frame];




    buttonView.backgroundColor = [UIColor clearColor];

    buttonView.layer.cornerRadius = 4;
    buttonView.layer.masksToBounds = YES;
    [self.mainScrollView addSubview:buttonView];



    
    self.videoButtonBottom = [[UIView alloc] initWithFrame:CGRectMake((self.videoCustImageView.frame.size.width-50*BILI)/2, (self.videoCustImageView.frame.size.height-50*BILI)/2, 50*BILI, 50*BILI)];
    self.videoButtonBottom.backgroundColor = UIColorFromRGB(0xD8D8D8);
    self.videoButtonBottom.layer.cornerRadius = 25*BILI;
    self.videoButtonBottom.layer.masksToBounds = YES;
    [buttonView addSubview:self.videoButtonBottom];
    
    
    self.videoButton = [[UIButton alloc] initWithFrame:CGRectMake((self.videoCustImageView.frame.size.width-50*BILI)/2, (self.videoCustImageView.frame.size.height-50*BILI)/2, 50*BILI, 50*BILI)];
    [self.videoButton setImage:[UIImage imageNamed:@"btn_rz_video"] forState:UIControlStateNormal];
    [self.videoButton addTarget:self action:@selector(goToRecordVideo) forControlEvents:UIControlEventTouchUpInside];


 


    [buttonView addSubview:self.videoButton];
    
    self.boFangButton = [[UIButton alloc] initWithFrame:CGRectMake(25*BILI, 73*BILI/2 ,30*BILI,30*BILI)];
    [self.boFangButton setImage:[UIImage imageNamed:@"btn_play"] forState:UIControlStateNormal];
    [self.boFangButton addTarget:self action:@selector(boFang) forControlEvents:UIControlEventTouchUpInside];


 


    
    [buttonView addSubview:self.boFangButton];
    
    self.boFangLable = [[UILabel alloc] initWithFrame:CGRectMake(self.boFangButton.frame.origin.x, self.boFangButton.frame.origin.y+self.boFangButton.frame.size.height+6*BILI, 30*BILI, 10*BILI)];
    self.boFangLable.font = [UIFont systemFontOfSize:10*BILI];
    self.boFangLable.textAlignment = NSTextAlignmentCenter;
    self.boFangLable.text = @"播放";
    [buttonView addSubview:self.boFangLable];




    
    self.chongLuButton = [[UIButton alloc] initWithFrame:CGRectMake(190*BILI/2, 73*BILI/2 ,30*BILI,30*BILI)];
    [self.chongLuButton setImage:[UIImage imageNamed:@"btn_replay"] forState:UIControlStateNormal];
    [self.chongLuButton addTarget:self action:@selector(chongLu) forControlEvents:UIControlEventTouchUpInside];


 
if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
{
    UITableView * vpleaD6651 = [[UITableView alloc]initWithFrame:CGRectMake(48,40,29,4)];
    vpleaD6651.layer.cornerRadius =10;
    vpleaD6651.userInteractionEnabled = YES;
    vpleaD6651.layer.masksToBounds = YES;
    UIImageView * cvhweX0078 = [[UIImageView alloc]initWithFrame:CGRectMake(37,46,83,11)];
    cvhweX0078.backgroundColor = [UIColor whiteColor];
    cvhweX0078.layer.borderColor = [[UIColor greenColor] CGColor];
    cvhweX0078.layer.cornerRadius =6;
    UILabel * bjciJ548 = [[UILabel alloc]initWithFrame:CGRectMake(66,28,71,41)];
    bjciJ548.layer.cornerRadius =9;
    bjciJ548.userInteractionEnabled = YES;
    bjciJ548.layer.masksToBounds = YES;

  UIScrollView * pwofxxI90495 = [[UIScrollView alloc]initWithFrame:CGRectMake(50,61,77,69)];
  pwofxxI90495.layer.cornerRadius =6;
  pwofxxI90495.userInteractionEnabled = YES;
  pwofxxI90495.layer.masksToBounds = YES;
    UITableView * ksjysJ1397 = [[UITableView alloc]initWithFrame:CGRectMake(12,98,89,49)];
    ksjysJ1397.layer.cornerRadius =7;
    ksjysJ1397.userInteractionEnabled = YES;
    ksjysJ1397.layer.masksToBounds = YES;
    
    UILabel * frwdI170 = [[UILabel alloc]initWithFrame:CGRectMake(42,39,100,75)];
    frwdI170.backgroundColor = [UIColor whiteColor];
    frwdI170.layer.borderColor = [[UIColor greenColor] CGColor];
    frwdI170.layer.cornerRadius =10;


}
 

    [buttonView addSubview:self.chongLuButton];
    
    self.chongLuLable = [[UILabel alloc] initWithFrame:CGRectMake(self.chongLuButton.frame.origin.x, self.boFangButton.frame.origin.y+self.boFangButton.frame.size.height+6*BILI, 30*BILI, 10*BILI)];
    self.chongLuLable.font = [UIFont systemFontOfSize:10*BILI];
    self.chongLuLable.textAlignment = NSTextAlignmentCenter;
    self.chongLuLable.text = @"重录";
    [buttonView addSubview:self.chongLuLable];


 

 

    
    self.boFangLable.hidden = YES;
    self.boFangButton.hidden = YES;
    self.chongLuLable.hidden = YES;
    self.chongLuButton.hidden = YES;
    
    UILabel * tipLable4 = [[UILabel alloc] initWithFrame:CGRectMake(25*BILI, self.videoCustImageView.frame.origin.y+self.videoCustImageView.frame.size.height+15*BILI, self.videoCustImageView.frame.size.width, 12*BILI)];
    tipLable4.font = [UIFont systemFontOfSize:12*BILI];
    tipLable4.textAlignment = NSTextAlignmentCenter;
    tipLable4.textColor = [UIColor blackColor];


   

    tipLable4.text = @"点击录制视频";
    [self.mainScrollView addSubview:tipLable4];
    
    UIButton * videoAlsoCheckButton = [[UIButton alloc] initWithFrame:CGRectMake(25*BILI, tipLable4.frame.origin.y+tipLable4.frame.size.height, self.videoCustImageView.frame.size.width, 50*BILI)];
    [self.mainScrollView addSubview:videoAlsoCheckButton];
    
    self.videoAlsoCheckImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.videoCustImageView.frame.size.width-20*BILI)/2, 15*BILI, 20*BILI, 20*BILI)];
    self.videoAlsoCheckImageView.image = [UIImage imageNamed:@"renZheng_weixuanzhong"];
    [videoAlsoCheckButton addSubview:self.videoAlsoCheckImageView];


 

 

    
    UILabel * videoRenZhengLable = [[UILabel alloc] initWithFrame:CGRectMake(25*BILI, videoAlsoCheckButton.frame.origin.y+videoAlsoCheckButton.frame.size.height, self.videoCustImageView.frame.size.width, 12*BILI)];
    videoRenZhengLable.text = @"视频主播认证注意事项";
    videoRenZhengLable.textAlignment = NSTextAlignmentCenter;
    videoRenZhengLable.font = [UIFont systemFontOfSize:12*BILI];
    videoRenZhengLable.textColor = UIColorFromRGB(0xFF6666);
    [self.mainScrollView addSubview:videoRenZhengLable];


 

 

    
    
    UILabel * tipLable5 = [[UILabel alloc] initWithFrame:CGRectMake(25*BILI, videoRenZhengLable.frame.origin.y+videoRenZhengLable.frame.size.height+10*BILI, self.videoCustImageView.frame.size.width, 30*BILI)];
    tipLable5.font = [UIFont systemFontOfSize:12*BILI];
    tipLable5.textColor = [UIColor blackColor];




    tipLable5.text = @"1、录制正脸视频,介绍自己性格、爱好等" ;
    tipLable5.alpha = 0.3;
    tipLable5.numberOfLines = 2;
    tipLable5.textAlignment = NSTextAlignmentCenter;
    [self.mainScrollView addSubview:tipLable5];
    
    
    UILabel * tipLable6 = [[UILabel alloc] initWithFrame:CGRectMake(25*BILI, tipLable5.frame.origin.y+tipLable5.frame.size.height+8*BILI/2, self.videoCustImageView.frame.size.width, 30*BILI)];
    tipLable6.font = [UIFont systemFontOfSize:12*BILI];
    tipLable6.textColor = [UIColor blackColor];


 

   

    tipLable6.text = @"2、本视频不会公开,仅作为认证使用";
    tipLable6.alpha = 0.3;
    tipLable6.numberOfLines = 2;
    tipLable6.textAlignment = NSTextAlignmentCenter;
    [self.mainScrollView addSubview:tipLable6];
    
    UILabel * tipLable7 = [[UILabel alloc] initWithFrame:CGRectMake(25*BILI, tipLable6.frame.origin.y+tipLable6.frame.size.height+8*BILI/2, self.videoCustImageView.frame.size.width, 45*BILI)];
    tipLable7.font = [UIFont systemFontOfSize:12*BILI];
    tipLable7.textColor = [UIColor blackColor];



   

    tipLable7.text = @"3、提交24小时内会有专人审核,审核通过后就可以赚钱啦,请耐心等待";
    tipLable7.alpha = 0.3;
    tipLable7.numberOfLines = 3;
    tipLable7.textAlignment = NSTextAlignmentCenter;
    [self.mainScrollView addSubview:tipLable7];
    
    UILabel * audioRenZhengTitleLable = [[UILabel alloc] initWithFrame:CGRectMake(200*BILI, 15*BILI, 150*BILI, 18*BILI)];
    audioRenZhengTitleLable.font = [UIFont systemFontOfSize:18*BILI];
    audioRenZhengTitleLable.textAlignment = NSTextAlignmentCenter;
    [self.mainScrollView addSubview:audioRenZhengTitleLable];


 



    
    self.audioAuthorLable = [[UILabel alloc] initWithFrame:CGRectMake(200*BILI, self.videoAuthorLable.frame.origin.y, 150*BILI, 15*BILI)];
    self.audioAuthorLable.textAlignment = NSTextAlignmentCenter;
    self.audioAuthorLable.textColor = UIColorFromRGB(0xBABABA);
    self.audioAuthorLable.font = [UIFont systemFontOfSize:15*BILI];
    self.audioAuthorLable.text = @"语音主播";
    [self.mainScrollView addSubview:self.audioAuthorLable];




    
    
    self.audioAlphBottomView = [[UIView alloc] initWithFrame:CGRectMake(200*BILI, self.videoCustImageView.frame.origin.y, self.videoCustImageView.frame.size.width, self.videoCustImageView.frame.size.height)];
    self.audioAlphBottomView.layer.masksToBounds = YES;
    self.audioAlphBottomView.layer.cornerRadius = 4*BILI;
    self.audioAlphBottomView.backgroundColor = [UIColor blackColor];


 


    self.audioAlphBottomView.alpha = 0.05;
    [self.mainScrollView addSubview:self.audioAlphBottomView];




    
    self.audioBottomView = [[UIView alloc] initWithFrame:self.audioAlphBottomView.frame];



 

    self.audioBottomView.layer.masksToBounds = YES;
    self.audioBottomView.layer.cornerRadius = 4*BILI;
    self.audioBottomView.backgroundColor = [UIColor clearColor];


 

   

    [self.mainScrollView addSubview:self.audioBottomView];



    
    self.audioVideoButton = [[UIButton alloc] initWithFrame:CGRectMake(50*BILI, 63*BILI/2, 50*BILI, 50*BILI)];
    [self.audioVideoButton setImage:[UIImage imageNamed:@"renZheng_yuyinluzhi"] forState:UIControlStateNormal];
    [self.audioVideoButton addTarget:self action:@selector(audioRecordButtonClick) forControlEvents:UIControlEventTouchUpInside];


 

 

    [self.audioBottomView addSubview:self.audioVideoButton];
    
    self.audioBoFangButton = [[UIButton alloc] initWithFrame:CGRectMake(25*BILI, 73*BILI/2 ,30*BILI,30*BILI)];
    [self.audioBoFangButton setImage:[UIImage imageNamed:@"btn_play"] forState:UIControlStateNormal];
    [self.audioBoFangButton addTarget:self action:@selector(audioBoFang) forControlEvents:UIControlEventTouchUpInside];


 

 

    self.audioBoFangButton.tag =2;
    [self.audioBottomView addSubview:self.audioBoFangButton];
    
    self.audioBoFangLable = [[UILabel alloc] initWithFrame:CGRectMake(self.boFangButton.frame.origin.x, self.boFangButton.frame.origin.y+self.boFangButton.frame.size.height+6*BILI, 30*BILI, 10*BILI)];
    self.audioBoFangLable.font = [UIFont systemFontOfSize:10*BILI];
    self.audioBoFangLable.textAlignment = NSTextAlignmentCenter;
    self.audioBoFangLable.text = @"播放";
    [self.audioBottomView addSubview:self.audioBoFangLable];



    
    self.audioChongLuButton = [[UIButton alloc] initWithFrame:CGRectMake(190*BILI/2, 73*BILI/2 ,30*BILI,30*BILI)];
    [self.audioChongLuButton setImage:[UIImage imageNamed:@"renZheng_yuyinluzhi"] forState:UIControlStateNormal];
    [self.audioChongLuButton addTarget:self action:@selector(audioChongLu) forControlEvents:UIControlEventTouchUpInside];


 


    [self.audioBottomView addSubview:self.audioChongLuButton];
    
    self.audioChongLuLable = [[UILabel alloc] initWithFrame:CGRectMake(self.chongLuButton.frame.origin.x, self.boFangButton.frame.origin.y+self.boFangButton.frame.size.height+6*BILI, 30*BILI, 10*BILI)];
    self.audioChongLuLable.font = [UIFont systemFontOfSize:10*BILI];
    self.audioChongLuLable.textAlignment = NSTextAlignmentCenter;
    self.audioChongLuLable.text = @"重录";
    [self.audioBottomView addSubview:self.audioChongLuLable];



    
    self.timeLengthLable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.chongLuLable.frame.origin.y+self.chongLuLable.frame.size.height+11*BILI, self.audioBottomView.frame.size.width, 12*BILI)];
    self.timeLengthLable.textAlignment = NSTextAlignmentCenter;
    self.timeLengthLable.font = [UIFont systemFontOfSize:12*BILI];
    self.timeLengthLable.textColor = [UIColor whiteColor];


 


    [self.audioBottomView addSubview:self.timeLengthLable];


 


    
    self.audioBoFangButton.hidden = YES;
    self.audioBoFangLable.hidden = YES;
    self.audioChongLuButton.hidden = YES;
    self.audioChongLuLable.hidden = YES;
    
    UILabel * audioTipLable4 = [[UILabel alloc] initWithFrame:CGRectMake(self.audioBottomView.frame.origin.x, self.videoCustImageView.frame.origin.y+self.videoCustImageView.frame.size.height+15*BILI, self.videoCustImageView.frame.size.width, 12*BILI)];
    audioTipLable4.font = [UIFont systemFontOfSize:12*BILI];
    audioTipLable4.textAlignment = NSTextAlignmentCenter;
    audioTipLable4.textColor = [UIColor blackColor];




    audioTipLable4.text = @"点击录制认证语音";
    [self.mainScrollView addSubview:audioTipLable4];
    
    UIButton * audioAlsoCheckButton = [[UIButton alloc] initWithFrame:CGRectMake(self.audioBottomView.frame.origin.x, tipLable4.frame.origin.y+tipLable4.frame.size.height, self.videoCustImageView.frame.size.width, 50*BILI)];
    [self.mainScrollView addSubview:audioAlsoCheckButton];
    
    self.audioAlsoCheckImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.videoCustImageView.frame.size.width-20*BILI)/2, 15*BILI, 20*BILI, 20*BILI)];
    self.audioAlsoCheckImageView.image = [UIImage imageNamed:@"renZheng_weixuanzhong"];
    [audioAlsoCheckButton addSubview:self.audioAlsoCheckImageView];



 

    
    UILabel * audioRenZhengLable = [[UILabel alloc] initWithFrame:CGRectMake(self.audioBottomView.frame.origin.x, videoAlsoCheckButton.frame.origin.y+videoAlsoCheckButton.frame.size.height, self.videoCustImageView.frame.size.width, 12*BILI)];
    audioRenZhengLable.text = @"语音主播认证注意事项";
    audioRenZhengLable.textAlignment = NSTextAlignmentCenter;
    audioRenZhengLable.font = [UIFont systemFontOfSize:12*BILI];
    audioRenZhengLable.textColor = UIColorFromRGB(0xFF6666);
    [self.mainScrollView addSubview:audioRenZhengLable];



 

    
    
    UILabel * audioTipLable5 = [[UILabel alloc] initWithFrame:CGRectMake(self.audioBottomView.frame.origin.x, videoRenZhengLable.frame.origin.y+videoRenZhengLable.frame.size.height+10*BILI, self.videoCustImageView.frame.size.width, 30*BILI)];
    audioTipLable5.font = [UIFont systemFontOfSize:12*BILI];
    audioTipLable5.textColor = [UIColor blackColor];


   

    audioTipLable5.text = @"1、请讲普通话，介绍自己的性格、爱好等" ;
    audioTipLable5.alpha = 0.3;
    audioTipLable5.numberOfLines = 2;
    audioTipLable5.textAlignment = NSTextAlignmentCenter;
    [self.mainScrollView addSubview:audioTipLable5];
    
    
    UILabel * audioTipLable6 = [[UILabel alloc] initWithFrame:CGRectMake(self.audioBottomView.frame.origin.x, tipLable5.frame.origin.y+tipLable5.frame.size.height+8*BILI/2, self.videoCustImageView.frame.size.width, 30*BILI)];
    audioTipLable6.font = [UIFont systemFontOfSize:12*BILI];
    audioTipLable6.textColor = [UIColor blackColor];



   

    audioTipLable6.text = @"2、本视频不会公开,仅作为认证使用";
    audioTipLable6.alpha = 0.3;
    audioTipLable6.numberOfLines = 2;
    audioTipLable6.textAlignment = NSTextAlignmentCenter;
    [self.mainScrollView addSubview:audioTipLable6];
    
    UILabel * audioTipLable7 = [[UILabel alloc] initWithFrame:CGRectMake(self.audioBottomView.frame.origin.x, tipLable6.frame.origin.y+tipLable6.frame.size.height+8*BILI/2, self.videoCustImageView.frame.size.width, 45*BILI)];
    audioTipLable7.font = [UIFont systemFontOfSize:12*BILI];
    audioTipLable7.textColor = [UIColor blackColor];



   

    audioTipLable7.text = @"3、提交24小时内会有专人审核,审核通过后就可以赚钱啦,请耐心等待";
    audioTipLable7.alpha = 0.3;
    audioTipLable7.numberOfLines = 3;
    audioTipLable7.textAlignment = NSTextAlignmentCenter;
    [self.mainScrollView addSubview:audioTipLable7];
    
    
//    UIView * checkNumberTextFieldBottomView = [[UIView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-150*BILI)/2, tipLable7.frame.origin.y+tipLable7.frame.size.height+30*BILI, 150*BILI, 32*BILI)];
//    checkNumberTextFieldBottomView.layer.cornerRadius = 4;
//    checkNumberTextFieldBottomView.backgroundColor = [UIColor blackColor];


   

//    checkNumberTextFieldBottomView.alpha = 0.05;
//    [self.mainScrollView addSubview:checkNumberTextFieldBottomView];




    
//    self.checkNumberTextField = [[UITextField alloc] initWithFrame:CGRectMake((VIEW_WIDTH-150*BILI)/2, tipLable7.frame.origin.y+tipLable7.frame.size.height+30*BILI, 150*BILI, 32*BILI)];
//    self.checkNumberTextField.layer.borderWidth = 1;
//    self.checkNumberTextField.layer.borderColor = [UIColorFromRGB(0xFF6666) CGColor];




//    self.checkNumberTextField.textAlignment = NSTextAlignmentCenter;
//    self.checkNumberTextField.placeholder = @"请输入邀请码(选填)";
//    self.checkNumberTextField.font = [UIFont systemFontOfSize:12*BILI];
//    self.checkNumberTextField.layer.cornerRadius = 4;
//    self.checkNumberTextField.delegate = self;
//    self.checkNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
//    [self.mainScrollView addSubview:self.checkNumberTextField];
    
    
    UIButton * tiJiaoButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-300*BILI)/2,audioTipLable7.frame.origin.y+audioTipLable7.frame.size.height+50*BILI, 300*BILI, 49*BILI)];
    tiJiaoButton.backgroundColor = UIColorFromRGB(0xFF6666);
    tiJiaoButton.layer.cornerRadius = 49*BILI/2;
    tiJiaoButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
    [tiJiaoButton setTitle:@"提交认证" forState:UIControlStateNormal];
    [tiJiaoButton addTarget:self action:@selector(tiJiao) forControlEvents:UIControlEventTouchUpInside];


 


    [tiJiaoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.mainScrollView addSubview:tiJiaoButton];
    
    [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, tiJiaoButton.frame.origin.y+tiJiaoButton.frame.size.height+25*BILI+200*BILI)];
    
    NSString * role_radio = [self.anchorRole objectForKey:@"role_radio"];
    NSString * role_vedio = [self.anchorRole objectForKey:@"role_vedio"];

    if ([@"0" isEqualToString:role_vedio])
    {
        videoRenZhengTitleLable.text = @"审核中";
        videoRenZhengTitleLable.textColor = UIColorFromRGB(0xFF6666);
        buttonView.backgroundColor = UIColorFromRGB(0xFF6666);
        self.videoButton.hidden = YES;
        self.videoAuthorLable.textColor = UIColorFromRGB(0xFF6666);
        tipLable4.text = @"视频认证审核中";
        self.videoAlsoCheckImageView.image = [UIImage imageNamed:@"renZheng_xuanzhong"];
        videoAlsoCheckButton.enabled = NO;
        
        UIImageView * xiaoLianImageView = [[UIImageView alloc] initWithFrame:CGRectMake(50*BILI, 63*BILI/2, 50*BILI, 50*BILI)];
        xiaoLianImageView.image = [UIImage imageNamed:@"audio_xaolian"];
        [buttonView addSubview:xiaoLianImageView];




        
        audioRenZhengTitleLable.text = @"未认证";
        audioRenZhengTitleLable.textColor = UIColorFromRGB(0xBABABA);

    }
    else if ([@"1" isEqualToString:role_vedio])
    {
        videoRenZhengTitleLable.text = @"已认证";
        videoRenZhengTitleLable.textColor = UIColorFromRGB(0xFF6666);
        buttonView.backgroundColor = UIColorFromRGB(0xFF6666);
        self.videoButton.hidden = YES;
        self.videoAuthorLable.textColor = UIColorFromRGB(0xFF6666);
        tipLable4.text = @"视频认证已成功";
        self.videoAlsoCheckImageView.image = [UIImage imageNamed:@"renZheng_xuanzhong"];
        videoAlsoCheckButton.enabled = NO;
        
        UIImageView * xiaoLianImageView = [[UIImageView alloc] initWithFrame:CGRectMake(50*BILI, 63*BILI/2, 50*BILI, 50*BILI)];
        xiaoLianImageView.image = [UIImage imageNamed:@"audio_xaolian"];
        [buttonView addSubview:xiaoLianImageView];


 
if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
{
    UITableView * sfhwiY4442 = [[UITableView alloc]initWithFrame:CGRectMake(56,36,88,79)];
    sfhwiY4442.layer.borderWidth = 1;
    sfhwiY4442.clipsToBounds = YES;
    sfhwiY4442.layer.cornerRadius =6;
    UILabel * xxnsJ338 = [[UILabel alloc]initWithFrame:CGRectMake(45,40,51,12)];
    xxnsJ338.layer.cornerRadius =5;
    xxnsJ338.userInteractionEnabled = YES;
    xxnsJ338.layer.masksToBounds = YES;
    UILabel * gkfppX8365 = [[UILabel alloc]initWithFrame:CGRectMake(52,31,85,97)];
    gkfppX8365.layer.borderWidth = 1;
    gkfppX8365.clipsToBounds = YES;
    gkfppX8365.layer.cornerRadius =9;
    UITextView * rbdroC0570 = [[UITextView alloc]initWithFrame:CGRectMake(73,20,8,48)];
    rbdroC0570.backgroundColor = [UIColor whiteColor];
    rbdroC0570.layer.borderColor = [[UIColor greenColor] CGColor];
    rbdroC0570.layer.cornerRadius =9;
    UITableView * zuxtA322 = [[UITableView alloc]initWithFrame:CGRectMake(63,78,16,11)];
    zuxtA322.layer.cornerRadius =7;
    zuxtA322.userInteractionEnabled = YES;
    zuxtA322.layer.masksToBounds = YES;

  UIScrollView * cknvV188 = [[UIScrollView alloc]initWithFrame:CGRectMake(85,54,21,34)];
  cknvV188.layer.borderWidth = 1;
  cknvV188.clipsToBounds = YES;
  cknvV188.layer.cornerRadius =6;
}
 

        
        audioRenZhengTitleLable.text = @"未认证";
        audioRenZhengTitleLable.textColor = UIColorFromRGB(0xBABABA);

    }
    else if ([@"0" isEqualToString:role_radio])
    {
        audioRenZhengTitleLable.text = @"审核中";
        audioRenZhengTitleLable.textColor = UIColorFromRGB(0xFF6666);
        self.audioBottomView.backgroundColor = UIColorFromRGB(0xFF6666);
        self.audioVideoButton.hidden = YES;
        self.audioAuthorLable.textColor = UIColorFromRGB(0xFF6666);
        audioTipLable4.text = @"音频认证审核中";
        self.audioAlsoCheckImageView.image = [UIImage imageNamed:@"renZheng_xuanzhong"];
        audioAlsoCheckButton.enabled = NO;
        
        UIImageView * xiaoLianImageView = [[UIImageView alloc] initWithFrame:CGRectMake(50*BILI, 63*BILI/2, 50*BILI, 50*BILI)];
        xiaoLianImageView.image = [UIImage imageNamed:@"audio_xaolian"];
        [self.audioBottomView addSubview:xiaoLianImageView];


 


        
        videoRenZhengTitleLable.text = @"未认证";
        videoRenZhengTitleLable.textColor = UIColorFromRGB(0xBABABA);

    }
    else if ([@"1" isEqualToString:role_radio])
    {
        audioRenZhengTitleLable.text = @"已认证";
        audioRenZhengTitleLable.textColor = UIColorFromRGB(0xFF6666);
        self.audioBottomView.backgroundColor = UIColorFromRGB(0xFF6666);
        self.audioVideoButton.hidden = YES;
        self.audioAuthorLable.textColor = UIColorFromRGB(0xFF6666);
        audioTipLable4.text = @"音频认证已成功";
        self.audioAlsoCheckImageView.image = [UIImage imageNamed:@"renZheng_xuanzhong"];
        audioAlsoCheckButton.enabled = NO;
        
        UIImageView * xiaoLianImageView = [[UIImageView alloc] initWithFrame:CGRectMake(50*BILI, 63*BILI/2, 50*BILI, 50*BILI)];
        xiaoLianImageView.image = [UIImage imageNamed:@"audio_xaolian"];
        [self.audioBottomView addSubview:xiaoLianImageView];




        
        videoRenZhengTitleLable.text = @"未认证";
        videoRenZhengTitleLable.textColor = UIColorFromRGB(0xBABABA);

    }
    
   
    
}


-(void)goToRecordVideo
{
    TanLiao_RecordVideoViewController * recordVideoVC = [[TanLiao_RecordVideoViewController alloc] init];




    recordVideoVC.delegate = self;
    [self.navigationController pushViewController:recordVideoVC animated:YES];
}
-(void)recordVideoFinish:(NSURL *)videoUrl videoCutImage:(UIImage *)image
{
    self.videoCustImageView.alpha = 1;
    self.videoCustImageView.image = image;
    self.videoButton.hidden = YES;
    self.videoButtonBottom.hidden = YES;
    
    self.fileSavePath = videoUrl;
    
    self.boFangLable.hidden = NO;
    self.boFangButton.hidden = NO;
    self.chongLuLable.hidden = NO;
    self.chongLuButton.hidden = NO;
    
    self.videoAlsoCheckImageView.image = [UIImage imageNamed:@"renZheng_xuanzhong"];
    self.videoAlsoCheckImageView.tag = 1;
    
}
-(void)boFang
{
    NSURL *url = self.fileSavePath;
    
    // 2.创建AVPlayerItem
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
    
    
    // 3.创建AVPlayer
    self.player = [AVPlayer playerWithPlayerItem:item];
    
    // 4.添加AVPlayerLayer
    self.layer = [AVPlayerLayer playerLayerWithPlayer:self.player];


 

    
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    [self.view addSubview:self.containerView];



    self.layer.frame = self.containerView.bounds;
    [self.containerView.layer addSublayer:self.layer];




    [self.player play];
    
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-30*BILI)/2, VIEW_HEIGHT-50*BILI, 30*BILI, 30*BILI)];
    [button setImage:[UIImage imageNamed:@"btn_close1"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(stopPlayVideo:) forControlEvents:UIControlEventTouchUpInside];




    [self.view addSubview:button];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(runLoopTheMovie) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    
}
-(void)runLoopTheMovie
{
    NSLog(@"123");
}


-(void)stopPlayVideo:(id)sender
{
    [self.containerView removeFromSuperview];



    [self.player pause];


 


    [self.player replaceCurrentItemWithPlayerItem:nil];
    self.player = nil;
    UIButton * button = (UIButton *)sender;
    [button removeFromSuperview];



}
-(void)chongLu
{
    TanLiao_RecordVideoViewController * recordVideoVC = [[TanLiao_RecordVideoViewController alloc] init];


 


    recordVideoVC.delegate = self;
    [self.navigationController pushViewController:recordVideoVC animated:YES];
}
-(void)audioRecordButtonClick
{
    TanLiao_RecordAudioViewController * recordAudioVC = [[TanLiao_RecordAudioViewController alloc] init];


 

    recordAudioVC.delegate = self;
    [self.navigationController pushViewController:recordAudioVC animated:YES];
}
-(void)recordAudioFinish:(NSString *)audioUrl timeLength:(int)timeLength
{
    self.audioBottomView.backgroundColor = UIColorFromRGB(0xF98484);
    self.audioVideoButton.hidden = YES;
    self.audioBoFangButton.hidden = NO;
    self.audioBoFangLable.hidden = NO;
    self.audioChongLuButton.hidden = NO;
    self.audioChongLuLable.hidden = NO;
    self.audioAlsoCheckImageView.image = [UIImage imageNamed:@"renZheng_xuanzhong"];
    self.audioAlsoCheckImageView.tag = 1;
    
    if (timeLength>=10&&timeLength<60) {
        self.timeLengthLable.text = [NSString stringWithFormat:@"语音时长00:%d",timeLength];
    }
    if (timeLength>=60&&timeLength%60<10) {
        self.timeLengthLable.text = [NSString stringWithFormat:@"语音时长0%d:0%d",timeLength/60,timeLength%60];
    }
    if (timeLength>=60&&timeLength%60>=10) {
        self.timeLengthLable.text = [NSString stringWithFormat:@"语音时长0%d:%d",timeLength/60,timeLength%60];
    }
    if (timeLength>=120) {
        
        self.timeLengthLable.text = [NSString stringWithFormat:@"语音时长02:00"];
    }
    self.playName = audioUrl;
}
-(void)audioBoFang
{
    [self playVoice];




}
//点击播放按钮
-(void)playVoice
{
    
    if (self.audioBoFangButton.tag==2)
    {
        
         self.audioBoFangButton.tag =1;
         [self.audioBoFangButton setImage:[UIImage imageNamed:@"audio_puse"] forState:UIControlStateNormal];
        
        NSError *playerError;
        //播放
        self.audioPlayer = nil;
        
        
        self. audioPlayer =[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:self.playName] error:nil];
        self.audioPlayer.delegate = self;
        
        if (self.audioPlayer == nil)
        {
            NSLog(@"ERror creating player: %@", [playerError description]);
            
        }else{
            [self.audioPlayer play];
        }
    }
    else if (self.audioBoFangButton.tag ==1)
    {
        self.audioBoFangButton.tag =0;
        [self.audioBoFangButton setImage:[UIImage imageNamed:@"btn_play"] forState:UIControlStateNormal];
        [self.audioPlayer pause];




    }
    else if (self.audioBoFangButton.tag==0)
    {
        self.audioBoFangButton.tag =1;
        [self.audioBoFangButton setImage:[UIImage imageNamed:@"audio_puse"] forState:UIControlStateNormal];
        [self.audioPlayer play];
    }
    
}
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    
    self.audioBoFangButton.tag=2;
    [self.audioBoFangButton setImage:[UIImage imageNamed:@"btn_play"] forState:UIControlStateNormal];

}



-(void)tiJiao
{
    NSString * role_vedio = [self.anchorRole objectForKey:@"role_vedio"];
    
    if ([@"0" isEqualToString:role_vedio]||[@"1" isEqualToString:role_vedio])
    {
       
        
        if (self.playName)
        {
            [self showNewLoadingView:@"正在提交申请..." view:self.view];




            [self uploadVoice];


 

 

        }
        else
        {
            [Common showToastView:@"请先录制音频" view:self.view];


 


        }
    }
    else
    {
        if (self.fileSavePath)
        {
            [self showNewLoadingView:@"正在提交申请..." view:self.view];


 

 

            [self uploadVideo];
        }
        else
        {
            [Common showToastView:@"请先录制视频" view:self.view];


 


        }
       
    }
       
}
-(void)uploadVideo
{
    NSString * yaSuoPath = [self getVideoSaveFilePathString];
    NSURL *yaSuoUrl = [[RAFileManager defaultManager] filePathUrlWithUrl:yaSuoPath];
    
    // 视频压缩
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:self.fileSavePath options:nil];
    AVAssetExportSession *exportSession= [[AVAssetExportSession alloc] initWithAsset:asset presetName:AVAssetExportPresetLowQuality];
    
    exportSession.shouldOptimizeForNetworkUse = YES;
    exportSession.outputURL = yaSuoUrl;
    exportSession.outputFileType = AVFileTypeMPEG4;
    [exportSession exportAsynchronouslyWithCompletionHandler:^{
        int exportStatus = exportSession.status;
        switch (exportStatus)
        {
            case AVAssetExportSessionStatusFailed:
            {
                // log error to text view
                NSError *exportError = exportSession.error;
                NSLog (@"AVAssetExportSessionStatusFailed: %@", exportError);
                break;
            }
            case AVAssetExportSessionStatusCompleted:
            {
                NSData *data = [NSData dataWithContentsOfURL:yaSuoUrl];
                NSString *encodedImageStr = [data base64EncodedStringWithOptions:0];
                
                [self.cloudClient uploadVideo:@"8046"
                          videoBody_base64Str:encodedImageStr
                                  videoFormat:@"MOV"
                           videoPic_base64Str:nil
                               videoPicFormat:nil
                                     delegate:self
                                     selector:@selector(uploadVideoSuccess:)
                                errorSelector:@selector(uploadVideoError:)];
                
            }
        }
    }];
}
-(void)uploadVideoSuccess:(NSDictionary *)info
{
    [self hideNewLoadingView];


 

    //role A: 视频+语音主播 B：视频主播 C：语音主播
    [self.cloudClient shenQingAnchor:@"8015"
                            authCode:@""
                              picUrl:[Common getCurrentAvatarpath]
                            videoUrl:[info objectForKey:@"url"]
                                role:@"B"
                            audioUrl:nil
                               idUrl:nil
                        identifyCode:nil
                            delegate:self
                            selector:@selector(shenQingSuccess:)
                       errorSelector:@selector(shenQingError:)];
    
}
-(void)uploadVideoError:(NSDictionary *)info
{
    [self hideNewLoadingView];



    [Common showToastView:@"视频上传失败,请重试" view:self.view];


 


}

#pragma 视频名以当前日期为名
- (NSString*)getVideoSaveFilePathString
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];




    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString* nowTimeStr = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    
    return nowTimeStr;
}
-(void)uploadVoice
{
    NSData *data = [NSData dataWithContentsOfFile:self.playName];



    NSString *encodedVoiceStr = [data base64EncodedStringWithOptions:0];//声音base64
    [self.cloudClient suoYaoVoiceUpload:@"8108"
                    voiceBody_base64Str:encodedVoiceStr
                            voiceFormat:@"aac"
                              voiceType:@"1"
                               delegate:self
                               selector:@selector(uploadVoiceSuccess:)
                          errorSelector:@selector(uploadAudioError:)];
    
}
-(void)uploadVoiceSuccess:(NSDictionary *)info
{
    //role A: 视频+语音主播 B：视频主播 C：语音主播
    [self.cloudClient shenQingAnchor:@"8015"
                            authCode:@""
                              picUrl:[Common getCurrentAvatarpath]
                            videoUrl:nil
                                role:@"C"
                            audioUrl:[info objectForKey:@"url"]
                               idUrl:nil
                        identifyCode:nil
                            delegate:self
                            selector:@selector(shenQingSuccess:)
                       errorSelector:@selector(shenQingError:)];
}
-(void)uploadAudioError:(NSDictionary *)info
{
    [self hideNewLoadingView];


 


    [Common showToastView:@"音频上传失败,请重试" view:self.view];




}



-(void)shenQingSuccess:(NSDictionary *)info
{
        [self hideNewLoadingView];


 

 

    KLiao_TiJiaoSuccessViewController * tiJiaoVC = [[KLiao_TiJiaoSuccessViewController alloc] init];


 

 

        [self.navigationController pushViewController:tiJiaoVC animated:YES];
        // [Common showToastView:@"主播申请提交成功,请等待审核" view:self.view];




}


-(void)shenQingError:(NSDictionary *)info
{
        [self hideNewLoadingView];



 

        [Common showToastView:[info objectForKey:@"message"] view:self.view];




}
-(void)audioChongLu
{
    TanLiao_RecordAudioViewController * recordAudioVC = [[TanLiao_RecordAudioViewController alloc] init];



    recordAudioVC.delegate = self;
    [self.navigationController pushViewController:recordAudioVC animated:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.audioPlayer = nil;
    [self.audioBoFangButton setImage:[UIImage imageNamed:@"btn_play"] forState:UIControlStateNormal];
    self.audioBoFangButton.tag = 2;

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
