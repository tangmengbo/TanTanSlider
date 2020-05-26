                                                                                                       //
//  EditMessageViewController.m
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_EditMessageViewController.h"

@interface TanLiao_EditMessageViewController ()

@end

@implementation TanLiao_EditMessageViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLale.text = @"个人信息";
    self.titleLale.alpha = 0.9;
    
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];


 


    [self.cloudClient setToastView:self.view];



    
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT)];
    bottomView.backgroundColor = [UIColor blackColor];



    bottomView.alpha = 0.05;
    [self.view addSubview:bottomView];



    
    UIView * topView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height+15*BILI, VIEW_WIDTH, 80*BILI)];
    topView.backgroundColor = [UIColor whiteColor];



   

    [self.view addSubview:topView];



    
    UITapGestureRecognizer * topTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(eaditMessage)];
    [topView addGestureRecognizer:topTap];

    
    
    self.headerImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(12*BILI, 10*BILI, 60*BILI, 60*BILI)];
    self.headerImageView.imgType = IMAGEVIEW_TYPE_CENTER;
    self.headerImageView.clipsToBounds = YES;
    [topView addSubview:self.headerImageView];


 

 

    
    self.tipImageView = [[UIImageView alloc] initWithFrame:self.headerImageView.frame];

    self.tipImageView.image = [UIImage imageNamed:@"shenhezhong_icon"];
    [topView addSubview:self.tipImageView];





    if ([@"" isEqualToString:[self.userInformation objectForKey:@"pendingAvatarUrl"]]) {
        
        self.tipImageView.hidden = YES;
        self.headerImageView.urlPath = [self.userInformation objectForKey:@"avatarUrl"];

    }
    else
    {
        self.tipImageView.hidden = NO;
        self.headerImageView.urlPath = [self.userInformation objectForKey:@"pendingAvatarUrl"];

    }
    
    
    self.nameLable1 = [[UILabel alloc] initWithFrame:CGRectMake(self.headerImageView.frame.origin.x+self.headerImageView.frame.size.width+7*BILI, 22*BILI, VIEW_WIDTH-(self.headerImageView.frame.origin.x+self.headerImageView.frame.size.width+7*BILI+35*BILI), 15*BILI)];
    self.nameLable1.font = [UIFont fontWithName:@"Helvetica-Bold" size:15*BILI];
    self.nameLable1.textColor = [UIColor blackColor];




    self.nameLable1.alpha = 0.9;
    self.nameLable1.text = [self.userInformation objectForKey:@"nick"];
    [topView addSubview:self.nameLable1];
    
    self.acountLable = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLable1.frame.origin.x, self.nameLable1.frame.origin.y+self.nameLable1.frame.size.height+9*BILI, self.nameLable1.frame.size.width, 12*BILI)];
    self.acountLable.font = [UIFont systemFontOfSize:12*BILI];
    self.acountLable.textColor = [UIColor blackColor];



   

    self.acountLable.alpha = 0.5;
    self.acountLable.text = [NSString stringWithFormat:@"ID: %@",[self.userInformation objectForKey:@"userId"]] ;
    [topView addSubview:self.acountLable];




    
    UIImageView * topLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(12+18)*BILI, (80*BILI-18*BILI)/2, 18*BILI, 18*BILI)];
    topLeftImageView.image = [UIImage imageNamed:@"btn_back_nr_n"];
    [topView addSubview:topLeftImageView];


    
    
    
    UIButton * nameButton = [[UIButton alloc] initWithFrame:CGRectMake(0, topView.frame.origin.y+topView.frame.size.height+15*BILI, VIEW_WIDTH, 45*BILI)];
    nameButton.backgroundColor = [UIColor whiteColor];

    [nameButton addTarget:self action:@selector(nameButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nameButton];
    
    
    UILabel * settingLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI, (45*BILI-15*BILI)/2, 15*BILI*4.5, 15*BILI)];
    settingLable.font = [UIFont systemFontOfSize:15*BILI];
    settingLable.textColor = [UIColor blackColor];
    settingLable.alpha = 0.9;
    settingLable.text = @"昵称";
    [nameButton addSubview:settingLable];



    
    UIImageView * nameLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(12+18)*BILI, (45*BILI-18*BILI)/2, 18*BILI, 18*BILI)];
    nameLeftImageView.image = [UIImage imageNamed:@"btn_back_nr_n"];
    [nameButton addSubview:nameLeftImageView];


 
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        
        UITableView * hssthO4599 = [[UITableView alloc]initWithFrame:CGRectMake(95,23,30,11)];
        hssthO4599.layer.borderWidth = 1;
        hssthO4599.clipsToBounds = YES;
        hssthO4599.layer.cornerRadius =9;
    }
    
    
    self.nameLable2 = [[UILabel alloc] initWithFrame:CGRectMake(settingLable.frame.origin.x+settingLable.frame.size.width+20*BILI, (45*BILI-14*BILI)/2, VIEW_WIDTH-(settingLable.frame.origin.x+settingLable.frame.size.width+20*BILI+nameLeftImageView.frame.size.width+12*BILI+5*BILI), 14*BILI)];
    self.nameLable2.text = [self.userInformation objectForKey:@"nick"];
    self.nameLable2.textAlignment = NSTextAlignmentRight;
    self.nameLable2.font = [UIFont systemFontOfSize:14*BILI];
    self.nameLable2.textColor = [UIColor blackColor];

   

    self.nameLable2.alpha = 1;
    [nameButton addSubview:self.nameLable2];
    
    
    UIButton * sexButton = [[UIButton alloc] initWithFrame:CGRectMake(0, nameButton.frame.origin.y+nameButton.frame.size.height+1, VIEW_WIDTH, 45*BILI)];
    sexButton.backgroundColor = [UIColor whiteColor];
 

   // [sexButton addTarget:self action:@selector(sexButtonClick) forControlEvents:UIControlEventTouchUpInside];


 


    [self.view addSubview:sexButton];
    
    
    UILabel * sexLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI, (45*BILI-15*BILI)/2, 15*BILI*4.5, 15*BILI)];
    sexLable.font = [UIFont systemFontOfSize:15*BILI];
    sexLable.textColor = [UIColor blackColor];




    sexLable.alpha = 0.9;
    sexLable.text = @"性别";
    [sexButton addSubview:sexLable];


    
    UIImageView * sexLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(12+18)*BILI, (45*BILI-18*BILI)/2, 18*BILI, 18*BILI)];
    sexLeftImageView.image = [UIImage imageNamed:@"btn_back_nr_n"];
    [sexButton addSubview:sexLeftImageView];



    
    
    self.sexLable = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(12+18)*BILI-11*BILI-100, (45*BILI-14*BILI)/2, 100, 14*BILI)];
    if ([@"1" isEqualToString:[self.userInformation objectForKey:@"sex"]]) {
         self.sexLable.text = @"男";
    }
    else
    {
        self.sexLable.text = @"女";
    }
   
    self.sexLable.textAlignment = NSTextAlignmentRight;
    self.sexLable.font = [UIFont systemFontOfSize:14*BILI];
    self.sexLable.textColor = [UIColor blackColor];


 

    self.sexLable.alpha = 0.3;
    [sexButton addSubview:self.sexLable];



    
    
    
    
    UIButton * ageButton = [[UIButton alloc] initWithFrame:CGRectMake(0, sexButton.frame.origin.y+sexButton.frame.size.height+1, VIEW_WIDTH, 45*BILI)];
    ageButton.backgroundColor = [UIColor whiteColor];




    [ageButton addTarget:self action:@selector(ageButtonClick) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:ageButton];
    
    
    UILabel * ageLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI, (45*BILI-15*BILI)/2, 15*BILI*4.5, 15*BILI)];
    ageLable.font = [UIFont systemFontOfSize:15*BILI];
    ageLable.textColor = [UIColor blackColor];
    ageLable.alpha = 0.9;
    ageLable.text = @"年龄";
    [ageButton addSubview:ageLable];



    
    UIImageView * ageLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(12+18)*BILI, (45*BILI-18*BILI)/2, 18*BILI, 18*BILI)];
    ageLeftImageView.image = [UIImage imageNamed:@"btn_back_nr_n"];
    [ageButton addSubview:ageLeftImageView];

    self.ageLable = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(12+18)*BILI-11*BILI-100, (45*BILI-14*BILI)/2, 100, 14*BILI)];
    self.ageLable.text = [self.userInformation objectForKey:@"age"];
    self.ageLable.textAlignment = NSTextAlignmentRight;
    self.ageLable.font = [UIFont systemFontOfSize:14*BILI];
    self.ageLable.textColor = [UIColor blackColor];
    self.ageLable.alpha = 0.9;
    [ageButton addSubview:self.ageLable];


 
    
    
    
    UIButton * signButton = [[UIButton alloc] initWithFrame:CGRectMake(0, ageButton.frame.origin.y+ageButton.frame.size.height+1, VIEW_WIDTH, 45*BILI)];
    signButton.backgroundColor = [UIColor whiteColor];
    [signButton addTarget:self action:@selector(signButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:signButton];
    
    
    UILabel * signLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI, (45*BILI-15*BILI)/2, 15*BILI*4.5, 15*BILI)];
    signLable.font = [UIFont systemFontOfSize:15*BILI];
    signLable.textColor = [UIColor blackColor];
    signLable.alpha = 0.9;
    signLable.text = @"签名";
    [signButton addSubview:signLable];



    
    UIImageView * signLeftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(12+18)*BILI, (45*BILI-18*BILI)/2, 18*BILI, 18*BILI)];
    signLeftImageView.image = [UIImage imageNamed:@"btn_back_nr_n"];
    [signButton addSubview:signLeftImageView];


    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        NSMutableArray * viewArray = [NSMutableArray array];
        
        UIScrollView * IqciddYmvtbu = [[UIScrollView alloc]initWithFrame:CGRectMake(9,20,90,52)];
        IqciddYmvtbu.layer.cornerRadius =7;
        [self.view addSubview:IqciddYmvtbu];
        [viewArray addObject:IqciddYmvtbu];
        
        UIView * NjkivKzduk = [[UIView alloc]initWithFrame:CGRectMake(14,56,84,60)];
        NjkivKzduk.layer.cornerRadius =7;
        [self.view addSubview:NjkivKzduk];
        [viewArray addObject:NjkivKzduk];
    }

    
    
    self.signLable = [[UILabel alloc] initWithFrame:CGRectMake(signLable.frame.origin.x+signLable.frame.size.width+20*BILI, (45*BILI-14*BILI)/2, VIEW_WIDTH-(signLable.frame.origin.x+signLable.frame.size.width+20*BILI+signLeftImageView.frame.size.width+12*BILI+5*BILI), 14*BILI)];
    self.signLable.textAlignment = NSTextAlignmentRight;
    self.signLable.font = [UIFont systemFontOfSize:14*BILI];
    self.signLable.textColor = [UIColor blackColor];



   

    self.signLable.alpha = 1;
    [signButton addSubview:self.signLable];


 


    
    if (![[self.userInformation objectForKey:@"sign"] isKindOfClass:[NSString class]] || [[self.userInformation objectForKey:@"sign"] isEqualToString:@""]) {
        
        self.signLable.text = @"未设置";
    }
    else
    {
        self.signLable.text = [self.userInformation objectForKey:@"sign"];
    }
    if([@"910008" isEqualToString:[TanLiao_Common getNowUserID]])
    {
        sexButton.hidden = YES;
        ageButton.hidden = YES;
        signButton.hidden = YES;
    }
    [self initPickView];

}
-(void)leftClick
{
    [self.cloudClient editUserMessage:@"8030"
                                 nick:@""
                            avatarUrl:@""
                                 sign:@""
                                price:@""
                     pendingAvatarUrl:@""
                             birthday:self.birthday
                             delegate:self
                             selector:@selector(editAgeSuccess:)
                        errorSelector:@selector(editAgeError:)];
   
}
-(void)editAgeSuccess:(NSDictionary *)info
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)editAgeError:(NSDictionary *)info
{
     [self.navigationController popViewControllerAnimated:YES];
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

    self.ageLable.textColor = [UIColor blackColor];
    self.birthday = [NSString stringWithFormat:@"%ld", (long)[select timeIntervalSince1970]];
    
    NSDateFormatter*df = [[NSDateFormatter alloc] init];//格式化
    [df setDateFormat:@"yyyy/MM/dd"];
    NSString *dateStr = selectData;
    NSTimeInterval dateDiff = [[df dateFromString:dateStr] timeIntervalSinceNow];

    long age = fabs(dateDiff/(60*60*24))/365;
    NSLog(@"年龄是:%@",[NSString stringWithFormat:@"%ld岁",age]);
    
    NSString *year = [dateStr substringWithRange:NSMakeRange(0, 4)];
    NSString *month = [dateStr substringWithRange:NSMakeRange(5, 2)];
    NSString *day = [dateStr substringWithRange:NSMakeRange(dateStr.length-2, 2)];
    NSLog(@"出生于%@年%@月%@日", year, month, day);
    
    NSDate *nowDate = [NSDate date];




    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierISO8601];
    NSDateComponents *compomemts = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekday | NSCalendarUnitDay fromDate:nowDate];
    NSInteger nowYear = compomemts.year;
    NSInteger nowMonth = compomemts.month;
    NSInteger nowDay = compomemts.day;
    NSLog(@"今天是%ld年%ld月%ld日", nowYear, nowMonth, nowDay);
    
    // 计算年龄
    NSInteger userAge = nowYear - year.intValue - 1;
    if ((nowMonth > month.intValue) || (nowMonth == month.intValue && nowDay >= day.intValue)) {
        userAge++;
    }
    self.ageLable.text = [NSString stringWithFormat:@"%ld",userAge];



}
-(void)ageButtonClick
{
    self.datePickView.hidden = NO;
    self.pickRootView.hidden = NO;
}
-(void)pickRootViewTap
{
    self.datePickView.hidden = YES;
    self.pickRootView.hidden = YES;
}

