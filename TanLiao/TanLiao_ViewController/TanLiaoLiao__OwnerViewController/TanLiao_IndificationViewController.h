//
//  IndificationViewController.h
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/17.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TanLiao_IndificationViewController : TanLiao_BaseViewController<RecordVideoViewControllerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,RecordAudioViewControllerDelegate,AVAudioPlayerDelegate>

@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;


@property(nonatomic,strong)UIImagePickerController * imagePickerController;

@property(nonatomic,strong)UIScrollView * mainScrollView;


@property(nonatomic,strong)UIScrollView * hznjV021;
@property(nonatomic,strong)NSDictionary * xxpjznS95756;
@property(nonatomic,strong)NSData * xaaiorO82875;
@property(nonatomic,strong)UIImageView * fcgsF620;
@property(nonatomic,strong)UIView * zycgH134;
@property(nonatomic,strong)UIScrollView * tszftpW28291;
@property(nonatomic,strong)UIImageView * pvcvfD0035;



@property(nonatomic,strong)TanLiaoCustomImageView * headerImageView;

@property(nonatomic,strong)UIImageView * videoCustImageView;




@property(nonatomic,strong)UIView * videoButtonBottom;

@property(nonatomic,strong)UIButton * videoButton;





@property(nonatomic,strong)UIButton * boFangButton;




@property(nonatomic,strong)UILabel * boFangLable;

@property(nonatomic,strong)UIButton * chongLuButton;


@property(nonatomic,strong)UILabel *chongLuLable;

@property(nonatomic,strong)NSURL * fileSavePath;



@property(nonatomic,strong)UITextField * sfTextField;

@property(nonatomic,strong)UITextField * checkNumberTextField;

@property(nonatomic,strong)UIImageView * videoAlsoCheckImageView;



//播放视频层

@property(nonatomic,strong)UIView * containerView;


@property(nonatomic,strong)AVPlayer * player;
@property(nonatomic,strong)AVPlayerLayer *layer;


@property(nonatomic,strong)NSString * imagePath;



@property(nonatomic,strong)NSString * videoPath;


@property(nonatomic,strong)UILabel * videoAuthorLable;
@property(nonatomic,strong)UILabel * audioAuthorLable;

@property(nonatomic,strong)UIView * audioAlphBottomView;

@property(nonatomic,strong)UIView * audioBottomView;

@property(nonatomic,strong)UITableView * tfksdbJ07408;
@property(nonatomic,strong)NSDictionary * iiodZ949;
@property(nonatomic,strong)UIView * ceivE191;
@property(nonatomic,strong)UITextView * xnuxkP2987;


@property(nonatomic,strong)UIButton * audioVideoButton;


@property(nonatomic,strong)UIButton * audioBoFangButton;

@property(nonatomic,strong)UILabel * audioBoFangLable;

@property(nonatomic,strong)UIButton * audioChongLuButton;

@property(nonatomic,strong)UILabel * audioChongLuLable;

@property(nonatomic,strong)UILabel * timeLengthLable;

@property(nonatomic,strong)UIImageView * audioAlsoCheckImageView;


@property(nonatomic,strong)NSString * playName;

//录音波音器
@property(nonatomic,retain)AVAudioPlayer* audioPlayer;

@property(nonatomic,strong)NSString * audioPath;


//身份证照片
@property(nonatomic,strong)UIImage * sfImage;
@property(nonatomic,strong)UIImageView * sfImageView;


@property(nonatomic,strong)UIButton * alsoCheckSFCardButton;


@property(nonatomic,strong)UILabel * sfPaiSheOrChognPaiLable;

@property(nonatomic,strong)NSString * alsoSFPhoto;


@end
