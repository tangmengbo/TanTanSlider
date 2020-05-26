//
//  NTESNetChatViewController.h
//  NIM
//
//  Created by chris on 15/5/18.
//  Copyright (c) 2015年 Netease. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NTESTimerHolder.h"
#import "NTESRecordSelectView.h"
#import <NIMSDK/NIMSDK.h>
#import <NIMAVChat/NIMAVChat.h>
#import "HTTPModel.h"

@class NetCallChatInfo;
@class AVAudioPlayer;

#define dispatch_async_main_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}


@interface NTESNetChatViewController : TanLiao_BaseViewController<NIMNetCallManagerDelegate,NTESTimerHolderDelegate,NTESRecordSelectViewDelegate>
{
    BOOL alsoSelectBeauty;
    
    BOOL hangUpTiJiaoSuccessStatus;
    
    int netWorkQuality;
}


@property (nonatomic,strong) NetCallChatInfo *callInfo;

@property (nonatomic,strong) AVAudioPlayer *player; //播放提示音

@property (nonatomic, strong) NSString *peerUid;


//faceBeauty美颜
@property (nonatomic, strong) AVSampleBufferDisplayLayer *bufferDisplayer;

//主叫方是自己，发起通话，初始化方法
- (instancetype)initWithCallee:(NSString *)callee;
//被叫方是自己，接听界面，初始化方法
- (instancetype)initWithCaller:(NSString *)caller
                        callId:(uint64_t)callID;



//主叫方开始界面回调
- (void)startByCaller;
//被叫方开始界面回调
- (void)startByCallee;
//同意后正在进入聊天界面
- (void)waitForConnectiong;
//双方开始通话
- (void)onCalling;
//挂断
- (void)hangup;
//接受/拒接通话
- (void)response:(BOOL)accept;
//退出界面
- (void)dismiss:(void (^)(void))completion;

//开始语音对话录制
- (BOOL)startAudioRecording;
//开始本地录制
- (BOOL)startLocalRecording;
//开始对方录制
- (BOOL)startOtherSideRecording;
//结束语音对话录制
-(void)stopAudioRecording;
//结束本地录制
- (BOOL)stopLocalRecording;
//结束对方录制
- (BOOL)stopOtherSideRecording;
//结束所有录制任务
- (void)stopRecordTaskWithVideo:(BOOL)isVideo;
//所有录制是否结束
- (BOOL)allRecordsStopped;

//低空间警告
- (void)udpateLowSpaceWarning:(BOOL)show;

//选择类型进行录制
- (void)recordWithAudioConversation:(BOOL)audioConversationOn myMedia:(BOOL)myMediaOn otherSideMedia:(BOOL)otherSideMediaOn video:(BOOL)isVideo;

//显示录制选择框
-(void)showRecordSelectView:(BOOL)isVideo;

//滤镜值
@property(nonatomic,strong)NSString * lvJing;

#pragma mark - Ring
//铃声 - 正在呼叫请稍后
- (void)playConnnetRing;
//铃声 - 对方暂时无法接听
- (void)playHangUpRing;
//铃声 - 对方正在通话中
- (void)playOnCallRing;
//铃声 - 对方无人接听
- (void)playTimeoutRing;
//铃声 - 接收方铃声
- (void)playReceiverRing;
//铃声 - 拨打方铃声
- (void)playSenderRing;

@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;

///////////////////////////////////new add

@property(nonatomic,strong)NSString * yuEStr;

@property(nonatomic,strong)NSString * userOrderId;

@property(nonatomic,strong)NSString * anchorOrderId;

@property(nonatomic,strong)NSString * brokerOrderId;

@property(nonatomic,strong)NSString * officialOrderId;

@property(nonatomic,strong)NSString * price;

@property(nonatomic,strong)NSArray * giftArray;

@property(nonatomic,strong)NSDictionary * selectGift;

@property(nonatomic,strong)NSString * huJiaoOrJieShou;

@property(nonatomic,strong)NSString  * money;

//赠送礼物

@property(nonatomic,strong)UIImageView * flashGiftImageView;

@property(nonatomic,strong)UIButton * button;

//等待接听时

//关闭摄像头时的背景
@property(nonatomic,strong)UIView * noCameraBottomView;

//被叫头像
@property(nonatomic,strong) TanLiaoCustomImageView * beiJiaoHeaderImageView;

//被叫name
@property(nonatomic,strong) UILabel * beiJiaoNameLable;

//电话图片
@property(nonatomic,strong)UIImageView * beiJiaoTelImageView;

