//
//  SetSignViewController.h
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"

@protocol SetSignViewControllerDelegate
@required

- (void)setSign:(NSString *)sign ;
@end

@interface TanLiao__SetSignViewController : TanLiao_BaseViewController<UITextViewDelegate>

@property (nonatomic, assign) id<SetSignViewControllerDelegate> delegate;


@property(nonatomic,strong)NSString * sign;


@property(nonatomic,strong)UIScrollView * ccwoK424;
@property(nonatomic,strong)UIScrollView * hpqbpD7388;


@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;

@property(nonatomic,strong)UILabel * tipsLable;

@property(nonatomic,strong)UITextView *  textView;


@property(nonatomic,strong)UIButton * submitButton;

@end
