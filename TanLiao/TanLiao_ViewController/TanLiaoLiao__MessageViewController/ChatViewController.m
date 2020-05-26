//
//  ChatViewController.m
//  FanQieSQ
//
//  Created by pfjhetg on 2017/5/9.
//  Copyright © 2017年 mac. All rights reserved.
//
#import "ChatViewController.h"
#import "ChatImageMessageCell.h"
#import "FQSQ_ChatImageMessage.h"
#import "FQSQ_ChatVideoMessageCell.h"
#import "ChatVideoMessage.h"
#import "ChatVoiceMessageCell.h"
#import "FQSQ_ChatVoiceMessage.h"
#import "ChatCallVideoMessage.h"
#import "ChatCallVideoMessageCell.h"
#import "FQSQ_ChatSendGiftMessage.h"
#import "ChatSendGiftMessageCell.h"
#import "FQSQ_ChatBusinessCardMessage.h"
#import "ChatBusinessCardMessageCell.h"
#import "ChatGroupGiftMsgMessage.h"
#import "GroupGiftMessageViewCell.h"
#import "NTESVideoChatViewController.h"
#import "ContactMessageCell.h"

#import "MWPhotoBrowser.h"

@interface ChatViewController () {
    RCUploadMediaStatusListener *currentuploadListener;
    NSArray *shieldArr;
}

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [RCIM sharedRCIM].currentUserInfo = [[RCUserInfo alloc] initWithUserId:[TanLiao_Common getNowUserID] name:[TanLiao_Common getCurrentUserName] portrait:[TanLiao_Common getCurrentAvatarpath]];
    
    
    if([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]]) {
        
        UIButton * rightButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-40-10, 20, 50, 40)];
        [rightButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        rightButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [rightButton setTitle:@"举报" forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
        self.navigationItem.rightBarButtonItem = menuButton;

    }
    else
    {
        
    }
    
     [self registerClass:[ChatImageMessageCell class] forMessageClass:[FQSQ_ChatImageMessage class]];
     [self registerClass:[FQSQ_ChatVideoMessageCell class] forMessageClass:[ChatVideoMessage class]];
     [self registerClass:[ChatVoiceMessageCell class] forMessageClass:[FQSQ_ChatVoiceMessage class]];
    [self registerClass:[ChatCallVideoMessageCell class] forMessageClass:[ChatCallVideoMessage class]];
    [self registerClass:[ChatSendGiftMessageCell class] forMessageClass:[FQSQ_ChatSendGiftMessage class]];
     [self registerClass:[ChatBusinessCardMessageCell class] forMessageClass:[FQSQ_ChatBusinessCardMessage class]];
     [self registerClass:[GroupGiftMessageViewCell class] forMessageClass:[ChatGroupGiftMsgMessage class]];
    [self registerClass:[ContactMessageCell class] forMessageClass:[ContactMessage class]];
    
    shieldArr = [NSArray arrayWithObjects: @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0", @"WeChat", @"vx",
                 @"VX", @"weixin", @"a", @"b", @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k", @"l", @"m", @"n", @"o", @"p",
                 @"q", @"r", @"s", @"t", @"u", @"v", @"w", @"x", @"y", @"z", nil];
    
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];
    [self.cloudClient getAnchorDetailMes:self.targetId
                                            apiId:user_detail_info
                                         delegate:self
                                         selector:@selector(getAnchorMesSuccess:)
                                    errorSelector:@selector(getAnchorMesError:)];
    
   
    [self.cloudClient getGiftList:@"8019"
                         delegate:self
                         selector:@selector(getGiftListSuccess:)
                    errorSelector:@selector(getGiftListError:)];
    
    [self getUserInformation];
    

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedGiftNotification:) name:ReceivedGiftNotification object:nil];
    //主播呼叫弹框
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showZhuBoHuJiaoView:) name:ZhuBoHuJiaoNotification object:nil];
    
    
    self.chatSessionInputBarControl.inputTextView.delegate = self;
    //创建顶部风险提示
    
    if(![@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
    {
        [self initFengXianView];
    }
    //获取用户是否是vip
    [self.cloudClient getVIPDetailMessage:@"8903"
                                 delegate:self
                                 selector:@selector(getVipMessageSuccess:)
                            errorSelector:@selector(getVipMessageError:)];
}
//当输入空中内容变化时
- (void)inputTextView:(UITextView *)inputTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    /*
   if([@"vip" isEqualToString:self.alsoVip])
   {
       
   }else
   {
       UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"开通vip才能和主播私聊哦~" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"去开通 ", nil];
       alert.tag = 1001;
       alert.delegate = self;
       [alert show];
       self.chatSessionInputBarControl.inputTextView.text = nil;
       [self.chatSessionInputBarControl.inputTextView resignFirstResponder];
   }
     */
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0)
    {
        
    }
    else
    {
        TanLiao_VipViewController * vipVC = [[TanLiao_VipViewController alloc] init];
        [self.navigationController pushViewController:vipVC animated:YES];
    }
}
-(void)getVipMessageSuccess:(NSDictionary *)info
{
    if ([@"true" isEqualToString:[info objectForKey:@"isVip"]])
    {
        
        self.alsoVip = @"vip";
    }
    else
    {
        self.alsoVip = @"";
        
    }
}
-(void)getVipMessageError:(NSDictionary *)info
{
    
}
-(void)initFengXianView
{
    self.conversationMessageCollectionView.frame = CGRectMake(self.conversationMessageCollectionView.frame.origin.x, self.conversationMessageCollectionView.frame.origin.y+50, self.conversationMessageCollectionView.frame.size.width, self.conversationMessageCollectionView.frame.size.height-50);
    
    UIView * fengXianTipView = [[UIView alloc] initWithFrame:CGRectMake(0, 44+SafeAreaTopHeight, VIEW_WIDTH, 22*BILI)];
    fengXianTipView.backgroundColor = UIColorFromRGB(0xFECB39);
    [self.view addSubview:fengXianTipView];
    
    if(SafeAreaTopHeight==35)//适配iphoneX
    {
        fengXianTipView.frame = CGRectMake(0, 44+45, VIEW_WIDTH, 22*BILI);
    }
    
    UIImageView * tanHaoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5*BILI, 5*BILI, 12*BILI, 12*BILI)];
    tanHaoImageView.image = [UIImage imageNamed:@"icon_jinggao"];
    [fengXianTipView addSubview:tanHaoImageView];
    
    UILabel * fengXianTipLable1 = [[UILabel alloc] initWithFrame:CGRectMake(tanHaoImageView.frame.origin.x+tanHaoImageView.frame.size.width+5*BILI, 0, 68*BILI, 22*BILI)];
    fengXianTipLable1.textColor = UIColorFromRGB(0xFF3232);
    fengXianTipLable1.font = [UIFont systemFontOfSize:12*BILI];
    fengXianTipLable1.text = @"风险提示：";
    [fengXianTipView addSubview:fengXianTipLable1];
    
    UILabel * fengXianTipLable2 = [[UILabel alloc] initWithFrame:CGRectMake(fengXianTipLable1.frame.origin.x+fengXianTipLable1.frame.size.width, 0, VIEW_WIDTH-(fengXianTipLable1.frame.origin.x+fengXianTipLable1.frame.size.width+16*BILI), 22*BILI)];
    fengXianTipLable2.textColor = [UIColor blackColor];
    fengXianTipLable2.font = [UIFont systemFontOfSize:12*BILI];
    fengXianTipLable2.text = @"要求加微信,QQ,代充金币等全部属诈骗行为，请举报";
    fengXianTipLable2.adjustsFontSizeToFitWidth = YES;
    [fengXianTipView addSubview:fengXianTipLable2];

}
-(void)getUserInformation
{
    [self.cloudClient getUserInformation:@"8029"
                                delegate:self
                                selector:@selector(getUserInformationSuccess:)
                           errorSelector:@selector(getUserInformationError:)];
}
-(void)showZhuBoHuJiaoView:(NSNotification *)notification
{
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        
        UIApplicationState state = [UIApplication sharedApplication].applicationState;
        BOOL result = (state == UIApplicationStateActive);
        BOOL result1 = (state == UIApplicationStateBackground);
        if (result) {
            
            if (!alsoShowHuiBo) {
                alsoShowHuiBo = YES;
                
                NSDictionary * info = [notification object];
                [self initLaiDianView:info];
                NSURL *url = [[NSBundle mainBundle] URLForResource:@"wx" withExtension:@"mp3"];
                self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
                self.player.numberOfLoops = 200;
                [self.player play];
            }
        }
        if (result1) {
            if (!alsoShowHuiBo) {
                alsoShowHuiBo = YES;
                NSDictionary * info = [notification object];
                [self initLaiDianView:info];
            }
        }
        
        
        
    });
    
}

