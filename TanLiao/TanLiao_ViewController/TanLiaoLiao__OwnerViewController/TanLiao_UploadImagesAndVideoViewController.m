//
//  UploadImagesAndVideoViewController.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2017/9/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_UploadImagesAndVideoViewController.h"
#import "LLImagePickerConst.h"
#import "MWPhotoBrowser.h"

@interface TanLiao_UploadImagesAndVideoViewController ()

@end

@implementation TanLiao_UploadImagesAndVideoViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTabBarHidden];
    
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];




    
    maxImageSelected = 1;
    
    self.titleLale.text = @"我的秀场";
    
    
    self.mediaArray = [NSMutableArray array];
    
    self.bottomView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height))];
    [self.view addSubview:self.bottomView];



  
//    self.rightButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-60,  20, 60, 44)];
//    [self.rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [self.rightButton addTarget:self action:@selector(editButtonClick) forControlEvents:UIControlEventTouchUpInside];


//    [self.view addSubview:self.rightButton];
//    
//    self.rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.rightButton.frame.size.width-18*BILI-12*BILI, (44-18)/2, 18*BILI, 18*BILI*36/30)];
//    self.rightImageView.image = [UIImage imageNamed:@"btn_shanchu"];
//    [self.rightButton addSubview:self.rightImageView];


 


    
    [self reloadData];
}

-(void)editButtonClick
{
    if (alsoEdit == NO) {
        
        alsoEdit = YES;
        self.rightImageView.image = [UIImage imageNamed:@"btn_shanchu_hold"];
        for (int i=0; i<self.deleteCheckButtonArray.count; i++) {
            
            UIButton * button = [self.deleteCheckButtonArray objectAtIndex:i];
            button.hidden = NO;
        }
    }
    else
    {
        alsoEdit = NO;
        self.rightImageView.image = [UIImage imageNamed:@"btn_shanchu"];
        
        if (self.deleteIdsArray.count==0)
        {
            for (int i=0; i<self.deleteCheckButtonArray.count; i++) {
                
                UIButton * button = [self.deleteCheckButtonArray objectAtIndex:i];
                button.hidden = YES;
            }

        }
        else
        {
            NSString * ids = [self.deleteIdsArray objectAtIndex:0];
            
            for (int i=1; i<self.deleteIdsArray.count; i++) {
                
                NSString * mediaId = [self.deleteIdsArray objectAtIndex:i];
                ids = [ids stringByAppendingString:[NSString stringWithFormat:@",%@",mediaId]];
            }
            [self showNewLoadingView:@"正在删除.." view:self.view];



 

            [self.cloudClient deleteAnchorVideosAndImages:@"8076"
                                                      ids:ids
                                                 delegate:self
                                                 selector:@selector(deleteMediaSuccess:)
                                            errorSelector:@selector(deleteMediaError:)];
        }
    }
   
    
}
-(void)deleteMediaSuccess:(NSDictionary *)info
{
    [self reloadData];
}
-(void)deleteMediaError:(NSDictionary *)info
{
    
}
-(void)reloadData
{
    [self showNewLoadingView:@"加载中..." view:self.view];


 


    [self.cloudClient getAnchorVideosAndImages:@"8075"
                                      delegate:self
                                      selector:@selector(getVideoSAndImagesSuccess:)
                                 errorSelector:@selector(getVideoSAndImagesError:)];
}


