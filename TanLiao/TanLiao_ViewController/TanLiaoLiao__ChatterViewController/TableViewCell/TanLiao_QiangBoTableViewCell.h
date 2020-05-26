//
//  QiangBoTableViewCell.h
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/6/15.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QiangBoTableViewCellDelegate
@required

- (void)callUser:(NSDictionary *)info ;
@end

@interface TanLiao_QiangBoTableViewCell : UITableViewCell



@property (nonatomic, assign) id<QiangBoTableViewCellDelegate> delegate;

@property(nonatomic,strong)NSDictionary * info;





@property(nonatomic,strong)NSDictionary * ubtqT972;
@property(nonatomic,strong)UIImageView * rhsoW154;
@property(nonatomic,strong)UIView * vmtheG9203;
@property(nonatomic,strong)UIImageView * kvthU280;
@property(nonatomic,strong)NSString * mslmeqZ02332;
@property(nonatomic,strong)NSData * hjuhjeF31964;





@property(nonatomic,strong)TanLiaoCustomImageView * headerImageView;



@property(nonatomic,strong)UIImageView * telImageView ;

@property(nonatomic,strong)UILabel * nameLable;

@property(nonatomic,strong)UIImageView * sexAgeView;



@property(nonatomic,strong)UILabel * ageLable;

@property(nonatomic,strong)UILabel * cityLable;


@property(nonatomic,strong)UIButton * videoButton;



@property(nonatomic,strong)UIImageView * vipImageView;


-(void)initData:(NSDictionary *)info;


@end
