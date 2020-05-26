//
//  RecordVideoViewController.m
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/17.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_RecordVideoViewController.h"

@interface TanLiao_RecordVideoViewController ()

@end

@implementation TanLiao_RecordVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navView.hidden = YES;
    startOrStopRecordVideo = NO;
    isFront = NO;
    [self initAVCaptureSession];
    
    //闪关灯开关
    self.switchFlashLight = [[UIButton alloc] initWithFrame:CGRectMake(573*BILI/2,SafeAreaTopHeight+0*BILI, 32*BILI, 32*BILI)];
    [self.switchFlashLight setImage:[UIImage imageNamed:@"flash_on_n"] forState:UIControlStateNormal];
    [self.switchFlashLight addTarget:self action:@selector(switchFlashLight:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.switchFlashLight];
    
    //切换摄像头
    UIButton * switchbutton = [[UIButton alloc] initWithFrame:CGRectMake(657*BILI/2,SafeAreaTopHeight+0*BILI, 32*BILI, 32*BILI)];
    [switchbutton setImage:[UIImage imageNamed:@"change"] forState:UIControlStateNormal];
    [switchbutton addTarget:self action:@selector(switchCamera) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:switchbutton];
    
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT-90*BILI, VIEW_WIDTH, 90*BILI)];
    bottomView.backgroundColor = UIColorFromRGB(0x3C3A45);
    [self.view addSubview:bottomView];
    
    self.beginAndStopRecordButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-75*BILI)/2,15*BILI/2, 75*BILI, 75*BILI)];
    self.beginAndStopRecordButton.backgroundColor = UIColorFromRGB(0xFF6666);
    self.beginAndStopRecordButton.layer.cornerRadius = 75*BILI/2;
    [self.beginAndStopRecordButton addTarget:self action:@selector(stopRecord:) forControlEvents:UIControlEventTouchUpInside];
    [self.beginAndStopRecordButton addTarget:self action:@selector(beginRecord:) forControlEvents:UIControlEventTouchDown];
    [bottomView addSubview:self.beginAndStopRecordButton];
    
    self.choseVideoButton  = [[UIButton alloc] initWithFrame:CGRectMake(25*BILI,45*BILI/2, 45*BILI, 45*BILI)];
    [self.choseVideoButton  setImage:[UIImage imageNamed:@"video_ok"] forState:UIControlStateNormal];
    [self.choseVideoButton  addTarget:self action:@selector(choseVideoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.choseVideoButton.hidden = YES;
    [bottomView addSubview:self.choseVideoButton ];
    
    
    UIButton * closeButton = [[UIButton alloc] initWithFrame:CGRectMake(610*BILI/2,45*BILI/2, 45*BILI, 45*BILI)];
    [closeButton setImage:[UIImage imageNamed:@"video_close"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:closeButton];
    
    self.progressView = [[UIView alloc] initWithFrame:CGRectMake(0, bottomView.frame.origin.y-5*BILI, 0, 5*BILI)];
    self.progressView.backgroundColor = UIColorFromRGB(0xFFCF00);
    [self.view addSubview:self.progressView];
    
}
-(void)choseVideoButtonClick
{
    [self.delegate recordVideoFinish:self.fileSavePath videoCutImage:self.videoCutImage];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)closeButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - private mehtod
- (void)initAVCaptureSession{
    
    
    self.session = [[AVCaptureSession alloc] init];
    
    //这里根据需要设置  可以设置4K
    self.session.sessionPreset = AVCaptureSessionPreset1280x720;
    
    NSError *error;
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    //更改这个设置的时候必须先锁定设备，修改完后再解锁，否则崩溃
    [device lockForConfiguration:nil];
    //设置闪光灯为自动
    [device setFlashMode:AVCaptureFlashModeAuto];
    [device unlockForConfiguration];
    
    self.videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:device error:&error];
    
    self.audioInput = [[AVCaptureDeviceInput alloc] initWithDevice:[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio] error:nil];
    
    if (error) {
        NSLog(@"%@",error);
    }
    
    self.movieFileOutput = [[AVCaptureMovieFileOutput alloc] init];
    
    if ([self.session canAddInput:self.videoInput]) {
        [self.session addInput:self.videoInput];
    }
    
    if ([self.session canAddInput:self.audioInput]) {
        
        [self.session addInput:self.audioInput];
    }
    
    if ([self.session canAddOutput:self.movieFileOutput]) {
        
        [self.session addOutput:self.movieFileOutput];
    }
    
    //初始化预览图层
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    [self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspect];
    
    self.previewLayer.frame = CGRectMake(0, 0,VIEW_WIDTH, VIEW_HEIGHT);
    [self.view.layer insertSublayer:self.previewLayer atIndex:0];
    
    
    
    
//    UIButton * boFangButton = [[UIButton alloc] initWithFrame:CGRectMake(300,VIEW_HEIGHT-145, 45*BILI, 45*BILI)];
//    boFangButton.backgroundColor = [UIColor blueColor];
//    [boFangButton addTarget:self action:@selector(boFangButtonClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:boFangButton];
    
    
    self.timeLable = [[UILabel alloc] initWithFrame:CGRectMake(0,VIEW_HEIGHT-90*BILI-5*BILI-15*BILI, VIEW_WIDTH, 15*BILI)];
    self.timeLable.font = [UIFont systemFontOfSize:15*BILI];
    self.timeLable.textColor = [UIColor whiteColor];
    self.timeLable.textAlignment = NSTextAlignmentCenter;
    self.timeLable.alpha = 0.9;
    self.timeLable.text = @"00秒";
    [self.view addSubview:self.timeLable];
    
    [self switchCamera];
    
}
-(void)boFangButtonClick
{
    
    NSURL *url = self.fileSavePath;
    
    // 2.创建AVPlayerItem
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
    
    AVPlayer * player;
    // 3.创建AVPlayer
    player = [AVPlayer playerWithPlayerItem:item];
    
    // 4.添加AVPlayerLayer
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:player];
    layer.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width * 9 / 16);
    [self.view.layer addSublayer:layer];
    [player play];
    
}
-(void)playFinish
{
    
}
//清除视频本地文件
- (void)cleanCache
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:self.fileSavePath.absoluteString]) {
        //删除
        NSError *error = nil;
        [[NSFileManager defaultManager] removeItemAtPath:self.fileSavePath.absoluteString error:&error];
        if (error) {
            NSLog(@"%@",error);
            return;
        }
        NSLog(@"录制意外结束，删除本地文件");
    }
    NSAssert([[NSThread mainThread] isMainThread], @"Not Main Thread");
    
}
#pragma 视频名以当前日期为名
- (NSString*)getVideoSaveFilePathString
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString* nowTimeStr = [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    
    return nowTimeStr;
}
#pragma mark 开始录制和结束录制
- (void)startVideoRecorder{
    
    AVCaptureConnection *movieConnection = [self.movieFileOutput connectionWithMediaType:AVMediaTypeVideo];
    AVCaptureVideoOrientation avcaptureOrientation = AVCaptureVideoOrientationPortrait;
    [movieConnection setVideoOrientation:avcaptureOrientation];
    [movieConnection setVideoScaleAndCropFactor:1.0];
    NSString * path = [self getVideoSaveFilePathString];
    NSURL *url = [[RAFileManager defaultManager] filePathUrlWithUrl:path];
    [self.movieFileOutput startRecordingToOutputFileURL:url recordingDelegate:self];
    [self timerFired];
    
}
- (void)timerFired{
    
    timeLength = 0;
     self.progressView.frame = CGRectMake(self.progressView.frame.origin.x, self.progressView.frame.origin.y, 0, self.progressView.frame.size.height);
    self.timer = [NSTimer scheduledTimerWithTimeInterval:TIMER_INTERVAL target:self selector:@selector(timerRecord) userInfo:nil repeats:YES];
}
- (void)timerRecord{
    
    timeLength += TIMER_INTERVAL;
    if(timeLength>=10)
    {
        self.timeLable.text = [NSString stringWithFormat:@"%.0f秒",timeLength];

    }
    else
    {
        self.timeLable.text = [NSString stringWithFormat:@"0%.0f秒",timeLength];

    }
    self.progressView.frame = CGRectMake(self.progressView.frame.origin.x, self.progressView.frame.origin.y, timeLength*(VIEW_WIDTH/VIDEO_RECORDER_MAX_TIME), self.progressView.frame.size.height);
    if (timeLength/VIDEO_RECORDER_MAX_TIME >= 1) {
        
        [self stopVideoRecorder];
        
        [self timerStop];
    }
}
- (void)stopVideoRecorder{
    
    
    [self.movieFileOutput stopRecording];
    [self timerStop];
    
}
- (void)timerStop{
    
    if ([self.timer isValid]) {
        
        self.progressView.frame = CGRectMake(self.progressView.frame.origin.x, self.progressView.frame.origin.y, timeLength*(VIEW_WIDTH/VIDEO_RECORDER_MAX_TIME), self.progressView.frame.size.height);
        [self.timer invalidate];
        self.timer = nil;
    }
}
-(void)beginRecord:(id)sender
{
    [self cleanCache];
    self.choseVideoButton.hidden = YES;
     UIButton * button = (UIButton *)sender;
    [button setBackgroundColor:UIColorFromRGB(0xFFCF00)];
    [self startVideoRecorder];
}
-(void)stopRecord:(id)sender
{
    self.beginAndStopRecordButton.enabled = NO;
    [self stopVideoRecorder];
    UIButton * button = (UIButton *)sender;
    [button setBackgroundColor:UIColorFromRGB(0xFF6666)];
    
    
}
-(void)beginAndStopRecordButtonClick
{
    self.choseVideoButton.hidden = YES;
    if(startOrStopRecordVideo == NO)
    {
        [self startVideoRecorder];
        startOrStopRecordVideo = YES;
    }
    else
    {
        [self stopVideoRecorder];
        startOrStopRecordVideo = NO;
        
    }
    
}
#pragma mark - 视频输出
- (void)captureOutput:(AVCaptureFileOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error{
    
    if (CMTimeGetSeconds(captureOutput.recordedDuration) < VIDEO_RECORDER_MIN_TIME) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"视频时间过短" message:nil delegate:self
                                              cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    self.beginAndStopRecordButton.enabled = YES;

    
    NSLog(@"%s-- url = %@ ,recode = %f , int %lld kb", __func__, outputFileURL, CMTimeGetSeconds(captureOutput.recordedDuration), captureOutput.recordedFileSize / 1024);
    self.fileSavePath = outputFileURL;
    [self movieToImageHandler:^(UIImage *movieImage) {
        
        self.videoCutImage = movieImage;
        self.choseVideoButton.hidden = NO;
        
    }];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    self.beginAndStopRecordButton.enabled = YES;
}
//获取视频第一帧的图片
- (void)movieToImageHandler:(void (^)(UIImage *movieImage))handler {
    NSURL *url = self.fileSavePath;
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:url options:nil];
    AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    generator.appliesPreferredTrackTransform = TRUE;
    CMTime thumbTime = CMTimeMakeWithSeconds(0, 60);
    generator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    AVAssetImageGeneratorCompletionHandler generatorHandler =
    ^(CMTime requestedTime, CGImageRef im, CMTime actualTime, AVAssetImageGeneratorResult result, NSError *error){
        if (result == AVAssetImageGeneratorSucceeded) {
            UIImage *thumbImg = [UIImage imageWithCGImage:im];
            
            
            if (handler) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    handler(thumbImg);
                });
            }
        }
    };
    [generator generateCGImagesAsynchronouslyForTimes:
     [NSArray arrayWithObject:[NSValue valueWithCMTime:thumbTime]] completionHandler:generatorHandler];
}