-(void)tingZhiHuJiao
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"no" forKey:@"alsoShowHuiBo"];
    [defaults synchronize];
    alsoShowHuiBo = NO;
    [RCIM sharedRCIM].disableMessageAlertSound = YES;
    [self.player stop];
    self.player = nil;
    [self.laiDianBottomView removeFromSuperview];
    [self.laiDianView removeFromSuperview];
}
-(void)initLaiDianView:(NSDictionary *)info
{
    self.laiDianInfo = info;
    self.laiDianBottomView = [[UIView alloc] initWithFrame:CGRectMake(12*BILI, VIEW_HEIGHT-49-58*BILI, VIEW_WIDTH-24*BILI, 50*BILI)];
    self.laiDianBottomView.backgroundColor = [UIColor blackColor];
    self.laiDianBottomView.alpha = 0.7;
    self.laiDianBottomView.layer.cornerRadius = 8*BILI;
    self.laiDianBottomView.layer.masksToBounds = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:self.laiDianBottomView];
    
    self.laiDianView = [[UIView alloc] initWithFrame:CGRectMake(12*BILI, VIEW_HEIGHT-49-58*BILI, VIEW_WIDTH-24*BILI, 50*BILI)];
    self.laiDianView.backgroundColor = [UIColor clearColor];
    self.laiDianView.layer.cornerRadius = 8*BILI;
    self.laiDianView.layer.masksToBounds = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:self.laiDianView];
    
    TanLiaoCustomImageView * headerImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(12*BILI, 7*BILI, 36*BILI, 36*BILI)];
    headerImageView.urlPath = [info objectForKey:@"avatarUrl"];
    headerImageView.layer.cornerRadius = 18*BILI;
    headerImageView.layer.masksToBounds = YES;
    [self.laiDianView addSubview:headerImageView];
    
    UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x+headerImageView.frame.size.width+10*BILI, 17*BILI/2, 100, 15*BILI)];
    nameLable.textColor = [UIColor whiteColor];
    nameLable.font = [UIFont systemFontOfSize:15*BILI];
    nameLable.text = [info objectForKey:@"nick"];
    [self.laiDianView addSubview:nameLable];
    
    CGSize size = [TanLiao_Common setSize:[info objectForKey:@"nick"] withCGSize: CGSizeMake(VIEW_WIDTH, VIEW_HEIGHT) withFontSize:15*BILI];
    nameLable.frame = CGRectMake(nameLable.frame.origin.x, nameLable.frame.origin.y, size.width, nameLable.frame.size.height);
    
    UIImageView * sexAgeView = [[UIImageView alloc] initWithFrame:CGRectMake(nameLable.frame.origin.x+nameLable.frame.size.width+5*BILI, nameLable.frame.origin.y, 32*BILI, 15*BILI)];
    if ([@"0" isEqualToString:@"0"]) {
        
        sexAgeView.image = [UIImage imageNamed:@"pic_old_woman"];
        
    }
    else
    {
        sexAgeView.image = [UIImage imageNamed:@"pic_old_man"];
        
    }
    [self.laiDianView addSubview:sexAgeView];
    
    UILabel * ageLable = [[UILabel alloc] initWithFrame:CGRectMake(3, (sexAgeView.frame.size.height-(10*BILI))/2, 20, 10*BILI)];
    ageLable.font = [UIFont systemFontOfSize:10*BILI];
    ageLable.textColor = [UIColor whiteColor];
    [sexAgeView addSubview:ageLable];
    ageLable.adjustsFontSizeToFitWidth = YES;
    NSNumber * number = [info objectForKey:@"age"];
    ageLable.text = [NSString stringWithFormat:@"%d",number.intValue];
    
    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(nameLable.frame.origin.x, nameLable.frame.origin.y+nameLable.frame.size.height+4*BILI, 300*BILI, 9*BILI)];
    tipLable.textColor = [UIColor whiteColor];
    tipLable.font = [UIFont systemFontOfSize:9*BILI];
    tipLable.text = @"美女主播来电了";
    [self.laiDianView addSubview:tipLable];
    
    
    UIButton * jieShouButton = [[UIButton alloc] initWithFrame:CGRectMake(300*BILI, 7*BILI, 36*BILI, 36*BILI)];
    [jieShouButton setBackgroundImage:[UIImage imageNamed:@"btn_pop-up_connect"] forState:UIControlStateNormal];
    [jieShouButton addTarget:self action:@selector(jieShouButton) forControlEvents:UIControlEventTouchUpInside];
    [self.laiDianView addSubview:jieShouButton];
    
    UIButton * jvJueButton = [[UIButton alloc] initWithFrame:CGRectMake(492*BILI/2, 7*BILI, 36*BILI, 36*BILI)];
    [jvJueButton setBackgroundImage:[UIImage imageNamed:@"btn_pop-up_dropped"] forState:UIControlStateNormal];
    [jvJueButton addTarget:self action:@selector(jvJueButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.laiDianView addSubview:jvJueButton];
    
}
-(void)jieShouButton
{
    
    [self tingZhiHuJiao];
    
    
    NSNumber * number = [self.laiDianInfo objectForKey:@"userId"];
    NTESVideoChatViewController *vc = [[NTESVideoChatViewController alloc] initWithCallee:[NSString stringWithFormat:@"%d",number.intValue]];
    CATransition *transition = [CATransition animation];
    transition.duration = 0.25;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController pushViewController:vc animated:NO];
    
}

-(void)jvJueButtonClick
{
    [self tingZhiHuJiao];
    
}
-(void)getUserInformationSuccess:(NSDictionary *)info
{
    self.money = [info objectForKey:@"gold_number"];
    self.sendMessagMoney = [info objectForKey:@"gold_number"];
    NSLog(@"%@",self.sendMessagMoney);
}
-(void)getUserInformationError:(NSDictionary *)info
{

}

