//
//  UIImage+Additions.h
//  DidiTravel
//
//  Created by Apple_yjh on 15-4-10.
//  Copyright (c) 2015年 yjh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Additions)

-(UIImage *)fixOrientation;
-(UIImage *)sameScaleWith:(CGFloat)tempWidth;

- (BOOL)hasAlpha;
- (UIImage *)imageWithAlpha;
- (CGImageRef)newBorderMask:(NSUInteger)borderSize size:(CGSize)size;
- (UIImage *)transparentBorderImage:(NSUInteger)borderSize;

+ (UIImage *)imageFromView:(UIView *)view;
@end
