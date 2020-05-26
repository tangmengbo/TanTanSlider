//
//  BackListTableViewCell.h
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BackListTableViewCellDelegate
@required

- (void)removeFromBlackList:(NSDictionary *)info ;
@end


@interface TanLiao_BackListTableViewCell : UITableViewCell


@property (nonatomic, assign) id<BackListTableViewCellDelegate> delegate;

@property(nonatomic,strong)NSDictionary * info;


@property(nonatomic,strong)NSData * wugyoP4142;
@property(nonatomic,strong)UILabel * rfaymoL53596;


@property(nonatomic,strong)TanLiaoCustomImageView * headerImageView;

@property(nonatomic,strong)UILabel * nameLable;

@property(nonatomic,strong)UILabel * lastMessageLable;

-(void)initData:(NSDictionary *)info ;


@end
