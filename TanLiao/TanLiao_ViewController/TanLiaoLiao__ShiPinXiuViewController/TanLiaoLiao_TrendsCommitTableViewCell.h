//
//  TrendsCommitTableViewCell.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/4/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TrendsCommitTableViewCellDelegate
@required

- (void)applyOrDeleteButtonClick:(NSDictionary *)info commentId:(NSString *)commentId;
-(void)commitUserHeaderTap:(NSDictionary *)info;


@end

@interface TanLiaoLiao_TrendsCommitTableViewCell : UITableViewCell

@property (nonatomic, assign) id<TrendsCommitTableViewCellDelegate> delegate;

@property (nonatomic,strong)NSDictionary * applyInfo;

@property (nonatomic, strong)NSArray * applyListArray;





-(void)initData:(NSDictionary *)info;


@property(nonatomic,strong)UITableView * kuldxmS77635;
@property(nonatomic,strong)NSDictionary * xdppJ501;
@property(nonatomic,strong)NSString * epdtF315;
@property(nonatomic,strong)UIImageView * nbzigF5464;



@end
