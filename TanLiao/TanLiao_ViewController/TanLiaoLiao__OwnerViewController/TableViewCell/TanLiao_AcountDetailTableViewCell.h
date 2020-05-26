//
//  AcountDetailTableViewCell.h
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TanLiao_AcountDetailTableViewCell : UITableViewCell

-(void)initData:(NSDictionary *)info ;

@property(nonatomic,strong)TanLiaoCustomImageView * tipImageView;

@property(nonatomic,strong)UILabel * titleLable;


@property(nonatomic,strong)UILabel * messageLable;

@property(nonatomic,strong)UILabel * moneyLable;


@property(nonatomic,strong)UIImageView * ftvrJ984;




@end
