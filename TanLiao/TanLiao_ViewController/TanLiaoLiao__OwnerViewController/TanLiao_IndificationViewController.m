  //
//  IndificationViewController.m
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/17.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_IndificationViewController.h"

@interface TanLiao_IndificationViewController ()

@end

@implementation TanLiao_IndificationViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLale.text = @"颜值认证";
    self.tipLable.alpha = 0.9;
    
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];



 

    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navView.frame.size.height+self.navView.frame.origin.y, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.size.height+self.navView.frame.origin.y))];
    self.mainScrollView.backgroundColor = [UIColor whiteColor];


   

    [self.view addSubview:self.mainScrollView];


    
    UIImageView * stepOne = [[UIImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-387*BILI/2)/2, 31*BILI/2, 387*BILI/2, 144*BILI/2)];
    stepOne.image = [UIImage imageNamed:@"pic_step1"];
    [self.mainScrollView addSubview:stepOne];



 

    
    
    self.headerImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(111*BILI/2, stepOne.frame.origin.y+stepOne.frame.size.height, 80*BILI, 80*BILI)];
    self.headerImageView.imgType = IMAGEVIEW_TYPE_CENTER;
    self.headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.mainScrollView addSubview:self.headerImageView];


 

 

    
    UITapGestureRecognizer * headerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editImage)];
    [self.headerImageView addGestureRecognizer:headerTap];
    self.headerImageView.userInteractionEnabled = YES;


 

    
    UILabel * tipLable2 = [[UILabel alloc] initWithFrame:CGRectMake(self.headerImageView.frame.origin.x+self.headerImageView.frame.size.width+30*BILI, stepOne.frame.origin.y+stepOne.frame.size.height+8*BILI/2, 330*BILI/2, 30*BILI)];
    tipLable2.font = [UIFont systemFontOfSize:12*BILI];
    tipLable2.textColor = [UIColor blackColor];


 

    tipLable2.numberOfLines = 2;
    tipLable2.text = @"1、确保是本人真实正脸头像,且和视频同一人";
    tipLable2.alpha = 0.3;
    [self.mainScrollView addSubview:tipLable2];
    
    
    UILabel * tipLable3 = [[UILabel alloc] initWithFrame:CGRectMake(tipLable2.frame.origin.x, tipLable2.frame.origin.y+tipLable2.frame.size.height+44*BILI/2, 330*BILI/2, 12*BILI)];
    tipLable3.font = [UIFont systemFontOfSize:12*BILI];
    tipLable3.textColor = [UIColor blackColor];



   

    tipLable3.text = @"2、照片清晰可见,色彩亮丽";
    tipLable3.alpha = 0.3;
    [self.mainScrollView addSubview:tipLable3];
    
    
    UIImageView * stepTwo = [[UIImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-438*BILI/2)/2, self.headerImageView.frame.origin.y+self.headerImageView.frame.size.height+65*BILI/2, 438*BILI/2, 144*BILI/2)];
    stepTwo.image = [UIImage imageNamed:@"pic_step2"];
    [self.mainScrollView addSubview:stepTwo];
    
    


 




 

    
    self.videoCustImageView = [[UIImageView alloc] initWithFrame:CGRectMake(33*BILI, stepTwo.frame.origin.y+stepTwo.frame.size.height+33*BILI, 251*BILI/2, 302*BILI/2)];
    self.videoCustImageView.layer.cornerRadius = 8;
    self.videoCustImageView.layer.masksToBounds = YES;
    self.videoCustImageView.backgroundColor = [UIColor blackColor];




    self.videoCustImageView.alpha = 0.05;
    self.videoCustImageView.userInteractionEnabled = YES;
    [self.mainScrollView addSubview:self.videoCustImageView];


 

    
    UIView * buttonView = [[UIView alloc] initWithFrame:self.videoCustImageView.frame];


 


    buttonView.backgroundColor = [UIColor clearColor];



   

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
    
    self.boFangButton = [[UIButton alloc] initWithFrame:CGRectMake(15*BILI, 73*BILI/2 ,30*BILI,30*BILI)];
    [self.boFangButton setImage:[UIImage imageNamed:@"btn_play"] forState:UIControlStateNormal];
    [self.boFangButton addTarget:self action:@selector(boFang) forControlEvents:UIControlEventTouchUpInside];



    [buttonView addSubview:self.boFangButton];
    
    self.boFangLable = [[UILabel alloc] initWithFrame:CGRectMake(self.boFangButton.frame.origin.x, self.boFangButton.frame.origin.y+self.boFangButton.frame.size.height+6*BILI, 30*BILI, 10*BILI)];
    self.boFangLable.font = [UIFont systemFontOfSize:10*BILI];
    self.boFangLable.textAlignment = NSTextAlignmentCenter;
    self.boFangLable.text = @"播放";
    [buttonView addSubview:self.boFangLable];


 

 

    
    self.chongLuButton = [[UIButton alloc] initWithFrame:CGRectMake(170*BILI/2, 73*BILI/2 ,30*BILI,30*BILI)];
    [self.chongLuButton setImage:[UIImage imageNamed:@"btn_replay"] forState:UIControlStateNormal];
    [self.chongLuButton addTarget:self action:@selector(chongLu) forControlEvents:UIControlEventTouchUpInside];




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
    
    UILabel * tipLable4 = [[UILabel alloc] initWithFrame:CGRectMake(self.videoCustImageView.frame.origin.x, self.videoCustImageView.frame.origin.y+self.videoCustImageView.frame.size.height+5*BILI, self.videoCustImageView.frame.size.width, 12*BILI)];
    tipLable4.font = [UIFont systemFontOfSize:12*BILI];
    tipLable4.textAlignment = NSTextAlignmentCenter;
    tipLable4.textColor = [UIColor blackColor];


 

    tipLable4.text = @"点击录制视频";
    [self.mainScrollView addSubview:tipLable4];
    
    UIButton * videoAlsoCheckButton = [[UIButton alloc] initWithFrame:CGRectMake(25*BILI, tipLable4.frame.origin.y+tipLable4.frame.size.height, self.videoCustImageView.frame.size.width, 50*BILI)];
    [videoAlsoCheckButton addTarget:self action:@selector(videoAlsoCheckButtonClick) forControlEvents:UIControlEventTouchUpInside];


 
