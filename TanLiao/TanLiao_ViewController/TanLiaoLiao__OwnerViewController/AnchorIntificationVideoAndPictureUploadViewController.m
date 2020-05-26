//
//  AnchorIntificationVideoAndPictureUploadViewController.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/6/5.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiao_AnchorIntificationVideoAndPictureUploadViewController.h"

@interface TanLiao_AnchorIntificationVideoAndPictureUploadViewController ()

@end

@implementation TanLiao_AnchorIntificationVideoAndPictureUploadViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTabBarHidden];
    self.cloudClient = [KuaiLiaoCloudClient getInstance];


 
 

    self.loadingViewAlsoFullScreen = @"yes";
    
    self.backImageView.hidden = YES;
    
    self.titleLale.text = @"申请认证";
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height))];
    [self.view addSubview:self.mainScrollView];


 

    
    self.picArray = [NSMutableArray array];
    self.videoArray = [NSMutableArray array];
    [self initView];



 

    
}


-(void)initView
{
    [self.mainScrollView removeAllSubviews];



   

    UIImageView * step4ImageView = [[UIImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-459*BILI/2)/2, 35*BILI, 459*BILI/2, 51*BILI)];
    step4ImageView.image = [UIImage imageNamed:@"pic_step4"];
    [self.mainScrollView addSubview:step4ImageView];


 


    UILabel * picNumberTipLable = [[UILabel alloc] initWithFrame:CGRectMake(0, step4ImageView.frame.origin.y+step4ImageView.frame.size.height+15*BILI, VIEW_WIDTH, 15*BILI)];
    picNumberTipLable.textColor =UIColorFromRGB(0xFF6666);
    picNumberTipLable.font = [UIFont systemFontOfSize:15*BILI];
    picNumberTipLable.textAlignment = NSTextAlignmentCenter;
    picNumberTipLable.text = @"上传生活照(6~9张)";
    [self.mainScrollView addSubview:picNumberTipLable];


    
    UIView * picBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, picNumberTipLable.frame.origin.y+picNumberTipLable.frame.size.height+18*BILI, VIEW_WIDTH, 0)];
    [self.mainScrollView addSubview:picBottomView];


    
    if (self.picArray.count==0)
    {
        UIButton * addPicButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-214*BILI/2)/2, 0, 214*BILI/2, 214*BILI/2)];
        [addPicButton setBackgroundImage:[UIImage imageNamed:@"anchorAddPic"] forState:UIControlStateNormal];
        [addPicButton addTarget:self action:@selector(addPicButtonClick) forControlEvents:UIControlEventTouchUpInside];


        [picBottomView addSubview:addPicButton];
        
        picBottomView.frame = CGRectMake(0, picBottomView.frame.origin.y, VIEW_WIDTH, 214*BILI/2);
        
    }
    else
    {
        for (int i=0; i<self.picArray.count; i++) {
            
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(21*BILI+(214*BILI/2+6*BILI)*(i%3), (214*BILI/2+6*BILI)*(i/3), 214*BILI/2, 214*BILI/2)];
            imageView.image = [self.picArray objectAtIndex:i];
            imageView.userInteractionEnabled = YES;
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.autoresizingMask = UIViewAutoresizingNone;
            imageView.clipsToBounds = YES;
            [picBottomView addSubview:imageView];



            
            UIButton * picDelete = [[UIButton alloc] initWithFrame:CGRectMake(imageView.frame.size.width-21*BILI, 0, 21*BILI, 21*BILI)];
            [picDelete setBackgroundImage:[UIImage imageNamed:@"create_dongtai_shanchu"] forState:UIControlStateNormal] ;
            [picDelete addTarget:self action:@selector(deletePicButtonClick:) forControlEvents:UIControlEventTouchUpInside];



            picDelete.tag = i;
            [imageView addSubview:picDelete];



            
        }
        if (self.picArray.count!=9)
        {
            UIButton * addPicButton = [[UIButton alloc] initWithFrame:CGRectMake(21*BILI+(214*BILI/2+6*BILI)*(self.picArray.count%3), (214*BILI/2+6*BILI)*(self.picArray.count/3), 214*BILI/2, 214*BILI/2)];
            [addPicButton setBackgroundImage:[UIImage imageNamed:@"anchorAddPic"] forState:UIControlStateNormal];
            [addPicButton addTarget:self action:@selector(addPicButtonClick) forControlEvents:UIControlEventTouchUpInside];


 


            [picBottomView addSubview:addPicButton];
            

            
            picBottomView.frame = CGRectMake(0, picBottomView.frame.origin.y, VIEW_WIDTH, addPicButton.frame.origin.y+addPicButton.frame.size.height);

        }
        else
        {
             picBottomView.frame = CGRectMake(0, picBottomView.frame.origin.y, VIEW_WIDTH, (214*BILI/2+6*BILI)*3);
        }
        
    }
    
    UILabel * picTipDeleteLable = [[UILabel alloc] initWithFrame:CGRectMake(0, picBottomView.frame.origin.y+picBottomView.frame.size.height+13*BILI, VIEW_WIDTH, 12*BILI)];
    picTipDeleteLable.textColor = [UIColor blackColor];




    picTipDeleteLable.alpha = 0.3;
    picTipDeleteLable.font = [UIFont systemFontOfSize:12*BILI];
    picTipDeleteLable.textAlignment = NSTextAlignmentCenter;
    picTipDeleteLable.text = @"小姐姐们一定要上传本人照片哦,认证通过后不可删除";
    picTipDeleteLable.adjustsFontSizeToFitWidth = YES;
    [self.mainScrollView addSubview:picTipDeleteLable];


 


    
    UILabel * videoNumberTipLable = [[UILabel alloc] initWithFrame:CGRectMake(0, picTipDeleteLable.frame.origin.y+picTipDeleteLable.frame.size.height+29*BILI, VIEW_WIDTH, 15*BILI)];
    videoNumberTipLable.textColor =UIColorFromRGB(0xFF6666);
    videoNumberTipLable.font = [UIFont systemFontOfSize:15*BILI];
    videoNumberTipLable.textAlignment = NSTextAlignmentCenter;
    videoNumberTipLable.text = @"上传视频(1~3个)";
    [self.mainScrollView addSubview:videoNumberTipLable];


 

    
    
    UIView * videoBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, videoNumberTipLable.frame.origin.y+videoNumberTipLable.frame.size.height+25*BILI, VIEW_WIDTH, 214*BILI/2+6*BILI)];
    [self.mainScrollView addSubview:videoBottomView];


 


    
    if (self.videoArray.count==0)
    {
        UIButton * addVideoButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-214*BILI/2)/2, 0, 214*BILI/2, 214*BILI/2)];
        [addVideoButton setBackgroundImage:[UIImage imageNamed:@"anchorAddVideo"] forState:UIControlStateNormal];
        [addVideoButton addTarget:self action:@selector(addVideoButtonClick) forControlEvents:UIControlEventTouchUpInside];


 


        [videoBottomView addSubview:addVideoButton];
        
    }
    else
    {
        for (int i=0; i<self.videoArray.count; i++) {
            
            LLImagePickerModel *model = [self.videoArray objectAtIndex:i];
            
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(21*BILI+(214*BILI/2+6*BILI)*(i%3), (214*BILI/2+6*BILI)*(i/3), 214*BILI/2, 214*BILI/2)];
            imageView.image = model.image;
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.autoresizingMask = UIViewAutoresizingNone;
            imageView.userInteractionEnabled = YES;
            imageView.clipsToBounds = YES;
            [videoBottomView addSubview:imageView];



            
            UIButton * boFangButton = [[UIButton alloc] initWithFrame:CGRectMake((214*BILI/2-30*BILI)/2, (214*BILI/2-30*BILI)/2, 30*BILI, 30*BILI)];
            [boFangButton setImage:[UIImage imageNamed:@"bofang copy"] forState:UIControlStateNormal];
            [imageView addSubview:boFangButton];
            
            UIButton * videoDelete = [[UIButton alloc] initWithFrame:CGRectMake(imageView.frame.size.width-21*BILI, 0, 21*BILI, 21*BILI)];
            [videoDelete setBackgroundImage:[UIImage imageNamed:@"create_dongtai_shanchu"] forState:UIControlStateNormal] ;
            [videoDelete addTarget:self action:@selector(deleteVideoButtonClick:) forControlEvents:UIControlEventTouchUpInside];




            videoDelete.tag = i;
            [imageView addSubview:videoDelete];


 
if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
{
  UITextView * qybtfS9656 = [[UITextView alloc]initWithFrame:CGRectMake(83,34,45,55)];
  qybtfS9656.layer.cornerRadius =8;
  qybtfS9656.userInteractionEnabled = YES;
  qybtfS9656.layer.masksToBounds = YES;
    UITableView * zpfsytJ22511 = [[UITableView alloc]initWithFrame:CGRectMake(38,81,71,2)];
    zpfsytJ22511.layer.cornerRadius =10;
    zpfsytJ22511.userInteractionEnabled = YES;
    zpfsytJ22511.layer.masksToBounds = YES;
    UITableView * dhybrZ9092 = [[UITableView alloc]initWithFrame:CGRectMake(0,61,16,23)];
    dhybrZ9092.layer.borderWidth = 1;
    dhybrZ9092.clipsToBounds = YES;
    dhybrZ9092.layer.cornerRadius =7;
    UIView * guxqlwD53379 = [[UIView alloc]initWithFrame:CGRectMake(58,49,23,5)];
    guxqlwD53379.layer.cornerRadius =10;
    guxqlwD53379.userInteractionEnabled = YES;
    guxqlwD53379.layer.masksToBounds = YES;
    UILabel * cibbmW2924 = [[UILabel alloc]initWithFrame:CGRectMake(61,7,11,49)];
    cibbmW2924.layer.cornerRadius =7;
    cibbmW2924.userInteractionEnabled = YES;
    cibbmW2924.layer.masksToBounds = YES;
    
    
    UITableView * wfmxtO2202 = [[UITableView alloc]initWithFrame:CGRectMake(67,74,41,67)];
    wfmxtO2202.layer.cornerRadius =8;
    wfmxtO2202.userInteractionEnabled = YES;
    wfmxtO2202.layer.masksToBounds = YES;

}
 


        }
        
        if (self.videoArray.count!=3)
        {
            UIButton * addVideoButton = [[UIButton alloc] initWithFrame:CGRectMake(21*BILI+(214*BILI/2+6*BILI)*(self.videoArray.count%3), 0, 214*BILI/2, 214*BILI/2)];
            [addVideoButton setBackgroundImage:[UIImage imageNamed:@"anchorAddVideo"] forState:UIControlStateNormal];
            [addVideoButton addTarget:self action:@selector(addVideoButtonClick) forControlEvents:UIControlEventTouchUpInside];



 

            [videoBottomView addSubview:addVideoButton];
        }

    }
    
    UILabel * videoTipDeleteLable = [[UILabel alloc] initWithFrame:CGRectMake(0, videoBottomView.frame.origin.y+videoBottomView.frame.size.height+11*BILI, VIEW_WIDTH, 12*BILI)];
    videoTipDeleteLable.textColor = [UIColor blackColor];




    videoTipDeleteLable.alpha = 0.3;
    videoTipDeleteLable.font = [UIFont systemFontOfSize:12*BILI];
    videoTipDeleteLable.textAlignment = NSTextAlignmentCenter;
    videoTipDeleteLable.text = @"小姐姐们一定要上传本人视频哦,认证通过后不可删除";
    videoTipDeleteLable.adjustsFontSizeToFitWidth = YES;
    [self.mainScrollView addSubview:videoTipDeleteLable];




    
    UIButton * uploadButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-300*BILI)/2, videoTipDeleteLable.frame.origin.y+videoTipDeleteLable.frame.size.height+11*BILI, 300*BILI, 49*BILI)];
    uploadButton.layer.cornerRadius = 49*BILI/2;
    uploadButton.backgroundColor = UIColorFromRGB(0xFF6666);
    [uploadButton setTitle:@"提交认证" forState:UIControlStateNormal];
    [uploadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    uploadButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
    [uploadButton addTarget:self action:@selector(uploadButtonClick) forControlEvents:UIControlEventTouchUpInside];




    [self.mainScrollView addSubview:uploadButton];
    
    [self.mainScrollView setContentSize:CGSizeMake(VIEW_WIDTH, uploadButton.frame.origin.y+uploadButton.frame.size.height+20*BILI)];
}
-(void)deletePicButtonClick:(id)sender
{
    UIButton * button = (UIButton *)sender;
    [self.picArray removeObjectAtIndex:button.tag];
    [self initView];




}
-(void)deleteVideoButtonClick:(id)sender
{
    UIButton * button = (UIButton *)sender;
    [self.videoArray removeObjectAtIndex:button.tag];
    [self initView];



}
-(void)addPicButtonClick
{
    TZImagePickerController *imagePickController;
    int count = 9 - (int)self.picArray.count;
    imagePickController = [[TZImagePickerController alloc] initWithMaxImagesCount:count delegate:self];
    //是否 在相册中显示拍照按钮
    imagePickController.allowTakePicture = NO;
    //是否可以选择显示原图
    imagePickController.allowPickingOriginalPhoto = NO;
    
    //是否 在相册中可以选择照片
    imagePickController.allowPickingImage= YES;
    //是否 在相册中可以选择视频
    imagePickController.allowPickingVideo = NO;
    [self.navigationController presentViewController:imagePickController animated:YES completion:nil];
}
-(void)addVideoButtonClick
{
    TZImagePickerController *imagePickController;
    int count = 3 - (int)self.videoArray.count;
    imagePickController = [[TZImagePickerController alloc] initWithMaxImagesCount:count delegate:self];
    //是否 在相册中显示拍照按钮
    imagePickController.allowTakePicture = NO;
    //是否可以选择显示原图
    imagePickController.allowPickingOriginalPhoto = NO;
    
    //是否 在相册中可以选择照片
    imagePickController.allowPickingImage= NO;
    //是否 在相册中可以选择视频
    imagePickController.allowPickingVideo = YES;
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
        for (UIImage * image in photos) {
            
            [self.picArray addObject:image];



 

        }
        [self initView];




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
        
        [self.videoArray addObject:model];
        [self initView];




    }];
}

