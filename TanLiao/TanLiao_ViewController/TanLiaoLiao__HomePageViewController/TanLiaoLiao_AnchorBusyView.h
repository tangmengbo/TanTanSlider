//
//  AnchorBusyView.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/6/9.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AnchorBusyViewDelegate
@required

- (void)busySiLiaoButtonClick;

-(void)busyAnchorTap:(NSString *)userId;

@end

@interface TanLiaoLiao_AnchorBusyView : UIView

@property (nonatomic, assign) id<AnchorBusyViewDelegate> delegate;


@property(nonatomic,strong)UIView * bottomView;

@property(nonatomic,strong)UIView * contentView;


@property(nonatomic,strong)UITextView * bblwlA9944;
@property(nonatomic,strong)UIImageView * nekmgU5957;
@property(nonatomic,strong)UIView * uwmhnT5431;


@property(nonatomic,strong)NSArray * anchorArray;



- (void)initContentView:(NSArray *)anchorList;

@end
