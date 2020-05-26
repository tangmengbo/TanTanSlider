//
//  AnchorPingJiaView.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/6/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AnchorPingJiaViewDelegate
@required

- (void)anchorSubmitPingJia:(NSDictionary *)info tags:(NSArray *)tags startLeve:(NSString *)startLeve;

@end

@interface TanLiaoLiao_AnchorPingJiaView : UIView
{
    int starNumber;
}
@property (nonatomic, assign) id<AnchorPingJiaViewDelegate> delegate;

@property(nonatomic,strong)UIView * bottomView;


@property(nonatomic,strong)UIView * contentView;


@property(nonatomic,strong)NSDictionary * xxxoC676;
@property(nonatomic,strong)NSData * oomelxD30695;
@property(nonatomic,strong)NSDictionary * kumaS490;


@property(nonatomic,strong)NSMutableArray * starArray;


@property(nonatomic,strong)NSArray * sourcePingJiaList;//评价数据源

@property(nonatomic,strong)NSDictionary * anchorInfo;



@property(nonatomic,strong)NSMutableArray * selectedTags;

- (void)initContentView:(NSDictionary *)info;


@end