//等待接通lable
@property(nonatomic,strong)UILabel * beiJiaoTipLable;

//协议背景
@property(nonatomic,strong)UIView * agreementBottomView;

//协议文字lable
@property(nonatomic,strong)UILabel * agreementTipLable;

//打开或关闭摄像头button
@property(nonatomic,strong)UIButton * openOrCloseCameraButton;

//打开或关闭摄像头Lable
@property(nonatomic,strong)UILabel * openOrCloseCameraLable;
//取消通话button
@property(nonatomic,strong)UIButton * quXiaoButton;

@property(nonatomic,strong)UILabel * quXiaoLable;

//视频通话中

//关闭视频
@property(nonatomic,strong)UIButton * closeShiPinButton;


//记录时间底背景
@property(nonatomic,strong)UIButton * shiChangLableBottom;

//记录时间
@property(nonatomic,strong)UILabel * shiChangLable;


//记录所花金币底背景
@property(nonatomic,strong)UIButton * jinBiLableBottom;
//记录所花金币
@property(nonatomic,strong)UILabel * jinBiLable;

@property(nonatomic,strong)UIView * chatTextFieldBottomView;
@property(nonatomic,strong)UITextField * chatTextField;
@property(nonatomic,strong)UIButton * faSongButton;
//聊天按钮
@property(nonatomic,strong)UIButton * sendMessageButton;


//静音
@property(nonatomic,strong)UIButton * openOrCloseVoiceButton;

//切换镜头
@property(nonatomic,strong)UIButton * qieHuanJingTouButton;

//打开关闭摄像头
@property(nonatomic,strong)UIButton * guanBiDaKaiCameraButton;

//充钱
@property(nonatomic,strong)UIButton * chongZhiBUtton;

//送礼
@property(nonatomic,strong)UIButton * songLiButton;

//互动挑逗button
@property(nonatomic,strong)UIButton * huDongButton;


//没有wifi时的界面

@property(nonatomic,strong)UIView * noWifiView;

//充值界面

@property(nonatomic,strong)UIView * chongZhiView;
//金额选项button数组
@property(nonatomic,strong)NSMutableArray * buttonArray;
//充值金额lable
@property(nonatomic,strong)UILabel * chongZhiJinErLable;
//充值界面关闭按钮
@property(nonatomic,strong)UIButton * closeChongZhiViewButton;
//充值金额
@property(nonatomic,strong)NSString * chongZhiMoney;

//打赏界面
@property(nonatomic,strong)UIScrollView * daShangView;
//打赏界面的半透明背景
@property(nonatomic,strong)UIView * daShangBottomView;
//打赏界面的底部放按钮界面
@property(nonatomic,strong)UIView * daShangBottomButtonView;
//打赏界面的金币Lable
@property(nonatomic,strong)UILabel *daShangViewJinBiLable;
//打赏界面关闭按钮
@property(nonatomic,strong)UIButton * closeDaShangViewButton;
//礼物数组
@property(nonatomic,strong)NSMutableArray * liWuButtonArray;



////被呼叫界面

@property(nonatomic,strong)UIButton * jieShouButton;

@property(nonatomic,strong)UIButton * jvJueButtn;

//appPay

@property(nonatomic,strong)NSString * productID;
@property(nonatomic,strong)NSArray * productIDArray;

//
@property(nonatomic,strong) NSThread* myThread;

@property(nonatomic,strong)NSTimer * meiFenZhongKouFeiTimer;

//主播端判断是否扣费成功

@property(nonatomic,strong)NSTimer * anchorAlsoKoFeiSuccessTimer;

//扣费异常弹出框
@property(nonatomic,strong)UIView * kouFeiFailureView;

@property(nonatomic,strong)NSMutableArray * moneyList;


@property(nonatomic,strong)NSString * hangUpType;

@property(nonatomic,strong)UIView * bigAndSmallBottomView;
@property(nonatomic,strong)UIView * bigAndSmallView;

//是否是从群发界面来的
@property(nonatomic,strong)NSString * alsoPopRoot;

//音频还是视频
@property(nonatomic,strong)NSString * videoOrAudio;

//视频中聊天展示的tableView
@property(nonatomic,strong)UITableView * chatTableView;
@property(nonatomic,strong)NSMutableArray * chatSourceArray;

@property(nonatomic,strong)NSArray * shieldArr;

@property(nonatomic,strong)NSMutableArray * allGiftListArray;
@property(nonatomic,strong)NSString * animationAlsoFisish;
@end
