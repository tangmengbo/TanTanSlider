//
//  NewShiPinXiuPingLunTableViewCell.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/6/6.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NewShiPinXiuPingLunTableViewCellDelegate
@optional

- (void)pushToAnchorDatailVC:(NSString *)idStr ;
@end

@interface TanLiaoLiao_NewShiPinXiuPingLunTableViewCell : UITableViewCell


@property(nonatomic,strong)NSDictionary * rmobG676;


@property (nonatomic, assign) id<NewShiPinXiuPingLunTableViewCellDelegate> delegate;

@property(nonatomic,strong)NSDictionary * info;


-(void)initData:(NSDictionary *)info ;

@end
