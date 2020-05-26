//
//  UIImage+Additions.m
//  DidiTravel
//
//  Created by Apple_yjh on 15-4-10.
//  Copyright (c) 2015年 yjh. All rights reserved.
//

#import "UIImage+Additions.h"

@implementation UIImage (Additions)

-(UIImage *)fixOrientation
{
    //    if (srcImg.imageOrientation == UIImageOrientationUp) return srcImg;
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

-(UIImage *)sameScaleWith:(CGFloat)tempWidth
{
    UIImage *newImg = [self fixOrientation];
    CGFloat w = self.size.width;
    CGFloat h = self.size.height;
    if(w > tempWidth || h > tempWidth)
    {
        float b = (float)tempWidth/w < (float)tempWidth/h ? (float)tempWidth/w : (float)tempWidth/h;
        CGSize itemSize = CGSizeMake(b*w, b*h);
        UIGraphicsBeginImageContext(itemSize);
        CGRect imageRect = CGRectMake(0, 0, b*w, b*h);
        [self drawInRect:imageRect];
        newImg = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newImg;
}

- (BOOL)hasAlpha
{
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(self.CGImage);
    return (alpha == kCGImageAlphaFirst || alpha == kCGImageAlphaLast || alpha == kCGImageAlphaPremultipliedFirst || alpha == kCGImageAlphaPremultipliedLast);
}

- (UIImage *)imageWithAlpha
{
    if ([self hasAlpha])
        return self;
    
    CGImageRef imageRef = self.CGImage;
    size_t width        = CGImageGetWidth(imageRef);
    size_t height       = CGImageGetHeight(imageRef);
    
    CGContextRef context = CGBitmapContextCreate(NULL, width, height, 8, 0, CGImageGetColorSpace(imageRef), kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    
    CGImageRef alphaImageRef    = CGBitmapContextCreateImage(context);
    UIImage *alphaImage         = [UIImage imageWithCGImage:alphaImageRef];
    
    CGContextRelease(context);
    CGImageRelease(alphaImageRef);
    
    return alphaImage;
}

- (CGImageRef)newBorderMask:(NSUInteger)borderSize size:(CGSize)size
{
    CGColorSpaceRef colorSpace  = CGColorSpaceCreateDeviceGray();
    CGContextRef maskContext    = CGBitmapContextCreate(NULL, size.width, size.height, 8, 0, colorSpace, kCGBitmapByteOrderDefault | kCGImageAlphaNone);
    
    CGContextSetFillColorWithColor(maskContext, [UIColor blackColor].CGColor);
    CGContextFillRect(maskContext, CGRectMake(0, 0, size.width, size.height));
    
    CGContextSetFillColorWithColor(maskContext, [UIColor whiteColor].CGColor);
    CGContextFillRect(maskContext, CGRectMake(borderSize, borderSize, size.width - borderSize * 2, size.height - borderSize * 2));
    
    CGImageRef imageRef = CGBitmapContextCreateImage(maskContext);
    
    CGContextRelease(maskContext);
    CGColorSpaceRelease(colorSpace);
    
    return imageRef;
}

- (UIImage *)transparentBorderImage:(NSUInteger)borderSize
{
    UIImage *image          = [self imageWithAlpha];
    CGRect frame            = CGRectMake(0, 0, image.size.width + borderSize * 2, image.size.height + borderSize * 2);
    CGContextRef bitmap     = CGBitmapContextCreate(NULL, frame.size.width, frame.size.height, CGImageGetBitsPerComponent(self.CGImage), 0, CGImageGetColorSpace(self.CGImage), CGImageGetBitmapInfo(self.CGImage));
    CGRect locationFrame    = CGRectMake(borderSize, borderSize, image.size.width, image.size.height);
    
    CGContextDrawImage(bitmap, locationFrame, self.CGImage);
    
    CGImageRef borderImageRef               = CGBitmapContextCreateImage(bitmap);
    CGImageRef maskImageRef                 = [self newBorderMask:borderSize size:frame.size];
    CGImageRef transparentBorderImageRef    = CGImageCreateWithMask(borderImageRef, maskImageRef);
    UIImage *transparentBorderImage         = [UIImage imageWithCGImage:transparentBorderImageRef];
    
    CGContextRelease(bitmap);
    CGImageRelease(borderImageRef);
    CGImageRelease(maskImageRef);
    CGImageRelease(transparentBorderImageRef);
    
    return transparentBorderImage;
}

+ (UIImage *)imageFromView:(UIView *)view
{
    UIGraphicsBeginImageContext(view.frame.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *rasterizedView = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return rasterizedView;
}

@end
