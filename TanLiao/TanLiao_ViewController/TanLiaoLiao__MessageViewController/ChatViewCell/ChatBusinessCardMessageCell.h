//
//  BusinessCardMessageCell.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/3/5.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "FQSQ_ChatBusinessCardMessage.h"
#import <RongIMKit/RongIMKit.h>

@interface ChatBusinessCardMessageCell : RCMessageCell
/*!
 文本内容的Label
 */
@property(strong, nonatomic) UILabel *textLabel;

@property(nonatomic,strong)FQSQ_ChatBusinessCardMessage * modle;

/*!
 背景View
 */
@property(nonatomic, strong) UIImageView *bubbleBackgroundView;

/*!
 根据消息内容获取显示的尺寸
 
 @param message 消息内容
 
 @return 显示的View尺寸
 */
+ (CGSize)getBubbleBackgroundViewSize:(FQSQ_ChatBusinessCardMessage *)message;

@end