-(void)getGiftListSuccess:(NSArray *)info
{
    
    self.giftArray = [NSArray arrayWithArray:info];
    
    
    if ([@"1" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]]||[@"3" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]]) {
        float height;
        if (SafeAreaBottomHeight==49) {
            height = 120*BILI;
        }
        else
        {
            height = 120*BILI+15;
        }
        UIButton * senGiftButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-60*BILI, VIEW_HEIGHT-height, 50*BILI, 50*BILI)];
        [senGiftButton setImage:[UIImage imageNamed:@"btn_lw"] forState:UIControlStateNormal];
        senGiftButton.layer.cornerRadius = 25*BILI;
        [senGiftButton addTarget:self action:@selector(sendGiftButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:senGiftButton];

    }
    [self initDaShangView];
}
-(void)sendGiftButtonClick
{
    self.daShangView.hidden = NO;
    self.daShangBottomButtonView.hidden = NO;
    self.daShangBottomView.hidden = NO;
    self.closeDaShangViewButton.hidden = NO;
}
-(void)getGiftListError:(NSDictionary *)info
{
    
}
//送礼物界面
-(void)initDaShangView
{
    self.daShangBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT-270*BILI, VIEW_WIDTH, 270*BILI)];
    self.daShangBottomView.backgroundColor = UIColorFromRGB(0x000000);
    self.daShangBottomView.alpha = 0.8;
    [self.view addSubview:self.daShangBottomView];
    
    self.daShangView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT-270*BILI, VIEW_WIDTH, 270*BILI)];
    self.daShangView.backgroundColor = [UIColor clearColor];
    self.daShangView.pagingEnabled = YES;
    [self.view addSubview:self.daShangView];
    
    self.daShangBottomButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT-78*BILI, VIEW_WIDTH, 78*BILI)];
    self.daShangBottomButtonView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.daShangBottomButtonView];
    
    UIButton * zengSongButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-(24+75)*BILI, 33*BILI, 75*BILI, 30*BILI)];
    [zengSongButton setTitle:@"赠送" forState:UIControlStateNormal];
    [zengSongButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    zengSongButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
    zengSongButton.backgroundColor = UIColorFromRGB(0xFF5C93);
    zengSongButton.layer.cornerRadius = 15*BILI;
    [zengSongButton addTarget:self action:@selector(zengSongButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.daShangBottomButtonView addSubview:zengSongButton];
    
    
    UIButton * closeButton  = [[UIButton alloc] initWithFrame:CGRectMake(20*BILI, 33*BILI, 30*BILI, 30*BILI)];
    [closeButton setImage:[UIImage imageNamed:@"shou"]forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(shouButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.daShangBottomButtonView addSubview:closeButton];
    
    
    self.liWuButtonArray = [NSMutableArray array];
    int number = 1;
    if (self.giftArray.count%8==0) {
        
        number = (int)self.giftArray.count/8;
        [self.daShangView setContentSize:CGSizeMake(self.giftArray.count/8*VIEW_WIDTH, self.daShangView.frame.size.height)];
    }
    else
    {
        number = (int)self.giftArray.count/8+1;
        [self.daShangView setContentSize:CGSizeMake((self.giftArray.count/8+1)*VIEW_WIDTH, self.daShangView.frame.size.height)];
    }
    
    for (int i=0; i<number; i++) {
        
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(i*VIEW_WIDTH, 0, VIEW_WIDTH, self.daShangView.frame.size.height)];
        view.backgroundColor = [UIColor clearColor];
        [self.daShangView addSubview:view];
        
        if ((i+1)*8<self.giftArray.count) {
            
            for (int j=i*8; j<(i+1)*8; j++) {
                
                UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(3*BILI+(90*BILI+3*BILI)*(j%4),13*BILI/2+(90*BILI+5*BILI)*(j%8/4), 90*BILI, 90*BILI)];
                button.backgroundColor = [UIColor clearColor];
                button.layer.cornerRadius = 4;
                button.layer.borderWidth =1;
                button.layer.borderColor = [UIColorFromRGB(0x323232) CGColor];
                button.tag = j;
                [button addTarget:self action:@selector(checkLiWu:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:button];
                
                NSDictionary * giftInfo = [self.giftArray objectAtIndex:j];
                
                TanLiaoCustomImageView * imageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(button.frame.origin.x, button.frame.origin.y+5*BILI, 90*BILI, 90*BILI-27*BILI)];
                imageView.contentMode = UIViewContentModeScaleAspectFit;
                imageView.urlPath =  [giftInfo  objectForKey:@"goodsIconUrl"];
                [view addSubview:imageView];
                
                UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(button.frame.origin.x, imageView.frame.origin.y+imageView.frame.size.height+5*BILI, 90*BILI, 12*BILI)];
                titleLable.textAlignment  = NSTextAlignmentCenter;
                titleLable.font = [UIFont systemFontOfSize:12*BILI];
                titleLable.textColor = [UIColor whiteColor];
                NSString * money = [giftInfo objectForKey:@"amount"];
                if(money.intValue%JinBiBiLi==0)
                {
                    titleLable.text = [NSString stringWithFormat:@"%.0f金币",money.floatValue/JinBiBiLi];
                    
                }
                else
                {
                    titleLable.text = [NSString stringWithFormat:@"%.2f金币",money.floatValue/JinBiBiLi];
                }
                [view addSubview:titleLable];
                
                [self.liWuButtonArray addObject:button];
                
                
            }
        }
        else
        {
            for (int j=i*8; j<self.giftArray.count; j++) {
                
                UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(3*BILI+(90*BILI+3*BILI)*(j%4),13*BILI/2+(90*BILI+5*BILI)*(j%8/4), 90*BILI, 90*BILI)];
                button.backgroundColor = [UIColor clearColor];
                button.layer.cornerRadius = 4;
                button.layer.borderWidth =1;
                button.tag = j;
                button.layer.borderColor = [UIColorFromRGB(0x323232) CGColor];
                [button addTarget:self action:@selector(checkLiWu:) forControlEvents:UIControlEventTouchUpInside];
                [view addSubview:button];
                
                NSDictionary * giftInfo = [self.giftArray objectAtIndex:j];
                
                TanLiaoCustomImageView * imageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(button.frame.origin.x, button.frame.origin.y+5*BILI, 90*BILI, 90*BILI-27*BILI)];
                imageView.contentMode = UIViewContentModeScaleAspectFit;
                imageView.urlPath = [giftInfo  objectForKey:@"goodsIconUrl"];
                [view addSubview:imageView];
                
                UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(button.frame.origin.x, button.frame.origin.y+button.frame.size.height-17*BILI, 90*BILI, 12*BILI)];
                titleLable.textAlignment  = NSTextAlignmentCenter;
                titleLable.font = [UIFont systemFontOfSize:12*BILI];
                titleLable.textColor = [UIColor whiteColor];
                NSString * money = [giftInfo objectForKey:@"amount"];

                if(money.intValue%JinBiBiLi==0)
                {
                    titleLable.text = [NSString stringWithFormat:@"%.0f金币",money.floatValue/JinBiBiLi];
                    
                }
                else
                {
                    titleLable.text = [NSString stringWithFormat:@"%.2f金币",money.floatValue/JinBiBiLi];
                }
                [view addSubview:titleLable];
                
                [self.liWuButtonArray addObject:button];
            }
        }
    }
    
    self.daShangView.hidden = YES;
    self.daShangBottomButtonView.hidden = YES;
    self.daShangBottomView.hidden = YES;
    self.closeDaShangViewButton.hidden = YES;
    
    
}
-(void)shouButtonClick
{
    self.daShangView.hidden = YES;
    self.daShangBottomButtonView.hidden = YES;
    self.daShangBottomView.hidden = YES;
    self.closeDaShangViewButton.hidden = YES;

}
-(void)closeDaShangViewButtonClick
{
    self.daShangView.hidden = YES;
    self.daShangBottomButtonView.hidden = YES;
    self.daShangBottomView.hidden = YES;
    self.closeDaShangViewButton.hidden = YES;
}
-(void)checkLiWu:(id)sender
{
    
    for (int i=0; i<self.liWuButtonArray.count; i++) {
        
        UIButton * button = [self.liWuButtonArray objectAtIndex:i];
        
        button.layer.borderWidth =1;
        button.alpha = 1;
        button.layer.borderColor = [UIColorFromRGB(0x323232) CGColor];
    }
    
    UIButton * button = (UIButton *)sender;
    button.layer.borderWidth = 2;
    button.layer.borderColor  = [[UIColor whiteColor] CGColor];
    button.alpha = 0.5;
    
    self.selectGift = [self.giftArray objectAtIndex:button.tag];
}
-(void)zengSongButtonClick
{
    self.daShangView.hidden = YES;
    self.daShangBottomButtonView.hidden = YES;
    self.daShangBottomView.hidden = YES;
    self.closeDaShangViewButton.hidden = YES;
     NSString * giftMoney = [self.selectGift objectForKey:@"goodsWorth"];
    if (self.money.intValue<giftMoney.intValue) {
        
        
        TanLiaoLiao_YuEBuZuView * tipView = [[TanLiaoLiao_YuEBuZuView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
        tipView.delegate = self;
        [self.view addSubview:tipView];

           // [TanLiao_Common showToastView:@"余额不足请充值" view:self.view];
       
        return;
    }
    if([self.selectGift isKindOfClass:[NSDictionary class]])
    {
            //赠送礼物
            [self.cloudClient sendGift:@"8139"
                              anchorId:self.targetId
                               goodsId:[self.selectGift objectForKey:@"goodsId"]
                              delegate:self
                              selector:@selector(sendGiftSuccess:)
                         errorSelector:@selector(sendGiftError:)];
        
    }
    else
    {
        [TanLiao_Common showToastView:@"请选要增送的礼物" view:self.view];
    }
}
-(void)sendGiftSuccess:(NSDictionary *)indo
{
    
   [self getUserInformation];
    
    TanLiaoCustomImageView * imageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-100)/2,VIEW_HEIGHT, 100, 100)];
    imageView.urlPath = [self.selectGift objectForKey:@"goodsIconUrl"];
    [self.view addSubview:imageView];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    imageView.frame = CGRectMake((VIEW_WIDTH-100)/2, VIEW_HEIGHT/2, 100, 100);
    [UIView commitAnimations];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        
        [TanLiao_Common shakeAnimationForView:imageView];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:1];
            imageView.frame = CGRectMake((VIEW_WIDTH-100)/2, -100,100, 100);
            [UIView commitAnimations];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                
                [imageView removeFromSuperview];
            });
            
        });
        
    });
    
    
}
-(void)sendGiftError:(NSDictionary *)info
{
    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];
}

//获取到礼物通知执行动画
-(void)receivedGiftNotification:(NSNotification *)notification
{
    NSDictionary * selectGift ;
    NSDictionary * sendInfo = [notification object];
    
    for (int i=0; i<self.giftArray.count; i++) {
        
        NSDictionary * info = [self.giftArray objectAtIndex:i];
        if ([[info objectForKey:@"goodsId"] isEqualToString:[sendInfo objectForKey:@"txtInfo"]]) {
            
            selectGift = [[NSDictionary alloc] initWithDictionary:info];
        }
    }
    [self performSelectorOnMainThread:@selector(myThreadMainMethod:) withObject:selectGift waitUntilDone:NO];
    
}

