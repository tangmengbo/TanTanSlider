//
//  HuJiaoQingQiuView.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2019/1/30.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HuJiaoQingQiuViewDelegate
@optional


- (void)jieTingHuJiaoView:(NSDictionary *)info ;
-(void)removeHjView:(int)tag;

@end

@interface TanLiaoLiao_HuJiaoQingQiuView : UIView
{
    int viewTag;
}
@property (nonatomic, assign) id<HuJiaoQingQiuViewDelegate> delegate;

@property(nonatomic,strong)NSDictionary * info;
-(void)initHuJiaoTongJiView:(NSDictionary *)info typeStr:(NSString *)typeStr tag:(int)tag;

@end

NS_ASSUME_NONNULL_END