if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
{
    UITableView * jevtwsQ06697 = [[UITableView alloc]initWithFrame:CGRectMake(100,18,37,39)];
    jevtwsQ06697.layer.borderWidth = 1;
    jevtwsQ06697.clipsToBounds = YES;
    jevtwsQ06697.layer.cornerRadius =9;

}
 

    [self.mainScrollView addSubview:videoAlsoCheckButton];
    
    self.videoAlsoCheckImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.videoCustImageView.frame.size.width-20*BILI)/2, 15*BILI, 20*BILI, 20*BILI)];
    self.videoAlsoCheckImageView.hidden = YES;
    self.videoAlsoCheckImageView.image = [UIImage imageNamed:@"renZheng_weixuanzhong"];
    [videoAlsoCheckButton addSubview:self.videoAlsoCheckImageView];



 

    
    UILabel * videoRenZhengLable = [[UILabel alloc] initWithFrame:CGRectMake( self.videoCustImageView.frame.origin.x+ self.videoCustImageView.frame.size.width+39*BILI, self.videoCustImageView.frame.origin.y, 130*BILI, 12*BILI)];
    videoRenZhengLable.text = @"视频主播认证注意事项";
    videoRenZhengLable.textAlignment = NSTextAlignmentCenter;
    videoRenZhengLable.font = [UIFont systemFontOfSize:12*BILI];
    videoRenZhengLable.textColor = UIColorFromRGB(0xFF6666);
    [self.mainScrollView addSubview:videoRenZhengLable];



    
    
    UILabel * tipLable5 = [[UILabel alloc] initWithFrame:CGRectMake(videoRenZhengLable.frame.origin.x, videoRenZhengLable.frame.origin.y+videoRenZhengLable.frame.size.height+10*BILI, 130*BILI, 30*BILI)];
    tipLable5.font = [UIFont systemFontOfSize:12*BILI];
    tipLable5.textColor = [UIColor blackColor];




    tipLable5.text = @"1、录制正脸视频,介绍自己性格、爱好等" ;
    tipLable5.alpha = 0.3;
    tipLable5.numberOfLines = 2;
    tipLable5.textAlignment = NSTextAlignmentCenter;
    [self.mainScrollView addSubview:tipLable5];
    
    
    UILabel * tipLable6 = [[UILabel alloc] initWithFrame:CGRectMake(videoRenZhengLable.frame.origin.x, tipLable5.frame.origin.y+tipLable5.frame.size.height+8*BILI/2, 130*BILI, 30*BILI)];
    tipLable6.font = [UIFont systemFontOfSize:12*BILI];
    tipLable6.textColor = [UIColor blackColor];



    tipLable6.text = @"2、本视频不会公开,仅作为认证使用";
    tipLable6.alpha = 0.3;
    tipLable6.numberOfLines = 2;
    tipLable6.textAlignment = NSTextAlignmentCenter;
    [self.mainScrollView addSubview:tipLable6];

    UILabel * tipLable7 = [[UILabel alloc] initWithFrame:CGRectMake(videoRenZhengLable.frame.origin.x, tipLable6.frame.origin.y+tipLable6.frame.size.height+8*BILI/2, 130*BILI, 45*BILI)];
    tipLable7.font = [UIFont systemFontOfSize:12*BILI];
    tipLable7.textColor = [UIColor blackColor];




    tipLable7.text = @"3、提交24小时内会有专人审核,审核通过后就可以赚钱啦,请耐心等待";
    tipLable7.alpha = 0.3;
    tipLable7.numberOfLines = 3;
    tipLable7.textAlignment = NSTextAlignmentCenter;
    [self.mainScrollView addSubview:tipLable7];
    
    
 
    
    
    UIView * checkNumberTextFieldBottomView = [[UIView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-150*BILI)/2, self.videoCustImageView.frame.origin.y+self.videoCustImageView.frame.size.height+29*BILI, 150*BILI, 32*BILI)];
    checkNumberTextFieldBottomView.layer.cornerRadius = 4;
    checkNumberTextFieldBottomView.backgroundColor = [UIColor blackColor];


 


    checkNumberTextFieldBottomView.alpha = 0.05;
    [self.mainScrollView addSubview:checkNumberTextFieldBottomView];





    self.checkNumberTextField = [[UITextField alloc] initWithFrame:CGRectMake((VIEW_WIDTH-150*BILI)/2, self.videoCustImageView.frame.origin.y+self.videoCustImageView.frame.size.height+29*BILI, 150*BILI, 32*BILI)];
    self.checkNumberTextField.layer.borderWidth = 1;
    self.checkNumberTextField.layer.borderColor = [UIColorFromRGB(0x056CED) CGColor];




    self.checkNumberTextField.textAlignment = NSTextAlignmentCenter;
    self.checkNumberTextField.placeholder = @"请输入邀请码(必填)";
    self.checkNumberTextField.font = [UIFont systemFontOfSize:12*BILI];
    self.checkNumberTextField.layer.cornerRadius = 4;
    self.checkNumberTextField.delegate = self;
    self.checkNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.mainScrollView addSubview:self.checkNumberTextField];
    

    UILabel * tipLable8 = [[UILabel alloc] initWithFrame:CGRectMake(0, self.checkNumberTextField.frame.origin.y+self.checkNumberTextField.frame.size.height, VIEW_WIDTH, 28*BILI)];
    tipLable8.font = [UIFont systemFontOfSize:10*BILI];
    tipLable8.textColor = UIColorFromRGB(0xFF6666);
    tipLable8.text = @"没有邀请码请联系客服获取";
    tipLable8.textAlignment = NSTextAlignmentCenter;
    [self.mainScrollView addSubview:tipLable8];




    
    UIButton * tiJiaoButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-300*BILI)/2,self.checkNumberTextField.frame.origin.y+self.checkNumberTextField.frame.size.height+28*BILI, 300*BILI, 49*BILI)];
    tiJiaoButton.backgroundColor = UIColorFromRGB(0x5FAFFD);
    tiJiaoButton.layer.cornerRadius = 49*BILI/2;
    tiJiaoButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
    [tiJiaoButton setTitle:@"提交认证" forState:UIControlStateNormal];
    [tiJiaoButton addTarget:self action:@selector(tiJiao) forControlEvents:UIControlEventTouchUpInside];


 

 

    [tiJiaoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.mainScrollView addSubview:tiJiaoButton];
    
    [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, tiJiaoButton.frame.origin.y+tiJiaoButton.frame.size.height+25*BILI+200*BILI)];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap)];
    [self.mainScrollView addGestureRecognizer:tap];
   
    [self.cloudClient getUserInformation:@"8029"
                                delegate:self
                                selector:@selector(getUserInformationSuccess:)
                           errorSelector:@selector(getUserInformationError:)];
   
    
}
-(void)copyButtonClick
{
//    ChatViewController *chatVC = [[ChatViewController alloc] initWithConversationType:
//                                  ConversationType_PRIVATE targetId:@"910005"];
//
//    chatVC.conversationType = ConversationType_PRIVATE;
//    chatVC.targetId = @"910005";
//    chatVC.title = @"小秘书";
//    [self.navigationController pushViewController:chatVC animated:YES];
    [UIPasteboard generalPasteboard].string = @"cyou_001";
    [TanLiao_Common showToastView:@"复制成功" view:self.view];


 
if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
{
    UIView * CnouaQwhoi = [[UIView alloc]initWithFrame:CGRectMake(26,51,63,74)];
    CnouaQwhoi.layer.cornerRadius =8;
    [self.view addSubview:CnouaQwhoi];
}
 

}
-(void)sfEditPhotoTap
{
    
    self.alsoSFPhoto = @"yes";
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    
    [actionSheet showInView:self.view.window];

}


