//
//  RecordVideoViewController.h
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/17.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "RAFileManager.h"
#define TIMER_INTERVAL 0.1
#define VIDEO_RECORDER_MAX_TIME 20 //视频最大时长 (单位/秒)
#define VIDEO_RECORDER_MIN_TIME 5  //最短视频时长 (单位/秒)

@protocol RecordVideoViewControllerDelegate
@required

- (void)recordVideoFinish:(NSURL *)videoUrl videoCutImage:(UIImage *)image ;
@end

@interface TanLiao_RecordVideoViewController : TanLiao_BaseViewController<AVCaptureFileOutputRecordingDelegate>
{
    //时间长度
    float timeLength;
    //是否录制
    BOOL startOrStopRecordVideo;
    //摄像头是前置还是后置
    BOOL isFront;
    
}


@property (nonatomic, assign) id<RecordVideoViewControllerDelegate> delegate;


@property (nonatomic) dispatch_queue_t sessionQueue;
/**
 *  AVCaptureSession对象来执行输入设备和输出设备之间的数据传递
 */
@property (nonatomic, strong) AVCaptureSession* session;
/**
 *  视频输入设备
 */
@property (nonatomic, strong) AVCaptureDeviceInput* videoInput;
/**
 *  声音输入
 */
@property (nonatomic, strong) AVCaptureDeviceInput* audioInput;
/**
 *  视频输出流
 */
@property(nonatomic,strong)AVCaptureMovieFileOutput *movieFileOutput;
/**
 *  预览图层
 */
@property (nonatomic, strong) AVCaptureVideoPreviewLayer* previewLayer;

@property (strong, nonatomic) AVCaptureDeviceInput       *backCameraInput;//后置摄像头输入
@property (strong, nonatomic) AVCaptureDeviceInput       *frontCameraInput;//前置摄像头输入

@property (nonatomic,strong)UIButton * switchFlashLight;


/**
 *  记录录制时间
 */
@property (nonatomic,strong)UIButton * beginAndStopRecordButton;

@property (nonatomic, strong)NSTimer* timer;

@property (nonatomic,strong)UILabel * timeLable;

@property (nonatomic,strong)NSURL * fileSavePath;

@property (nonatomic,strong)UIImage * videoCutImage;

@property (nonatomic,strong)MPMoviePlayerController * player;

@property (nonatomic,strong)UIButton * choseVideoButton;

@property (nonatomic,strong)UIView * progressView;

@end
