//
//  CreateTrendsViewController.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/4/4.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLL_CreateTrendsViewController.h"

@interface TanLL_CreateTrendsViewController ()

@end

@implementation TanLL_CreateTrendsViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTabBarHidden];
    
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];


 

    
    maxImageSelected = 9;
    
    self.loadingViewAlsoFullScreen = @"yes";
    
    self.titleLale.text = @"发动态";
    [self.leftButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.leftButton setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
    self.backImageView.hidden = YES;
    
     [self.rightButton setTitle:@"发布" forState:UIControlStateNormal];
    [self.rightButton setTitleColor:UIColorFromRGB(0xFF4C5B) forState:UIControlStateNormal];
    
    self.view.backgroundColor =UIColorFromRGB(0xF5F5F5);
    UITapGestureRecognizer * viewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap)];
    [self.view addGestureRecognizer:viewTap];
    
    UIView * textViewBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navView.frame.size.height+self.navView.frame.origin.y, VIEW_WIDTH, 140*BILI)];
    textViewBottomView.backgroundColor = [UIColor whiteColor];




    [self.view addSubview:textViewBottomView];


 


    
    self.wenZiTipLable = [[UILabel alloc] initWithFrame:CGRectMake(15*BILI,self.navView.frame.size.height+self.navView.frame.origin.y+15*BILI, VIEW_WIDTH, 15*BILI)];
    self.wenZiTipLable.text = @"说点什么~";
    self.wenZiTipLable.textColor = [UIColor blackColor];


 
   

    self.wenZiTipLable.font = [UIFont fontWithName:@"TimesNewRomanPS-ItalicMT" size:15*BILI];
    self.wenZiTipLable.alpha = 0.3;
    [self.view addSubview:self.wenZiTipLable];


 

 

    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(15*BILI,self.navView.frame.size.height+self.navView.frame.origin.y+9*BILI, VIEW_WIDTH-30*BILI, 140*BILI-9*BILI)];
    self.textView.font = [UIFont fontWithName:@"TimesNewRomanPS-ItalicMT" size:15*BILI];
    self.textView.alpha = 0.6;
    self.textView.backgroundColor = [UIColor clearColor];



    self.textView.delegate = self;
    [self.view addSubview:self.textView];


 

 

  
    if (![@"wenzi" isEqualToString:self.trendsType])
    {
        self.imageArray = [NSMutableArray array];
        self.imagePathArray = [NSMutableArray array];
        self.imageContentView = [[UIView alloc] initWithFrame:CGRectMake(15*BILI, textViewBottomView.frame.origin.y+textViewBottomView.frame.size.height+15*BILI, VIEW_WIDTH-30*BILI, VIEW_HEIGHT-(textViewBottomView.frame.origin.y+textViewBottomView.frame.size.height+15*BILI))];
        [self.view addSubview:self.imageContentView];



 

        [self initImageContentView];


 

 

    }
    
}


