//
//  ShiPinXiuTableViewCell.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2017/10/11.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiaoLiao_ShiPinXiuTableViewCell.h"

@implementation TanLiaoLiao_ShiPinXiuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];




    if (self)
    {
        self.view1 = [[UIView alloc] initWithFrame:CGRectMake(6*BILI, 5*BILI, (VIEW_WIDTH-12*BILI-7*BILI)/2, 550*BILI/2)];
        self.view1.layer.cornerRadius = 10*BILI;
        self.view1.layer.masksToBounds = YES;
        [self addSubview:self.view1];
        
        self.view2 = [[UIView alloc] initWithFrame:CGRectMake(6*BILI+self.view1.frame.size.width+7*BILI,self.view1.frame.origin.y , self.view1.frame.size.width, self.view1.frame.size.height)];
        self.view2.layer.cornerRadius = 10*BILI;
        self.view2.layer.masksToBounds = YES;

        [self addSubview:self.view2];
        
        
    }
    return self;
}


-(void)initData:(NSDictionary *)info1 index1:(int)index1 data2:(NSDictionary *)info2 index2:(int)index2
{
    
    [self.view1 removeAllSubviews];




    [self.view2 removeAllSubviews];




    
    
    self.info1 = info1;
    ornginIndex1 = index1;
    
    
    TanLiaoCustomImageView * bigImageView1 = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(0, 0, self.view1.frame.size.width, self.view1.frame.size.height)];
    bigImageView1.contentMode = UIViewContentModeScaleAspectFill;
    bigImageView1.autoresizingMask = UIViewAutoresizingNone;
    bigImageView1.clipsToBounds = YES;
    bigImageView1.userInteractionEnabled = YES;
    UITapGestureRecognizer *imageViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageView1Tap)];
    [bigImageView1 addGestureRecognizer:imageViewTap];
    bigImageView1.urlPath = [self.info1 objectForKey:@"picUrl"];
    [self.view1 addSubview:bigImageView1];
    
    UIImageView * bottomView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view1.frame.size.height-36*BILI, self.view1.frame.size.width, 36*BILI)];
    bottomView1.image = [UIImage imageNamed:@"pic_mask_video"];
    bottomView1.clipsToBounds = YES;
    [self.view1 addSubview:bottomView1];

    
    TanLiaoCustomImageView * smallImageView1 = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(5*BILI, self.view1.frame.size.height-30*BILI-3*BILI, 30*BILI, 30*BILI)];
    smallImageView1.imgType = IMAGEVIEW_TYPE_CENTER;
    smallImageView1.urlPath = [self.info1 objectForKey:@"avatarUrl"];
    smallImageView1.contentMode = UIViewContentModeScaleAspectFill;
    smallImageView1.autoresizingMask = UIViewAutoresizingNone;
    smallImageView1.clipsToBounds = YES;
    [self.view1 addSubview:smallImageView1];
    
    UILabel * nameLable1 = [[UILabel alloc] initWithFrame:CGRectMake(smallImageView1.frame.origin.x+smallImageView1.frame.size.width+5*BILI, smallImageView1.frame.origin.y, 90*BILI, 30*BILI)];
    nameLable1.textColor = [UIColor whiteColor];


 

    nameLable1.font = [UIFont systemFontOfSize:12*BILI];
    nameLable1.text = [self.info1 objectForKey:@"nick"];
    [self.view1 addSubview:nameLable1];
    
//    UIImageView *dianZanImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(267*BILI/2, self.view1.frame.size.height-12*BILI-10*BILI, 10*BILI, 10*BILI)];
//    dianZanImageView1.image = [UIImage imageNamed:@"shipinxiu_icon_love"];
//    [self.view1 addSubview:dianZanImageView1];
    
    UILabel * dianZanLable1 = [[UILabel alloc] initWithFrame:CGRectMake(self.view1.width-111*BILI/2-5*BILI, self.view1.frame.size.height-12*BILI-10*BILI,111*BILI/2, 10*BILI)];
    dianZanLable1.textColor = [UIColor whiteColor];


 
