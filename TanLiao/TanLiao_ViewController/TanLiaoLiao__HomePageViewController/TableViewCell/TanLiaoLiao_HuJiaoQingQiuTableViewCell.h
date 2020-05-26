//
//  HuJiaoQingQiuTableViewCell.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2019/1/24.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol HuJiaoQingQiuTableViewCellDelegate
@optional


- (void)jieTingHuJiao:(NSDictionary *)info ;


@end
@interface TanLiaoLiao_HuJiaoQingQiuTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel * whxqtqY76090;

@property (nonatomic, assign) id<HuJiaoQingQiuTableViewCellDelegate> delegate;

@property(nonatomic,strong)NSDictionary * info;



-(void)initData:(NSDictionary *)info ;
@end

NS_ASSUME_NONNULL_END
