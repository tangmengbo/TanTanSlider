//
//  EditAnchorNameViewController.h
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/27.
//  Copyright © 2017年 mac. All rights reserved.
//


@protocol EditAnchorNameViewControllerDelegate
@required

- (void)changeName:(NSString *)name ;
@end



#import "TanLiao_BaseViewController.h"

@interface TanLiaoLiao_EditAnchorNameViewController : TanLiao_BaseViewController<UITextFieldDelegate>

@property (nonatomic, assign) id<EditAnchorNameViewControllerDelegate> delegate;



@property(nonatomic,strong)UITextField * nameTF;

@property(nonatomic,strong)NSString * name;


@end
