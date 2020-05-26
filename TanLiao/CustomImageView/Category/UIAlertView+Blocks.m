//
//  UIAlertView+Blocks.m
//  DidiTravel
//
//  Created by Apple_yjh on 15-5-7.
//  Copyright (c) 2015年 yjh. All rights reserved.
//

#import "UIAlertView+Blocks.h"

static TouchBlock _touchAction;
@implementation UIAlertView (Blocks)


- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString*)otherButtonTitles block:(TouchBlock)block{
    self = [self initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];//注意这里初始化父类的
    if (self) {
        _touchAction = block;
    }
    return self;
}

- (id)initWithTitle:(NSString *)title
            message:(NSString *)message
  cancelButtonTitle:(NSString *)cancelButtonTitle
        otherTitles:(NSArray *) others
              block:(TouchBlock)block
{
    self = [self initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil, nil];
    for(NSString *item in others)
    {
        [self addButtonWithTitle:item];
    }
    
    if (self) {
        _touchAction = block;
    }
    return self;
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle  block:(TouchBlock)block{
    //
    self = [self initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil,nil];//注意这里初始化父类的
    if (self) {
        _touchAction = block;
    }
    return self;
}

//#pragma mark -AlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //这里调用函数指针_block(要传进来的参数);
    //_touchAction(buttonIndex);
}
@end
