//
//  CustomImageView.h
//  DidiTravel
//
//  Created by Apple_yjh on 15-4-16.
//  Copyright (c) 2015年 yjh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageCache.h"

typedef enum {
    IMAGEVIEW_TYPE_NONE = 0,
    IMAGEVIEW_TYPE_CENTER,
    IMAGEVIEW_TYPE_BORDERCENTER
} IMAGEVIEW_TYPE;


@interface TanLiaoCustomImageView : UIImageView

@property (nonatomic, copy) NSString* urlPath;
@property (nonatomic, strong) UIImage * defaultImage;
@property (nonatomic, strong) UIColor * borderColor;
@property (nonatomic, assign) CGFloat  borderWidth;

@property (nonatomic, assign) IMAGEVIEW_TYPE imgType;
-(void)noPlacehold;


@end