-(void)initImageContentView
{
    [self.imageContentView removeAllSubviews];




    float imageHeight = (VIEW_WIDTH-30*BILI-15*BILI)/4;
    if ([@"zhaopian" isEqualToString:self.trendsType])
    {
        
        
        for (int i=0; i<self.imageArray.count; i++) {
            
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake((i%4)*(imageHeight+5*BILI), (imageHeight+5*BILI)*(i/4), imageHeight, imageHeight)];
            imageView.userInteractionEnabled = YES;
            imageView.clipsToBounds = YES;
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.image = [self.imageArray objectAtIndex:i];
            [self.imageContentView addSubview:imageView];




            
            UIImageView * imageDelete = [[UIImageView alloc] initWithFrame:CGRectMake(imageView.frame.size.width-21*BILI, 0, 21*BILI, 21*BILI)];
            imageDelete.image = [UIImage imageNamed:@"create_dongtai_shanchu"];
            [imageView addSubview:imageDelete];



            
            UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(imageView.frame.size.width-30*BILI, 0, 30*BILI, 30*BILI)];
            button.tag = i;
            [button addTarget:self action:@selector(deleteImageButtonClick:) forControlEvents:UIControlEventTouchUpInside];


 

 

            [imageView addSubview:button];
        }
        if(self.imageArray.count==9)
        {
            
        }
        else
        {
            UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake((self.imageArray.count%4)*(imageHeight+5*BILI), (imageHeight+5*BILI)*(self.imageArray.count/4), imageHeight, imageHeight)];
            [button setImage:[UIImage imageNamed:@"dongtai_tianjia"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(addMediaButtonClick) forControlEvents:UIControlEventTouchUpInside];




            [self.imageContentView addSubview:button];
        }
    }
    
    if ([@"shipin" isEqualToString:self.trendsType]) {
        
        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, imageHeight, imageHeight)];
        [button setImage:[UIImage imageNamed:@"dongtai_tianjia"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(addMediaButtonClick) forControlEvents:UIControlEventTouchUpInside];



        [self.imageContentView addSubview:button];
        
        if (self.videoUrl!=nil&&self.covreImage!=nil)
        {
            self.videoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(button.frame.origin.x, button.frame.origin.y, 120*BILI, 160*BILI)];
            self.videoImageView.image = self.covreImage;
            self.videoImageView.userInteractionEnabled = YES;
            self.videoImageView.contentMode = UIViewContentModeScaleAspectFill;
            [self.imageContentView addSubview:self.videoImageView];


 


            self.videoImageView.clipsToBounds = YES;
            UIImageView * imageDelete = [[UIImageView alloc] initWithFrame:CGRectMake(self.videoImageView.frame.size.width-21*BILI, 0, 21*BILI, 21*BILI)];
            imageDelete.image = [UIImage imageNamed:@"create_dongtai_shanchu"];
            [self.videoImageView addSubview:imageDelete];


            
            UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(self.videoImageView.frame.size.width-30*BILI, 0, 30*BILI, 30*BILI)];
            [button addTarget:self action:@selector(deleteImageButtonClick:) forControlEvents:UIControlEventTouchUpInside];


 

            [self.videoImageView addSubview:button];
            
            UIButton * playVideoButton = [[UIButton alloc] initWithFrame:CGRectMake((120*BILI-30*BILI)/2, (160*BILI-30*BILI)/2, 30*BILI, 30*BILI)];
            [playVideoButton setImage:[UIImage imageNamed:@"bofang copy"] forState:UIControlStateNormal];
            //[playVideoButton addTarget:self action:@selector(playVideoButtonClick:) forControlEvents:UIControlEventTouchUpInside];



            [self.videoImageView addSubview:playVideoButton];

        }
        
        if (self.videoModel!=nil) {
            
            self.videoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(button.frame.origin.x, button.frame.origin.y, 120*BILI, 160*BILI)];
            self.videoImageView.image = self.videoModel.image;
            self.videoImageView.userInteractionEnabled = YES;
            self.videoImageView.contentMode = UIViewContentModeScaleAspectFill;
            self.videoImageView.clipsToBounds = YES;
            [self.imageContentView addSubview:self.videoImageView];



            
            UIImageView * imageDelete = [[UIImageView alloc] initWithFrame:CGRectMake(self.videoImageView.frame.size.width-21*BILI, 0, 21*BILI, 21*BILI)];
            imageDelete.image = [UIImage imageNamed:@"create_dongtai_shanchu"];
            [self.videoImageView addSubview:imageDelete];


 


            
            UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(self.videoImageView.frame.size.width-30*BILI, 0, 30*BILI, 30*BILI)];
            [button addTarget:self action:@selector(deleteImageButtonClick:) forControlEvents:UIControlEventTouchUpInside];




            [self.videoImageView addSubview:button];
            
            UIButton * playVideoButton = [[UIButton alloc] initWithFrame:CGRectMake((120*BILI-30*BILI)/2, (160*BILI-30*BILI)/2, 30*BILI, 30*BILI)];
            [playVideoButton setImage:[UIImage imageNamed:@"bofang copy"] forState:UIControlStateNormal];