- (void)startSession{
    
    if (![self.session isRunning]) {
        
        [self.session startRunning];
    }
}

- (void)stopSession{
    
    if ([self.session isRunning]) {
        
        [self.session stopRunning];
    }
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    [self startSession];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:YES];
    
    [self stopSession];
    
    [self.timer invalidate];
    self.timer = nil;
}

- (void)switchCamera {
    NSUInteger cameraCount = [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count];
    if (cameraCount > 1) {
        NSError *error;
        AVCaptureDeviceInput *newVideoInput;
        AVCaptureDevicePosition position = [[_videoInput device] position];
        
        if (position == AVCaptureDevicePositionBack)
            newVideoInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self frontCamera] error:&error];
        else if (position == AVCaptureDevicePositionFront)
            newVideoInput = [[AVCaptureDeviceInput alloc] initWithDevice:[self backCamera] error:&error];
        else
            return;
        
        if (newVideoInput != nil) {
            [self.session beginConfiguration];
            [self.session removeInput:self.videoInput];
            if ([self.session canAddInput:newVideoInput]) {
                [self.session addInput:newVideoInput];
                [self setVideoInput:newVideoInput];
            } else {
                [self.session addInput:self.videoInput];
                
            }
            [self.session commitConfiguration];
        } else if (error) {
            NSLog(@"toggle carema failed, error = %@", error);
        }
    }
}
//用来返回是前置摄像头还是后置摄像头
- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition) position {
    
    if (AVCaptureDevicePositionFront == position) {
        
        NSLog(@"前边");
        isFront = YES;
    }
    else
    {
        isFront = NO;
    }
    //返回和视频录制相关的所有默认设备
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    //遍历这些设备返回跟position相关的设备
    for (AVCaptureDevice *device in devices) {
        if ([device position] == position) {
            return device;
        }
    }
    return nil;
}
//返回前置摄像头
- (AVCaptureDevice *)frontCamera {
    return [self cameraWithPosition:AVCaptureDevicePositionFront];
}

