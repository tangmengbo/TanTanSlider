//
//  UploadImagesAndVideoViewController.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2017/9/13.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"
#import "TZImagePickerController.h"
#import "LLImagePickerManager.h"
#import "LLImagePickerModel.h"



@interface TanLiao_UploadImagesAndVideoViewController : TanLiao_BaseViewController<TZImagePickerControllerDelegate>
{
    ////视频上传
    int maxImageSelected;
    BOOL allowMultipleSelection;//是否允许一个视频或者图片多次选择



    BOOL alsoEdit;
}
@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;
/** 总的媒体数组 */
@property(nonatomic,strong)UIImageView * rightImageView ;
@property(nonatomic,strong)NSMutableArray * mediaArray;

@property(nonatomic,strong)NSArray * videosAndImagesArray;

@property(nonatomic,strong)NSMutableArray * deleteCheckButtonArray;

@property(nonatomic,strong)NSMutableArray * deleteIdsArray;


@property(nonatomic,strong)UIScrollView * bottomView;

@property(nonatomic,strong)UIScrollView * tgdvD826;
@property(nonatomic,strong)NSDictionary * uulpklE90138;
@property(nonatomic,strong)UIScrollView * kbrgfM0141;
@property(nonatomic,strong)UILabel * pmhmzJ5238;
@property(nonatomic,strong)UIView * pulnD470;


@end
