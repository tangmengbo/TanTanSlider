//
//  TaskSystemViewController.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2017/12/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"
#import "TZImagePickerController.h"
#import "LLImagePickerManager.h"
#import "LLImagePickerModel.h"


@interface TanLiaoLiao_TaskSystemViewController : TanLiao_BaseViewController<TZImagePickerControllerDelegate>
{
    float luYinTime;//录音的时长
    
    ////视频图片上传最多可选的数量
    int maxImageSelected;

}



@property(nonatomic,strong)NSDictionary * zowisH2491;
@property(nonatomic,strong)NSDictionary * ezenvM8066;
@property(nonatomic,strong)NSString * olnotpJ93643;
@property(nonatomic,strong)NSString * pawotU1293;
@property(nonatomic,strong)NSDictionary * ewfrbX6185;


@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;

@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)UIView * renWuBottomView;

@property(nonatomic,strong)UIView * qunFaBottomView;

@property(nonatomic,strong)UILabel * jinRiJiangLiLable;

@property(nonatomic,strong)UILabel * weiLingQuJiangLiLable;

@property(nonatomic,strong)NSDictionary * messageInfo;

/****录音和播放*****/
//录音存放地址
@property(nonatomic,strong)NSString *playName;
//录音设置
@property(nonatomic,strong) NSDictionary *recorderSettingsDict;
//录音器
@property(nonatomic,strong)AVAudioRecorder *recorder;
//录音波音器
@property(nonatomic,strong)AVAudioPlayer* player;
//录音计时器
@property(nonatomic,strong)NSTimer * timer;
//录音的数据
@property(nonatomic,strong)NSData * voiceData ;
//2 用户给权限 0 没有给权限
@property(nonatomic,strong)NSString * maiKeFengQuanXianStatus;

/*****选择视频和图片上传*****/
@property(nonatomic,strong)LLImagePickerModel * mediaModel;

//选择上传视频或图片或语音或礼物的背景蒙层
@property(nonatomic,strong)UIView * bottomMengCengView;



//选择上传视频或图片或语音或礼物的内容界面
@property(nonatomic,strong)UIView * qunFaContentView;



@property(nonatomic,strong)UIButton * selectPhotoOrVideoButton;



@property(nonatomic,strong)UILabel * selectOrSelectAgainTipLable;
@property(nonatomic,strong)UIImageView * videoImageView;



@property(nonatomic,strong)NSArray * giftArray;



@property(nonatomic,strong)NSMutableArray * nameLableArray;



@property(nonatomic,strong)NSMutableArray * priceLableArray;




@property(nonatomic,strong)UIImageView * giftSelectImageView;




@property(nonatomic,strong)NSDictionary * selectGiftDic;


@property(nonatomic,strong)NSDictionary * suoYaoInfo;





@property(nonatomic,strong)UIButton * recordVoiceButton;



@property(nonatomic,strong)UILabel * recoradVoiceStatusLable;
@property(nonatomic,strong)UIButton * uploadVoiceButton;



@property(nonatomic,strong)UILabel * timeLengthLable;
@property(nonatomic,strong)UIButton * zhengZaiLuYinOrChongXinLuYinButton;




@property(nonatomic,strong)UIView * greenPointView;




@property(nonatomic,strong)UIImageView * boDongImageView;



@end
