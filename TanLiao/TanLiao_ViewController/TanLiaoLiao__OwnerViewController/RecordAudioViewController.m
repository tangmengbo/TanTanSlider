//
//  RecordAudioViewController.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/1/23.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiao_RecordAudioViewController.h"

@interface TanLiao_RecordAudioViewController ()

@end

@implementation TanLiao_RecordAudioViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navView.hidden = YES;
    
    [self luYinQianZhunBei];
    
    self.view.backgroundColor = UIColorFromRGB(0x656565);
    
    self.redPointView = [[UIView alloc] initWithFrame:CGRectMake(318*BILI/2, 227*BILI/2, 15*BILI, 15*BILI)];
    self.redPointView.layer.masksToBounds = YES;
    self.redPointView.layer.cornerRadius = 15*BILI/2;
    self.redPointView.backgroundColor = UIColorFromRGB(0xFF7B7A);
    [self.view addSubview:self.redPointView];




    
    self.RECLable = [[UILabel alloc] initWithFrame:CGRectMake(self.redPointView.frame.origin.x+self.redPointView.frame.size.width+5*BILI, self.redPointView.frame.origin.y-1.5*BILI, 50*BILI, 18*BILI)];
    self.RECLable.textColor = UIColorFromRGB(0xFF7B7A);
    self.RECLable.font = [UIFont systemFontOfSize:18*BILI];
    self.RECLable.text = @"REC";
    [self.view addSubview:self.RECLable];



    
    self.timeLable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.RECLable.frame.origin.y+self.RECLable.frame.size.height+38*BILI, VIEW_WIDTH, 60*BILI)];
    self.timeLable.textAlignment = NSTextAlignmentCenter;
    self.timeLable.font = [UIFont systemFontOfSize:60*BILI];
    self.timeLable.textColor = [UIColor whiteColor];


 


    self.timeLable.text = @"00:00";
    [self.view addSubview:self.timeLable];



    
    UILabel* tipLable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.timeLable.frame.origin.y+self.timeLable.frame.size.height+36*BILI, VIEW_WIDTH, 15*BILI)];
    tipLable.textAlignment = NSTextAlignmentCenter;
    tipLable.font = [UIFont systemFontOfSize:15*BILI];
    tipLable.textColor =UIColorFromRGB(0xFFFFFF);
    tipLable.text = @"语音录制2分钟时长  录制时间不能少于15秒";
    tipLable.alpha = 0.7;
    [self.view addSubview:tipLable];



 

    
    self.recordAudioButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-150*BILI)/2, tipLable.frame.origin.y+tipLable.frame.size.height+40*BILI, 150*BILI, 150*BILI)];
    [self.recordAudioButton setImage:[UIImage imageNamed:@"audio_luzhi_kaishi"] forState:UIControlStateNormal];
    [self.view addSubview:self.recordAudioButton];
    [self.recordAudioButton addTarget:self action:@selector(recordAudioButtonClick) forControlEvents:UIControlEventTouchUpInside];



    
    self.tipMesLable = [[UILabel alloc] initWithFrame:CGRectMake(0, self.recordAudioButton.frame.origin.y+self.recordAudioButton.frame.size.height+15*BILI, VIEW_WIDTH, 18*BILI)];
    self.tipMesLable.textAlignment = NSTextAlignmentCenter;
    self.tipMesLable.font = [UIFont systemFontOfSize:18*BILI];
    self.tipMesLable.textColor = [UIColor whiteColor];


 

   

    self.tipMesLable.alpha = 0.7;
    self.tipMesLable.text = @"点击开始录音";
    [self.view addSubview:self.tipMesLable];



 

    
    UIButton * closeButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-40*BILI)/2, VIEW_HEIGHT- 80*BILI, 40*BILI, 40*BILI)];
    [closeButton setImage:[UIImage imageNamed:@"audio_yuyin_close"] forState:UIControlStateNormal];
    [self.view addSubview:closeButton];
    [closeButton addTarget:self action:@selector(closeButtonClick) forControlEvents:UIControlEventTouchUpInside];



}
//录音前准备录音设置和存储路径
-(void)luYinQianZhunBei
{
    luYinTime = 0;
    //录音权限处理
    [self canRecord];
    //录音设置
    self. recorderSettingsDict =[[NSDictionary alloc] initWithObjectsAndKeys:
                                 [NSNumber numberWithInt:kAudioFormatMPEG4AAC],AVFormatIDKey,
                                 [NSNumber numberWithInt:1000.0],AVSampleRateKey,
                                 [NSNumber numberWithInt:2],AVNumberOfChannelsKey,
                                 [NSNumber numberWithInt:8],AVLinearPCMBitDepthKey,
                                 [NSNumber numberWithBool:NO],AVLinearPCMIsBigEndianKey,
                                 [NSNumber numberWithBool:NO],AVLinearPCMIsFloatKey,
                                 nil];
    
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    self.playName = [NSString stringWithFormat:@"%@/play.aac",docDir];


 


}
//判断是否允许使用麦克风7.0新增的方法requestRecordPermission
-(void)canRecord
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    int flag;
    switch (authStatus) {
        case AVAuthorizationStatusNotDetermined:
            //没有询问是否开启麦克风
            flag = 1;
            break;
        case AVAuthorizationStatusRestricted:
            //未授权，家长限制
            flag = 0;
            break;
        case AVAuthorizationStatusDenied:
            //玩家未授权
            flag = 0;
            break;
        case AVAuthorizationStatusAuthorized:
            //玩家授权
            flag = 2;
            break;
        default:
            break;
    }
    if (flag==2) {
        
        self.maiKeFengQuanXianStatus = @"2";
    }
    else if(flag==1)
    {
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];



        [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
            if (granted) {
                self.maiKeFengQuanXianStatus = @"2";
                return  YES;
            }
            else {
                self.maiKeFengQuanXianStatus = @"0";
                return NO;
            }
        }];
    }
    else
    {
        [Common showAlert:@"麦克风权限未打开" message:@"请在设置中打开麦克风权限"];
    }
    
}
-(void)recordAudioButtonClick
{
    if ([@"点击开始录音" isEqualToString:self.tipMesLable.text]) {
     
        [self startRecordVoice];


 

    }
    else
    {
        [self stopRecordVoice];



    }
}


