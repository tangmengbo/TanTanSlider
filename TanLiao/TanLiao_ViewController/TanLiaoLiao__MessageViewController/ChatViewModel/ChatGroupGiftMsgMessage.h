//
//  ChatGroupGiftMsgMessage.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/4/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <RongIMLib/RongIMLib.h>

/*!
 测试消息的类型名
 */
#define RCDGroupGiftTypeIdentifier @"SY:GroupGiftMsg"


/*!
 Demo测试用的自定义消息类
 
 @discussion Demo测试用的自定义消息类，此消息会进行存储并计入未读消息数。
 */

@interface ChatGroupGiftMsgMessage : RCMessageContent

/*!
 测试消息的内容
 */
@property(nonatomic, strong) NSString *content;

/*!
 测试消息的附加信息
 */
@property(nonatomic, strong) NSString *extra;

/*!
 初始化测试消息
 
 @param content 文本内容
 @return        测试消息对象
 */
+ (instancetype)messageWithContent:(NSString *)content;
@end
