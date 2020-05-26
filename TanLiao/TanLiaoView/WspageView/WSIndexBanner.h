//
//  WSIndexBanner.h
//  WSCycleScrollView
//
//  Created by iMac on 16/8/10.
//  Copyright © 2016年 sinfotek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSIndexBanner : UIView

@property (nonatomic,strong) UILabel * titleLable;
/**
 *  主图
 */
@property (nonatomic, strong) TanLiaoCustomImageView *mainImageView;

/**
 *  用来变色的view
 */
@property (nonatomic, strong) UIView *coverView;

@property(nonatomic,strong)UIImageView * imageViewLeft;
@property(nonatomic,strong)UIImageView * imageViewRight;

@end
