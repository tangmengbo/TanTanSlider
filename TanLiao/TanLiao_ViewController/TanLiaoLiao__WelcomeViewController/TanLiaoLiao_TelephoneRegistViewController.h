//
//  TelephoneRegistViewController.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/1/22.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"

@interface TanLiaoLiao_TelephoneRegistViewController : TanLiao_BaseViewController
{
    int stepSeconds;

}
@property(nonatomic,strong)UILabel * bgpfrH2822;


@property(nonatomic,strong)UITextField * telTextField;
@property(nonatomic,strong)UITextField * checkNumberTextField;
@property(nonatomic,strong)UITextField * passWorldRextField;
@property(nonatomic,strong)UITextField * passWorldAgainTextField;

@property(nonatomic,strong)NSString * cityName;

@property(nonatomic,strong)NSTimer * timer;

@property(nonatomic,strong)UIButton * getCheckNumberButton;




@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;

@property(nonatomic,strong)NSString * alsoForgetPassWorld;

@end
