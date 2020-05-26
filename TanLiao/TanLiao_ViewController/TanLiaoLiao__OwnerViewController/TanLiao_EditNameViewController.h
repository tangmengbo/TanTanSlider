//
//  EditNameViewController.h
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"



@protocol EditNameViewControllerDelegate
@required

- (void)changeName:(NSString *)name ;
@end

@interface TanLiao_EditNameViewController : TanLiao_BaseViewController<UITextFieldDelegate>

@property (nonatomic, assign) id<EditNameViewControllerDelegate> delegate;


@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;


@property(nonatomic,strong)UITextField * nameTF;

@property(nonatomic,strong)NSString * name;
@end
