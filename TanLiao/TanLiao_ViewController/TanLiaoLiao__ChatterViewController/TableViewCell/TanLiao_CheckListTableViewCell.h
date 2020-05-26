//
//  CheckListTableViewCell.h
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/11.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TanLiao_CheckListTableViewCell : UITableViewCell


@property(nonatomic,strong)TanLiaoCustomImageView * headerImageView;



@property(nonatomic,strong)UITableView * rcclnaA10444;
@property(nonatomic,strong)UILabel * dppmG954;
@property(nonatomic,strong)UIView * rilgV925;




@property(nonatomic,strong)UILabel * nameLable;
@property(nonatomic,strong)UIImageView * sexImageView;

@property(nonatomic,strong)UILabel * ageLable;
@property(nonatomic,strong)UILabel * messageLable;


-(void)initData:(NSDictionary *)info;



@end
