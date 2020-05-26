//
//  RongCloudManager.h
//  FanQieSQ
//
//  Created by pfjhetg on 2017/5/2.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#define ReceivedMessageNotification @"ReceivedMessageNotification"
#define ReceivedGiftNotification  @"ReceivedGiftNotification"
#define VideoGetMessageNotification  @"VideoGetMessageNotification"
#define ZhuBoHuJiaoNotification @"ZhuBoHuJiaoNotification"
#define UnReaderMesCount  @"UnReaderMesCount"

#define RoomReceivedMessageNotification @"RoomReceivedMessageNotification"//收到聊天室文字类型的消息
#define RoomReceivedVoiceMessageNotification @"RoomReceivedVoiceMessageNotification"//收到聊天室文字类型的消息
#define RoomReceivedHuanJieMessageNotification @"RoomReceivedHuanJieMessageNotification"//收到聊天室中信息变化的通知


@interface RongCloudManager : NSObject<RCIMReceiveMessageDelegate, RCIMUserInfoDataSource,RCIMConnectionStatusDelegate>

+ (RongCloudManager *)getInstance;

- (void)connectRongCloud;
- (void)disconnectRongCloud;





@end
