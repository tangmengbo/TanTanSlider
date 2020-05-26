//
//  UIAlertView+Blocks.h
//  DidiTravel
//
//  Created by Apple_yjh on 15-5-7.
//  Copyright (c) 2015年 yjh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TouchBlock)(NSInteger);

@interface UIAlertView (Blocks)


//需要自定义初始化方法，调用Block
- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
  cancelButtonTitle:(NSString *)cancelButtonTitle
  otherButtonTitles:(NSString*)otherButtonTitles
              block:(TouchBlock)block;

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
  cancelButtonTitle:(NSString *)cancelButtonTitle
  otherTitles:(NSArray *) others
              block:(TouchBlock)block;

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle  block:(TouchBlock)block;

@end