-(void)getVideoSAndImagesSuccess:(NSArray *)array
{
    self.deleteCheckButtonArray = [NSMutableArray array];
    self.deleteIdsArray = [NSMutableArray array];
    [self.bottomView removeAllSubviews];


    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        NSMutableArray * viewArray = [NSMutableArray array];
        
        UIScrollView * TfwiRigc = [[UIScrollView alloc]initWithFrame:CGRectMake(57,93,84,42)];
        TfwiRigc.layer.cornerRadius =9;
        [viewArray addObject:TfwiRigc];
        
        UIScrollView * TkckuZzztd = [[UIScrollView alloc]initWithFrame:CGRectMake(88,34,35,90)];
        TkckuZzztd.layer.cornerRadius =10;
        [viewArray addObject:TkckuZzztd];
        
    }


    self.videosAndImagesArray = array;
    
    for (int i=0; i<self.videosAndImagesArray.count; i++) {
        
        NSDictionary * info = [self.videosAndImagesArray objectAtIndex:i];
        
        
        TanLiaoCustomImageView * headerImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake((i%3)*((VIEW_WIDTH-6*BILI)/3+3), (i/3)*(((VIEW_WIDTH-6*BILI)/3+3)), (VIEW_WIDTH-6*BILI)/3, (VIEW_WIDTH-6*BILI)/3)];
        headerImageView.tag = i;
        headerImageView.userInteractionEnabled = YES;
        headerImageView.contentMode = UIViewContentModeScaleAspectFill;
        headerImageView.clipsToBounds = YES;
        NSString * imageOrVideoPath = [info objectForKey:@"url"];
        if(![imageOrVideoPath containsString:@".MP4"]&&![imageOrVideoPath containsString:@".mp4"]&&![imageOrVideoPath containsString:@".mov"]&&![imageOrVideoPath containsString:@".MOV"])
        {
            
            
            headerImageView.urlPath = [info objectForKey:@"url"];

            
           
        }
        else
        {
            headerImageView.urlPath = [info objectForKey:@"picUrl"] ; //[self getVideoPreViewImage:[NSURL URLWithString:imageOrVideoPath]];
            
            UIButton * playVideoButton = [[UIButton alloc] initWithFrame:CGRectMake(((VIEW_WIDTH-6*BILI)/3-30*BILI)/2, ((VIEW_WIDTH-6*BILI)/3-30*BILI)/2, 30*BILI, 30*BILI)];
            playVideoButton.tag = i;
            [playVideoButton setImage:[UIImage imageNamed:@"bofang copy"] forState:UIControlStateNormal];
             [playVideoButton addTarget:self action:@selector(playVideoButtonClick:) forControlEvents:UIControlEventTouchUpInside];

            [headerImageView addSubview:playVideoButton];
        }
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(videoAndInageTap:)];
        [headerImageView addGestureRecognizer:tap];
        
        if([@"0" isEqualToString:[info objectForKey:@"status"]])
        {
            UIImageView * tipIMageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, headerImageView.frame.size.height-28*BILI, headerImageView.frame.size.width, 28*BILI)];
            tipIMageView.image = [UIImage imageNamed:@"shenhe_pic"];
            [headerImageView addSubview:tipIMageView];


 

 

        }
        
        UIButton * checkButton = [[UIButton alloc] initWithFrame:CGRectMake(headerImageView.frame.size.width-10*BILI-25*BILI, 10*BILI, 25*BILI, 25*BILI)];
        [checkButton addTarget:self action:@selector(checkButtonClick:) forControlEvents:UIControlEventTouchUpInside];


 

 

        [checkButton setBackgroundImage:[UIImage imageNamed:@"btn_xuanze_n"] forState:UIControlStateNormal];
        [headerImageView addSubview:checkButton];
        checkButton.hidden = YES;
        checkButton.tag = i;
        [self.deleteCheckButtonArray addObject:checkButton];
        
        [self.bottomView addSubview:headerImageView];




    }
    

        UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake((self.videosAndImagesArray.count%3)*((VIEW_WIDTH-6*BILI)/3+3), (self.videosAndImagesArray.count/3)*(((VIEW_WIDTH-6*BILI)/3+3)), (VIEW_WIDTH-6*BILI)/3, (VIEW_WIDTH-6*BILI)/3)];
        [button setImage:[UIImage imageNamed:@"icon_tianjia"] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor blackColor];
        button.alpha = 0.1;
        [button addTarget:self action:@selector(addbuttonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.bottomView addSubview:button];
 
    [self.bottomView setContentSize:CGSizeMake(VIEW_WIDTH, button.frame.origin.y+button.frame.size.height+15*BILI)];
    
    [self hideNewLoadingView];


 


}
-(void)checkButtonClick:(id)sender
{
    UIButton * button = (UIButton *)sender;
    NSDictionary * info = [self.videosAndImagesArray objectAtIndex:button.tag];
    NSString * checkId = [info objectForKey:@"id"];
    BOOL alsoHave = NO;
    for (int i=0; i<self.deleteIdsArray.count; i++) {
        
        if ([checkId isEqualToString:[self.deleteIdsArray objectAtIndex:i]]) {
            alsoHave = YES;
            break;
        }
        
    }
    
    if (alsoHave == YES)
    {
        [button setBackgroundImage:[UIImage imageNamed:@"btn_xuanze_n"] forState:UIControlStateNormal];

        [self.deleteIdsArray removeObject:checkId];
    }
    else
    {
        [button setBackgroundImage:[UIImage imageNamed:@"btn_xuanze_h"] forState:UIControlStateNormal];

        [self.deleteIdsArray addObject:checkId];
    }
}


