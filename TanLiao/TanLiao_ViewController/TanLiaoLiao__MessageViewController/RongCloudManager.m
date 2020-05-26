
//
//  RongCloudManager.m
//  FanQieSQ
//
//  Created by pfjhetg on 2017/5/2.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "RongCloudManager.h"
#import "FQSQ_ChatImageMessage.h"
#import "FQSQ_ChatVoiceMessage.h"
#import "ChatVideoMessage.h"
#import "ContactMessage.h"
#import "YLCustom.h"

#import "ChatCallVideoMessage.h"
#import "FQSQ_ChatSendGiftMessage.h"
#import "FQSQ_ChatBusinessCardMessage.h"
#import "ChatGroupGiftMsgMessage.h"
NSString *const rongCloudAppKey = RYKey;

@implementation RongCloudManager

+ (RongCloudManager *)getInstance {
    static dispatch_once_t pred;
    static RongCloudManager *singletonInstance = nil;
    [RCIM sharedRCIM].disableMessageAlertSound = YES;
    

    dispatch_once(&pred, ^{
        singletonInstance = [[self alloc] init];
    });
    return singletonInstance;
}

- (id)init {
    if ((self = [super init])) {
        [[RCIM sharedRCIM] initWithAppKey:rongCloudAppKey];
        [[RCIM sharedRCIM] setReceiveMessageDelegate:self];
        [[RCIM sharedRCIM] setConnectionStatusDelegate:self];
        [[RCIM sharedRCIM] setUserInfoDataSource:self];
        [RCIM sharedRCIM].enableMessageAttachUserInfo = YES;
        [RCIM sharedRCIM].enablePersistentUserInfoCache = YES;
        [RCIM sharedRCIM].enableMessageRecall = YES;
      
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationWillEnterForeground)
                                                     name:UIApplicationWillEnterForegroundNotification
                                                   object:nil];
    }
    // 注册自定义测试消息
    // 注册自定义测试消息
    [[RCIM sharedRCIM] registerMessageType:[ContactMessage class]];//好友消息
    [[RCIM sharedRCIM] registerMessageType:[FQSQ_ChatImageMessage class]];
     [[RCIM sharedRCIM] registerMessageType:[ChatVideoMessage class]];
     [[RCIM sharedRCIM] registerMessageType:[FQSQ_ChatVoiceMessage class]];
     [[RCIM sharedRCIM] registerMessageType:[ChatCallVideoMessage class]];
     [[RCIM sharedRCIM] registerMessageType:[FQSQ_ChatSendGiftMessage class]];
    [[RCIM sharedRCIM] registerMessageType:[FQSQ_ChatBusinessCardMessage class]];
    [[RCIM sharedRCIM] registerMessageType:[ChatGroupGiftMsgMessage class]];
    [[RCIM sharedRCIM] registerMessageType:[YLCustom class]];//聊天室自定义消息

    return self;
}

- (void)connectRongCloud {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * userInfo = [defaults objectForKey:USERINFO];
    NSString *loginToken = [userInfo objectForKey:@"face_token"];
    if([[RCIMClient sharedRCIMClient] getConnectionStatus] != ConnectionStatus_Connected) {
        [[RCIM sharedRCIM] connectWithToken:loginToken success:^(NSString *userId) {
            NSLog(@"融云 登陆成功。当前登录的用户ID：%@", userId);
            [RCIM sharedRCIM].currentUserInfo = [[RCUserInfo alloc] initWithUserId:[TanLiao_Common getNowUserID] name:[TanLiao_Common getCurrentUserName] portrait:[TanLiao_Common getCurrentAvatarpath]];
        } error:^(RCConnectErrorCode status) {
            NSLog(@"融云 登陆的错误码为:%ld", (long)status);
        } tokenIncorrect:^{
            //token过期或者不正确。
            //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
            //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
            NSLog(@"融云 token错误");
        }];
    }
}
//断开与融云的链接但是接收推送
-(void)disconnectRongCloud
{
    [[RCIM sharedRCIM] disconnect:YES];
    NSLog(@"融云 断开连接");
}
/*!
 获取用户信息
 @param userId                  用户ID
 @param completion              获取用户信息完成之后需要执行的Block
 @param userInfo(in completion) 该用户ID对应的用户信息
 @discussion SDK通过此方法获取用户信息并显示，请在completion中返回该用户ID对应的用户信息。
 在您设置了用户信息提供者之后，SDK在需要显示用户信息的时候，会调用此方法，向您请求用户信息用于显示。
 */
