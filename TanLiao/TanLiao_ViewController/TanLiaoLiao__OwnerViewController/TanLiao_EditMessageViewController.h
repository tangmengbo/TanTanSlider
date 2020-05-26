//
//  EditMessageViewController.h
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"

@interface TanLiao_EditMessageViewController : TanLiao_BaseViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate,EditNameViewControllerDelegate,SetSignViewControllerDelegate>

@property(nonatomic,strong)UIImagePickerController * imagePickerController;

@property(nonatomic,strong)NSString * path;




@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;

@property(nonatomic,strong)NSDictionary * userInformation;



@property(nonatomic,strong)UIImage * headerImage;

@property(nonatomic,strong)TanLiaoCustomImageView * headerImageView;


@property(nonatomic,strong)UIView * jlgfY071;
@property(nonatomic,strong)UIImageView * zetuyfN77472;
@property(nonatomic,strong)UILabel * iytenP1471;
@property(nonatomic,strong)UIImageView * ttjzriD31370;


@property(nonatomic,strong)UILabel * nameLable1;

@property(nonatomic,strong)UILabel * nameLable2;

@property(nonatomic,strong)UILabel * acountLable;

@property(nonatomic,strong)UILabel * sexLable;

@property(nonatomic,strong)UILabel * ageLable;


@property(nonatomic,strong)UILabel * signLable;

@property(nonatomic,strong)UIImageView * tipImageView;


@property(nonatomic,strong)UIView * pickRootView;

@property(nonatomic,strong)UIDatePicker * datePickView ;
@property(nonatomic,strong)NSString * birthday;






@end
