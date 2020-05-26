//
//  AddInformationViewController.m
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/11.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiaoLiao_AddInformationViewController.h"
#import "TanLiaoLiao_FinishRegisterViewController.h"
#import <AdSupport/AdSupport.h>


@interface TanLiaoLiao_AddInformationViewController ()

@end

@implementation TanLiaoLiao_AddInformationViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];



    [self.cloudClient setToastView:self.view];

    
    self.navView.hidden = YES;
    self.loadingViewAlsoFullScreen = @"yes";
    
    self.leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0,  20, 60, 40)];
    [self.leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.leftButton addTarget:self action:@selector(leftClick) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:self.leftButton];
    
    UIImageView * backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(12*BILI, (40-18)/2, 18*BILI, 18*BILI)];
    backImageView.image = [UIImage imageNamed:@"btn_back_n"];
    [self.leftButton addSubview:backImageView];


    
    if ([@"registerVC" isEqualToString:self.formWhere]) {
        self.leftButton.hidden = YES;
    }
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap)];
    [self.view addGestureRecognizer:tap];
    
    self.view.backgroundColor = [UIColor whiteColor];

    self.loginImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-75*BILI)/2, 90*BILI, 75*BILI, 75*BILI)];
    self.loginImageView.image = [UIImage imageNamed:@"pic_photo"];
    self.loginImageView.userInteractionEnabled = YES;
    self.loginImageView.imgType = IMAGEVIEW_TYPE_CENTER;
    [self.view addSubview:self.loginImageView];


    NSString * avatarUrl = [self.userInfoDic objectForKey:@"avatarUrl"] ;
    if ([avatarUrl isKindOfClass:[NSString class]]&&avatarUrl.length>0) {
        
        self.loginImageView.urlPath = avatarUrl;
        
        self.avatarUrl = avatarUrl;
    }
    
    UITapGestureRecognizer * imageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap)];
    [self.loginImageView addGestureRecognizer:imageTap];
    
    
    UIView * nameBottomView = [[UIView alloc] initWithFrame:CGRectMake(125*BILI/2, self.loginImageView.frame.origin.y+self.loginImageView.frame.size.height+65*BILI, 250*BILI, 40*BILI)];
    nameBottomView.layer.borderColor = [UIColorFromRGB(0x979797) CGColor];
    nameBottomView.layer.borderWidth = 1;
    nameBottomView.layer.cornerRadius = 20*BILI;
    [self.view addSubview:nameBottomView];

    UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(27*BILI/2, 0, 45*BILI, 40*BILI)];
    nameLable.font = [UIFont systemFontOfSize:15*BILI];
    nameLable.textColor = [UIColor blackColor];



    nameLable.alpha = 0.8;
    nameLable.text = @"昵称:";
    [nameBottomView addSubview:nameLable];




    
    self.nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(nameLable.frame.origin.x+nameLable.frame.size.width, 0, nameBottomView.frame.size.width-(nameLable.frame.origin.x+nameLable.frame.size.width), 40*BILI)];
    self.nameTextField.font = [UIFont systemFontOfSize:15*BILI];
    self.nameTextField.placeholder = @"请输入昵称(1-8个字符)";
    self.nameTextField.delegate = self;
    [nameBottomView addSubview:self.nameTextField];
    
    if (![TanLiao_Common isEmpty:[self.userInfoDic objectForKey:@"nick"]]) {
        
        self.nameTextField.text = [self.userInfoDic objectForKey:@"nick"];
    }
   
    
    UIView * ageBottomView = [[UIView alloc] initWithFrame:CGRectMake(125*BILI/2, nameBottomView.frame.origin.y+nameBottomView.frame.size.height+15*BILI, 250*BILI, 40*BILI)];
    ageBottomView.layer.borderColor = [UIColorFromRGB(0x979797) CGColor];


    ageBottomView.layer.borderWidth = 1;
    ageBottomView.layer.cornerRadius = 20*BILI;
    [self.view addSubview:ageBottomView];

    
    UILabel * ageLable = [[UILabel alloc] initWithFrame:CGRectMake(27*BILI/2, 0, 45*BILI, 40*BILI)];
    ageLable.font = [UIFont systemFontOfSize:15*BILI];
    ageLable.textColor = [UIColor blackColor];



    ageLable.alpha = 0.8;
    ageLable.text = @"生日:";
    [ageBottomView addSubview:ageLable];

    
    self.ageTextField = [[UITextField alloc] initWithFrame:CGRectMake(nameLable.frame.origin.x+nameLable.frame.size.width, 0, nameBottomView.frame.size.width-(nameLable.frame.origin.x+nameLable.frame.size.width), 40*BILI)];
    self.ageTextField.font = [UIFont systemFontOfSize:15*BILI];
    self.ageTextField.placeholder = @"请选择";
    [ageBottomView addSubview:self.ageTextField];
    
