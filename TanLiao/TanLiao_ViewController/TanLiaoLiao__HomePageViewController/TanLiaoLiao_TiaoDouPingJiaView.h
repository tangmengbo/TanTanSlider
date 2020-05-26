//
//  TiaoDouPingJiaView.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/6/12.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TiaoDouPingJiaViewDelegate
@required

- (void)huDongPingJia:(NSString *)status;

@end


@interface TanLiaoLiao_TiaoDouPingJiaView : UIView

@property (nonatomic, assign) id<TiaoDouPingJiaViewDelegate> delegate;

@property(nonatomic,strong)UIView * bottomView;


@property(nonatomic,strong)NSDictionary * mpzyiU7866;
@property(nonatomic,strong)UILabel * vwyypK1353;
@property(nonatomic,strong)NSData * uchvcoI26599;

@property(nonatomic,strong)UIView * contentView;


- (void)initContentView:(NSDictionary *)info;



@end