-(void)myThreadMainMethod:(NSDictionary *)selectGift
{
    TanLiaoCustomImageView * imageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH)/2,VIEW_HEIGHT/2, 0, 0)];
    imageView.urlPath = [selectGift objectForKey:@"goodsIconUrl"];
    [self.view addSubview:imageView];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    imageView.frame = CGRectMake((VIEW_WIDTH-200)/2, VIEW_HEIGHT/2-100, 150, 150);
    [UIView commitAnimations];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        
        [TanLiao_Common shakeAnimationForView:imageView];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:1];
            imageView.frame = CGRectMake((VIEW_WIDTH-50)/2, -50,50, 50);
            [UIView commitAnimations];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                
                [imageView removeFromSuperview];
            });
            
        });
        
    });
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate setTabBarHidden];
    self.enableUnreadMessageIcon = YES;
    self.enableNewComingMessageIcon = YES;
    self.defaultInputType = RCChatSessionInputBarInputText;
    if([self.targetId isEqualToString:@"910005"]||[@"910005" isEqualToString:[TanLiao_Common getNowUserID]])
    {
        [self.chatSessionInputBarControl setInputBarType:RCChatSessionInputBarControlDefaultType style:RC_CHAT_INPUT_BAR_STYLE_CONTAINER_EXTENTION];
    }
    else
    {
    [self.chatSessionInputBarControl setInputBarType:RCChatSessionInputBarControlDefaultType style:4];
    }
    if ([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]]) {
        
        [self.chatSessionInputBarControl setInputBarType:RCChatSessionInputBarControlDefaultType style:RC_CHAT_INPUT_BAR_STYLE_CONTAINER];
    }
    if([@"800001" isEqualToString:self.targetId])
    {
        self.chatSessionInputBarControl.hidden = YES;
    }
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [self closePLayVoiceButtonClick];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ZhuBoHuJiaoNotification object:nil];
     [[NSNotificationCenter defaultCenter] removeObserver:self name:@"threeTuiJianPushToAnchorDetail" object:nil];
    [super viewWillDisappear:animated];
}
-(void)viewDidAppear:(BOOL)animated
{
    //主播推荐弹框
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(threeTuiJianPushToAnchorDetail:) name:@"threeTuiJianPushToAnchorDetail" object:nil];
    
}
-(void)threeTuiJianPushToAnchorDetail:(NSNotification *)notification
{
    NSString * userId = [notification object];
    TanLiaoLiao_AnchorDetailMessageViewController * vc = [[TanLiaoLiao_AnchorDetailMessageViewController alloc] init];
    vc.anchorId = userId;
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    //self.navigationController.navigationBarHidden = YES;
}

- (void)leftBarButtonItemPressed:(id)sender {
    [super leftBarButtonItemPressed:sender];
    self.navigationController.navigationBarHidden = NO;
}
//重新添加定义cell的一些属性
- (void)willDisplayMessageCell:(RCMessageBaseCell *)cell
                   atIndexPath:(NSIndexPath *)indexPath
{
    
    RCMessageCell * cell2 = (RCMessageCell *)cell;
    //设置用户头像是圆的
    cell2.portraitStyle = RC_USER_AVATAR_CYCLE;

    //头像添加vip标识
    if(cell.messageDirection == MessageDirection_RECEIVE)
    {
        NSNumber * accountNumber = [self.anchorInfo objectForKey:@"accountType"];
        if ([@"1" isEqualToString:[self.anchorInfo objectForKey:@"isVip"]]&&[@"1"isEqualToString:[NSString stringWithFormat:@"%d",accountNumber.intValue]]) {
            
//            UIImageView * alsoVipImageView;
//            if (VIEW_WIDTH==320) {
//                alsoVipImageView   = [[UIImageView alloc] initWithFrame:CGRectMake(45*BILI, 60*BILI, 16*BILI, 16*BILI)];
//            }
//            else if(VIEW_WIDTH == 414)
//            {
//               
//                alsoVipImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(35*BILI, 50*BILI, 12*BILI, 12*BILI)];
//            }
//            else if(VIEW_WIDTH ==375)
//            {
//                alsoVipImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(42*BILI, 54*BILI, 12*BILI, 12*BILI)];
//            }
//            
//         
//            alsoVipImageView.image = [UIImage imageNamed:@"vip_grade_wg_h"];
//            [cell addSubview:alsoVipImageView];
            
            cell2.nicknameLabel.textColor = UIColorFromRGB(0xFF4B4B);
            
        }
        
    }
    
    RCMessage *message = self.conversationDataRepository[indexPath.row];
    if ([message.objectName isEqualToString:RCTextMessageTypeIdentifier]) {
        RCTextMessage *rctext = (RCTextMessage*)message.content;
        NSData *jsonData = [rctext.content dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        id dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                 options:NSJSONReadingMutableContainers
                                                   error:&err];
        if (dic) {
            if (dic[@"type"]) {
                //删除消息
                NSArray *msgIdArray = [[NSArray alloc]initWithObjects:@(message.messageId), nil];
                [[RCIMClient sharedRCIMClient] deleteMessages:msgIdArray];
                [self deleteMessage:cell.model];
            }
        }
    }
}

- (RCMessage *)willAppendAndDisplayMessage:(RCMessage *)message
{
    if ([message.objectName isEqualToString:RCTextMessageTypeIdentifier]) {
        RCTextMessage *rctext = (RCTextMessage*)message.content;
        NSData *jsonData = [rctext.content dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        id dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                 options:NSJSONReadingMutableContainers
                                                   error:&err];
        if (dic) {
            if (dic[@"type"]) {
                //删除消息
                NSArray *msgIdArray = [[NSArray alloc]initWithObjects:@(message.messageId), nil];
                [[RCIMClient sharedRCIMClient] deleteMessages:msgIdArray];
                return nil;
            }
        }
    }
    return message;
}

-(void)getAnchorMesSuccess:(NSDictionary *)info
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:info forKey:info[@"userId"]];
    [defaults synchronize];

    [[RCIM sharedRCIM] refreshUserInfoCache:[[RCUserInfo alloc] initWithUserId:info[@"userId"] name:info[@"nick"] portrait:info[@"avatarUrl"]] withUserId:info[@"userId"]];
}