-(void)getVideoSAndImagesError:(NSDictionary *)info
{
    [self hideNewLoadingView];


 


}
-(void)addbuttonClick
{
    NSInteger count = 0;
    count = maxImageSelected - self.mediaArray.count;
    TZImagePickerController *imagePickController = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    //是否 在相册中显示拍照按钮
    imagePickController.allowTakePicture = NO;
    //是否可以选择显示原图
    imagePickController.allowPickingOriginalPhoto = NO;
    //是否 在相册中可以选择照片
    imagePickController.allowPickingImage= YES;
    //是否 在相册中可以选择视频
    imagePickController.allowPickingVideo = YES;
    //    if (!_allowMultipleSelection) {
    //        imagePickController.selectedAssets = _selectedImageAssets;
    //    }
    
    [self.navigationController presentViewController:imagePickController animated:YES completion:nil];

}
#pragma mark - TZImagePickerController Delegate
//处理从相册单选或多选的照片
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    
    
    [[LLImagePickerManager manager] getMediaInfoFromAsset:[assets objectAtIndex:0] completion:^(NSString *name, id pathData) {
        
        LLImagePickerModel *model = [[LLImagePickerModel alloc] init];



 

        model.name = name;
        model.uploadType = pathData;
        model.image = photos[0];
        [self uploadImageAndVideo:model];
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
        [self uploadImageAndVideo:model];

    }];
}


-(void)uploadImageAndVideo :(LLImagePickerModel *)model
{
    
    if( model.isVideo)
    {
        [self showNewLoadingView:@"正在上传..." view:nil];
        [self getVideoFromPHAsset:model.asset];


 


            
    }
    else
    {
        
        [self showNewLoadingView:@"正在上传..." view:self.view];




        UIImage * image = model.image;
        UIImage * uploadImage = [TanLiao_Common scaleToSize:image size:CGSizeMake(400, 400*(image.size.height/image.size.width))];
        
        NSData *data = UIImagePNGRepresentation(uploadImage);
        
        NSString *encodedImageStr = [data base64EncodedStringWithOptions:0];
        
        
        NSString *imageType = [TanLiao_Common contentTypeForImageData:data];
        
        
        [self.cloudClient anchorImageOrtVideoUpload:@"8073"
                                videoBody_base64Str:encodedImageStr
                                        videoFormat:imageType
                                 videoPic_base64Str:@"tupian"
                                     videoPicFormat:@"tupian"
                                               type:@"1"
                                           delegate:self
                                           selector:@selector(uploadSuccess:)
                                      errorSelector:@selector(uploadError:)];
    }
    

}
-(void)uploadSuccess:(NSDictionary *)info
{
     [self reloadData];
}
-(void)uploadError:(NSDictionary *)info
{
    [TanLiao_Common showToastView:@"视频上传失败,请重试" view:self.view];




    [self hideNewLoadingView];



}
//获取视频文件的路径
- (void) getVideoFromPHAsset: (PHAsset * ) phAsset {
    
    
    if (phAsset.mediaType == PHAssetMediaTypeVideo) {
        PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];



 

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
                
                UIImage * shouZhenImage = [self getVideoPreViewImage:yaSuoUrl];
                UIImage * yaSuoShouZhenImage =     [TanLiao_Common scaleToSize:shouZhenImage size:CGSizeMake(200, 200*(shouZhenImage.size.height/shouZhenImage.size.width))];
                NSData *data = UIImagePNGRepresentation(yaSuoShouZhenImage);
                NSString *encodedImageStr = [data base64EncodedStringWithOptions:0];
                NSString *imageType = [TanLiao_Common contentTypeForImageData:data];

                    
                
                [self.cloudClient anchorImageOrtVideoUpload:@"8073"
                                        videoBody_base64Str:encodedVideoStr
                                                videoFormat:@"MOV"
                                         videoPic_base64Str:encodedImageStr
                                             videoPicFormat:imageType
                                                       type:@"1"
                                                   delegate:self
                                                   selector:@selector(uploadSuccess:)
                                              errorSelector:@selector(uploadError:)];
                }
            }
        }
    }];
    

}

