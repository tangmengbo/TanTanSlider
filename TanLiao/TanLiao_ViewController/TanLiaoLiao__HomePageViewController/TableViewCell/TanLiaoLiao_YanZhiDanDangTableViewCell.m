//
//  YanZhiDanDangTableViewCell.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/4/19.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiaoLiao_YanZhiDanDangTableViewCell.h"

@implementation TanLiaoLiao_YanZhiDanDangTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
    }
    return self;
}


-(void)initData:(NSDictionary *)info
{
    self.info = info;
    TanLiaoCustomImageView * headerImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(5*BILI, 0, VIEW_WIDTH-10*BILI, VIEW_WIDTH-10*BILI)];
    UITapGestureRecognizer *imageViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTap)];
    [headerImageView addGestureRecognizer:imageViewTap];
    headerImageView.layer.cornerRadius = 10*BILI;
    headerImageView.layer.masksToBounds = YES;
    headerImageView.userInteractionEnabled = YES;
    headerImageView.urlPath = [info objectForKey:@"url"];
    headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    headerImageView.autoresizingMask = UIViewAutoresizingNone;
    headerImageView.clipsToBounds = YES;
    [self addSubview:headerImageView];
    
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        UIScrollView * baaepV5654 = [[UIScrollView alloc]initWithFrame:CGRectMake(9,87,12,49)];
        baaepV5654.layer.cornerRadius =6;
        baaepV5654.userInteractionEnabled = YES;
        baaepV5654.layer.masksToBounds = YES;
    }
    
    UIImageView * freeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(VIEW_WIDTH-46*BILI-12*BILI, 12*BILI, 46*BILI, 18*BILI)];
    [headerImageView addSubview:freeImageView];



    if ([@"1" isEqualToString:[info objectForKey:@"onlineStatus"]])
    {
        freeImageView.image = [UIImage imageNamed:@"hp_icon_kongxian"];
    }
    else
    {
        freeImageView.image = [UIImage imageNamed:@"hp_icon_tonghua"];
    }
    
    UIImageView * yinYingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, headerImageView.frame.size.height-80*BILI, headerImageView.frame.size.width, 80*BILI)];
    yinYingImageView.image = [UIImage imageNamed:@"home_pic_yinyin"];
    yinYingImageView.clipsToBounds = YES;
    [headerImageView addSubview:yinYingImageView];



    
    CGSize nameSize = [TanLiao_Common setSize:[info objectForKey:@"nick"] withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_WIDTH) withFontSize:15*BILI];
    UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI,29*BILI, nameSize.width, 16*BILI)];
    nameLable.font = [UIFont systemFontOfSize:15*BILI];
    nameLable.textColor = [UIColor whiteColor];
    nameLable.text = [info objectForKey:@"nick"];
    [yinYingImageView addSubview:nameLable];

//
//    if ([@"A" isEqualToString:[info objectForKey:@"role"]]) {
//
//        UIImageView * audioRenZheng = [[UIImageView alloc] initWithFrame:CGRectMake(nameLable.frame.origin.x+nameLable.frame.size.width+5*BILI, nameLable.frame.origin.y, 15*BILI, 15*BILI)];
//        audioRenZheng.image = [UIImage imageNamed:@"hp_icon_shouye_renzheng copy"];
//        [yinYingImageView addSubview:audioRenZheng];
//
//        UIImageView * videoRenZheng = [[UIImageView alloc] initWithFrame:CGRectMake(audioRenZheng.frame.origin.x+audioRenZheng.frame.size.width+5*BILI, nameLable.frame.origin.y, 15*BILI, 15*BILI)];
//        videoRenZheng.image = [UIImage imageNamed:@"hp_Group 3 Copy 3"];
//        [yinYingImageView addSubview:videoRenZheng];
//
//    }
//    else if([@"B" isEqualToString:[info objectForKey:@"role"]])
//    {
//        UIImageView * audioRenZheng = [[UIImageView alloc] initWithFrame:CGRectMake(nameLable.frame.origin.x+nameLable.frame.size.width+5*BILI, nameLable.frame.origin.y, 15*BILI, 15*BILI)];
//        audioRenZheng.image = [UIImage imageNamed:@"hp_icon_shouye_renzheng copy"];
//        [yinYingImageView addSubview:audioRenZheng];
//
//    }
//    else if ([@"C" isEqualToString:[info objectForKey:@"role"]])
//    {
//        UIImageView * audioRenZheng = [[UIImageView alloc] initWithFrame:CGRectMake(nameLable.frame.origin.x+nameLable.frame.size.width+5*BILI, nameLable.frame.origin.y, 15*BILI, 15*BILI)];
//        audioRenZheng.image = [UIImage imageNamed:@"hp_Group 3 Copy 3"];
//        [yinYingImageView addSubview:audioRenZheng];
//    }
//
//    UILabel * messageLable1 = [[UILabel alloc] initWithFrame:CGRectMake(0, nameLable.frame.origin.y+1.5*BILI, VIEW_WIDTH-12*BILI, 12*BILI)];
//    messageLable1.textColor = [UIColor whiteColor];
//
//
//    messageLable1.textAlignment = NSTextAlignmentRight;
//    messageLable1.font = [UIFont systemFontOfSize:12*BILI];
//    [yinYingImageView addSubview:messageLable1];
//    messageLable1.text = [NSString stringWithFormat:@"%@ %@ 接通率%@",[info objectForKey:@"age"],[info objectForKey:@"cityName"],[info objectForKey:@"rate"]];
    
    UILabel * messageLable = [[UILabel alloc] initWithFrame:CGRectMake(nameLable.frame.origin.x, nameLable.frame.origin.y+nameLable.frame.size.height+8*BILI, VIEW_WIDTH-2*(nameLable.frame.origin.x), 12*BILI)];
    messageLable.textColor = [UIColor whiteColor];


    messageLable.font = [UIFont systemFontOfSize:12*BILI];
    [yinYingImageView addSubview:messageLable];



    messageLable.text = [NSString stringWithFormat:@"%@",[info objectForKey:@"signature"]];
    
}


-(void)imageViewTap
{
    
    
    
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        UITableView * xmzsmH2145 = [[UITableView alloc]initWithFrame:CGRectMake(62,73,93,82)];
        xmzsmH2145.backgroundColor = [UIColor whiteColor];
        xmzsmH2145.layer.borderColor = [[UIColor greenColor] CGColor];
        xmzsmH2145.layer.cornerRadius =8;
        [self addSubview:xmzsmH2145];
    }
    
    [self.delegate yanZhiDanDangTableViewPushToAnchorDatailVC:self.info];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