-(void)getAnchorMesError:(NSDictionary *)info
{
    
}
-(void)didLongTouchMessageCell:(RCMessageModel *)model inView:(UIView *)view
{
}
//点击消息内容
-(void)didTapMessageCell:(RCMessageModel *)model
{
    [super didTapMessageCell:model];
    FQSQ_ChatImageMessage *testMessage = (FQSQ_ChatImageMessage *)model.content;
    NSDictionary * info = [TanLiao_Common dictionaryWithJsonString:testMessage.extra];
     if([RCDVideoMessageTypeIdentifier isEqualToString:model.objectName])
     {
         self.picOrVideoInfo = info;
         [self.cloudClient chaXunGongBaoPurchaseRecord:@"8107"
                                               payType:@"2"
                                               goodsId:[info objectForKey:@"goodsId"]
                                              delegate:self
                                              selector:@selector(checkVideoHongBaoSuccess:)
                                         errorSelector:@selector(checkError:)];

     }
    else if ([RCDImageMessageTypeIdentifier isEqualToString:model.objectName])
    {
         self.picOrVideoInfo = info;
        [self.cloudClient chaXunGongBaoPurchaseRecord:@"8107"
                                              payType:@"0"
                                              goodsId:[info objectForKey:@"goodsId"]
                                             delegate:self
                                             selector:@selector(checkImageHongBaoSuccess:)
                                        errorSelector:@selector(checkError:)];
        
    }
    else if ([RCDVoiceMessageTypeIdentifier isEqualToString:model.objectName])
    {
        self.picOrVideoInfo = info;
        [self.cloudClient chaXunGongBaoPurchaseRecord:@"8107"
                                              payType:@"1"
                                              goodsId:[info objectForKey:@"goodsId"]
                                             delegate:self
                                             selector:@selector(checkVoiceHongBaoSuccess:)
                                        errorSelector:@selector(checkError:)];
    }
    else if ([RCDCallVideoMessageTypeIdentifier isEqualToString:model.objectName])
    {
       if(self.money.intValue<300)
       {
           TanLiaoLiao_YuEBuZuView * tipView = [[TanLiaoLiao_YuEBuZuView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
           tipView.delegate = self;
           [self.view addSubview:tipView];

           //[TanLiao_Common showToastView:@"余额不足请充值" view:self.view];
       }
        else
        {
            NTESVideoChatViewController *vc = [[NTESVideoChatViewController alloc] initWithCallee:self.targetId];
            CATransition *transition = [CATransition animation];
            transition.duration = 0.25;
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromTop;
            [self.navigationController.view.layer addAnimation:transition forKey:nil];
            self.navigationController.navigationBarHidden = YES;
            [self.navigationController pushViewController:vc animated:NO];
        }
    }
    else if ([RCDSendGiftMessageTypeIdentifier isEqualToString:model.objectName])
    {
        [self initQiuLiWuView:info];
    }
    else if ([RCDBusinessCardTypeIdentifier isEqualToString:model.objectName])
    {
        TanLiaoLiao_AnchorDetailMessageViewController * anchorDetailVC = [[TanLiaoLiao_AnchorDetailMessageViewController alloc] init];
        anchorDetailVC.anchorId = [info objectForKey:@"userId"];
        [self.navigationController pushViewController:anchorDetailVC animated:YES];

    }
}
-(void)YuEBuZuPushToRechargeView
{
    TanLiao_RechargeViewController * rechargeVC = [[TanLiao_RechargeViewController alloc] init];
    rechargeVC.payChannel = @"appPay";
    rechargeVC.delegate = self;
    [self.navigationController pushViewController:rechargeVC animated:YES];
    
}
-(void)chongZhiSuccess
{
    [self getUserInformation];
    [TanLiao_Common showToastView:@"充值成功" view:self.view];
}
-(void)checkImageHongBaoSuccess:(NSDictionary *)info
{
    NSNumber * type = [info objectForKey:@"isPayed"];
    if ([@"0" isEqualToString:[NSString stringWithFormat:@"%d",type.intValue]])
    {
        [self initZhiFuView:self.picOrVideoInfo];
    }
    else
    {
        NSMutableArray * photos = [NSMutableArray array];
        MWPhoto * photo = [MWPhoto photoWithURL:[NSURL URLWithString:[self.picOrVideoInfo objectForKey:@"picUrl"]]];
        [photos addObject:photo];
        MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithPhotos:photos];
        browser.displayActionButton = NO;
        browser.alwaysShowControls = NO;
        browser.displaySelectionButtons = NO;
        browser.zoomPhotosToFill = YES;
        browser.displayNavArrows = NO;
        browser.startOnGrid = NO;
        browser.enableGrid = YES;
        [browser setCurrentPhotoIndex:0];
        [self .navigationController pushViewController:browser animated:YES];
    }
    
}
-(void)checkVoiceHongBaoSuccess:(NSDictionary *)info
{
    NSNumber * type = [info objectForKey:@"isPayed"];
    if ([@"0" isEqualToString:[NSString stringWithFormat:@"%d",type.intValue]])
    {
        [self initZhiFuView:self.picOrVideoInfo];
    }
    else
    {
        [self playVoiceMes:[self.picOrVideoInfo objectForKey:@"voiceUrl"]];
    }
}
-(void)checkVideoHongBaoSuccess:(NSDictionary *)info
{
    NSNumber * type = [info objectForKey:@"isPayed"];
    if ([@"0" isEqualToString:[NSString stringWithFormat:@"%d",type.intValue]])
    {
        [self initZhiFuView:self.picOrVideoInfo];
    }
    else
    {
//        NSMutableArray * photos = [NSMutableArray array];
//        MWPhoto * photo = [MWPhoto photoWithURL:[NSURL URLWithString:[self.picOrVideoInfo objectForKey:@"picUrl"]]];
//        photo.videoURL = [NSURL URLWithString:[self.picOrVideoInfo objectForKey:@"videoUrl"]];
//        [photos addObject:photo];
//        MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithPhotos:photos];
//        browser.displayActionButton = NO;
//        browser.alwaysShowControls = NO;
//        browser.displaySelectionButtons = NO;
//        browser.zoomPhotosToFill = YES;
//        browser.displayNavArrows = NO;
//        browser.startOnGrid = NO;
//        browser.enableGrid = YES;
//        [browser setCurrentPhotoIndex:0];
//        [self .navigationController pushViewController:browser animated:YES];
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        [dic setObject:[self.picOrVideoInfo objectForKey:@"videoUrl"] forKey:@"videoUrl"];
        
        KuaiLiao_BoFangShiPinViewController * boFangShiPinVC = [[KuaiLiao_BoFangShiPinViewController alloc] init];
        boFangShiPinVC.fromWhere = @"chat";
        boFangShiPinVC.anchorInfo = dic;
        [self.navigationController pushViewController:boFangShiPinVC animated:YES];
    }
}
-(void)checkError:(NSDictionary *)info
{
    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];
}
-(void)initQiuLiWuView :(NSDictionary *)info
{
    self.giftInfo = info;
    self.qiuLiWuButtomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    self.qiuLiWuButtomView.backgroundColor = [UIColor blackColor];
    self.qiuLiWuButtomView.alpha = 0.6;
      [[UIApplication sharedApplication].keyWindow addSubview:self.qiuLiWuButtomView];
    
    self.qiuLiWuView = [[UIView alloc] initWithFrame:CGRectMake(50*BILI, 202*BILI, 550*BILI/2, 546*BILI/2)];
    self.qiuLiWuView.backgroundColor = [UIColor whiteColor];
    self.qiuLiWuView.layer.cornerRadius = 8*BILI;
    self.qiuLiWuView.layer.masksToBounds = YES;
    self.qiuLiWuView.clipsToBounds = YES;
     [[UIApplication sharedApplication].keyWindow addSubview:self.qiuLiWuView];
    
    
    UIView * topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.qiuLiWuView.frame.size.width, 40*BILI)];
    topView.backgroundColor = UIColorFromRGB(0xD7D7D7);
    [self.qiuLiWuView addSubview:topView];
    
    UIButton * closeButton = [[UIButton alloc] initWithFrame:CGRectMake(self.qiuLiWuView.frame.size.width-40*BILI, 0, 40*BILI, 40*BILI)];
    [closeButton addTarget:self action:@selector(qiuLiWuViewCloseButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.qiuLiWuView addSubview:closeButton];
    
    UIImageView * closeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.qiuLiWuView.frame.size.width-65*BILI/2, 25*BILI/2, 15*BILI, 15*BILI)];
    closeImageView.image = [UIImage imageNamed:@"close"];
    [self.qiuLiWuView addSubview:closeImageView];

    
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.qiuLiWuView.frame.size.width, 40*BILI)];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font = [UIFont systemFontOfSize:18*BILI];
    titleLable.textColor = [UIColor blackColor];
    titleLable.alpha = 0.6;
    titleLable.text = @"赠送礼物";
    [topView addSubview:titleLable];
    
    UILabel * messageLable = [[UILabel alloc] initWithFrame:CGRectMake(0, titleLable.frame.size.height+15*BILI, self.qiuLiWuView.frame.size.width, 12*BILI)];
    messageLable.textColor =UIColorFromRGB(0x040404);
    messageLable.alpha = 0.6;
    messageLable.font = [UIFont systemFontOfSize:12*BILI];
    messageLable.textAlignment = NSTextAlignmentCenter;
    NSString * prcie = [info objectForKey:@"price"];
    if(prcie.intValue%JinBiBiLi==0)
    {
        messageLable.text = [NSString stringWithFormat:@"%.0f金币",prcie.floatValue/JinBiBiLi];
        
    }
    else
    {
        messageLable.text = [NSString stringWithFormat:@"%.2f金币",prcie.floatValue/JinBiBiLi];
    }
    [self.qiuLiWuView addSubview:messageLable];
    
    TanLiaoCustomImageView * imageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(155*BILI/2, messageLable.frame.origin.y+messageLable.frame.size.height+10*BILI, 120*BILI, 120*BILI)];
    imageView.urlPath = [info objectForKey:@"picUrl"];
    [self.qiuLiWuView addSubview:imageView];
    
    UILabel *yuELable = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.frame.size.height+imageView.frame.origin.y+10*BILI, self.qiuLiWuView.frame.size.width, 12*BILI)];
    yuELable.textColor =UIColorFromRGB(0x040404);
    yuELable.alpha = 0.6;
    yuELable.font = [UIFont systemFontOfSize:12*BILI];
    yuELable.textAlignment = NSTextAlignmentCenter;
    yuELable.text = [NSString stringWithFormat:@"账户余额:%.2f金币",self.money.floatValue/100];
    [self.qiuLiWuView addSubview:yuELable];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(150*BILI/2, yuELable.frame.origin.y+yuELable.frame.size.height+12*BILI, 250*BILI/2, 1*BILI)];
    lineView.alpha = 0.1;
    lineView.backgroundColor = [UIColor blackColor];
    [self.qiuLiWuView addSubview:lineView];

    UIButton * zengSongButton = [[UIButton alloc] initWithFrame:CGRectMake(0, lineView.frame.origin.y, self.qiuLiWuView.frame.size.width, 41*BILI)];
    [zengSongButton setTitleColor:UIColorFromRGB(0XF85BA3) forState:UIControlStateNormal];
    [zengSongButton setTitle:@"立即赠送" forState:UIControlStateNormal];
    [zengSongButton addTarget:self action:@selector(liJiZengSong) forControlEvents:UIControlEventTouchUpInside];
    [self.qiuLiWuView addSubview:zengSongButton];
    
}
-(void)liJiZengSong
{
    self.qiuLiWuView.hidden = YES;
    self.qiuLiWuButtomView.hidden = YES;

    NSString * giftMoney = [self.giftInfo objectForKey:@"price"];
    if (self.money.intValue<giftMoney.intValue) {
//        [TanLiao_Common showToastView:@"余额不足请充值" view:self.view];
        TanLiaoLiao_YuEBuZuView * tipView = [[TanLiaoLiao_YuEBuZuView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
        tipView.delegate = self;
        [self.view addSubview:tipView];

        return;
    }
    if([self. giftInfo isKindOfClass:[NSDictionary class]])
    {
        //赠送礼物
        [self.cloudClient sendGift:@"8109"
                          anchorId:self.targetId
                           goodsId:[self.giftInfo objectForKey:@"goodsId"]
                          delegate:self
                          selector:@selector(zengSongGiftSuccess:)
                     errorSelector:@selector(sendGiftError:)];
        
    }
}
-(void)zengSongGiftSuccess:(NSDictionary *)info
{
    
    self.qiuLiWuView.hidden = YES;
    self.qiuLiWuButtomView.hidden = YES;
    // NSString * giftMoney = [self.selectGift objectForKey:@"goodsWorth"];
    [self getUserInformation];
    
    TanLiaoCustomImageView * imageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH-100)/2,VIEW_HEIGHT, 100, 100)];
    imageView.urlPath = [self.giftInfo objectForKey:@"picUrl"];
    [self.view addSubview:imageView];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    imageView.frame = CGRectMake((VIEW_WIDTH-100)/2, VIEW_HEIGHT/2, 100, 100);
    [UIView commitAnimations];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        
        [TanLiao_Common shakeAnimationForView:imageView];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:1];
            imageView.frame = CGRectMake((VIEW_WIDTH-100)/2, -100,100, 100);
            [UIView commitAnimations];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW,  NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                
                [imageView removeFromSuperview];
            });
            
        });
        
    });
    
    
}
-(void)qiuLiWuViewCloseButtonClick
{
    [self.qiuLiWuView removeFromSuperview];
    [self.qiuLiWuButtomView removeFromSuperview];
    
}
-(void)initZhiFuView:(NSDictionary *)info
{
   
    self.qiuLiWuButtomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    self.qiuLiWuButtomView.backgroundColor = [UIColor blackColor];
    self.qiuLiWuButtomView.alpha = 0.6;
    [[UIApplication sharedApplication].keyWindow addSubview:self.qiuLiWuButtomView];
    
    self.qiuLiWuView = [[UIView alloc] initWithFrame:CGRectMake(111*BILI/2, 202*BILI, 528*BILI/2, 446*BILI/2)];
    self.qiuLiWuView.backgroundColor = [UIColor whiteColor];
    self.qiuLiWuView.layer.cornerRadius = 8*BILI;
    self.qiuLiWuView.layer.masksToBounds = YES;
    self.qiuLiWuView.clipsToBounds = YES;
    [[UIApplication sharedApplication].keyWindow addSubview:self.qiuLiWuView];
    
    
    UIView * topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.qiuLiWuView.frame.size.width, 40*BILI)];
    topView.backgroundColor = UIColorFromRGB(0xD7D7D7);
    [self.qiuLiWuView addSubview:topView];
    
    UIButton * closeButton = [[UIButton alloc] initWithFrame:CGRectMake(self.qiuLiWuView.frame.size.width-40*BILI, 0, 40*BILI, 40*BILI)];
    [closeButton addTarget:self action:@selector(qiuLiWuViewCloseButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.qiuLiWuView addSubview:closeButton];
    
    UIImageView * closeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.qiuLiWuView.frame.size.width-65*BILI/2, 25*BILI/2, 15*BILI, 15*BILI)];
    closeImageView.image = [UIImage imageNamed:@"close"];
    [self.qiuLiWuView addSubview:closeImageView];
    
    
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.qiuLiWuView.frame.size.width, 40*BILI)];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.font = [UIFont systemFontOfSize:18*BILI];
    titleLable.textColor = [UIColor blackColor];
    titleLable.alpha = 0.6;
    titleLable.text = @"查看私密信息";
    [topView addSubview:titleLable];
    
    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(0, topView.frame.size.height+77*BILI/2, self.qiuLiWuView.frame.size.width, 12*BILI)];
    tipLable.font = [UIFont systemFontOfSize:12*BILI];
    tipLable.textAlignment = NSTextAlignmentCenter;
    tipLable.textColor = [UIColor blackColor];
    tipLable.alpha = 0.3;
    tipLable.text = @"需要金币";
    [self.qiuLiWuView addSubview:tipLable];
    
    NSString * price = [info objectForKey:@"price"];
    UILabel * moneyLable = [[UILabel alloc] initWithFrame:CGRectMake(0, tipLable.frame.size.height+tipLable.frame.origin.y+20*BILI/2, self.qiuLiWuView.frame.size.width, 24*BILI)];
    moneyLable.font = [UIFont systemFontOfSize:24*BILI];
    moneyLable.textAlignment = NSTextAlignmentCenter;
    moneyLable.textColor = UIColorFromRGB(0x040404);
    moneyLable.alpha = 0.6;
    if(price.intValue%JinBiBiLi==0)
    {
        moneyLable.text = [NSString stringWithFormat:@"%.0f金币",price.floatValue/JinBiBiLi];
        
    }
    else
    {
        moneyLable.text = [NSString stringWithFormat:@"%.2f金币",price.floatValue/JinBiBiLi];
    }
    [self.qiuLiWuView addSubview:moneyLable];
    
    UIButton * sureButton = [[UIButton alloc] initWithFrame:CGRectMake(7*BILI, self.qiuLiWuView.frame.size.height-47*BILI, self.qiuLiWuView.frame.size.width-14*BILI, 40*BILI)];
    sureButton.backgroundColor = UIColorFromRGB(0xFF5C93);
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureButton.titleLabel.font = [UIFont systemFontOfSize:18*BILI];
    [self.qiuLiWuView addSubview:sureButton];
    [sureButton addTarget:self action:@selector(zhiFuButtonClick) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)zhiFuButtonClick
{
    [self.qiuLiWuButtomView removeFromSuperview];
    [self.qiuLiWuView removeFromSuperview];
    
    NSString * price = [self.picOrVideoInfo objectForKey:@"price"];
    if (self.money.intValue<price.intValue) {
        
        TanLiaoLiao_YuEBuZuView * tipView = [[TanLiaoLiao_YuEBuZuView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
        tipView.delegate = self;
        [self.view addSubview:tipView];

//         [TanLiao_Common showToastView:@"余额不足请充值" view:self.view];
        return;
    }
    if([self.picOrVideoInfo isKindOfClass:[NSDictionary class]])
    {
        NSString * ticket = [self.picOrVideoInfo objectForKey:@"ticket"];
        //购买照片
        if ([ticket containsString:@"PhotoMsg"])
        {
             [self.cloudClient gouMaiSuoYaoMes:@"8104"
                                      anchorId:self.targetId
                                       goodsId:[self.picOrVideoInfo objectForKey:@"goodsId"]
                                      delegate:self
                                      selector:@selector(picOrVideoZhiFuSuccess:)
                                 errorSelector:@selector(picOrVideoZhiFuError:)];
        }
        //购买视频
        if ([ticket containsString:@"VideoMsg"])
        {
                  [self.cloudClient gouMaiSuoYaoMes:@"8102"
                                           anchorId:self.targetId
                                            goodsId:[self.picOrVideoInfo objectForKey:@"goodsId"]
                                           delegate:self
                                           selector:@selector(picOrVideoZhiFuSuccess:)
                                      errorSelector:@selector(picOrVideoZhiFuError:)];
        }
        //购买语音
        if ([ticket containsString:@"VioceMsg"])
        {
                [self.cloudClient gouMaiSuoYaoMes:@"8106"
                                           anchorId:self.targetId
                                            goodsId:[self.picOrVideoInfo objectForKey:@"goodsId"]
                                           delegate:self
                                           selector:@selector(picOrVideoZhiFuSuccess:)
                                      errorSelector:@selector(picOrVideoZhiFuError:)];
        }
        
    }
}

-(void)picOrVideoZhiFuSuccess:(NSDictionary *)info
{
    [self getUserInformation];
    NSString * ticket = [self.picOrVideoInfo objectForKey:@"ticket"];
    
    if ([ticket containsString:@"PhotoMsg"]) {
        
        NSMutableArray * photos = [NSMutableArray array];
        MWPhoto * photo = [MWPhoto photoWithURL:[NSURL URLWithString:[self.picOrVideoInfo objectForKey:@"picUrl"]]];
        [photos addObject:photo];
        MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithPhotos:photos];
        browser.displayActionButton = NO;
        browser.alwaysShowControls = NO;
        browser.displaySelectionButtons = NO;
        browser.zoomPhotosToFill = YES;
        browser.displayNavArrows = NO;
        browser.startOnGrid = NO;
        browser.enableGrid = YES;
        [browser setCurrentPhotoIndex:0];
        [self .navigationController pushViewController:browser animated:YES];
    }
    
    if ([ticket containsString:@"VideoMsg"]) {
        
        /*
        NSMutableArray * photos = [NSMutableArray array];
        MWPhoto * photo = [MWPhoto photoWithURL:[NSURL URLWithString:[self.picOrVideoInfo objectForKey:@"picUrl"]]];
        photo.videoURL = [NSURL URLWithString:[self.picOrVideoInfo objectForKey:@"videoUrl"]];
        [photos addObject:photo];
        MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithPhotos:photos];
        browser.displayActionButton = NO;
        browser.alwaysShowControls = NO;
        browser.displaySelectionButtons = NO;
        browser.zoomPhotosToFill = YES;
        browser.displayNavArrows = NO;
        browser.startOnGrid = NO;
        browser.enableGrid = YES;
        [browser setCurrentPhotoIndex:0];
        [self .navigationController pushViewController:browser animated:YES];
        */
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        [dic setObject:[self.picOrVideoInfo objectForKey:@"videoUrl"] forKey:@"videoUrl"];
        
        KuaiLiao_BoFangShiPinViewController * boFangShiPinVC = [[KuaiLiao_BoFangShiPinViewController alloc] init];
        boFangShiPinVC.fromWhere = @"chat";
        boFangShiPinVC.anchorInfo = dic;
        [self.navigationController pushViewController:boFangShiPinVC animated:YES];
    }
    
    if ([ticket containsString:@"VioceMsg"]) {
       
         [self playVoiceMes:[self.picOrVideoInfo objectForKey:@"voiceUrl"]];
    }
    
}
-(void)playVoiceMes:(NSString *)voicePath
{
    self.playVoiceBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
    self.playVoiceBottomView.backgroundColor = [UIColor blackColor];
    self.playVoiceBottomView.alpha = 0.3;
    [self.view addSubview:self.playVoiceBottomView];
    
    self.playVoiceContentView = [[UIView alloc] initWithFrame:CGRectMake(45*BILI, VIEW_HEIGHT-109*BILI, VIEW_WIDTH-90*BILI, 60*BILI)];
    self.playVoiceContentView.backgroundColor = [UIColor whiteColor];
    self.playVoiceContentView.layer.masksToBounds = YES;
    self.playVoiceContentView.layer.cornerRadius = 4*BILI;
    [self.view addSubview:self.playVoiceContentView];
    
    self.playAndPuseButton = [[UIButton alloc] initWithFrame:CGRectMake(30*BILI, 10*BILI, 40*BILI, 40*BILI)];
    [self.playAndPuseButton setImage:[UIImage imageNamed:@"chat_btn_zanting"] forState:UIControlStateNormal];
    self.playAndPuseButton.tag = 1;
    [self.playAndPuseButton addTarget:self action:@selector(playAndPuseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.playVoiceContentView addSubview:self.playAndPuseButton];
    
    UIImageView * tipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100*BILI, 2*BILI, 168*BILI/2, 50*BILI)];
    tipImageView.image = [UIImage imageNamed:@"chat_pic_bofang"];
    [self.playVoiceContentView addSubview:tipImageView];
    
    UIButton * closePLayButton = [[UIButton alloc] initWithFrame:CGRectMake(214*BILI, 10*BILI, 40*BILI, 40*BILI)];
    [closePLayButton setImage:[UIImage imageNamed:@"chat_btn_guanbi"] forState:UIControlStateNormal];
    [closePLayButton addTarget:self action:@selector(closePLayVoiceButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.playVoiceContentView addSubview:closePLayButton];

    
    NSError *playerError;
    //播放
    self. voicePlayer = nil;

    self. voicePlayer = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:voicePath]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished) name:AVPlayerItemDidPlayToEndTimeNotification   object:self.voicePlayer.currentItem];
    
    if (self.voicePlayer == nil)
    {
        NSLog(@"ERror creating player: %@", [playerError description]);

    }else{
        [self.voicePlayer play];
        
    }
  
}
-(void)playbackFinished
{
    [self.playAndPuseButton setImage:[UIImage imageNamed:@"chat_btn_bofang"] forState:UIControlStateNormal];
    self.playAndPuseButton.tag = 2;
}
-(void)playAndPuseButtonClick:(id)sender
{
    UIButton * button = (UIButton *)sender;
    if (button.tag==1)
    {
        button.tag =0;
       [self.voicePlayer pause];
        [button setImage:[UIImage imageNamed:@"chat_btn_bofang"] forState:UIControlStateNormal];
    }
    else if(button.tag==0)
    {
            button.tag = 1;
         [self.voicePlayer play];
         [button setImage:[UIImage imageNamed:@"chat_btn_zanting"] forState:UIControlStateNormal];
    }
    else if (button.tag == 2)
    {
        NSError *playerError;
        //播放
        self. voicePlayer = nil;
        
        self. voicePlayer = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:[self.picOrVideoInfo objectForKey:@"voiceUrl"]]];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished) name:AVPlayerItemDidPlayToEndTimeNotification   object:nil];
        
        if (self.voicePlayer == nil)
        {
            NSLog(@"ERror creating player: %@", [playerError description]);
            
        }else{
            [self.voicePlayer play];
            
        }
        button.tag =1;
        [button setImage:[UIImage imageNamed:@"chat_btn_zanting"] forState:UIControlStateNormal];
    }
    
}
-(void)closePLayVoiceButtonClick
{
     self.voicePlayer = nil;
    [self.playVoiceBottomView removeFromSuperview];
    [self.playVoiceContentView removeFromSuperview];
}