- (void)getUserInfoWithUserId:(NSString *)userId
                   completion:(void (^)(RCUserInfo *userInfo))completion {
    RCUserInfo *userInfo;
    if ([userId isEqualToString:[TanLiao_Common getNowUserID]]) {
        userInfo = [[RCUserInfo alloc] initWithUserId:[TanLiao_Common getNowUserID] name:[TanLiao_Common getCurrentUserName] portrait:[TanLiao_Common getCurrentAvatarpath]];
        completion(userInfo);
    } else {
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *info = [defaults objectForKey:userId];
        userInfo = [[RCUserInfo alloc] initWithUserId:info[@"userId"] name:info[@"nick"] portrait:info[@"avatarUrl"]];
        completion(userInfo);
    }
}

/*!
 接收消息的回调方法
 
 @param message     当前接收到的消息
 @param left        还剩余的未接收的消息数，left>=0
 
 @discussion 如果您设置了IMKit消息监听之后，SDK在接收到消息时候会执行此方法（无论App处于前台或者后台）。
 其中，left为还剩余的、还未接收的消息数量。比如刚上线一口气收到多条消息时，通过此方法，您可以获取到每条消息，left会依次递减直到0。
 您可以根据left数量来优化您的App体验和性能，比如收到大量消息时等待left为0再刷新UI。
 */
