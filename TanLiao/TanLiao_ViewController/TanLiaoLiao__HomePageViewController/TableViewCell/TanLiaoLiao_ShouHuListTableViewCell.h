//
//  ShouHuListTableViewCell.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/6/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TanLiaoLiao_ShouHuListTableViewCell : UITableViewCell

@property(nonatomic,strong)UIView * bottomView;


@property(nonatomic,strong)UIScrollView * gqgteL7185;

-(void)initData:(NSDictionary *)info indexStr:(NSString *)indexStr;

@end
