//
//  TuiJianAnchorView.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/6/11.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TuiJianAnchorViewDelegate
@required

- (void)tuiJianAnchorPushToAnchorDetail:(NSDictionary *)info;


@property(nonatomic,strong)UITextView * gaecP561;
@property(nonatomic,strong)NSData * fjgvI451;
@property(nonatomic,strong)NSString * owpxE748;


@end


@interface TanLiaoLiao_TuiJianAnchorView : UIView

@property (nonatomic, assign) id<TuiJianAnchorViewDelegate> delegate;


@property(nonatomic,strong)UIView * bottomView;

@property(nonatomic,strong)UIView * contentView;

@property(nonatomic,strong)NSArray * anchorList;
- (void)initContentView:(NSArray *)anchorList;

@end
