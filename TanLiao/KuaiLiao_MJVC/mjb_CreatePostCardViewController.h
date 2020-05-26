//
//  CreatePostCardViewController.h
//  SeeYou
//
//  Created by 唐蒙波 on 2018/4/2.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"

@interface mjb_CreatePostCardViewController : TanLiao_BaseViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate>

@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;

@property(nonatomic,strong)UIScrollView * mainScrollView;

@property(nonatomic,strong)UIImagePickerController * imagePickerController;

@property(nonatomic,strong)UIImageView * selectImageView;

@property(nonatomic,strong)UIImage * selectedImage;


@property(nonatomic,strong)UITextView * describleTextView;

@end
