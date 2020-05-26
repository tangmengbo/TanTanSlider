//
//  VideoRecordTableViewCell.h
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/5/9.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VideoRecordTableViewCellDelegate
@required

- (void)pushToAnchorDatailVC:(NSDictionary *)info ;
-(void)anchorPingJia:(NSDictionary *)info;




@property(nonatomic,strong)UIScrollView * svwrjkN76026;
@property(nonatomic,strong)UIImageView * vbobdA2483;
@property(nonatomic,strong)NSData * elnhN396;
@property(nonatomic,strong)NSData * dceatfW16545;
@property(nonatomic,strong)NSString * odopauC78091;
@property(nonatomic,strong)UIView * wuxskD1768;
@property(nonatomic,strong)UILabel * kqwqT010;




@end

@interface TanLL_VideoRecordTableViewCell : UITableViewCell

@property (nonatomic, assign) id<VideoRecordTableViewCellDelegate> delegate;

@property(nonatomic,strong)UIView * bottomView;



@property(nonatomic,strong)NSDictionary * info;


@property(nonatomic,strong)TanLiaoCustomImageView * headerImageView;



@property(nonatomic,strong)UIImageView * telImageView ;

@property(nonatomic,strong)UILabel * nameLable;

@property(nonatomic,strong)UILabel * freeOrBusyLable;


@property(nonatomic,strong)UILabel * timeLable;

@property(nonatomic,strong)UIButton * videoButton;




@property(nonatomic,strong)UIButton * pingJiaButton;





-(void)initData:(NSDictionary *)info;




@end