//            [playVideoButton addTarget:self action:@selector(playVideoButtonClick:) forControlEvents:UIControlEventTouchUpInside];


 

 

            [self.videoImageView addSubview:playVideoButton];
        }
    }
    
    
}
-(void)deleteImageButtonClick:(id)sender
{
    if ([@"zhaopian" isEqualToString:self.trendsType])
    {
        
        UIButton * button = (UIButton *)sender;
        [self.imageArray removeObjectAtIndex:button.tag];
        [self initImageContentView];


    }
    if ([@"shipin" isEqualToString:self.trendsType])
    {
        self.videoUrl = nil;
        self.covreImage = nil;
        self.videoModel = nil;
        [self initImageContentView];



    }
}
-(void)addMediaButtonClick
{
    if ([@"zhaopian" isEqualToString:self.trendsType])
    {
        UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        
        [actionSheet showInView:self.view.window];


 

 

    }
    else
    {
        UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍视频",@"从手机相册选择", nil];
        actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        
        [actionSheet showInView:self.view.window];


 

 

    }
   
}
#pragma UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(buttonIndex == 0)
    {
        //拍摄照片或者视频
        [self addMeidFromCamera];
        
        
    }
    else if (buttonIndex == 1)
    {
        //从手机选取视频或者照片
        [self addMediaFromLibaray];
    }
   
}
- (void)addMeidFromCamera
{
    if ([@"zhaopian" isEqualToString:self.trendsType]) {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            self.imagePickerController = [[UIImagePickerController alloc] init] ;
            self.imagePickerController.delegate = self;
            self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            self.imagePickerController.allowsEditing = YES;
            
            [self presentModalViewController:self.imagePickerController animated:YES];
        } else {
            [TanLiao_Common showAlert:nil message:@"您的设备不支持此种方式上传照片"];
        }
    }
    else
    {
        TanLiao_RecordVideoViewController * recordVideoVC = [[TanLiao_RecordVideoViewController alloc] init];




        recordVideoVC.delegate = self;
        [self.navigationController pushViewController:recordVideoVC animated:YES];
        
    }
    
}
-(void)addMediaFromLibaray
{
    TZImagePickerController *imagePickController;
    
    if ([@"zhaopian" isEqualToString:self.trendsType])
    {
        NSInteger count = 0;
        count = maxImageSelected - self.imageArray.count;
        imagePickController = [[TZImagePickerController alloc] initWithMaxImagesCount:count delegate:self];
        //是否 在相册中显示拍照按钮
        imagePickController.allowTakePicture = NO;
        //是否可以选择显示原图
        imagePickController.allowPickingOriginalPhoto = NO;

        //是否 在相册中可以选择照片
        imagePickController.allowPickingImage= YES;
        //是否 在相册中可以选择视频
        imagePickController.allowPickingVideo = NO;
    }
    else
    {
        NSInteger count = 0;
        count = maxImageSelected - self.imageArray.count;
        imagePickController = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
        //是否 在相册中显示拍照按钮
        imagePickController.allowTakePicture = NO;
        //是否可以选择显示原图
        imagePickController.allowPickingOriginalPhoto = NO;

        //是否 在相册中可以选择照片
        imagePickController.allowPickingImage= NO;
        //是否 在相册中可以选择视频
        imagePickController.allowPickingVideo = YES;

    }
    
    [self.navigationController presentViewController:imagePickController animated:YES completion:nil];
    
}
-(void)recordVideoFinish:(NSURL *)videoUrl videoCutImage:(UIImage *)image
{
    
    self.videoUrl = videoUrl;
    self.covreImage = image;
    self.videoModel = nil;
    [self initImageContentView];



 

    
    
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{   //判断是否设置头像
    UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];



    [self dismissModalViewControllerAnimated:YES];
    
    [self.imageArray addObject:image];




    [self initImageContentView];



}

#pragma mark - TZImagePickerController Delegate
//处理从相册单选或多选的照片
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    
    
    [[LLImagePickerManager manager] getMediaInfoFromAsset:[assets objectAtIndex:0] completion:^(NSString *name, id pathData) {
        
        LLImagePickerModel *model = [[LLImagePickerModel alloc] init];



 

        model.name = name;
        model.uploadType = pathData;
        model.image = photos[0];
        for (UIImage * image in photos) {
            
            [self.imageArray addObject:image];




        }
        [self initImageContentView];




       //[self uploadImageAndVideo:model];
    }];
    
    
}

///选取视频后的回调
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset {
    [[LLImagePickerManager manager] getMediaInfoFromAsset:asset completion:^(NSString *name, id pathData) {
        LLImagePickerModel *model = [[LLImagePickerModel alloc] init];




        model.name = name;
        model.uploadType = pathData;
        model.image = coverImage;
        model.isVideo = YES;
        model.asset = asset;
        
        self.videoUrl = nil;
        self.covreImage = nil;
        self.videoModel = model;
        [self initImageContentView];

        //[self uploadImageAndVideo:model];
        
    }];
}



-(void)viewTap
{
    [self.textView resignFirstResponder];

    
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        UIView * NthjuVhckc = [[UIView alloc]initWithFrame:CGRectMake(38,99,53,86)];
        NthjuVhckc.layer.cornerRadius =7;
        [self.view addSubview:NthjuVhckc];
    }


}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.wenZiTipLable.hidden = YES;
    return  YES;
}