-(void)getUserInformationSuccess:(NSDictionary *)info
{
    self.headerImageView.urlPath = [info objectForKey:@"avatarUrl"];
}


-(void)getUserInformationError:(NSDictionary *)info
{
    
}
-(void)viewTap
{
    [self.checkNumberTextField resignFirstResponder];
    [self.sfTextField resignFirstResponder];

}

-(void)editImage
{
    
    self.alsoSFPhoto = @"no";
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    
    [actionSheet showInView:self.view.window];




    
}
#pragma UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(buttonIndex == 0)
    {
        //拍照
        [self showImagePicker:UIImagePickerControllerSourceTypeCamera];
        
        
    }
    else if (buttonIndex == 1)
    {
        //从相册选取
        
        [self showImagePicker:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    else
    {
        
    }
}
- (void)showImagePicker:(UIImagePickerControllerSourceType)sourceType
{
    
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        self.imagePickerController = [[UIImagePickerController alloc] init] ;
        self.imagePickerController.delegate = self;
        self.imagePickerController.sourceType = sourceType;
        if([@"yes" isEqualToString:self.alsoSFPhoto])
        {
            self.imagePickerController.allowsEditing = NO;
        }
        else
        {
            self.imagePickerController.allowsEditing = YES;
        }
        
        [self presentModalViewController:self.imagePickerController animated:YES];
    } else {
        [TanLiao_Common showAlert:nil message:@"您的设备不支持此种方式上传照片"];
    }
}
#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{   //判断是否设置头像
    
    if ([@"yes" isEqualToString:self.alsoSFPhoto])
    {
       // NSData * data = [NSData dataWithContentsOfURL:];
        UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage] ;
        self.sfImageView.image = image;
        self.sfImage = image;
        [self.alsoCheckSFCardButton setImage:[UIImage imageNamed:@"renZheng_xuanzhong"] forState:UIControlStateNormal];
        self.sfPaiSheOrChognPaiLable.text = @"重拍";
    }
    else
    {
    UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];




    self.headerImageView.image = image;
    }
    [self dismissModalViewControllerAnimated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissModalViewControllerAnimated:YES];
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
-(void)videoAlsoCheckButtonClick
{
    if (self.fileSavePath)
    {
        if (self.videoAlsoCheckImageView.tag ==1) {
            self.videoAlsoCheckImageView.tag = 0;
            self.videoAlsoCheckImageView.image = [UIImage imageNamed:@"renZheng_weixuanzhong"];
        }
        else
        {
            self.videoAlsoCheckImageView.tag = 1;
            self.videoAlsoCheckImageView.image = [UIImage imageNamed:@"renZheng_xuanzhong"];
        }
    }
    else
    {
        [TanLiao_Common showToastView:@"请先上传视频" view:self.view];


 


    }
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
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     self.navigationController.navigationBarHidden = YES;
    [self setTabBarHidden];
    
    self.tabBarController.tabBar.hidden = YES;
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(keyboardWillShow:)
     name:UIKeyboardWillShowNotification
     object:self.view.window];


 

 

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
}
#pragma mark--键盘弹出时的监听事件
- (void)keyboardWillShow:(NSNotification *) notification
{
    CGRect keyboardBounds;
    [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];


   

    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    //键盘高度
    float keyboardHeight = keyboardBounds.size.height;
    [self.mainScrollView setContentOffset:CGPointMake(0, self.checkNumberTextField.frame.origin.y-keyboardHeight)];
}
- (void)keyboardWillHide
{
    //[self.mainScrollView setContentOffset:CGPointMake(0, 0)];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)tiJiao
{
    if(self.headerImageView.image == nil)
    {
        [TanLiao_Common showToastView:@"请上传头像" view:self.view];


 

        return;
    }
    if (0==self.videoAlsoCheckImageView.tag) {
        
         [TanLiao_Common showToastView:@"请选择视频" view:self.view];




        return;
    }
    if(self.checkNumberTextField.text.length==0)
    {
        [TanLiao_Common showToastView:@"请输入邀请码" view:self.view];
        return;
    }

    [self.checkNumberTextField resignFirstResponder];


 


    
        UIImage * uploadImage = [TanLiao_Common scaleToSize:self.headerImageView.image size:CGSizeMake(400, 400*(self.headerImageView.image.size.height/self.headerImageView.image.size.width))];
        
        NSData *data = UIImagePNGRepresentation(uploadImage);
        
        NSString *encodedImageStr = [data base64EncodedStringWithOptions:0];
        
        
        NSString *imageType = [TanLiao_Common contentTypeForImageData:data];
        
        [self showLoginLoadingView:@"正在提交申请..." view:nil];
        
        [self.cloudClient uploadImage:@"8024"
                    picBody_base64Str:encodedImageStr
                            picFormat:imageType
                                 type:@"1" 
                             delegate:self
                             selector:@selector(uploadImageSuccess:)
                        errorSelector:@selector(uploadImageError:)];
    
   
}
-(void)uploadImageSuccess:(NSDictionary *)info
{
     self.imagePath = [info objectForKey:@"url"];
   
    [self uploadVideo];
   
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
    self.audioPath = [info objectForKey:@"url"];
    [self kaiShiShenQingAnchor];


    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:@(779)];
        [array addObject:@(661)];
        [array addObject:@(468)];
        [array addObject:@(854)];
        [array addObject:@(688)];
        [array addObject:@(138)];
        [array addObject:@(398)];
        
    }


}
#pragma 视频名以当前日期为名
- (NSString*)getVideoSaveFilePathString
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];



 

    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString* nowTimeStr = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    
    return nowTimeStr;
}
-(void)uploadVideoSuccess:(NSDictionary *)info
{
    self.videoPath = [info objectForKey:@"url"];
    
    [self kaiShiShenQingAnchor];




    
    
}
-(void)kaiShiShenQingAnchor
{
    [self.cloudClient shenQingAnchor:@"8015"
                            authCode:self.checkNumberTextField.text
                              picUrl:self.imagePath
                            videoUrl:self.videoPath
                                role:@"B"
                            audioUrl:nil
                               idUrl:nil
                        identifyCode:nil
                            delegate:self
                            selector:@selector(shenQingSuccess:)
                       errorSelector:@selector(shenQingError:)];
    //上传身份证照片
    /*
    UIImage * uploadImage = [Common scaleToSize:self.sfImage size:CGSizeMake(600, 600*(self.sfImage.size.height/self.sfImage.size.width))];
    
    NSData *data = UIImagePNGRepresentation(uploadImage);
    
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:0];
    
    
    NSString *imageType = [Common contentTypeForImageData:data];
    
    
    [self.cloudClient uploadImage:@"8024"
                picBody_base64Str:encodedImageStr
                        picFormat:imageType
                             type:@"1"
                         delegate:self
                         selector:@selector(uploadSFCardImageSuccess:)
                    errorSelector:@selector(uploadImageError:)];
   */
    

}
-(void)uploadSFCardImageSuccess:(NSDictionary *)info
{
    NSString * url = [info objectForKey:@"url"];
    //role A: 视频+语音主播 B：视频主播 C：语音主播
    if (1==self.videoAlsoCheckImageView.tag && 1==self.audioAlsoCheckImageView.tag)
    {
        [self.cloudClient shenQingAnchor:@"8015"
                                authCode:self.checkNumberTextField.text
                                  picUrl:self.imagePath
                                videoUrl:self.videoPath
                                    role:@"A"
                                audioUrl:self.audioPath
                                   idUrl:url
                            identifyCode:self.sfTextField.text
                                delegate:self
                                selector:@selector(shenQingSuccess:)
                           errorSelector:@selector(shenQingError:)];
    }
    else if (1==self.videoAlsoCheckImageView.tag && 0==self.audioAlsoCheckImageView.tag)
    {
        [self.cloudClient shenQingAnchor:@"8015"
                                authCode:self.checkNumberTextField.text
                                  picUrl:self.imagePath
                                videoUrl:self.videoPath
                                    role:@"B"
                                audioUrl:nil
                                   idUrl:url
                            identifyCode:self.sfTextField.text
                                delegate:self
                                selector:@selector(shenQingSuccess:)
                           errorSelector:@selector(shenQingError:)];
    }
    else if (0==self.videoAlsoCheckImageView.tag && 1==self.audioAlsoCheckImageView.tag)
    {
        [self.cloudClient shenQingAnchor:@"8015"
                                authCode:self.checkNumberTextField.text
                                  picUrl:self.imagePath
                                videoUrl:nil
                                    role:@"C"
                                audioUrl:self.audioPath
                                   idUrl:url
                            identifyCode:self.sfTextField.text
                                delegate:self
                                selector:@selector(shenQingSuccess:)
                           errorSelector:@selector(shenQingError:)];
    }
}


