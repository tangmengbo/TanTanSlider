//
//  RecordAudioViewController.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/1/23.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"
@protocol RecordAudioViewControllerDelegate
@required

- (void)recordAudioFinish:(NSString *)audioUrl timeLength:(int)timeLength;

@end
@interface TanLiao_RecordAudioViewController : TanLiao_BaseViewController
{
    float luYinTime;
}
@property (nonatomic, assign) id<RecordAudioViewControllerDelegate> delegate;


@property(nonatomic,strong)UIView * redPointView;


@property(nonatomic,strong)UITextView * wvrpdlR23550;
@property(nonatomic,strong)UILabel * lgfvvmO84700;
@property(nonatomic,strong)UITableView * toyfqC5021;


@property(nonatomic,strong)UILabel * RECLable;
@property(nonatomic,strong)UILabel * timeLable;

@property(nonatomic,strong)UIButton * recordAudioButton;



@property(nonatomic,strong)UILabel * tipMesLable;

@property(nonatomic,strong)NSDictionary * recorderSettingsDict;
@property(nonatomic,strong)NSString * playName;
@property(nonatomic,strong)NSString * maiKeFengQuanXianStatus;


//录音器
@property(nonatomic,strong)AVAudioRecorder *recorder;

@property(nonatomic,strong)NSTimer * timer;



@end