#pragma 视频名以当前日期为名
- (NSString*)getVideoSaveFilePathString
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];




    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString* nowTimeStr = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    
    return nowTimeStr;
}

//获取视频的第一帧
- (UIImage*) getVideoPreViewImage:(NSURL *)path
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:path options:nil];
    AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];


 


    
    assetGen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];


 

   

    UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];


 

 

    CGImageRelease(image);
    return videoImage;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)videoAndInageTap:(UITapGestureRecognizer *)tap
{

    UIImageView * imageView = (UIImageView *)tap.view;
    [self pushToPhotoBrowser:(int)imageView.tag];
    
}
-(void)playVideoButtonClick:(id)sender
{

    UIButton * button  = (UIButton *)sender;
    
    [self pushToPhotoBrowser:(int)button.tag];
}

-(void)pushToPhotoBrowser:(int)index
{

    NSMutableArray * photos = [NSMutableArray array];
    
    for (int i=0; i<self.videosAndImagesArray.count; i++) {
        NSDictionary * info = [self.videosAndImagesArray objectAtIndex:i];
        NSString * path = [info objectForKey:@"url"];
        //图片
        if (![path containsString:@".MP4"]&&![path containsString:@".mp4"]&&![path containsString:@".mov"]&&![path containsString:@".MOV"]) {
            
            MWPhoto *photo = [MWPhoto photoWithURL:[NSURL URLWithString:path]];
            [photos addObject:photo];
        }
        else
        {
            MWPhoto * photo = [MWPhoto photoWithURL:[NSURL URLWithString:[info objectForKey:@"picUrl"]]];
            photo.videoURL = [NSURL URLWithString:path];
            [photos addObject:photo];
        }
        
    }
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithPhotos:photos];


 

    browser.displayActionButton = NO;
    browser.alwaysShowControls = NO;
    browser.displaySelectionButtons = NO;
    browser.zoomPhotosToFill = YES;
    browser.displayNavArrows = NO;
    browser.startOnGrid = NO;
    browser.enableGrid = YES;
    [browser setCurrentPhotoIndex:index];
    [self .navigationController pushViewController:browser animated:YES];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)initDataVfgpdrPlummrVC:(NSDictionary *)info
{
    
    NSMutableArray * viewArray = [NSMutableArray array];
    
    UIView * NthjuVhckc = [[UIView alloc]initWithFrame:CGRectMake(67,90,27,2)];
    NthjuVhckc.layer.cornerRadius =10;
    [viewArray addObject:NthjuVhckc];
    
    UILabel * TkckuZzztd = [[UILabel alloc]initWithFrame:CGRectMake(3,43,28,2)];
    TkckuZzztd.layer.cornerRadius =6;
    [viewArray addObject:TkckuZzztd];
    
    
}

@end
