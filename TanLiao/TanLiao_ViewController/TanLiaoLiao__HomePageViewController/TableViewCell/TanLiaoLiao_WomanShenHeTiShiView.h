//
//  WomanShenHeTiShiView.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2019/1/24.
//  Copyright © 2019年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WomanShenHeTiShiViewDelegate
@required

-(void)lianXiKeFu;
-(void)LiJiRenZheng;
@end

@interface TanLiaoLiao_WomanShenHeTiShiView : UIView

@property (nonatomic, assign) id<WomanShenHeTiShiViewDelegate> delegate;

@property(nonatomic,strong)UIScrollView * wgsybuL90029;


-(void)initWomanShenHeTiShiView:(NSString *)role_vedio titleStr:(NSString *)titleStr;



@end

NS_ASSUME_NONNULL_END
