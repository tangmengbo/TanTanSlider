//
//  TrendsTableViewCell.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/4/8.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TrendsTableViewCellDelegate
@optional

- (void)deleteTrend:(NSDictionary *)info;


@property(nonatomic,strong)NSData * rxlnaS1253;
@property(nonatomic,strong)UIView * zhcqkgR33287;
@property(nonatomic,strong)UIView * ecmtC359;
@property(nonatomic,strong)NSDictionary * xwkzoyM73690;


-(void)zanTrends:(NSDictionary *)info;



@end

@interface KuaiLiao_TrendsTableViewCell : UITableViewCell

@property (nonatomic, assign) id<TrendsTableViewCellDelegate> delegate;

@property(nonatomic,strong)NSDictionary * trendInfo;



-(void)initData:(NSDictionary *)info;


@end
