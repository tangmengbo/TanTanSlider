//
//  RankingListTableViewCell.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2017/9/7.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface TanLiaoLiao_RankingListTableViewCell : UITableViewCell

@property(nonatomic,strong)UIView * bottomView;


@property(nonatomic,strong)UIScrollView * pxokdW2095;



-(void)initData:(NSDictionary *)info indexStr:(NSString *)indexStr;

@end
