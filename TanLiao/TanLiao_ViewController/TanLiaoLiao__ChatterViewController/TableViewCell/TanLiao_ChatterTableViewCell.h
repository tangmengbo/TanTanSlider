//
//  ChatterTableViewCell.h
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol KLiao_ChatterTableViewCellDelegate
@required

- (void)chatButtonClick:(NSDictionary *)info ;
@end


@interface TanLiao_ChatterTableViewCell : UITableViewCell

@property (nonatomic, assign) id<KLiao_ChatterTableViewCellDelegate> delegate;

@property(nonatomic,strong)TanLiaoCustomImageView * headerImageView;

@property(nonatomic,strong)NSDictionary * info;


@property(nonatomic,strong)UILabel * uixweF8625;
@property(nonatomic,strong)UIImageView * kbrutG5804;
@property(nonatomic,strong)NSDictionary * abqtdrI31379;




@property(nonatomic,strong)UILabel * nameLable;
@property(nonatomic,strong)UIImageView * vipImageView;

-(void)initData:(NSDictionary *)info;



@end
