//
//  NewHomePageTableViewCell.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/4/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NewHomePageTableViewCellDelegate
@required

- (void)newPushToAnchorDatailVC:(NSDictionary *)info ;
@end

@interface TanLiaoLiao_NewHomePageTableViewCell : UITableViewCell

@property (nonatomic, assign) id<NewHomePageTableViewCellDelegate> delegate;

@property(nonatomic,strong)UIView * view1;
@property(nonatomic,strong)TanLiaoCustomImageView * headerImageView1;
@property(nonatomic,strong)UILabel * nameLable1;
@property(nonatomic,strong)UIImageView * vipImageView1;
@property(nonatomic,strong)UILabel * messageLable1;

@property(nonatomic,strong)UIView * view2;
@property(nonatomic,strong)TanLiaoCustomImageView * headerImageView2;
@property(nonatomic,strong)UILabel * nameLable2;
@property(nonatomic,strong)UIImageView * vipImageView2;
@property(nonatomic,strong)UILabel * messageLable2;

@property(nonatomic,strong)UIView * view3;
@property(nonatomic,strong)TanLiaoCustomImageView * headerImageView3;
@property(nonatomic,strong)UILabel * nameLable3;
@property(nonatomic,strong)UIImageView * vipImageView3;
@property(nonatomic,strong)UILabel * messageLable3;

-(void)initData:(NSDictionary *)info1 data2:(NSDictionary *)info2 data3:(NSDictionary *)info3;

@property(nonatomic,strong)NSDictionary * info1;

@property(nonatomic,strong)NSDictionary * info2;

@property(nonatomic,strong)NSDictionary * info3;

@end