//    NSString *str = @"1990-01-01";
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    NSDate *date = [dateFormatter dateFromString:str];
//
//    self.birthday = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    
    UIButton * ageButton = [[UIButton alloc] initWithFrame:self.ageTextField.frame];
    [ageBottomView addSubview:ageButton];
    ageButton.backgroundColor = [UIColor clearColor];
    [ageButton addTarget:self action:@selector(ageButtonClick) forControlEvents:UIControlEventTouchUpInside];


    
    UIView * sexBottomView = [[UIView alloc] initWithFrame:CGRectMake(125*BILI/2, ageBottomView.frame.origin.y+ageBottomView.frame.size.height+15*BILI, 250*BILI, 40*BILI)];
    sexBottomView.layer.borderColor = [UIColorFromRGB(0x979797) CGColor];
    sexBottomView.layer.borderWidth = 1;
    sexBottomView.layer.cornerRadius = 20*BILI;
    [self.view addSubview:sexBottomView];


    
    self.manButton = [[UIButton alloc] initWithFrame:CGRectMake(4*BILI, 4*BILI, 115*BILI, 32*BILI)];
    [self.manButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.manButton setTitle:@"男" forState:UIControlStateNormal];
    self.manButton.titleLabel.font = [UIFont systemFontOfSize:15*BILI];
    self.manButton.layer.cornerRadius = 16*BILI;
    self.manButton.backgroundColor = UIColorFromRGB(0xeeeeee);
    [self.manButton addTarget:self action:@selector(manButtonClick) forControlEvents:UIControlEventTouchUpInside];



    [sexBottomView addSubview:self.manButton];
    
    UIImageView * manImageView = [[UIImageView alloc] initWithFrame:CGRectMake(7*BILI, (32-18)*BILI/2, 18*BILI, 18*BILI)];
    manImageView.image = [UIImage imageNamed:@"icon_zc_man"];
    [self.manButton addSubview:manImageView];




    
    self.womanButton = [[UIButton alloc] initWithFrame:CGRectMake(self.manButton.frame.origin.x+self.manButton.frame.size.width+12*BILI, 4*BILI, 115*BILI, 32*BILI)];
    [self.womanButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.womanButton setTitle:@"女" forState:UIControlStateNormal];
    self.womanButton.titleLabel.font = [UIFont systemFontOfSize:15*BILI];
    self.womanButton.layer.cornerRadius = 16*BILI;
    self.womanButton.backgroundColor = UIColorFromRGB(0xeeeeee);
    [self.womanButton addTarget:self action:@selector(womanButtonClick) forControlEvents:UIControlEventTouchUpInside];

    [sexBottomView addSubview:self.womanButton];
    
    UIImageView * womanImageView = [[UIImageView alloc] initWithFrame:CGRectMake(90*BILI, (32-18)*BILI/2, 18*BILI, 18*BILI)];
    womanImageView.image = [UIImage imageNamed:@"icon_zc_woman"];
    [self.womanButton addSubview:womanImageView];



    
    UIButton  * tiJiaoButton = [[UIButton alloc] initWithFrame:CGRectMake(sexBottomView.frame.origin.x, sexBottomView.frame.origin.y+sexBottomView.frame.size.height+35*BILI, sexBottomView.frame.size.width, 40*BILI)];
    tiJiaoButton.backgroundColor = UIColorFromRGB(0xFF5C93);
    tiJiaoButton.layer.cornerRadius = 20*BILI;
    [tiJiaoButton setTitle:@"完善资料" forState:UIControlStateNormal];
    [tiJiaoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    tiJiaoButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
     [tiJiaoButton addTarget:self action:@selector(tiJiaoButtonClick) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:tiJiaoButton];
    
    [self initPickView];


}
-(void)leftClick
{
    [self.navigationController popViewControllerAnimated:YES];
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


-(void)imageTap
{
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
        self.imagePickerController.allowsEditing = YES;
        
        [self presentModalViewController:self.imagePickerController animated:YES];
    } else {
        [TanLiao_Common showAlert:nil message:@"您的设备不支持此种方式上传照片"];
    }
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{   //判断是否设置头像
    UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];


    [self dismissModalViewControllerAnimated:YES];
    
    self.headerImage = image;
    
    
    self.loginImageView.image = image;
    
    self.avatarUrl = nil;
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissModalViewControllerAnimated:YES];
}



