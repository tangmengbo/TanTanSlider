//
//  HomePageTableViewCell.h
//  FanQieSQ
//
//  Created by mac on 2017/4/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HomePageTableViewCellDelegate
@required
@property(nonatomic,strong)NSDictionary * dxhbC308;
- (void)pushToAnchorDatailVC:(NSDictionary *)info ;
@end






@interface TanLiaoLiao_HomePageTableViewCell : UITableViewCell

@property (nonatomic, assign) id<HomePageTableViewCellDelegate> delegate;

@property(nonatomic,strong)NSDictionary * info;

@property(nonatomic,strong)NSDictionary * info2;



@property(nonatomic,strong)UIView * view1;

@property(nonatomic,strong)UIView * view2;

@property(nonatomic,strong)UIView * pointView1;

@property(nonatomic,strong)UIView * pointView2;

@property(nonatomic,strong)TanLiaoCustomImageView * imageView1;

@property(nonatomic,strong)UIImageView * sexIV1;


@property(nonatomic,strong)UILabel * nameLable1;

@property(nonatomic,strong)UILabel * messageLable1;

@property(nonatomic,strong)TanLiaoCustomImageView * imageView2;


@property(nonatomic,strong)UIImageView * sexIV2;

@property(nonatomic,strong)UILabel * nameLable2;

@property(nonatomic,strong)UILabel * messageLable2;

-(void)initData:(NSDictionary *)info data2:(NSDictionary *)info2 fromWhere:(NSString *)where;

@end