if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
{
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@(108)];
    [array addObject:@(165)];
    [array addObject:@(892)];
    [array addObject:@(558)];
    [array addObject:@(542)];
}
   

    dianZanLable1.font = [UIFont systemFontOfSize:10*BILI];
    dianZanLable1.textAlignment = NSTextAlignmentRight;
    dianZanLable1.adjustsFontSizeToFitWidth = YES;
    dianZanLable1.text = [NSString stringWithFormat:@"%@次播放",[self.info1 objectForKey:@"clicks"]];
    [self.view1 addSubview:dianZanLable1];
    
    if (info2) {
        
        self.info2 = info2;
        ornginIndex2 = index2;
        
        TanLiaoCustomImageView * bigImageView1 = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(0, 0, self.view1.frame.size.width, self.view1.frame.size.height)];
        bigImageView1.urlPath = [self.info2 objectForKey:@"picUrl"];
        bigImageView1.contentMode = UIViewContentModeScaleAspectFill;
        bigImageView1.autoresizingMask = UIViewAutoresizingNone;
        bigImageView1.clipsToBounds = YES;
        [self.view2 addSubview:bigImageView1];
        bigImageView1.userInteractionEnabled = YES;
        UITapGestureRecognizer *imageViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageView2Tap)];
        [bigImageView1 addGestureRecognizer:imageViewTap];

        
        UIImageView * bottomView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view1.frame.size.height-36*BILI, self.view1.frame.size.width, 36*BILI)];
        bottomView1.image = [UIImage imageNamed:@"pic_mask_video"];
        bottomView1.clipsToBounds = YES;
        [self.view2 addSubview:bottomView1];

        
        TanLiaoCustomImageView * smallImageView1 = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(5*BILI, self.view1.frame.size.height-30*BILI-3*BILI, 30*BILI, 30*BILI)];
        smallImageView1.imgType = IMAGEVIEW_TYPE_CENTER;
        smallImageView1.urlPath = [self.info2 objectForKey:@"avatarUrl"];
        smallImageView1.contentMode = UIViewContentModeScaleAspectFill;
        smallImageView1.autoresizingMask = UIViewAutoresizingNone;
        smallImageView1.clipsToBounds = YES;
        [self.view2 addSubview:smallImageView1];
        
        UILabel * nameLable1 = [[UILabel alloc] initWithFrame:CGRectMake(smallImageView1.frame.origin.x+smallImageView1.frame.size.width+5*BILI, smallImageView1.frame.origin.y, 90*BILI, 30*BILI)];
        nameLable1.textColor = [UIColor whiteColor];



        nameLable1.font = [UIFont systemFontOfSize:12*BILI];
        nameLable1.text = [self.info2 objectForKey:@"nick"];;
        [self.view2 addSubview:nameLable1];
        
//        UIImageView *dianZanImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(267*BILI/2, self.view1.frame.size.height-12*BILI-10*BILI, 10*BILI, 10*BILI)];
//        dianZanImageView1.image = [UIImage imageNamed:@"shipinxiu_icon_love"];
//        [self.view2 addSubview:dianZanImageView1];
        
        UILabel * dianZanLable1 = [[UILabel alloc] initWithFrame:CGRectMake(self.view2.width-111*BILI/2-5*BILI, self.view2.frame.size.height-12*BILI-10*BILI,111*BILI/2, 10*BILI)];
        dianZanLable1.textColor = [UIColor whiteColor];



   

        dianZanLable1.font = [UIFont systemFontOfSize:10*BILI];
        dianZanLable1.textAlignment = NSTextAlignmentRight;
        dianZanLable1.adjustsFontSizeToFitWidth = YES;
        dianZanLable1.text = [NSString stringWithFormat:@"%@次播放",[self.info2 objectForKey:@"clicks"]];
        [self.view2 addSubview:dianZanLable1];
 
    }
}


-(void)imageView1Tap
{
     [self.delegate pushToShiPinXiuDetailVC:self.info1 index:ornginIndex1];
}


-(void)imageView2Tap
{
    [self.delegate pushToShiPinXiuDetailVC:self.info2 index:ornginIndex2];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
