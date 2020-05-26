//
//  VideoLocationViewController.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2019/1/22.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "TanLiaoLiao_VideoLocationViewController.h"

@interface TanLiaoLiao_VideoLocationViewController ()

@end

@implementation TanLiaoLiao_VideoLocationViewController

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    
    [self stopSession];
    [self.previewLayer removeFromSuperlayer];
    self.previewLayer = nil;
    alsoInVC = NO;
    [self.player stop];
    
    NSUserDefaults * alsoQunFaWaitingDefaults = [NSUserDefaults standardUserDefaults];
    [alsoQunFaWaitingDefaults setObject:@"" forKey:@"alsoQunFaWaiting"];
    [alsoQunFaWaitingDefaults synchronize];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTabBarHidden];
    alsoInVC = YES;
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"qunFaWaiting" forKey:@"alsoQunFaWaiting"];
    [defaults synchronize];


    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    self.containerView.backgroundColor = UIColorFromRGB(0x69FFF);
    [self.view addSubview:self.containerView];
    
    UIImageView * bottomImageView = [[UIImageView alloc] initWithFrame:self.containerView.frame];
    bottomImageView.image = [UIImage imageNamed:@"btn_blue_bg"];
    [self.containerView addSubview:bottomImageView];
//
    self.dingZhuanKuaiGiftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,(VIEW_HEIGHT-VIEW_WIDTH*1334/750)/2, VIEW_WIDTH, VIEW_WIDTH*1334/750)];
    [self.containerView addSubview:self.dingZhuanKuaiGiftImageView];


    self.topGiftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20*BILI, SafeAreaTopHeight+20*BILI, 29*BILI*385/56, 29*BILI)];
    [self.containerView addSubview:self.topGiftImageView];
    
    UILabel * zhengZaiPiPeiLable = [[UILabel alloc] initWithFrame:CGRectMake(20*BILI, self.topGiftImageView.frame.origin.y+self.topGiftImageView.frame.size.height+10*BILI, 200*BILI, 18*BILI)];
    zhengZaiPiPeiLable.text = @"正在匹配中";
    zhengZaiPiPeiLable.textColor = [UIColor whiteColor];
    zhengZaiPiPeiLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:18*BILI];
    [self.containerView addSubview:zhengZaiPiPeiLable];
    
    UIButton * exitButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-49*BILI, VIEW_HEIGHT-69*BILI, 34*BILI, 54*BILI)];
    [exitButton addTarget:self action:@selector(exitButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [exitButton setBackgroundImage:[UIImage imageNamed:@"video_btn_tuichu"] forState:UIControlStateNormal];
    [self.containerView addSubview:exitButton];
    ////设置耳机声音和扬声器音
     [self initAVCaptureSession];//初始化本地摄像头界面
     [self startSession];
}
-(void)viewDidAppear:(BOOL)animated
{
    [self performSelector:@selector(loadGifImageView) withObject:nil afterDelay:0];

}
-(void)loadGifImageView
{
    NSString  *name = @"dingZhuanKuai.gif";
    NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:name ofType:nil];
    NSData  *imageData = [NSData dataWithContentsOfFile:filePath];
    self.dingZhuanKuaiGiftImageView.image = [UIImage sd_animatedGIFWithData:imageData];
    
    name = @"kuaiLiaoShiKe.gif";
    filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:name ofType:nil];
    imageData = [NSData dataWithContentsOfFile:filePath];
    self.topGiftImageView.image = [UIImage sd_animatedGIFWithData:imageData];

    [self playMusic];
    [self performSelector:@selector(suiYuan) withObject:nil afterDelay:6];

}
-(void)playMusic
{
    NSString * soudString  = [[NSBundle mainBundle] pathForResource:@"jump" ofType:@"m4a"];
    if ([soudString isKindOfClass:[NSString class]]) {
        NSURL *url = [NSURL fileURLWithPath:soudString];
        self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        self.player.numberOfLoops = 200;
        [self.player play];
    }

}
-(void)suiYuan
{
    if (alsoInVC)
    {
        NSString *versionAgent = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
        [self.cloudClient manYiJianSuiYuan:@"1225"
                                   version:versionAgent
                                   channel:@"appstore"
                                  delegate:self
                                  selector:@selector(suiYuanSuccess:)
                             errorSelector:@selector(suiYuanError:)];
    }
    
}


-(void)suiYuanSuccess:(NSDictionary *)info
{
    [self performSelector:@selector(suiYuan) withObject:nil afterDelay:6];
}
-(void)suiYuanError:(NSDictionary *)info
{
    [self performSelector:@selector(suiYuan) withObject:nil afterDelay:6];
}
-(void)exitButtonClick
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.25;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    transition.type = kCATransitionPush;
    transition.subtype  = kCATransitionFromBottom;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:NO];
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
    [self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    self.previewLayer.frame = CGRectMake(VIEW_WIDTH-115*BILI, 20*BILI+SafeAreaTopHeight,100*BILI, 150*BILI);
    [self.containerView.layer addSublayer:self.previewLayer];
 
    [self qieHuanJingTou];
    
}
-(void)qieHuanJingTou
{
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
//返回前置摄像头
- (AVCaptureDevice *)frontCamera
{
    return [self cameraWithPosition:AVCaptureDevicePositionFront];
}

//返回后置摄像头
- (AVCaptureDevice *)backCamera
{
    return [self cameraWithPosition:AVCaptureDevicePositionBack];
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
@end
