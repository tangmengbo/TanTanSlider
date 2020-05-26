//
//  TanKuangQueRenAlert.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/6/13.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TanKuangQueRenAlertDelegate
@optional

- (void)tanKuangQueRenAlertSelectQueDing;

@end

@interface TanLiaoLiao_TanKuangQueRenAlert : UIView

@property (nonatomic, assign) id<TanKuangQueRenAlertDelegate> delegate;

@property(nonatomic,strong)UIView * bottomView;


@property(nonatomic,strong)UILabel * zhzsxiT28518;
@property(nonatomic,strong)NSString * dmweN704;

@property(nonatomic,strong)UIView * contentView;


- (void)initContentView:(NSString *)type title:(NSString *)title content:(NSString *)content message:(NSString *)message;

@end
