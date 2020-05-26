//
//  NoticeMessageTableViewCell.m
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLL_NoticeMessageTableViewCell.h"
#import "FQSQ_ChatImageMessage.h"
#import "ChatVideoMessage.h"
#import "FQSQ_ChatVoiceMessage.h"
#import "ChatCallVideoMessage.h"
#import "FQSQ_ChatSendGiftMessage.h"
#import "FQSQ_ChatBusinessCardMessage.h"

@implementation TanLL_NoticeMessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];


    if (self)
    {
        self.headerImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(12*BILI, 10*BILI, 45*BILI, 45*BILI)];
        self.headerImageView.imgType = IMAGEVIEW_TYPE_CENTER;
        self.headerImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.headerImageView.autoresizingMask = UIViewAutoresizingNone;
        self.headerImageView.clipsToBounds = YES;
        [self addSubview:self.headerImageView];
        
        self.headerImageView.hidden = YES;

        self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(self.headerImageView.frame.origin.x+self.headerImageView.frame.size.width+14*BILI,14*BILI,  VIEW_WIDTH-(self.headerImageView.frame.origin.x+self.headerImageView.frame.size.width+40*BILI), 15*BILI)];
        self.titleLable.font = [UIFont systemFontOfSize:15*BILI];
        self.titleLable.textColor = [UIColor blackColor];
        self.titleLable.alpha = 0.9;
        [self addSubview:self.titleLable];


 
        self.messageCountLable = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_WIDTH-35*BILI, 12*BILI, 20*BILI, 15*BILI)];
        self.messageCountLable.textColor = [UIColor whiteColor];
        self.messageCountLable.font = [UIFont systemFontOfSize:10*BILI];
        self.messageCountLable.textAlignment = NSTextAlignmentCenter;
        self.messageCountLable.layer.cornerRadius = 15*BILI/2;
        self.messageCountLable.layer.masksToBounds = YES;
        self.messageCountLable.hidden = YES;
        self.messageCountLable.backgroundColor = [UIColor redColor];
        [self addSubview:self.messageCountLable];


 

        
        self.vipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(41*BILI, 40.5*BILI, 16*BILI, 16*BILI)];
        self.vipImageView.image = [UIImage imageNamed:@"vip_grade_wg_h"];
        [self addSubview:self.vipImageView];
        self.vipImageView.hidden = YES;

 


        
        self.messageLable = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLable.frame.origin.x, self.titleLable.frame.origin.y+self.titleLable.frame.size.height+19*BILI/2, self.titleLable.frame.size.width-40*BILI, 13*BILI)];
        self.messageLable.font = [UIFont systemFontOfSize:12*BILI];
        self.messageLable.textColor = [UIColor blackColor];
        self.messageLable.alpha = 0.5;
        [self addSubview:self.messageLable];


 

 

        
        
        self.timeLbale = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_WIDTH-210*BILI, self.messageLable.frame.origin.y, 200*BILI, 15*BILI)];
        self.timeLbale.font = [UIFont systemFontOfSize:12*BILI];
        self.timeLbale.textColor = [UIColor blackColor];
        self.timeLbale.alpha = 0.5;
        self.timeLbale.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.timeLbale];

        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 65*BILI-1, VIEW_WIDTH, 1)];
        lineView.backgroundColor =UIColorFromRGB(0xf9f9f9);
        [self addSubview:lineView];


 


        
    }
    return self;
}


-(void)initData:(NSDictionary *)info
{
    self.headerImageView.hidden = NO;
    //系统通知
    if(info == nil)
    {
        //没有系统通知显示默认
        self.headerImageView.image = [UIImage imageNamed:@"Combined Shape"];
        self.titleLable.text = @"系统通知";
        self.vipImageView.hidden = YES;
        //self.messageLable.text = @"用户材料申请通知";
       
    }
    else if ( [[info allKeys] containsObject:@"createdAt"] && [[info allKeys] containsObject:@"content"]) {
        
        self.vipImageView.hidden = YES;
        //有系统通知现实最后一条通知内容
        self.headerImageView.image = [UIImage imageNamed:@"Combined Shape"];
        self.titleLable.text = @"系统通知";
        self.messageLable.text =[info objectForKey:@"content"];
        self.messageLable.textColor = [UIColor blackColor];
        
        NSString* string =  [info objectForKey:@"createdAt"];
        NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];



        [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
        [inputFormatter setDateFormat:@"yyyyMMddHHmmss"];
        NSDate* inputDate = [inputFormatter dateFromString:string];
        
        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];


        [outputFormatter setLocale:[NSLocale currentLocale]];
        [outputFormatter setDateFormat:@"MM-dd"];
        NSString *str = [outputFormatter stringFromDate:inputDate];




        self.timeLbale.text = str;


    }
    else
    {
    //聊天记录
    self.headerImageView.image = [UIImage imageNamed:@"Combined Shape"];
    self.titleLable.text = @"系统通知";
    self.messageLable.text = @"用户材料申请通知";
    self.timeLbale.text = @"2010-12";
    self.messageLable.textColor = [UIColor blackColor];

    }
    if ([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]]) {
        
        self.headerImageView.image = [UIImage imageNamed:@"Combined Shape"];
    }
}