-(void)initPickView
{
    
    self.pickRootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT*5)];
    self.pickRootView.backgroundColor = [UIColor blackColor];
    self.pickRootView.alpha = 0.5;
    [self.view addSubview:self.pickRootView];

    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickRootViewTap)];
    [self.pickRootView addGestureRecognizer:tapGesture];

    
    self.datePickView = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT-162, VIEW_WIDTH, 162)];
    self.datePickView.datePickerMode=UIDatePickerModeDate;
    [self.view addSubview:self.datePickView];

    self.datePickView.maximumDate = [NSDate date];

   // [self.datePickView setDate:self.selectDate animated:YES];
    self.datePickView.backgroundColor = [UIColor whiteColor];


    [self.datePickView addTarget:self action:@selector(oneDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged]; // 添加监听器
    self.datePickView.hidden = YES;
    self.pickRootView.hidden = YES;

}
#pragma mark - 实现oneDatePicker的监听方法
-(void)oneDatePickerValueChanged:(UIDatePicker *) sender
{
    NSDate *select = [sender date]; // 获取被选中的时间

    NSDateFormatter *selectDateFormatter = [[NSDateFormatter alloc] init];
    selectDateFormatter.dateFormat = @"yyyy/MM/dd";
    NSString * selectData = [selectDateFormatter stringFromDate:select];


    self.ageTextField.text = selectData;
    self.ageTextField.textColor = [UIColor blackColor];



    self.birthday = [NSString stringWithFormat:@"%ld", (long)[select timeIntervalSince1970]];

    
}
-(void)ageButtonClick
{
    self.datePickView.hidden = NO;
    self.pickRootView.hidden = NO;
    [self.nameTextField resignFirstResponder];
    [self.ageTextField resignFirstResponder];
}
-(void)pickRootViewTap
{
    self.datePickView.hidden = YES;
    self.pickRootView.hidden = YES;
}
-(void)manButtonClick
{
    self.sex = @"1";
    [self.manButton setBackgroundColor:UIColorFromRGB(0x0CCEF9)] ;
    [self.womanButton setBackgroundColor:UIColorFromRGB(0xeeeeee)];
    
}
-(void)womanButtonClick
{
    self.sex = @"0";
    [self.manButton setBackgroundColor:UIColorFromRGB(0xeeeeee)] ;
    [self.womanButton setBackgroundColor:UIColorFromRGB(0xFF6666)];
}



