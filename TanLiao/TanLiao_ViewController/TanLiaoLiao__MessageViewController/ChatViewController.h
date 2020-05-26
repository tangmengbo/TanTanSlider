//
//  ChatViewController.h
//  FanQieSQ
//
//  Created by pfjhetg on 2017/5/9.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"

@interface ChatViewController : RCConversationViewController<UITextViewDelegate>
{
    BOOL sendMesStatus;
    
    //是否展示回拨提示
    BOOL alsoShowHuiBo;
}



@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;

@property(nonatomic,strong)NSDictionary * anchorInfo;

@property(nonatomic,strong)NSString * money;

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

@property(nonatomic,strong)NSArray * giftArray;

@property(nonatomic,strong)NSDictionary * selectGift;

@property(nonatomic,strong)RCMessageContent * messageContent;

@property(nonatomic,strong)NSString * sendMessagMoney;


@property(nonatomic,strong)RCMessage * mediaMessage;//发送图片时需要

//求礼物
@property(nonatomic,strong)UIView * qiuLiWuButtomView;
@property(nonatomic,strong)UIView * qiuLiWuView;
@property(nonatomic,strong)NSDictionary * giftInfo;
//红包图片
@property(nonatomic,strong)NSDictionary * picOrVideoInfo;
//主播呼叫弹框展示
@property(nonatomic,strong)UIView * laiDianBottomView;
@property(nonatomic,strong)UIView * laiDianView;
@property(nonatomic,strong)NSDictionary * laiDianInfo;
@property(nonatomic,strong)AVAudioPlayer * player;

//余额不足充值界面
@property(nonatomic,strong)UIView * chongZhiBottomView;
@property(nonatomic,strong)UIView * chongZhiView;
@property(nonatomic,strong)NSArray * chongZhiMoneyArray;
@property(nonatomic,strong)NSMutableArray * quanViewArray;
@property(nonatomic,strong)NSMutableArray * checkImageArray;
@property(nonatomic,strong)NSString * selectMoneyStr;

@property(nonatomic,strong)UIView * loadingBottomView;
@property(nonatomic,strong)UIView *loadingView;
@property(nonatomic,strong)NSString * out_trade_no;


@property(nonatomic,strong) NSString * mhtOrMy;

@property(nonatomic,strong)AVPlayer * voicePlayer;

@property(nonatomic,strong)UIView * playVoiceBottomView;
@property(nonatomic,strong)UIView * playVoiceContentView;
@property(nonatomic,strong)UIButton * playAndPuseButton;

@property(nonatomic,strong)NSString * alsoVip;

@property(nonatomic,strong)RCTextMessage * textMessage;
@property(nonatomic,strong)RCVoiceMessage * voiceMessage;
@end