-(void)uploadButtonClick
{
    uploadImageIndex = 0;
    uploadVideoIndex = 0;
    self.mediaPathArray = [NSMutableArray array];
    if (self.picArray.count<6)
    {
        [Common showToastView:@"图片不能少于6张" view:self.view];


        return;
    }
    if (self.videoArray.count==0)
    {
        [Common showToastView:@"请选择至少一个视频" view:self.view];



        return;
    }
    [self showNewLoadingView:@"资料上传中请稍等..." view:self.view];


 


    [self uploadImage];



 

    
}
-(void)uploadImage
{
    
    UIImage * image = [self.picArray objectAtIndex:uploadImageIndex];
    UIImage * uploadImage = [Common scaleToSize:image size:CGSizeMake(400, 400*(image.size.height/image.size.width))];
    
    NSData *data = UIImagePNGRepresentation(uploadImage);
    
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:0];
    
    
    NSString *imageType = [Common contentTypeForImageData:data];
    
    
    [self.cloudClient anchorImageOrtVideoUpload:@"8073"
                            videoBody_base64Str:encodedImageStr
                                    videoFormat:imageType
                             videoPic_base64Str:@"tupian"
                                 videoPicFormat:@"tupian"
                                           type:@"3"
                                       delegate:self
                                       selector:@selector(uploadImageSuccess:)
                                  errorSelector:@selector(uploadImageError:)];
    
}
-(void)uploadImageSuccess:(NSDictionary *)info
{
    NSNumber * number = [info objectForKey:@"id"];
    [self.mediaPathArray addObject:[NSString stringWithFormat:@"%d",number.intValue]];
    uploadImageIndex = uploadImageIndex+1;
    if (uploadImageIndex<self.picArray.count)
    {
        [self uploadImage];


 

 

    }
    else
    {
        
        [self uploadVideo];
        
    }
}
-(void)uploadImageError:(NSDictionary *)info
{
    uploadImageIndex = uploadImageIndex+1;
    if (uploadImageIndex<self.picArray.count)
    {
        [self uploadImage];


 

    }
    else
    {
        
        [self uploadVideo];
        
    }
}
-(void)uploadVideo
{
    self.videoModel = [self.videoArray objectAtIndex:uploadVideoIndex];
    [self getVideoFromPHAsset:self.videoModel.asset];


 

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
            
            if(url==nil)
            {
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    
                    [self hideNewLoadingView];



                    [Common showToastView:@"视频路径错误,请重新选择视频上传" view:self.view];


 

                    
                });
                
            }
            else
            {
                [self yaSuoAndUploadVideo:url];
            }
            
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
                
                 dispatch_sync(dispatch_get_main_queue(), ^{
                     
                     [self hideNewLoadingView];




                     [Common showToastView:@"视频解析失败,请重新选择视频上传" view:self.view];


 


                 });
                     
               
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


 


                        [Common showToastView:@"视频过大请重新选择" view:self.view];



                        
                    });
                    
                }
                else
                {
                    NSString *encodedVideoStr = [data base64EncodedStringWithOptions:0];
                    
                    UIImage * shouZhenImage  = self.videoModel.image;
                
                    UIImage * yaSuoShouZhenImage =   [Common scaleToSize:shouZhenImage size:CGSizeMake(400, 400*(shouZhenImage.size.height/shouZhenImage.size.width))];
                    
                    NSData *data = UIImagePNGRepresentation(yaSuoShouZhenImage);
                    NSString *encodedImageStr = [data base64EncodedStringWithOptions:0];
                    NSString *imageType = [Common contentTypeForImageData:data];
                    
                    [self.cloudClient anchorImageOrtVideoUpload:@"8073"
                                            videoBody_base64Str:encodedVideoStr
                                                    videoFormat:@"MOV"
                                             videoPic_base64Str:encodedImageStr
                                                 videoPicFormat:imageType
                                                           type:@"3"
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
    NSNumber * number = [info objectForKey:@"id"];
    [self.mediaPathArray addObject:[NSString stringWithFormat:@"%d",number.intValue]];
    uploadVideoIndex = uploadVideoIndex+1;
    if (uploadVideoIndex<self.videoArray.count)
    {
        [self uploadVideo];
    }
    else
    {
        [self finialStep];
    }
}
-(void)uploadVideoError:(NSDictionary *)info
{
    [self hideNewLoadingView];



    uploadVideoIndex = uploadVideoIndex+1;
    if (uploadVideoIndex<self.videoArray.count)
    {
        [self uploadVideo];
    }
    else
    {
        [self finialStep];
    }
}
-(void)finialStep
{
    NSString * finialStr = [self.mediaPathArray objectAtIndex:0];
    for (int i=1; i<self.mediaPathArray.count; i++) {
        
        finialStr = [[finialStr stringByAppendingString:@","] stringByAppendingString:[self.mediaPathArray objectAtIndex:i]];
    }
    [self.cloudClient anchorIntificationUploadVideosAndPics:@"8150"
                                                        ids:finialStr
                                                   delegate:self
                                                   selector:@selector(uploadSuccess:)
                                              errorSelector:@selector(uploadError:)];
}
-(void)uploadSuccess:(NSDictionary *)info
{
    KLiao_TiJiaoSuccessViewController * tiJiaoVC = [[KLiao_TiJiaoSuccessViewController alloc] init];



 

    [self.navigationController pushViewController:tiJiaoVC animated:YES];

}
-(void)uploadError:(NSDictionary *)info
{
    [Common showToastView:[info objectForKey:@"message"] view:self.view];


 

}
#pragma 视频名以当前日期为名
- (NSString*)getVideoSaveFilePathString
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];


 

 

    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString* nowTimeStr = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    
    return nowTimeStr;
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
