//
//  NTESVideoChatViewController.h
//  NIM
//
//  Created by chris on 15/5/5.
//  Copyright (c) 2015年 Netease. All rights reserved.
//

#import "NTESNetChatViewController.h"
#import <StoreKit/StoreKit.h>
@class NetCallChatInfo;
@class NTESVideoChatNetStatusView;

@interface NTESVideoChatViewController : NTESNetChatViewController<SKPaymentTransactionObserver,SKProductsRequestDelegate,UIActionSheetDelegate,UITableViewDelegate,UITableViewDataSource,YuEBuZuViewDelegate,TiaoDouViewDelegate,TiaoDouPingJiaViewDelegate,TanKuangQueRenAlertDelegate>
{
    BOOL  continueNoWifi ;
    BOOL yuErBuZu;
    BOOL ziDongGuaDuan;
    int huaFeiMoney;
    
    BOOL viewMissStatus;
    
    BOOL appPayTotast;
    
    BOOL stopMeiFenZhongKouFei;
    
    BOOL alsoQiDongTenSecondsDingShiQi;//如果推送走到10s定时器的前边就不创建10s的定时器
    
    BOOL cameraAlsoAllow;//相机权限没有打开提示一次并挂断
    
    BOOL firstCreateBigAndSmallVideo;
    
    BOOL localViewAlsoHidden;//只在刚开始的时候隐藏一次本地视频界面
    
}
//通话过程中，从语音聊天切到视频聊天
- (instancetype)initWithCallInfo:(NetCallChatInfo *)callInfo;

@property (weak, nonatomic) IBOutlet UIImageView *bigVideoView;


@property (weak, nonatomic) IBOutlet UIView *smallVideoView;

@property (nonatomic,strong) IBOutlet UIButton *hungUpBtn;   //挂断按钮

@property (nonatomic,strong) IBOutlet UIButton *acceptBtn; //接通按钮

@property (nonatomic,strong) IBOutlet UIButton *refuseBtn;   //拒接按钮

@property (nonatomic,strong) IBOutlet UILabel  *durationLabel;//通话时长

@property (nonatomic,strong) IBOutlet UIButton *muteBtn;     //静音按钮

@property (nonatomic,strong) IBOutlet UIButton *switchModelBtn; //模式转换按钮

@property (nonatomic,strong) IBOutlet UIButton *switchCameraBtn; //切换前后摄像头

@property (nonatomic,strong) IBOutlet UIButton *disableCameraBtn; //禁用摄像头按钮

@property (weak, nonatomic) IBOutlet UIButton *localRecordBtn; //录制

@property (nonatomic,strong) IBOutlet UILabel  *connectingLabel;  //等待对方接听

@property (nonatomic,strong) IBOutlet NTESVideoChatNetStatusView *netStatusView;//网络状况

@property (weak, nonatomic) IBOutlet UIView *localRecordingView;

@property (weak, nonatomic) IBOutlet UIView *localRecordingRedPoint;

@property (weak, nonatomic) IBOutlet UIView *lowMemoryView;

@property (weak, nonatomic) IBOutlet UIView *lowMemoryRedPoint;

@property(nonatomic,strong) NSString * mhtOrMy;

@property(nonatomic,strong)NSString * wxinChongZhi;

@property(nonatomic,strong)NSString * out_trade_no;

@property(nonatomic,strong)NSString * call_type;
//////////////////////////////////////语音聊天控件
@property(nonatomic,strong)UIImageView * audioBottomView;
@property(nonatomic,strong)UIView * userMessageBottomView;

@property(nonatomic,strong)UIButton * jingYinButton;
@property(nonatomic,strong)UILabel * jingYinLable;

@property(nonatomic,strong)UIButton * huJiaoGuaDuanButton;
@property(nonatomic,strong)UILabel * huJiaoGuaDuanLable;

@property(nonatomic,strong)UILabel * beiJiaoGuaDuanLable;
@property(nonatomic,strong)UILabel * beiJiaoJieTongLable;

@property(nonatomic,strong)UIButton * authorGiftButton;

//背景播放主播视频
@property(nonatomic,strong)AVPlayer * anchorAudioPlayer;
@property(nonatomic,strong)UIView * anchorVideoView;
@property(nonatomic,strong)NSString * anchorVideoUrl;

@property(nonatomic,strong)NSDictionary * anchorPingJiaInfo;

@property(nonatomic,strong)TanLiaoLiao_TiaoDouView * tiaoDouView;
@property(nonatomic,strong)TanLiaoLiao_TiaoDouPingJiaView * tiaoDouPingJiaView;
@property(nonatomic,strong)NSArray * lureList;//挑逗数据源
@property(nonatomic,strong)NSDictionary * lureInfo;
@property(nonatomic,strong)NSString * order_lure_id;

@property(nonatomic,strong)UIView * yongHuTiaoDouPingJiaAlphaView;
@property(nonatomic,strong)UIView * yongHuTiaoDouPingJiaView;
@end