- (void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left {
    
    
     RCImageMessage * msgs = (RCImageMessage *)message.content;
    
    if ( message.conversationType == ConversationType_CHATROOM)
    {
        if ([message.objectName isEqualToString:@"RC:TxtMsg"])//收到文字消息
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:RoomReceivedMessageNotification object:message];
        }
        else if ([message.objectName isEqualToString:@"RC:VcMsg"])//收到语音消息
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:RoomReceivedVoiceMessageNotification object:message];
            
        }else if ([message.objectName isEqualToString:@"YL:Custom"])//自定义推送消息
        {
            YLCustom * customMessage = (YLCustom *)message.content;
            NSDictionary * customInfo = [TanLiao_Common dictionaryWithJsonString:customMessage.content];
            
            NSString * systemTime = [customInfo objectForKey:@"systemTime"];
            NSLog(@"%@",customInfo);
            if (![TanLiao_Common isEmpty:systemTime])
            {
                int timeDistance = [TanLiao_Common getTimeDistanceSinceNow:systemTime];//如果后台系统发送时间与当前时间间隔过大就不处理
                if (timeDistance>10) {
                    return;
                }
            }
            NSString * timeStr = [TanLiao_Common getTimestamp:[NSDate new]];
            //如果消息发送时间与当前时间间隔过大就不处理
            if(timeStr.intValue-(int)(message.sentTime/1000)>20)
            {
                return;
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:RoomReceivedHuanJieMessageNotification object:customInfo];
            NSLog(@"%@",customMessage.content);
        }
        NSArray *msgIdArray = [[NSArray alloc]initWithObjects:@(message.messageId), nil];
        [[RCIMClient sharedRCIMClient] deleteMessages:msgIdArray];
        
        
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ReceivedMessageNotification object:nil userInfo:@{@"message":message}];
    if ([@"SY:GroupGiftMsg" isEqualToString:message.objectName])
    {
        ChatGroupGiftMsgMessage * content =(ChatGroupGiftMsgMessage *) message.content;
        NSString * json = content.extra;
        NSDictionary * giftInfo = [TanLiao_Common dictionaryWithJsonString:json];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"allGiftNotification" object:giftInfo];
        //删除消息
        NSArray *msgIdArray = [[NSArray alloc]initWithObjects:@(message.messageId), nil];
        [[RCIMClient sharedRCIMClient] deleteMessages:msgIdArray];
        return;
    }
    if([@"RC:TxtMsg" isEqualToString:message.objectName])
    {
        RCTextMessage * content =(RCTextMessage *) message.content;
        NSString * json = content.extra;
        NSDictionary * giftInfo = [TanLiao_Common dictionaryWithJsonString:json];
        NSLog(@"%@",content.senderUserInfo);
        if([giftInfo isKindOfClass:[NSDictionary class]] && [[giftInfo allKeys] containsObject:@"type"])
        {
            
            if ([@"one_click" isEqualToString:[giftInfo objectForKey:@"type"]]) {
                
                NSString * timeStr = [TanLiao_Common getTimestamp:[NSDate new]];
                //时间差值
                if(timeStr.intValue-(int)(message.sentTime/1000)>10)
                {
                    NSLog(@"%d,%d,%d",timeStr.intValue,(int)(message.sentTime/1000),timeStr.intValue-(int)(message.sentTime/1000));
                    
                    return;
                }
                [[NSNotificationCenter defaultCenter] postNotificationName:@"userCallWaitingNotification" object:giftInfo];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"baseViewuserCallWaitingNotification" object:giftInfo];

                //删除消息
                NSArray *msgIdArray = [[NSArray alloc]initWithObjects:@(message.messageId), nil];
                [[RCIMClient sharedRCIMClient] deleteMessages:msgIdArray];

                return;

            }
            //用户收到主播呼叫
            if ([@"call_back" isEqualToString:[giftInfo objectForKey:@"type"]]) {
                
                //删除消息
                NSArray *msgIdArray = [[NSArray alloc]initWithObjects:@(message.messageId), nil];
                [[RCIMClient sharedRCIMClient] deleteMessages:msgIdArray];

                if ([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]]) {
                    
                    return;
                }
                
                NSString * timeStr = [TanLiao_Common getTimestamp:[NSDate new]];
                //判断主播呼叫时间与收到消息时间的差值
                if(timeStr.intValue-(int)(message.sentTime/1000)>60)
                {
                    NSLog(@"%d,%d,%d",timeStr.intValue,(int)(message.sentTime/1000),timeStr.intValue-(int)(message.sentTime/1000));
                    
                    return;
                }
                
                NSString *  recordId = [giftInfo objectForKey:@"recordId"];
                NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:recordId forKey:@"tongHuaJiLuRecordId"];
                [defaults synchronize];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:ZhuBoHuJiaoNotification object:giftInfo];
                return;
            }
        }
        if([giftInfo isKindOfClass:[NSDictionary class]] && [[giftInfo allKeys] containsObject:@"type"])
        {
            //用户发起挑逗主播端展示
            if([@"lure" isEqualToString:[giftInfo objectForKey:@"type"]])
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"getTiaoDouMessgae" object:giftInfo];
                //删除消息
                NSArray *msgIdArray = [[NSArray alloc]initWithObjects:@(message.messageId), nil];
                [[RCIMClient sharedRCIMClient] deleteMessages:msgIdArray];
                return;
            }
        }
        if([giftInfo isKindOfClass:[NSDictionary class]] && [[giftInfo allKeys] containsObject:@"type"])
        {
            //扣费成功给主播端发送消息
            if([@"video" isEqualToString:[giftInfo objectForKey:@"type"]])
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"kouFeiSuccess" object:giftInfo];
                //删除消息
                NSArray *msgIdArray = [[NSArray alloc]initWithObjects:@(message.messageId), nil];
                [[RCIMClient sharedRCIMClient] deleteMessages:msgIdArray];
                return;
            }
        }
        //视频时有用户送礼物给主播
        if([giftInfo isKindOfClass:[NSDictionary class]] && [[giftInfo allKeys] containsObject:@"type"])
        {
            if([@"GP_GIFT" isEqualToString:[giftInfo objectForKey:@"type"]])
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"allGiftNotification" object:giftInfo];
                //删除消息
                NSArray *msgIdArray = [[NSArray alloc]initWithObjects:@(message.messageId), nil];
                [[RCIMClient sharedRCIMClient] deleteMessages:msgIdArray];
                return;
            }
        }
        
        if([giftInfo isKindOfClass:[NSDictionary class]] && [[giftInfo allKeys] containsObject:@"type"]&& [[giftInfo allKeys] containsObject:@"txtInfo"])
        {
           [[NSNotificationCenter defaultCenter] postNotificationName:ReceivedGiftNotification object:giftInfo];
        }
        if ([giftInfo isKindOfClass:[NSDictionary class]] && [[giftInfo allKeys] containsObject:@"cityName"]) {
            
            
            NSString * timeStr = [TanLiao_Common getTimestamp:[NSDate new]];
            //判断主播呼叫时间与收到消息时间的差值
            if(timeStr.intValue-(int)(message.sentTime/1000)>60)
            {
                NSLog(@"%d,%d,%d",timeStr.intValue,(int)(message.sentTime/1000),timeStr.intValue-(int)(message.sentTime/1000));
                
                return;
            }
            
            NSUserDefaults * defaultsPush = [NSUserDefaults standardUserDefaults];
            NSArray * array = [defaultsPush objectForKey:@"pushList"];
            NSMutableArray * allArray = [NSMutableArray array];
            for (int i=0; i<array.count; i++) {
                
                if (i==5) {
                    break;
                }
                [allArray addObject:[array objectAtIndex:i]];
            }
            BOOL alsoHave = NO;
            NSNumber * newIdNumber = [giftInfo objectForKey:@"from_userId"];
            
            NSString * newIdStr = [NSString stringWithFormat:@"%d",newIdNumber.intValue];
            for (int i=0; i<allArray.count; i++) {
                NSDictionary * info = [allArray objectAtIndex:i];
                NSNumber * idNumber = [info objectForKey:@"from_userId"];
                
                NSString * idStr = [NSString stringWithFormat:@"%d",idNumber.intValue];
                if ([idStr isEqualToString:newIdStr]) {
                    alsoHave = YES;
                     ;
                }
            }
            
            if (alsoHave ==NO) {
                
                [allArray insertObject:giftInfo atIndex:0];


            }

            [defaultsPush setObject:allArray forKey:@"pushList"];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"GETPUSHER" object:nil];

            return;
        }
      
    }
    
        //删除送礼送信息
    if ([message.objectName isEqualToString:RCTextMessageTypeIdentifier]) {
        RCTextMessage *rctext = (RCTextMessage*)message.content;
        NSData *jsonData = [rctext.content dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        id dic;
        if (jsonData) {
            
            dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingMutableContainers
                                                      error:&err];
        }
        
        
        RCTextMessage *rctext1 = (RCTextMessage*)message.content;
        NSString * json = rctext1.extra;
        
        if (json) {
            if ([json containsString:@"from_userId"]&&[json containsString:@"cityName"]) {
                //删除消息
                NSArray *msgIdArray = [[NSArray alloc]initWithObjects:@(message.messageId), nil];
                [[RCIMClient sharedRCIMClient] deleteMessages:msgIdArray];
                return;
            }
        }
        
        if (dic) {
            if (dic[@"type"]) {
                //删除消息
                NSArray *msgIdArray = [[NSArray alloc]initWithObjects:@(message.messageId), nil];
                [[RCIMClient sharedRCIMClient] deleteMessages:msgIdArray];
                return;
            }
        }
        
        if ([@"RC:TxtMsg" isEqualToString:message.objectName]) {
            
            RCTextMessage * textMessage =(RCTextMessage *) message.content;
            
            NSDictionary * messageInVideo = [[NSDictionary alloc] initWithObjectsAndKeys:message.senderUserId,@"sendUserId",textMessage.content,@"content",textMessage.senderUserInfo.name,@"sendUserName",message.targetId,@"targetId" ,nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:VideoGetMessageNotification object:messageInVideo];
            
        }
        
    }
    
    if ([@"RC:TxtMsg" isEqualToString:message.objectName])
    {
        RCTextMessage * textMessage = (RCTextMessage *)message.content;
        NSString * extra =textMessage.extra;
        
        NSDictionary * info = [TanLiao_Common dictionaryWithJsonString:extra];
        if ([info isKindOfClass:[NSDictionary class]]&&[info allKeys].count>0) {
            
            if ([@"SHTG" isEqualToString:[TanLiao_Common getobjectForKey:[info objectForKey:@"code"]]])
            {
                NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:[TanLiao_Common removeNullFromDictionary:info] forKey:@"DefaultsAuthentication"];
                [defaults synchronize];
            }
            
            
        }
        
    }


    int unReadMesNumber = [[RCIMClient sharedRCIMClient] getUnreadCount:@[@(ConversationType_PRIVATE)]];
    [[NSNotificationCenter defaultCenter] postNotificationName:UnReaderMesCount object:[NSString stringWithFormat:@"%d",unReadMesNumber]];
   
}
//用户被挤掉下线

- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status
{
    if (status==ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT)
    {
        //退出融云
        [[RCIM sharedRCIM] logout];
        [[RCIM sharedRCIM] disconnect];
        //退出网易云登录
        [[[NIMSDK sharedSDK] loginManager] logout:^(NSError *error)
         {
             extern NSString *NTESNotificationLogout;
             [[NSNotificationCenter defaultCenter] postNotificationName:NTESNotificationLogout object:nil];
         }];
        
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:nil forKey:USERINFO];
        [defaults synchronize];
        
        
        AppDelegate * appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [appDelegate resetNotLoginTabBar];
        
        CGSize oneLineSize = [TanLiao_Common setSize:@"您的账号已在其他设备登录,请重新登录" withCGSize:CGSizeMake(VIEW_WIDTH-(146*USERCC*2), VIEW_HEIGHT) withFontSize:12*BILI];
        
        UIButton * tipButton = [[UIButton alloc] initWithFrame:CGRectMake((VIEW_WIDTH-oneLineSize.width-20)/2,(VIEW_HEIGHT-40*BILI)/2, oneLineSize.width+20, 40)];
        tipButton.enabled = NO;
        tipButton.alpha = 0.8;
        tipButton.layer.cornerRadius = 20;
        tipButton.backgroundColor = [UIColor blackColor];
        [tipButton setTitle:@"您的账号已在其他设备登录,请重新登录" forState:UIControlStateNormal];
        [tipButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        tipButton.titleLabel.font = [UIFont systemFontOfSize:12*BILI];
        tipButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [[UIApplication sharedApplication].keyWindow addSubview:tipButton];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:3];
        tipButton.alpha = 0;
        [UIView commitAnimations];
    }
}

- (void)applicationWillEnterForeground {
    if([[RCIMClient sharedRCIMClient] getConnectionStatus] != ConnectionStatus_Connected) {
        [[RCIM sharedRCIM] connectWithToken:@"YourTestUserToken" success:^(NSString *userId) {
            NSLog(@"融云 登陆成功。当前登录的用户ID：%@", userId);
        } error:^(RCConnectErrorCode status) {
            NSLog(@"融云 登陆的错误码为:%ld", (long)status);
        } tokenIncorrect:^{
            //token过期或者不正确。
            //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
            //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
            NSLog(@"融云 token错误");
        }];
    }
}

- (void)dealloc {
    
}

@end