-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (self.textView.text.length==0) {
        
        self.wenZiTipLable.hidden = NO;
    }
}
-(void)rightClick
{
     [self.textView resignFirstResponder];

 

    if ([@"zhaopian" isEqualToString:self.trendsType]) {
        
        if (self.imageArray.count!=0)
        {
            uploadImageIndex = 0;
             [self showNewLoadingView:@"正在创建动态..." view:nil];
            [self uploadImage];


        }
        else
        {
            [TanLiao_Common showToastView:@"请选择要上传的照片" view:self.view];



 

        }
    }
    
     if ([@"shipin" isEqualToString:self.trendsType])
    {
        if (self.videoUrl==nil && self.videoModel==nil)
        {
            
             [TanLiao_Common showToastView:@"请选择要上传的视频" view:self.view];
        }
        else
        {
            [self showNewLoadingView:@"正在创建动态..." view:nil];
            if (self.videoUrl!=nil)
            {
                [self yaSuoAndUploadVideo:self.videoUrl];
            }
            else
            {
                [self getVideoFromPHAsset:self.videoModel.asset];


 

 


            }
        }
    }
    if ([@"wenzi" isEqualToString:self.trendsType]) {
        
       
        if ([TanLiao_Common isEmpty:self.textView.text]) {
            
            [TanLiao_Common showToastView:@"文字内容不能为空" view:self.view];



 

        }
        else
        {
            [self showNewLoadingView:@"正在创建动态..." view:nil];
            [self createTrends:nil imagePath:nil];
        }
    }
   
}
-(void)uploadImage
{
        UIImage * image = [self.imageArray objectAtIndex:uploadImageIndex];
    
        UIImage * uploadImage = [TanLiao_Common scaleToSize:image size:CGSizeMake(400, 400*(image.size.height/image.size.width))];
        
        NSData *data = UIImagePNGRepresentation(uploadImage);
        
        NSString *encodedImageStr = [data base64EncodedStringWithOptions:0];
        
        
        NSString *imageType = [TanLiao_Common contentTypeForImageData:data];
        
        [self.cloudClient uploadImage:@"8024"
                    picBody_base64Str:encodedImageStr
                            picFormat:imageType
                                 type:@"3"
                             delegate:self
                             selector:@selector(uploadSuccess:)
                        errorSelector:@selector(uploadError:)];
    
}
-(void)uploadSuccess:(NSDictionary *)info
{
    NSNumber * number = [info objectForKey:@"id"];
    [self.imagePathArray addObject:[NSString stringWithFormat:@"%d",number.intValue]];
    uploadImageIndex = uploadImageIndex+1;
    if (uploadImageIndex<self.imageArray.count)
    {
        [self uploadImage];




    }
    else
    {
        
        [self createTrends:nil imagePath:nil];
        
    }
}

