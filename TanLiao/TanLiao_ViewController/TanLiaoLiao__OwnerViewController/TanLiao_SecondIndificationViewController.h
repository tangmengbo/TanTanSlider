//
//  SecondIndificationViewController.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/1/24.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"

@interface TanLiao_SecondIndificationViewController : TanLiao_BaseViewController<RecordAudioViewControllerDelegate,RecordVideoViewControllerDelegate,AVAudioPlayerDelegate>

@property(nonatomic,strong)NSData * wlwcX879;
@property(nonatomic,strong)UILabel * iswyskW08385;
@property(nonatomic,strong)UIScrollView * zjibH780;
@property(nonatomic,strong)UIView * ozjgbdV83875;


@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;
@property(nonatomic,strong)NSDictionary * anchorRole;
@property(nonatomic,strong)UIScrollView * mainScrollView;



@property(nonatomic,strong)UILabel * videoAuthorLable;
@property(nonatomic,strong)UIImageView * videoCustImageView;



@property(nonatomic,strong)UIView * videoButtonBottom;
@property(nonatomic,strong)UIButton * videoButton;



@property(nonatomic,strong)UIButton * boFangButton;




@property(nonatomic,strong)UILabel * boFangLable;
@property(nonatomic,strong)UIButton * chongLuButton;




@property(nonatomic,strong)UILabel * chongLuLable;
@property(nonatomic,strong)UILabel * audioAuthorLable;
@property(nonatomic,strong)UIView * audioAlphBottomView;




@property(nonatomic,strong)UIView * audioBottomView;



@property(nonatomic,strong)UIButton * audioVideoButton;



@property(nonatomic,strong)UIButton * audioBoFangButton;



@property(nonatomic,strong)UILabel * audioBoFangLable;
@property(nonatomic,strong)UIButton * audioChongLuButton;


@property(nonatomic,strong)UILabel * audioChongLuLable;
@property(nonatomic,strong)UILabel * timeLengthLable;
@property(nonatomic,strong)UIImageView * videoAlsoCheckImageView;


@property(nonatomic,strong)UIImageView * audioAlsoCheckImageView;

//播放视频层

@property(nonatomic,strong)UIView * containerView;

@property(nonatomic,strong)AVPlayer * player;
@property(nonatomic,strong)AVPlayerLayer *layer;

@property(nonatomic,strong)NSURL * fileSavePath;


@property(nonatomic,strong)NSString * playName;

//录音波音器
@property(nonatomic,retain)AVAudioPlayer * audioPlayer;

@property(nonatomic,strong)UITextView * mkslhL0691;
@property(nonatomic,strong)NSData * agcuR889;
@property(nonatomic,strong)NSString * dssitP9253;
@property(nonatomic,strong)UIScrollView * abxkO300;
@property(nonatomic,strong)NSDictionary * bzlzpR4241;
@property(nonatomic,strong)NSString * tkhgaA2055;


@end
