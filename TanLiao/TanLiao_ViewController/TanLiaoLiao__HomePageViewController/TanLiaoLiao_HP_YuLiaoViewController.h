//
//  HP_YuLiaoViewController.h
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/4/16.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiao_BaseViewController.h"
#import "TanLiaoLiao_AudioAnchorTableViewCell.h"

@protocol HP_YuLiaoViewControllerDelegate
@required

- (void)audioTongHua:(NSDictionary *)info ;
-(void)pushToAudioAnchorDetail:(NSDictionary *)info;


@end

@interface TanLiaoLiao_HP_YuLiaoViewController : TanLiao_BaseViewController<UITableViewDelegate,UITableViewDataSource,AudioAnchorTableViewCellDelegate,AVAudioPlayerDelegate>
{
    int pageIndex;
    int mainTableViewSection;


}

@property(nonatomic,strong)UITextView * ceiaT105;
@property(nonatomic,strong)UIView * hkorK251;
@property(nonatomic,strong)UITableView * jrhsB655;


@property(nonatomic,assign)id <HP_YuLiaoViewControllerDelegate> delegate;

@property(nonatomic,strong)TanLiaoLiao_CloudClient * cloudClient;

@property(nonatomic,strong)NSMutableArray * sourceArray;


@property(nonatomic,strong)UITableView * mainTableView;


@property(nonatomic,strong)UILabel * xiaLaLable;
@property(nonatomic,strong)UIActivityIndicatorView * activityView;

@property(nonatomic,strong)NSString * playAudioPath;

//录音波音器
@property(nonatomic,retain)AVPlayer * voicePlayer;

@end
