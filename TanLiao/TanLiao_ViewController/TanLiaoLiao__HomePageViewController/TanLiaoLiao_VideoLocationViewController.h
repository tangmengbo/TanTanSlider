//
//  VideoLocationViewController.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2019/1/22.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"
#import "UIImage+GIF.h"

NS_ASSUME_NONNULL_BEGIN

@interface TanLiaoLiao_VideoLocationViewController : TanLiao_BaseViewController
{
    BOOL isFront;
    BOOL alsoInVC;
}
@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;
@property(nonatomic,strong)UIView * containerView;
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

@property (nonatomic, strong,nullable) AVCaptureVideoPreviewLayer* previewLayer;

@property (nonatomic, strong) AVCaptureVideoPreviewLayer* smallPreviewLayer;

/**
 *  视频输出流
 */
@property(nonatomic,strong)AVCaptureMovieFileOutput *movieFileOutput;


@property(nonatomic,strong)UIImageView * dingZhuanKuaiGiftImageView;
@property(nonatomic,strong)UIImageView * topGiftImageView;


@property (nonatomic, strong)AVAudioPlayer *player;//播放声音


@end

NS_ASSUME_NONNULL_END
