//
//  ShiPinXiuPingLunTableViewCell.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2017/10/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShiPinXiuPingLunTableViewCellDelegate
@required

- (void)pushToAnchorDatailVC:(NSDictionary *)info ;
@end

@interface TanLiaoLiao_ShiPinXiuPingLunTableViewCell : UITableViewCell

@property (nonatomic,strong)NSString * fromWhere;
@property (nonatomic, assign) id<ShiPinXiuPingLunTableViewCellDelegate> delegate;

@property(nonatomic,strong)NSDictionary * info;



@property(nonatomic,strong)UIView * bottomView;


@property(nonatomic,strong)UIImageView * ygshmP6749;
@property(nonatomic,strong)UIView * fhweW897;



@property(nonatomic,strong)UILabel * nameLable;

@property(nonatomic,strong)UILabel *pingLunLable;

-(void)initData:(NSDictionary *)info ;

@end