-(void)tiJiaoButtonClick
{
    if([TanLiao_Common isEmpty:self.nameTextField.text])
    {
        self.nickName =   [self.userInfoDic objectForKey:@"nick"] ;
    }
    else
    {
        self.nickName = self.nameTextField.text;
    }
    if (!self.birthday) {
        [TanLiao_Common showToastView:@"请选择年龄" view:self.view];


        return;
    }
    if(![@"1" isEqualToString:self.sex]&&![@"0" isEqualToString:self.sex])
    {
        [TanLiao_Common showToastView:@"请选择性别" view:self.view];

        return;
    }
    if(self.nameTextField.text.length>10)
    {
        [TanLiao_Common showToastView:@"昵称不能多余10个字符" view:self.view];


        return;
    }
    
    if (self.headerImage) {
        
        UIImage * uploadImage = [TanLiao_Common scaleToSize:self.headerImage size:CGSizeMake(400, 400*(self.headerImage.size.height/self.headerImage.size.width))];
        
        NSData *data = UIImagePNGRepresentation(uploadImage);
        
        NSString *encodedImageStr = [data base64EncodedStringWithOptions:0];
        
        
        NSString *imageType = [TanLiao_Common contentTypeForImageData:data];
        
        [self showNewLoadingView:@"正在完善信息..." view:nil];
        [self.cloudClient uploadImage:@"8024"
                    picBody_base64Str:encodedImageStr
                            picFormat:imageType
                                 type:@"1" 
                             delegate:self
                             selector:@selector(uploadSuccess:)
                        errorSelector:@selector(uploadError:)];
        
    }
    else
    {
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];

        NSString * channel = [defaults objectForKey:CHANNEL];
        
        NSString * deviceId;
        if ( [[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
            
            deviceId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
            
        }
        else
        {
            deviceId = @"";
        }
        
        
        [self showNewLoadingView:@"正在完善信息..." view:nil];
        [self.cloudClient addUserMessage:@"8103"
                                birthday:self.birthday
                                     sex:self.sex
                               avatarUrl:[self.userInfoDic objectForKey:@"avatarUrl"]
                                    nick:self.nickName
                                deviceId:deviceId
                                sourceNo:channel
                              deviceType:@"2"
                                 appName:APPNAME
                                delegate:self
                                selector:@selector(addMessageSuccess:)
                           errorSelector:@selector(addMessageError:)];
    }
        
        
   
    
    
}
-(void)uploadSuccess:(NSDictionary *)info
{
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * channel = [defaults objectForKey:CHANNEL];
    self.avatarUrl = [info objectForKey:@"url"];
    
    NSString * deviceId;
    if ( [[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
        
        deviceId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        
    }
    else
    {
        deviceId = @"";
    }
    
    [self.cloudClient addUserMessage:@"8103"
                            birthday:self.birthday
                                 sex:self.sex
                           avatarUrl:self.avatarUrl
                                nick:self.nickName
                            deviceId:deviceId
                            sourceNo:channel
                          deviceType:@"2"
                             appName:APPNAME
                            delegate:self
                            selector:@selector(addMessageSuccess:)
                       errorSelector:@selector(addMessageError:)];
}
-(void)uploadError:(NSDictionary *)info
{
    [self hideNewLoadingView];

}
-(void)addMessageSuccess:(NSDictionary *)info
{
    if ([@"YES" isEqualToString:self.alsoAccountRegist]) {
        
        NSDictionary *  ipInfo = [TanLiao_Common getWANIP];
        if([ipInfo isKindOfClass:[NSDictionary class]])
        {
            [self.cloudClient telPhoneLogin:@"8098"
                                  accountId:self.phoneNumber
                                   password:self.passWorld
                                   cityName:self.cityName
                                         ip:[ipInfo objectForKey:@"ip"]
                                    country:[ipInfo objectForKey:@"country"]
                                   delegate:self
                                   selector:@selector(loginSuccess:)
                              errorSelector:@selector(loginError:)];
        }
        else
        {
            [self.cloudClient telPhoneLogin:@"8098"
                                  accountId:self.phoneNumber
                                   password:self.passWorld
                                   cityName:self.cityName
                                         ip:@""
                                    country:@""
                                   delegate:self
                                   selector:@selector(loginSuccess:)
                              errorSelector:@selector(loginError:)];
            
        }
    }
    else
    {
        [self hideNewLoadingView];
        
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        NSMutableDictionary * dicInfo = [[NSMutableDictionary alloc] initWithDictionary:[defaults objectForKey:USERINFO]];
        NSLog(@"%@",dicInfo);
        [dicInfo setObject:[TanLiao_Common getobjectForKey:[info objectForKey:@"sex"]] forKey:@"sex"];
         [dicInfo setObject:[TanLiao_Common getobjectForKey:[info objectForKey:@"nick"]] forKey:@"nick"];
         [dicInfo setObject:[TanLiao_Common getobjectForKey:[info objectForKey:@"avatarUrl"]] forKey:@"avatarUrl"];
        [defaults setObject:dicInfo forKey:USERINFO];
        [defaults synchronize];
        
        NSLog(@"%@",dicInfo);
        NSUserDefaults* loginStatusDefaults = [NSUserDefaults standardUserDefaults];
        [loginStatusDefaults setObject:@"1" forKey:LoginStatus];
        [loginStatusDefaults synchronize];
        
        NSString *loginAccount = [dicInfo objectForKey:@"userId"];
        NSString *loginToken   = [dicInfo objectForKey:@"face_token"];
        [[[NIMSDK sharedSDK] loginManager] login:loginAccount
                                           token:loginToken
                                      completion:^(NSError *error) {
                                          
                                          if (error == nil)
                                          {
                                              NSString *userID = [NIMSDK sharedSDK].loginManager.currentAccount;
                                              NSString *toast = [NSString stringWithFormat:@"网易云 登录成功 code: %zd",error.code];
                                              NSLog(@"%@||%@",toast,userID);
                                          }
                                          else
                                          {
                                              NSString *toast = [NSString stringWithFormat:@"网易云 登录失败 code: %zd",error.code];
                                              
                                              
                                              NSLog(@"%@",toast);
                                          }
                                      }];
        [[RongCloudManager getInstance] connectRongCloud];
        [TanLiao_Common showToastView:@"登陆成功" view:self.view];
        
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:ZhuBoHuJiaoNotification object:nil];
        AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate resetLoginTabBar];

    }
    
}

-(void)loginSuccess:(NSDictionary *)info
{
    NSUserDefaults* isShowAtHomeDefaults = [NSUserDefaults standardUserDefaults];
    [isShowAtHomeDefaults setObject:[info objectForKey:@"isShowAtHome"] forKey:@"isShowAtHomeDefaultsKey"];
    [isShowAtHomeDefaults synchronize];

    NSUserDefaults* accountStatusDefaults = [NSUserDefaults standardUserDefaults];
    [accountStatusDefaults setObject:@"new" forKey:@"accountStatusDefaultsKey"];
    [accountStatusDefaults synchronize];
    [self hideNewLoadingView];
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:info forKey:USERINFO];
    [defaults synchronize];


    
    NSUserDefaults* loginStatusDefaults = [NSUserDefaults standardUserDefaults];
    [loginStatusDefaults setObject:@"1" forKey:LoginStatus];
    [loginStatusDefaults synchronize];

    
    NSUserDefaults* defaults1 = [NSUserDefaults standardUserDefaults];

    NSDictionary * acocuntInfo = [[NSDictionary alloc] initWithObjectsAndKeys:self.phoneNumber,@"userId",self.passWorld,@"password" ,nil];
    [defaults1 setObject:acocuntInfo forKey:UserAccountAndPassWorld];
    [defaults1 synchronize];

    
    NSString *loginAccount = [info objectForKey:@"userId"];
    NSString *loginToken   = [info objectForKey:@"face_token"];
    [[[NIMSDK sharedSDK] loginManager] login:loginAccount
                                       token:loginToken
                                  completion:^(NSError *error) {
                                      
                                      if (error == nil)
                                      {
                                          NSString *userID = [NIMSDK sharedSDK].loginManager.currentAccount;
                                          NSString *toast = [NSString stringWithFormat:@"网易云 登录成功 code: %zd",error.code];
                                          NSLog(@"%@||%@",toast,userID);
                                      }
                                      else
                                      {
                                          NSString *toast = [NSString stringWithFormat:@"网易云 登录失败 code: %zd",error.code];


                                          NSLog(@"%@",toast);
                                      }
                                  }];
    [[RongCloudManager getInstance] connectRongCloud];
    [TanLiao_Common showToastView:@"登陆成功" view:self.view];


     [[NSNotificationCenter defaultCenter] removeObserver:self name:ZhuBoHuJiaoNotification object:nil];
    AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate resetLoginTabBar];

}
-(void)loginError:(NSDictionary *)info
{
    [self hideNewLoadingView];


}
-(void)addMessageError:(NSDictionary *)info
{
    [self hideNewLoadingView];

    
}

-(void)viewTap
{
    [self.nameTextField resignFirstResponder];


    [self.ageTextField resignFirstResponder];


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