-(void)picOrVideoZhiFuError:(NSDictionary *)info
{
    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];
}

-(void)getPayReturnSuccess:(NSDictionary *)info
{
    
    if ([[info objectForKey:@"gold_number"] isKindOfClass:[NSString class]]) {
        
        //NSString * money = [info objectForKey:@"gold_number"];
        
        [self getUserInformation];
        
        UIButton * tipButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-200)/2,VIEW_HEIGHT-100, 200, 40)];
        tipButton.enabled = NO;
        tipButton.alpha = 0.8;
        tipButton.layer.cornerRadius = 20;
        tipButton.backgroundColor = [UIColor blackColor];
        [tipButton setTitle:@"充值成功" forState:UIControlStateNormal];
        [tipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        tipButton.titleLabel.font = [UIFont systemFontOfSize:15];
        tipButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.view addSubview:tipButton];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:3];
        tipButton.alpha = 0;
        [UIView commitAnimations];
    }
    
    
}

-(void)getPayReturnError:(NSDictionary *)info
{
    
}
-(void)getChargeError:(NSDictionary *)info
{
    
}


- (RCMessageContent *)willSendMessage:(RCMessageContent *)messageContent
{
   
//    ChatBusinessCardMessage * textMsg = [[ChatBusinessCardMessage alloc] init];
//    NSDictionary * dic = [[NSDictionary alloc] initWithObjectsAndKeys:@"tmb",@"name",@"1",@"type",nil];
//    textMsg.extra = [Common convertToJsonData:dic];
//    textMsg.content = [Common convertToJsonData:dic];
//    return textMsg;
    
    
    if(! [@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]]) {
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSString * firstTip = [defaults objectForKey:@"firstTip"];
        if ([firstTip isKindOfClass:[NSString class]] && [@"firstTip" isEqualToString:firstTip]) {
            
            
            
                NSString * senMes;
                if ([messageContent isKindOfClass:[RCTextMessage class]]) {
                    
                    RCTextMessage * rctMes = (RCTextMessage *)messageContent;
                    senMes = rctMes.content;
                }
                else
                {
                senMes = @"";
                }
                if ([messageContent isKindOfClass:[RCImageMessage class]]) {
                    messageContent.senderUserInfo = [[RCUserInfo alloc] initWithUserId:[TanLiao_Common getNowUserID] name:[TanLiao_Common getCurrentUserName] portrait:[TanLiao_Common getCurrentAvatarpath]];
                    [self sendMediaMessage:messageContent pushContent:nil appUpload:YES];
                    return nil;
                } else if ([messageContent isKindOfClass:[RCTextMessage class]]) {

                    RCTextMessage *rctextMessage = (RCTextMessage *)messageContent;
                    
                    for (NSString *str in shieldArr) {
                        if ([rctextMessage.content containsString:str]) {
                            rctextMessage.content = [rctextMessage.content stringByReplacingOccurrencesOfString:str withString:@" "];
                        }
                    }
                    
                    [self SiLiaoKouFei:senMes];
                    self.textMessage = rctextMessage;
                    return nil;

                 
                }else if([messageContent isKindOfClass:[RCVoiceMessage class]])
                {
                    RCVoiceMessage *rcVoiceMessage = (RCVoiceMessage *)messageContent;
                    [self voiceSiLiaoKouFei:@""];
                    self.voiceMessage = rcVoiceMessage;
                    return nil;

                }
                else {
                    return messageContent;
                }

         
            
        }
        else
        {
            
                if([@"1" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]]&&![@"true" isEqualToString:[TanLiao_Common getVIPStatus]])
                {
                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"每条私聊消息将扣取0.1金币(成为会员私聊免费哦~)" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alertView show];
                alertView.tag = 1;
                [self.view addSubview:alertView];
                
                [defaults setObject:@"firstTip" forKey:@"firstTip"];
                [defaults synchronize];
                }
            
                NSString * senMes;
                if ([messageContent isKindOfClass:[RCTextMessage class]]) {
                    
                    RCTextMessage * rctMes = (RCTextMessage *)messageContent;
                    senMes = rctMes.content;
                }
                else
                {
                    senMes = @"";
                }
                
                if ([messageContent isKindOfClass:[RCImageMessage class]]) {
                    messageContent.senderUserInfo = [[RCUserInfo alloc] initWithUserId:[TanLiao_Common getNowUserID] name:[TanLiao_Common getCurrentUserName] portrait:[TanLiao_Common getCurrentAvatarpath]];
                    [self sendMediaMessage:messageContent pushContent:nil appUpload:YES];
                    return nil;
                } else if ([messageContent isKindOfClass:[RCTextMessage class]]) {
                    
                    RCTextMessage *rctextMessage = (RCTextMessage *)messageContent;
                    for (NSString *str in shieldArr) {
                        if ([rctextMessage.content containsString:str]) {
                            rctextMessage.content = [rctextMessage.content stringByReplacingOccurrencesOfString:str withString:@" "];
                        }
                    }
                    [self SiLiaoKouFei:senMes];
                    self.textMessage = rctextMessage;
                    return nil;

                }
                else if([messageContent isKindOfClass:[RCVoiceMessage class]])
                {
                    RCVoiceMessage *rcVoiceMessage = (RCVoiceMessage *)messageContent;
                    [self voiceSiLiaoKouFei:@""];
                    self.voiceMessage = rcVoiceMessage;
                    return nil;

                }
                else {
                    return messageContent;
                }
                
           

        }

    }
    else
    {
        
    if ([messageContent isKindOfClass:[RCImageMessage class]]) {
        messageContent.senderUserInfo = [[RCUserInfo alloc] initWithUserId:[TanLiao_Common getNowUserID] name:[TanLiao_Common getCurrentUserName] portrait:[TanLiao_Common getCurrentAvatarpath]];
        [self sendMediaMessage:messageContent pushContent:nil appUpload:YES];
        return nil;
    } else if ([messageContent isKindOfClass:[RCTextMessage class]]) {
        RCTextMessage *rctextMessage = (RCTextMessage *)messageContent;
        return rctextMessage;
    } else {
        return messageContent;
    }
    }
    
}
-(void)voiceSiLiaoKouFei:(NSString *)str
{
    [self.cloudClient siLiaoKouFei:self.targetId
                             apiId:@"8059"
                           content:str
                          delegate:self
                          selector:@selector(voiceKoFeiSuccess:)
                     errorSelector:@selector(kouFeiError:)];
}
-(void)voiceKoFeiSuccess:(NSDictionary *)info
{
    [[RCIM sharedRCIM] sendMessage:ConversationType_PRIVATE targetId:self.targetId content:self.voiceMessage pushContent:nil pushData:nil success:^(long messageId)
     {
          [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshNotice" object:nil];
         
     } error:^(RCErrorCode nErrorCode, long messageId) {
         [TanLiao_Common showToastView:@"发送失败,请重试" view:self.view];
     }];
    
    [self getUserInformation];
}
-(void)SiLiaoKouFei:(NSString *)str
{
    [self.cloudClient siLiaoKouFei:self.targetId
                             apiId:@"8059"
                           content:str
                          delegate:self
                          selector:@selector(koFeiSuccess:)
                     errorSelector:@selector(kouFeiError:)];
}
-(void)koFeiSuccess:(NSDictionary *)info
{
    
    [[RCIM sharedRCIM] sendMessage:ConversationType_PRIVATE targetId:self.targetId content:self.textMessage pushContent:nil pushData:nil success:^(long messageId)
     {
          [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshNotice" object:nil];
         
     } error:^(RCErrorCode nErrorCode, long messageId) {
         [TanLiao_Common showToastView:@"发送失败,请重试" view:self.view];
     }];
    
   [self getUserInformation];

}
-(void)kouFeiError:(NSDictionary *)info
{
    if ([@"-969" isEqualToString:[info objectForKey:@"code"]]) {
        
        [self.chatSessionInputBarControl.inputTextView resignFirstResponder];
        TanLiaoLiao_YuEBuZuView * tipView = [[TanLiaoLiao_YuEBuZuView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, VIEW_HEIGHT)];
        tipView.delegate = self;
        [self.view addSubview:tipView];
        
    }
    else
    {
        [self getUserInformation];
        [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];

    }
}
- (void)uploadMedia:(RCMessage *)message
     uploadListener:(RCUploadMediaStatusListener *)uploadListener
{
     if ([message.content isKindOfClass:[RCImageMessage class]]) {
         self.mediaMessage = message;
         currentuploadListener = uploadListener;
         RCImageMessage *rcImage = (RCImageMessage *)message.content;
         UIImage * currentImage = [[UIImage alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@.jpg", rcImage.localPath]];
         //开始上传图片
         UIImage * uploadImage = [TanLiao_Common scaleToSize:currentImage size:CGSizeMake(400, 400*(currentImage.size.height/currentImage.size.width))];
         NSData *data = UIImagePNGRepresentation(uploadImage);
         NSString *encodedImageStr = [data base64EncodedStringWithOptions:0];
         NSString *imageType = @"jpg";
         
         [self.cloudClient uploadImage:@"8024"
                     picBody_base64Str:encodedImageStr
                             picFormat:imageType
                                  type:@"1" 
                              delegate:self
                              selector:@selector(uploadSuccess:)
                         errorSelector:@selector(uploadError:)];
     }

    
}
-(void)uploadSuccess:(NSDictionary *)info
{
    //上传成功获得返回路径
    RCImageMessage *content = (RCImageMessage *)self.mediaMessage.content;
    content.imageUrl = [info objectForKey:@"url"];
    currentuploadListener.successBlock(content);
}

-(void)uploadError:(NSDictionary *)info
{
    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];
    currentuploadListener.errorBlock(RC_MSG_RESPONSE_TIMEOUT);
}

- (void)cancelUploadMedia:(RCMessageModel *)model
{
    
}
//点击头像
- (void)didTapCellPortrait:(NSString *)userId
{
    if (![userId isEqualToString:[TanLiao_Common getNowUserID]]) {
        
        if ([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]]) {
            
            MJUserDetailViewController * vc = [[MJUserDetailViewController alloc] init];
            
            vc.anchorId =userId;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            TanLiaoLiao_AnchorDetailMessageViewController * anchorDetailVC = [[TanLiaoLiao_AnchorDetailMessageViewController alloc] init];
            anchorDetailVC.anchorId = userId;
            [self.navigationController pushViewController:anchorDetailVC animated:YES];

        }
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)rightClick
{
    UIActionSheet * action = [[UIActionSheet alloc] initWithTitle:@"举报" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"内容色情",@"内容暴力",@"其他", nil];
    [action showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
if (buttonIndex != 3) {
    
    [TanLiao_Common showToastView:@"举报成功" view:self.view];
    
}
}

@end
