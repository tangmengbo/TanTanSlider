//
//  RCDTestMessageCell.h
//  RCloudMessage
//
//  Created by 岑裕 on 15/12/17.
//  Copyright © 2015年 RongCloud. All rights reserved.
//

#import "FQSQ_ChatImageMessage.h"
#import <RongIMKit/RongIMKit.h>

/*!
 测试消息Cell
 */
@interface ChatImageMessageCell : RCMessageCell



/*!
 文本内容的Label
*/
@property(strong, nonatomic) UILabel *textLabel;

@property(nonatomic,strong)FQSQ_ChatImageMessage * modle;

/*!
 背景View
 */
@property(nonatomic, strong) UIImageView *bubbleBackgroundView;

/*!
 根据消息内容获取显示的尺寸

 @param message 消息内容

 @return 显示的View尺寸
 */
+ (CGSize)getBubbleBackgroundViewSize:(FQSQ_ChatImageMessage *)message;

@end
