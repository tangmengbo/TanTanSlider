//
//  BoFangShiPinViewController.h
//  ZhangYu
//
//  Created by 周璟琳 on 2017/6/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "TanLiaoLiao_ShiPinXiuPingLunTableViewCell.h"
#import "TanLiaoLiao_NewShiPinXiuPingLunTableViewCell.h"

@protocol BoFangShiPinViewControllerDelegate
@optional

- (void)boFangShiPinFinished:(NSDictionary *)info ;
@end

@class AVAudioPlayer;


@interface KuaiLiao_BoFangShiPinViewController : TanLiao_BaseViewController<UIActionSheetDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,ShiPinXiuPingLunTableViewCellDelegate,NewShiPinXiuPingLunTableViewCellDelegate,YuEBuZuViewDelegate>
{
    int waitingTime;
    int endTime;
    
    BOOL alsoPlay;

    BOOL canRefresh;



    
}

@property(nonatomic,strong)NSMutableArray * sourceArray;


@property(nonatomic,strong)UIImageView * gfrwuH9241;
@property(nonatomic,strong)UIScrollView * edtkL625;
@property(nonatomic,strong)NSString * neohR724;
@property(nonatomic,strong)NSString * byljwF1149;
@property(nonatomic,strong)UIView * rjslbuP58230;
@property(nonatomic,strong)UITableView * vhzcL846;




@property(nonatomic,strong)NSString * indexStr;

@property(nonatomic,strong)NSString * pageIndexStr;

@property(nonatomic,strong)NSString * fromWhere;

@property (nonatomic, assign) id<BoFangShiPinViewControllerDelegate> delegate;



@property (nonatomic,strong) AVAudioPlayer * avAudioPlayer; //播放提示音

@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;


@property(nonatomic,strong)NSDictionary * videoInfo;





@property(nonatomic,strong)NSString * yuEr;


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

@property (nonatomic, strong) AVCaptureVideoPreviewLayer* previewLayer;

@property (nonatomic, strong) AVCaptureVideoPreviewLayer* smallPreviewLayer;

/**
 *  视频输出流
 */
@property(nonatomic,strong)AVCaptureMovieFileOutput *movieFileOutput;


@property(nonatomic,strong)NSMutableDictionary * anchorInfo;






@property(nonatomic,strong)NSString * likeStatus;

@property(nonatomic,strong)UIImageView * guanZhuImageView;





@property(nonatomic,strong)UILabel * pingLunNumberLable;

@property(nonatomic,strong)UILabel * dianZanNumberLable;

@property(nonatomic,strong)UIView * pingLunTextFieldBottomView;



@property(nonatomic,strong)UITextField * pingLunTextField;

@property(nonatomic,strong)UIButton * dianZanButton;





@property(nonatomic,strong)UITableView * pingLunTableView;



@property(nonatomic,strong)NSArray * commitList;

@property(nonatomic,strong) NSString * mhtOrMy;


@property(nonatomic,strong)NSString * out_trade_no;


@property(nonatomic,strong)UIView * introduceBottomView;





@property(nonatomic,strong)UIImageView * introduceImageView;




@property(nonatomic,strong)UIButton * introduceButton;



@property(nonatomic,strong) TanLiaoCustomImageView * bottomView;


@property(nonatomic,strong) UIButton * kouJinBiButton;

@property(nonatomic,strong) UIButton * kaiTongVipButton;

@end
