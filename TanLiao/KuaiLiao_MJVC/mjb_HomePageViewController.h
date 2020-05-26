//
//  SDwebimageTestViewController.h
//  SeeYou
//
//  Created by 唐蒙波 on 2018/3/23.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"
#import "mjb_PostCardDetailViewController.h"


@interface mjb_HomePageViewController : TanLiao_BaseViewController
{
    float iphoneXShiPei;
}


@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;

@property(nonatomic,strong)NSArray * sourceArray;
@property(nonatomic,strong)TanLiaoCustomImageView * topImageView;
@property(nonatomic,strong)TanLiaoCustomImageView * centerImageView;
@property(nonatomic,strong)TanLiaoCustomImageView * bottomImageView;
@property(nonatomic,strong)TanLiaoCustomImageView * sliderImageView;

@property(nonatomic,strong)TanLiaoCustomImageView * bigImageView;

@property(nonatomic,strong)UIView * sliderMessageView;
@property(nonatomic,strong)UIView * topMessageView;

@property(nonatomic,strong)UIView * topView;
@property(nonatomic,strong)UIView * centerView;
@property(nonatomic,strong)UIView * bottomView;
@property(nonatomic,strong)UIView * sliderView;

@property(nonatomic,strong)UIImageView * loveImageView;
@property(nonatomic,strong)UIImageView * disLoveImageView;

@property(nonatomic,strong)UIButton * disLoveButton;
@property(nonatomic,strong)UIButton * loveButton;
@end
