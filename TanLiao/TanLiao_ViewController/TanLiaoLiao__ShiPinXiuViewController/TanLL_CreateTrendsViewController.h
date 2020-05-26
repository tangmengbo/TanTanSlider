//
//  CreateTrendsViewController.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/4/4.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"
#import "TanLiao_RecordVideoViewController.h"
#import "TZImagePickerController.h"
#import "LLImagePickerManager.h"
#import "LLImagePickerModel.h"

@protocol CreateTrendsViewControllerDelegate
@required

- (void)createTrendsSuccess;
@end


@interface TanLL_CreateTrendsViewController : TanLiao_BaseViewController<UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TZImagePickerControllerDelegate,RecordVideoViewControllerDelegate>
{
    int maxImageSelected;
    int uploadImageIndex;
}
@property(nonatomic,strong)NSData * mccegO3797;
@property(nonatomic,strong)NSData * poiigZ3543;
@property(nonatomic,strong)UILabel * xdirftZ70169;


@property (nonatomic, assign) id<CreateTrendsViewControllerDelegate> delegate;

@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;

@property(nonatomic,strong)NSString * trendsType;//@"wenzi":文字,@"zhaopian":相册选取,@"shipin":拍摄
@property(nonatomic,strong)UILabel * wenZiTipLable;
@property(nonatomic,strong)UITextView * textView;



@property(nonatomic,strong)UIView * imageContentView;

@property(nonatomic,strong)UIImageView * videoImageView;

@property(nonatomic,strong)UIImagePickerController * imagePickerController;
@property(nonatomic,strong)NSMutableArray * imageArray;


@property(nonatomic,strong)NSMutableArray * imagePathArray;



@property(nonatomic,strong)LLImagePickerModel * videoModel;



@property(nonatomic,strong)NSURL * videoUrl;
@property(nonatomic,strong)UIImage * covreImage;


@end

