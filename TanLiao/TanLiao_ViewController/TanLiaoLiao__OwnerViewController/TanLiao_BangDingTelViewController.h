//
//  BangDingTelViewController.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/7/20.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"

@interface TanLiao_BangDingTelViewController : TanLiao_BaseViewController
{
   int stepSeconds;
}
@property(nonatomic,strong)NSData * fusvK735;

@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;
@property(nonatomic,strong)UITextField * telTextField;
@property(nonatomic,strong)UITextField * checkNumberTextField;
@property(nonatomic,strong)UIButton * getCheckNumberButton;


@property(nonatomic,strong)NSTimer * timer;

@property(nonatomic,strong)NSString * mobel;



@end