//返回后置摄像头
- (AVCaptureDevice *)backCamera {
    return [self cameraWithPosition:AVCaptureDevicePositionBack];
}
//开启闪光灯
- (void)switchFlashLight:(id)sender {
    if (isFront == NO) {
        AVCaptureDevice *backCamera = [self backCamera];
        if (backCamera.torchMode == AVCaptureTorchModeOff) {
            [self.switchFlashLight setImage:[UIImage imageNamed:@"flash_open_n"] forState:UIControlStateNormal];

            [backCamera lockForConfiguration:nil];
            backCamera.torchMode = AVCaptureTorchModeOn;
            backCamera.flashMode = AVCaptureFlashModeOn;
            [backCamera unlockForConfiguration];
        } else {
            [self.switchFlashLight setImage:[UIImage imageNamed:@"flash_on_n"] forState:UIControlStateNormal];
            [backCamera lockForConfiguration:nil];
            backCamera.torchMode = AVCaptureTorchModeOff;
            backCamera.flashMode = AVCaptureTorchModeOff;
            [backCamera unlockForConfiguration];
        }

        
    }
    }


- (void)changeCameraAnimation {
    CATransition *changeAnimation = [CATransition animation];
    changeAnimation.delegate = self;
    changeAnimation.duration = 0.45;
    changeAnimation.type = @"oglFlip";
    changeAnimation.subtype = kCATransitionFromRight;
    changeAnimation.timingFunction = UIViewAnimationCurveEaseInOut;
    [self.previewLayer addAnimation:changeAnimation forKey:@"changeAnimation"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