-(void)startRecordVoice
{
    if ([@"2" isEqualToString:self.maiKeFengQuanXianStatus]) {
        
        AVAudioSession *session = [AVAudioSession sharedInstance];


 

        NSError *sessionError;
        //AVAudioSessionCategoryPlayAndRecord用于录音和播放
        [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];



        if(session == nil)
            NSLog(@"Error creating session: %@", [sessionError description]);
        else
            [session setActive:YES error:nil];
        /*****每次录音前得重新设置 这一段设置声音从扬声器和耳机出来***/
        UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
        AudioSessionSetProperty (
                                 kAudioSessionProperty_OverrideAudioRoute,
                                 sizeof (audioRouteOverride),
                                 &audioRouteOverride
                                 );
        /*****这一段设置声音从扬声器出来***/
        luYinTime = 0;
        [self.recordAudioButton setImage:[UIImage imageNamed:@"audio_luzhi_wancheng"] forState:UIControlStateNormal];
        self.tipMesLable.text = @"点击完成录音";
        
        NSError *error = nil;
        //必须真机上测试,模拟器上可能会崩溃
        self.recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL URLWithString:self.playName] settings:self.recorderSettingsDict error:&error];




        
        if (self.recorder) {
            self.recorder.meteringEnabled = YES;
            [self.recorder prepareToRecord];
            [self.recorder record];
            
            //启动定时器
            self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(levelTimer) userInfo:nil repeats:YES];
            
        } else
        {
            int errorCode = CFSwapInt32HostToBig ([error code]);
            NSLog(@"Error: %@ [%4.4s])" , [error localizedDescription], (char*)&errorCode);
            
        }
    }
    else
    {
        [Common showAlert:@"麦克风权限未打开" message:@"请在设置中打开探聊的麦克风访问权限"];
    }
}
-(void)levelTimer
{
    luYinTime = luYinTime+0.1;
    int timeSeconds = luYinTime*10;

    if (timeSeconds%6==0)
    {
        self.redPointView.hidden = NO;
        self.RECLable.hidden = NO;
    }
    else
    {
        self.redPointView.hidden = YES;
        self.RECLable.hidden = YES;
    }
    if (timeSeconds/10<=9) {
        
        self.timeLable.text = [NSString stringWithFormat:@"00:0%d",timeSeconds/10];
    }
    if (timeSeconds/10>=10&&timeSeconds/10<60) {
        
         self.timeLable.text = [NSString stringWithFormat:@"00:%.0f",luYinTime];



        
    }
    if (timeSeconds/10>=60&&(timeSeconds/10)%60<10) {
        
         self.timeLable.text = [NSString stringWithFormat:@"0%d:0%d",(timeSeconds/10)/60,(timeSeconds/10)%60];
    }
    if ((timeSeconds/10)>=60&&(timeSeconds/10)%60>=10) {
        
        self.timeLable.text = [NSString stringWithFormat:@"0%d:%d",(timeSeconds/10)/60,(timeSeconds/10)%60];
    }
    if (luYinTime>=120) {
        
        self.timeLable.text = [NSString stringWithFormat:@"02:00"];
        [self stopRecordAndTimer];


   

        [Common showToastView:@"录音最长120秒" view:self.view];


 
if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
{
    UIView * kqjdtrY29442 = [[UIView alloc]initWithFrame:CGRectMake(26,93,88,72)];
    kqjdtrY29442.layer.cornerRadius =8;
    kqjdtrY29442.userInteractionEnabled = YES;
    kqjdtrY29442.layer.masksToBounds = YES;
    UITableView * wzkpxU4076 = [[UITableView alloc]initWithFrame:CGRectMake(100,61,28,8)];
    wzkpxU4076.layer.cornerRadius =8;
    wzkpxU4076.userInteractionEnabled = YES;
    wzkpxU4076.layer.masksToBounds = YES;
    
    UILabel * gutdM341 = [[UILabel alloc]initWithFrame:CGRectMake(47,100,40,24)];
    gutdM341.layer.cornerRadius =5;
    gutdM341.userInteractionEnabled = YES;
    gutdM341.layer.masksToBounds = YES;
    
    UIImageView * bzvdekQ40326 = [[UIImageView alloc]initWithFrame:CGRectMake(39,46,57,79)];
    bzvdekQ40326.backgroundColor = [UIColor whiteColor];
    bzvdekQ40326.layer.borderColor = [[UIColor greenColor] CGColor];
    bzvdekQ40326.layer.cornerRadius =5;

  UIImageView * tgiaaJ5587 = [[UIImageView alloc]initWithFrame:CGRectMake(94,9,99,35)];
  tgiaaJ5587.layer.borderWidth = 1;
  tgiaaJ5587.clipsToBounds = YES;
  tgiaaJ5587.layer.cornerRadius =8;
}
 

    }
}


-(void)stopRecordVoice
{
    if(luYinTime<15)
    {
        [Common showToastView:@"录音时长不能少于15秒,请重新录制" view:self.view];



 

        [self.recordAudioButton setImage:[UIImage imageNamed:@"audio_luzhi_kaishi"] forState:UIControlStateNormal];
        self.tipMesLable.text = @"点击开始录音";
        self.timeLable.text = @"00:00";
        [self stopRecordAndTimer];


 

   

        
    }
    else
    {
        
        [self stopRecordAndTimer];


        
        [self.delegate recordAudioFinish:self.playName timeLength:(int)luYinTime];




        [self.navigationController popViewControllerAnimated:YES];
        
    }
}

-(void)stopRecordAndTimer
{
    //录音停止
    [self.recorder stop];
    self.recorder = nil;
    //结束定时器
    [self.timer invalidate];


 

    self.timer = nil;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self stopRecordAndTimer];




}
-(void)closeButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
