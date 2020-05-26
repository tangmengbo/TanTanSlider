//
//  NoticeMessageTableViewCell.h
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TanLL_NoticeMessageTableViewCell : UITableViewCell

@property(nonatomic,strong)TanLiaoCustomImageView * headerImageView;



@property(nonatomic,strong)UIScrollView * pyqdiL7882;
@property(nonatomic,strong)UITextView * qthvT676;
@property(nonatomic,strong)UITextView * aajbqkH48530;
@property(nonatomic,strong)UITableView * rxdvyE6175;





@property(nonatomic,strong)UILabel * titleLable;

@property(nonatomic,strong)NSString * messageNewCountStr;


@property(nonatomic,strong)UILabel * messageLable;

@property(nonatomic,strong)UILabel * timeLbale;

@property(nonatomic,strong)UILabel * messageCountLable;

@property(nonatomic,strong)UIImageView * vipImageView;




-(void)initData:(NSDictionary *)info;



-(void)initWithFriendInfo:(NSDictionary *)info conversation:(RCConversation *)conversation;




@end
