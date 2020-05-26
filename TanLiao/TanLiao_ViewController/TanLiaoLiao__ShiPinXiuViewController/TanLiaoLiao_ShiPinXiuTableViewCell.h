//
//  ShiPinXiuTableViewCell.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2017/10/11.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShiPinXiuTableViewCellDelegate
@required

- (void)pushToShiPinXiuDetailVC:(NSDictionary *)info index:(int)index;
@end

@interface TanLiaoLiao_ShiPinXiuTableViewCell : UITableViewCell
{
    
    int ornginIndex1;
    int ornginIndex2;
}

@property (nonatomic, assign) id<ShiPinXiuTableViewCellDelegate> delegate;


@property(nonatomic,strong)UIView * view1;

@property(nonatomic,strong)UIView * view2;

@property(nonatomic,strong)NSDictionary * info1;

@property(nonatomic,strong)NSDictionary * info2;

-(void)initData:(NSDictionary *)info1 index1:(int)index1 data2:(NSDictionary *)info2 index2:(int)index2;


@end
