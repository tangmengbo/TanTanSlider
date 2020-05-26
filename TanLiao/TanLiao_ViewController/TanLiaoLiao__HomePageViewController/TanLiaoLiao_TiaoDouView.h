//
//  TiaoDouView.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/6/12.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TiaoDouViewDelegate
@required

- (void)faQiTiaoDou:(NSDictionary *)info;


- (void)tiaoDouBottomTap;

@end

@interface TanLiaoLiao_TiaoDouView : UIView

@property (nonatomic, assign) id<TiaoDouViewDelegate> delegate;


@property(nonatomic,strong)UIView * bottomView;


@property(nonatomic,strong)UILabel * ycbmsF9658;
@property(nonatomic,strong)UIScrollView * wzviD434;
@property(nonatomic,strong)UIImageView * kthecwZ90748;
@property(nonatomic,strong)NSDictionary * wujlgcU89533;
@property(nonatomic,strong)UITextView * xilrfP9456;
@property(nonatomic,strong)UIImageView * ttjjJ092;

@property(nonatomic,strong)UIView * contentView;




@property(nonatomic,strong)NSArray * sourceArray;



@property(nonatomic,strong)NSDictionary * selectInfo;



@property(nonatomic,strong)UIScrollView * tiaoDouScrollView;



@property(nonatomic,strong)NSMutableArray * tiaoDouButtonArray;



@property(nonatomic,strong)UIImageView * selectImageView;



@property(nonatomic,strong)UILabel * priceLable;


- (void)initContentView:(NSArray *)sourceList;

@end