-(void)initWithFriendInfo:(NSDictionary *)info conversation:(RCConversation *)conversation
{
    self.headerImageView.hidden = NO;
    
    self.messageLable.textColor = [UIColor blackColor];

    NSString * targateId = conversation.targetId;
    
    int unReadMessNumber =  [[RCIMClient sharedRCIMClient] getUnreadCount:ConversationType_PRIVATE targetId:targateId];
    if (unReadMessNumber !=0) {
        
        self.messageCountLable.hidden = NO;
        self.messageCountLable.text = [NSString stringWithFormat:@"%d",unReadMessNumber];


        if (unReadMessNumber<10) {
            self.messageCountLable.frame = CGRectMake(self.messageCountLable.frame.origin.x, self.messageCountLable.frame.origin.y, 15*BILI, 15*BILI);
        }
        else
        {
        self.messageCountLable.frame = CGRectMake(self.messageCountLable.frame.origin.x, self.messageCountLable.frame.origin.y, 20*BILI, 15*BILI);
        }
    }
    else
    {
        self.messageCountLable.hidden = YES;
    }
    
  
    
    if (![TanLiao_Common isEmpty:[info objectForKey:@"photoUrl"]]) {
        self.headerImageView.urlPath = [info objectForKey:@"photoUrl"];
    } else if(![TanLiao_Common isEmpty:[info objectForKey:@"avatarUrl"]]){
        self.headerImageView.urlPath = [info objectForKey:@"avatarUrl"];
    }
    else
    {
        self.headerImageView.backgroundColor = [UIColor lightGrayColor];

    }
    
    if (![TanLiao_Common isEmpty:[info objectForKey:@"nick"]]) {
        
        self.titleLable.text = [info objectForKey:@"nick"];

    }
    else
    {
        self.titleLable.text =  @"没有昵称";
    }
    if ([conversation.objectName isEqualToString:RCTextMessageTypeIdentifier]) {
        RCTextMessage *textMsg = (RCTextMessage *)conversation.lastestMessage;
        self.messageLable.text = textMsg.content;
    } else if ([conversation.objectName isEqualToString:RCImageMessageTypeIdentifier]) {
        self.messageLable.text = @"[图片]";
    } else if ([conversation.objectName isEqualToString:RCVoiceMessageTypeIdentifier]) {
        self.messageLable.text = @"[语音]";
    }
    else if ([conversation.objectName isEqualToString:RCDVideoMessageTypeIdentifier])
    {
        self.messageLable.text = @"[私密视频]";
    }
    else if ([RCDImageMessageTypeIdentifier isEqualToString:conversation.objectName])
    {
        self.messageLable.text = @"[私密照片]";
    }
    else if ([RCDVoiceMessageTypeIdentifier isEqualToString:conversation.objectName])
    {
        self.messageLable.text = @"[私密语音]";
    }
    else if ([RCDCallVideoMessageTypeIdentifier isEqualToString:conversation.objectName])
    {
        self.messageLable.text = @"[和我视频]";
    }
    else if ([RCDSendGiftMessageTypeIdentifier isEqualToString:conversation.objectName])
    {
        self.messageLable.text = @"[送我个礼物呗]";
    }
    else if([RCDBusinessCardTypeIdentifier isEqualToString:conversation.objectName]){
        self.messageLable.text = @"[关注消息]";
    }
    else
    {
        self.messageLable.text = @"";
    }
    
    self.timeLbale.text = [TanLiao_Common getDateStringByFormateString:@"MM-dd" date:[[NSDate alloc] initWithTimeIntervalSince1970:conversation.sentTime/1000]];

    if ([@"1" isEqualToString:[TanLiao_Common getobjectForKey:[info objectForKey:@"accountType"]]]) {
        if ([@"1" isEqualToString:[TanLiao_Common getobjectForKey:[info objectForKey:@"isVip"]]]) {
            
            self.titleLable.textColor = UIColorFromRGB(0xFF4B4B);
            self.vipImageView.hidden = NO;
        }
        else
        {
            self.titleLable.textColor = [UIColor blackColor];
            self.vipImageView.hidden = YES;
        }
        
    }
    else
    {
        self.titleLable.textColor = [UIColor blackColor];

        self.vipImageView.hidden = YES;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
