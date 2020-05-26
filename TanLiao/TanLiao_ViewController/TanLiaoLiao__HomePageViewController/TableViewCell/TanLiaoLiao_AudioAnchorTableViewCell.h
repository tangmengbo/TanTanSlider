//
//  AudioAnchorTableViewCell.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/4/17.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AudioAnchorTableViewCellDelegate
@optional


- (void)audioTongHua:(NSDictionary *)info ;

- (void)playAudioButtonClick:(NSDictionary *)info;




@end

@interface TanLiaoLiao_AudioAnchorTableViewCell : UITableViewCell

@property (nonatomic, assign) id<AudioAnchorTableViewCellDelegate> delegate;

@property(nonatomic,strong)NSDictionary * info;

@property(nonatomic,strong)UILabel * yicpfiG21832;
@property(nonatomic,strong)NSDictionary * roctB796;
@property(nonatomic,strong)UITableView * wdrbsxP98559;


-(void)initData:(NSDictionary *)info;

@end
