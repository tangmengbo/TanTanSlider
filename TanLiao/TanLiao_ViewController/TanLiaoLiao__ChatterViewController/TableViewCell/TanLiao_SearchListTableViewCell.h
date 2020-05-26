//
//  SearchListTableViewCell.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/3/13.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TanLiao_SearchListTableViewCell : UITableViewCell
@property(nonatomic,strong)TanLiaoCustomImageView * headerImageView;


@property(nonatomic,strong)NSDictionary * kyostiY59439;

@property(nonatomic,strong)UILabel * idLable;
@property(nonatomic,strong)UILabel * nameLable;
-(void)initData:(NSDictionary *)info alsoFinish:(NSString *)status;
@end
