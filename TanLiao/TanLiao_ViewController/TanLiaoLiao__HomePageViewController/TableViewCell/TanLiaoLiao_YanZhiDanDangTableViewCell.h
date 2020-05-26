//
//  YanZhiDanDangTableViewCell.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/4/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol YanZhiDanDangTableViewCellDelegate
@required

- (void)yanZhiDanDangTableViewPushToAnchorDatailVC:(NSDictionary *)info ;
@end

@interface TanLiaoLiao_YanZhiDanDangTableViewCell : UITableViewCell

@property (nonatomic, assign) id<YanZhiDanDangTableViewCellDelegate> delegate;

@property(nonatomic,strong)UIImageView * nbfagqG24635;
@property(nonatomic,strong)NSDictionary * fcgochB07995;



@property(nonatomic,strong)NSDictionary * info;

-(void)initData:(NSDictionary *)info;



@end
