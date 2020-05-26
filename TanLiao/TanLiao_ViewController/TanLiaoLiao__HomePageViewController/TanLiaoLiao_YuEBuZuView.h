//
//  YuEBuZuView.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/6/8.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol YuEBuZuViewDelegate
@required

- (void)YuEBuZuPushToRechargeView;


@property(nonatomic,strong)UITextView * ttsuurA99294;
@property(nonatomic,strong)UITableView * jcqwP450;

@end

@interface TanLiaoLiao_YuEBuZuView : UIView

@property(nonatomic,strong)UIView * bottomView;



@property(nonatomic,strong)UIView * contentView;



@property (nonatomic, assign) id<YuEBuZuViewDelegate> delegate;

@end
