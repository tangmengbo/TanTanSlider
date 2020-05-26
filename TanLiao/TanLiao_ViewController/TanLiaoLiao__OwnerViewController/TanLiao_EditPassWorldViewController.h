//
//  EditPassWorldViewController.h
//  tcmy
//
//  Created by 唐蒙波 on 2017/11/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"

@interface TanLiao_EditPassWorldViewController : TanLiao_BaseViewController

@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;

@property(nonatomic,strong)UITextField * oldPassWorldTextField;

@property(nonatomic,strong)UITextField * xinPWTextField1;

@property(nonatomic,strong)UITextField * xinPWTextField2;


@end
