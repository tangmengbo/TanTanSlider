//
//  AnchorIntificationVideoAndPictureUploadViewController.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/6/5.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"

@interface TanLiao_AnchorIntificationVideoAndPictureUploadViewController : TanLiao_BaseViewController<TZImagePickerControllerDelegate>
{
    int uploadImageIndex;
    int uploadVideoIndex;
}
@property(nonatomic,strong)UILabel * gwenutF92307;
@property(nonatomic,strong)UIScrollView * vtbdH202;
@property(nonatomic,strong)UITableView * uhqaN644;
@property(nonatomic,strong)UITableView * zjdewqS67182;

@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;

@property(nonatomic,strong)NSMutableArray * picArray;


@property(nonatomic,strong)NSMutableArray * videoArray;


@property(nonatomic,strong)NSMutableArray * mediaPathArray;

@property(nonatomic,strong)LLImagePickerModel * videoModel;

@end