-(void)uploadError:(NSDictionary *)info
{
    uploadImageIndex = uploadImageIndex+1;
    if (uploadImageIndex<self.imageArray.count)
    {
        [self uploadImage];




    }
    else
    {
         [self createTrends:nil imagePath:nil];
    }
}
//获取视频文件的路径
- (void) getVideoFromPHAsset: (PHAsset * ) phAsset {
    
    
    if (phAsset.mediaType == PHAssetMediaTypeVideo) {
        PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];


 
        if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
        {
            UILabel * XaespRlvnz = [[UILabel alloc]initWithFrame:CGRectMake(29,88,67,45)];
            XaespRlvnz.layer.cornerRadius =7;
            [self.view addSubview:XaespRlvnz];
        }
 

        options.version = PHImageRequestOptionsVersionCurrent;
        options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
        
        PHImageManager *manager = [PHImageManager defaultManager];

        [manager requestAVAssetForVideo:phAsset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
            AVURLAsset *urlAsset = (AVURLAsset *)asset;
            NSURL *url = urlAsset.URL;
            
            
            [self yaSuoAndUploadVideo:url];
            
        }];
    }
    
}
//压缩视频并上传
-(void)yaSuoAndUploadVideo :(NSURL *)fileURL
{
    
    NSString * yaSuoPath = [self getVideoSaveFilePathString];
    NSURL *yaSuoUrl = [[RAFileManager defaultManager] filePathUrlWithUrl:yaSuoPath];
    
    // 视频压缩
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:fileURL options:nil];
    AVAssetExportSession *exportSession= [[AVAssetExportSession alloc] initWithAsset:asset presetName:AVAssetExportPresetMediumQuality];
    exportSession.shouldOptimizeForNetworkUse = YES;
    exportSession.outputURL = yaSuoUrl;
    exportSession.outputFileType = AVFileTypeMPEG4;
    [exportSession exportAsynchronouslyWithCompletionHandler:^{
        int exportStatus = exportSession.status;
        switch (exportStatus)
        {
            case AVAssetExportSessionStatusFailed:
            {
                [self hideNewLoadingView];
                [TanLiao_Common showToastView:@"视频上传失败,请重试" view:self.view];

                NSError *exportError = exportSession.error;
                NSLog (@"AVAssetExportSessionStatusFailed: %@", exportError);
                break;
            }
            case AVAssetExportSessionStatusCompleted:
            {
                NSData *data = [NSData dataWithContentsOfURL:yaSuoUrl];
                
                unsigned long long size = data.length;
                NSString * videoFileSize = [NSString stringWithFormat:@"%.2f", size / pow(10, 6)];
                
                //视频大于5兆不让上传
                if (videoFileSize.intValue>5) {
                    
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        
                        [self hideNewLoadingView];
                        [TanLiao_Common showToastView:@"视频过大请重新选择" view:self.view];
                    });
                    
                }
                else
                {
                    NSString *encodedVideoStr = [data base64EncodedStringWithOptions:0];
                   
                    UIImage * shouZhenImage ;
                    if (self.videoModel) {
                        
                        shouZhenImage = self.videoModel.image;
                    }
                    else
                    {
                        shouZhenImage = self.covreImage;
                    }
                    UIImage * yaSuoShouZhenImage =     [TanLiao_Common scaleToSize:shouZhenImage size:CGSizeMake(200, 200*(shouZhenImage.size.height/shouZhenImage.size.width))];

                    NSData *data = UIImagePNGRepresentation(yaSuoShouZhenImage);
                    NSString *encodedImageStr = [data base64EncodedStringWithOptions:0];
                    NSString *imageType = [TanLiao_Common contentTypeForImageData:data];
                    
                    [self.cloudClient uploadVideo:@"8046"
                              videoBody_base64Str:encodedVideoStr
                                      videoFormat:@"MOV"
                               videoPic_base64Str:encodedImageStr
                                   videoPicFormat:imageType
                                         delegate:self
                                         selector:@selector(uploadVideoSuccess:)
                                    errorSelector:@selector(uploadVideoError:)];
                    
                }
            }
        }
    }];
    
    
}
-(void)uploadVideoSuccess:(NSDictionary *)info
{
    [self createTrends:[info objectForKey:@"url"] imagePath:[info objectForKey:@"picUrl"]];
}
-(void)uploadVideoError:(NSDictionary *)info
{
    [self hideNewLoadingView];



 

    [TanLiao_Common showToastView:@"视频上传失败,请重试" view:self.view];


 


}
#pragma 视频名以当前日期为名
- (NSString*)getVideoSaveFilePathString
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString* nowTimeStr = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    
    return nowTimeStr;
}
-(void)createTrends :(NSString *)videoPath imagePath:(NSString *)imagePath
{
    
    //@"wenzi":文字,@"zhaopian":相册选取,@"shipin":拍摄
    if ([@"wenzi" isEqualToString:self.trendsType]) {
        
        [self.cloudClient createTrends:@"8112"
                           moment_type:@"3"
                      moment_media_url:nil
                               content:self.textView.text
                              delegate:self
                              selector:@selector(createSuccess:)
                         errorSelector:@selector(createError:)];
    }
    else if ([@"zhaopian" isEqualToString:self.trendsType])
    {
        NSString * picUrl = [self.imagePathArray objectAtIndex:0];
        for (int i=1; i<self.imagePathArray.count; i++) {
            
            picUrl = [[picUrl stringByAppendingString:@","] stringByAppendingString:[self.imagePathArray objectAtIndex:i]];
        }
        [self.cloudClient createTrends:@"8112"
                           moment_type:@"2"
                      moment_media_url:picUrl
                               content:self.textView.text
                              delegate:self
                              selector:@selector(createSuccess:)
                         errorSelector:@selector(createError:)];
    }
    else
    {
        [self.cloudClient createTrends:@"8112"
                           moment_type:@"1"
                      moment_media_url:[NSString stringWithFormat:@"%@,%@",videoPath,imagePath]
                               content:self.textView.text
                              delegate:self
                              selector:@selector(createSuccess:)
                         errorSelector:@selector(createError:)];
    }
    
    
}
-(void)createSuccess:(NSDictionary *)info
{
    [self.delegate createTrendsSuccess];


 


    [self hideNewLoadingView];




    [TanLiao_Common showToastView:@"发布成功" view:self.view];



 

    [self performSelector:@selector(uploadSuccessAndPop) withObject:nil afterDelay:0.5];
}
-(void)createError:(NSDictionary *)info
{
    [self hideNewLoadingView];



 

    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];


 


}
-(void)uploadSuccessAndPop
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