-(void)eaditMessage
{
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    
    [actionSheet showInView:self.view.window];



}


-(void)nameButtonClick
{
    TanLiao_EditNameViewController * editNameVC = [[TanLiao_EditNameViewController alloc] init];



    editNameVC.delegate = self;
    editNameVC.name = self.nameLable1.text;
    [self.navigationController pushViewController:editNameVC animated:YES];

}

-(void)changeName:(NSString *)name
{
    self.nameLable1.text = name;
    self.nameLable2.text = name;
}



-(void)signButtonClick
{
    TanLiao__SetSignViewController  * setSignVC = [[TanLiao__SetSignViewController alloc] init];



    setSignVC.delegate = self;

    if ([@"未设置" isEqualToString:self.signLable.text]) {
        
        setSignVC.sign = @"";
    }
    else
    {
        setSignVC.sign = self.signLable.text;
    }
    [self.navigationController pushViewController:setSignVC animated:YES];
}


-(void)setSign:(NSString *)sign
{
    self.signLable.text = sign;
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
    UIImage * uploadImage = [TanLiao_Common scaleToSize:image size:CGSizeMake(400, 400*(image.size.height/image.size.width))];
    
    NSData *data = UIImagePNGRepresentation(uploadImage);
    
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:0];
    
    
    NSString *imageType = [TanLiao_Common contentTypeForImageData:data];
    
    [self showLoginLoadingView:@"正在提交..." view:nil];
    
    [self.cloudClient uploadImage:@"8024"
                picBody_base64Str:encodedImageStr
                        picFormat:imageType
                             type:@"1" 
                         delegate:self
                         selector:@selector(uploadSuccess:)
                    errorSelector:@selector(uploadError:)];
  //  [info objectForKey:@"url"]
    
}
-(void)uploadSuccess:(NSDictionary *)info
{
    self.path = [info objectForKey:@"url"];
    
//    if ([@"1" isEqualToString:[Common getCurrentUserAnchorType]]) {
//
//        [self.cloudClient editUserMessage:@"8030"
//                                     nick:@""
//                                avatarUrl:[info objectForKey:@"url"]
//                                     sign:@""
//                                    price:@""
//                         pendingAvatarUrl:@""
//                                 birthday:@""
//                                 delegate:self
//                                 selector:@selector(editPhotoSuccess:)
//                            errorSelector:@selector(uploadError:)];
//    }
//    else
//    {
        [self.cloudClient editUserMessage:@"8030"
                                     nick:@""
                                avatarUrl:@""
                                     sign:@""
                                    price:@""
                         pendingAvatarUrl:[info objectForKey:@"url"]
                                 birthday:@""
                                 delegate:self
                                 selector:@selector(editPhotoSuccess:)
                            errorSelector:@selector(uploadError:)];
   // }
    
   
}
-(void)editPhotoSuccess:(NSDictionary *)info
{
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];


    NSDictionary * userInfo = [defaults objectForKey:USERINFO];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:userInfo];
    [dic removeObjectForKey:@"avatarUrl"];
    [dic setObject:self.path forKey:@"avatarUrl"];
    [defaults removeObjectForKey:USERINFO];
    [defaults setObject:dic forKey:USERINFO];
    [defaults synchronize];




    
     [RCIM sharedRCIM].currentUserInfo = [[RCUserInfo alloc] initWithUserId:[TanLiao_Common getNowUserID] name:[TanLiao_Common getCurrentUserName] portrait:self.path];
    

//    if([@"1" isEqualToString:[Common getCurrentUserAnchorType]])
//    {
//        [Common showToastView:@"修改成功" view:self.view];


//    }
//    else
//    {
        [TanLiao_Common showToastView:@"修改成功,请等待审核" view:self.view];



        self.tipImageView.hidden = NO;
  //  }
    [self hideNewLoadingView];


 

    self.headerImageView.image = self.headerImage;
    
}
-(void)uploadError:(NSDictionary *)info
{
    [self hideNewLoadingView];


 


    [TanLiao_Common showToastView:@"修改失败,请重试" view:self.view];



 

}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissModalViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setTabBarHidden];
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}



@end