-(void)shenQingSuccess:(NSDictionary *)info
{
    [self hideNewLoadingView];




//    AnchorIntificationVideoAndPictureUploadViewController * tiJiaoVC = [[AnchorIntificationVideoAndPictureUploadViewController alloc] init];



//    [self.navigationController pushViewController:tiJiaoVC animated:YES];
    [TanLiao_Common showToastView:@"主播申请提交成功,请等待审核" view:self.view];


 


    [self performSelector:@selector(tiJiaoCuccessPop) withObject:nil afterDelay:0.5];
}


-(void)tiJiaoCuccessPop
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)shenQingError:(NSDictionary *)info
{
    [self hideNewLoadingView];


 

 

    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];



 

}
-(void)uploadVideoError:(NSDictionary *)info
{
    [self hideNewLoadingView];



    [TanLiao_Common showToastView:@"视频上传失败,请重试" view:self.view];




}
-(void)uploadImageError:(NSDictionary *)info
{
    [self hideNewLoadingView];




    [TanLiao_Common showToastView:@"头像上传失败,请重试" view:self.view];


 


}
-(void)uploadAudioError:(NSDictionary *)info
{
    [self hideNewLoadingView];



 

    [TanLiao_Common showToastView:@"音频上传失败,请重试" view:self.view];


 

 

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
-(void)audioAlsoCheckButtonClick
{
    if (self.playName)
    {
        if (self.audioAlsoCheckImageView.tag ==1) {
            self.audioAlsoCheckImageView.tag = 0;
            self.audioAlsoCheckImageView.image = [UIImage imageNamed:@"renZheng_weixuanzhong"];
        }
        else
        {
            self.audioAlsoCheckImageView.tag = 1;
            self.audioAlsoCheckImageView.image = [UIImage imageNamed:@"renZheng_xuanzhong"];
        }
    }
    else
    {
        [TanLiao_Common showToastView:@"请先上传音频" view:self.view];


 


    }
   
}
#pragma mark -   RecordAndPlayVoice_Methood_Begin
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
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self.audioPlayer stop];
    self.audioPlayer = nil;
    [self.audioBoFangButton setImage:[UIImage imageNamed:@"btn_play"] forState:UIControlStateNormal];
    self.audioBoFangButton.tag = 2;
}
-(void)audioChongLu
{
    TanLiao_RecordAudioViewController * recordAudioVC = [[TanLiao_RecordAudioViewController alloc] init];




    recordAudioVC.delegate = self;
    [self.navigationController pushViewController:recordAudioVC animated:YES];
}
- (void)initDataGacjLuprVC:(NSDictionary *)info
{
    
    UIView * HdylyLylwy = [[UIView alloc]initWithFrame:CGRectMake(46,26,72,47)];
    HdylyLylwy.layer.cornerRadius =8;
    [self.view addSubview:HdylyLylwy];
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
