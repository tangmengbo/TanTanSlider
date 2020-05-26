//
//  TrendsTableViewCell.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/4/8.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "KuaiLiao_TrendsTableViewCell.h"

@implementation KuaiLiao_TrendsTableViewCell

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
    [self removeAllSubviews];


 

   


    
    if ([info isKindOfClass:[NSDictionary class]]) {
        
        self.trendInfo = info;
        
        TanLiaoCustomImageView * headerImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(12*BILI, 12*BILI, 37*BILI, 37*BILI)];
        headerImageView.urlPath = [info objectForKey:@"avatarUrl"];
        headerImageView.imgType = IMAGEVIEW_TYPE_CENTER;
        headerImageView.contentMode  = UIViewContentModeScaleAspectFill;
        headerImageView.autoresizingMask = UIViewAutoresizingNone;
        [self addSubview:headerImageView];



        
        UILabel * nameLbale = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x+headerImageView.frame.size.width+12*BILI, 14*BILI, 150*BILI, 16*BILI)];
        nameLbale.font = [UIFont systemFontOfSize:15*BILI];
        nameLbale.textColor = UIColorFromRGB(0x333333);
        nameLbale.adjustsFontSizeToFitWidth = YES;
        nameLbale.text = [info objectForKey:@"name"];
        [self addSubview:nameLbale];


        
        
        if([[TanLiao_Common getNowUserID] isEqualToString:[info objectForKey:@"userId"]])
        {
            
        UIButton * deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(676*BILI/2, 19*BILI, 74*BILI/2, 20*BILI)];
        deleteButton.titleLabel.font = [UIFont systemFontOfSize:14*BILI];
        deleteButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        [deleteButton setImage:[UIImage imageNamed:@"dongtai_shanchu"] forState:UIControlStateNormal];
            [deleteButton addTarget:self action:@selector(deleteTrendsButtonClick) forControlEvents:UIControlEventTouchUpInside];


 

        [self addSubview:deleteButton];
        
            
        }
        
        UIImageView * sexAgeView = [[UIImageView alloc] initWithFrame:CGRectMake(nameLbale.frame.origin.x, nameLbale.frame.origin.y+nameLbale.frame.size.height+6*BILI, 26*BILI, 12*BILI)];
        if ([@"0" isEqualToString:[info objectForKey:@"sex"]]) {
            
            sexAgeView.image = [UIImage imageNamed:@"pic_old_woman"];
            
        }
        else
        {
            sexAgeView.image = [UIImage imageNamed:@"pic_old_man"];
            
        }
        [self addSubview:sexAgeView];



        
        UILabel * ageLable = [[UILabel alloc] initWithFrame:CGRectMake(3, (sexAgeView.frame.size.height-(10*BILI))/2, 20, 9*BILI)];
        ageLable.font = [UIFont systemFontOfSize:9*BILI];
        ageLable.textColor = [UIColor whiteColor];


 


        [sexAgeView addSubview:ageLable];




        ageLable.adjustsFontSizeToFitWidth = YES;
        NSNumber * number = [info objectForKey:@"age"];
        ageLable.text = [NSString stringWithFormat:@"%d",number.intValue];



        if (![@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
        {
            if([@"A" isEqualToString:[info objectForKey:@"role"]])
            {
                UIImageView * audioRenZheng = [[UIImageView alloc] initWithFrame:CGRectMake(sexAgeView.frame.origin.x+sexAgeView.frame.size.width+7*BILI, sexAgeView.frame.origin.y, 12*BILI, 12*BILI)];
                audioRenZheng.image = [UIImage imageNamed:@"dongtai_icon_yuyinrenz"];
                [self addSubview:audioRenZheng];
                
                UIImageView * videoRenZheng = [[UIImageView alloc] initWithFrame:CGRectMake(audioRenZheng.frame.origin.x+audioRenZheng.frame.size.width+6*BILI, audioRenZheng.frame.origin.y, 12*BILI, 12*BILI)];
                videoRenZheng.image = [UIImage imageNamed:@"dongtai_icon_shipinrenz"];
                [self addSubview:videoRenZheng];
            }
            else if([@"B" isEqualToString:[info objectForKey:@"role"]])
            {
                UIImageView * audioRenZheng = [[UIImageView alloc] initWithFrame:CGRectMake(sexAgeView.frame.origin.x+sexAgeView.frame.size.width+7*BILI, sexAgeView.frame.origin.y, 12*BILI, 12*BILI)];
                audioRenZheng.image = [UIImage imageNamed:@"dongtai_icon_shipinrenz"];
                [self addSubview:audioRenZheng];
                
                
            }
            else if ([@"C" isEqualToString:[info objectForKey:@"role"]])
            {
                UIImageView * audioRenZheng = [[UIImageView alloc] initWithFrame:CGRectMake(sexAgeView.frame.origin.x+sexAgeView.frame.size.width+7*BILI, sexAgeView.frame.origin.y, 12*BILI, 12*BILI)];
                audioRenZheng.image = [UIImage imageNamed:@"dongtai_icon_yuyinrenz"];
                [self addSubview:audioRenZheng];
            }
            
        }
       
        UILabel * messageLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x, headerImageView.frame.origin.y+headerImageView.frame.size.height+12*BILI, VIEW_WIDTH-24*BILI, 0)];
        messageLable.font = [UIFont systemFontOfSize:15*BILI];
        messageLable.textColor = UIColorFromRGB(0x333333);
        messageLable.numberOfLines = 0;
        [self addSubview:messageLable];




        //lable中要显示的文字
        NSString * describle = [info objectForKey:@"content"];
        if (describle) {
            
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:describle];

 

            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];

 

            //调整行间距
            [paragraphStyle setLineSpacing:2];
            [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [describle length])];
            messageLable.attributedText = attributedString;
            //设置自适应
            [messageLable  sizeToFit];


 

 

        }
        UIView * imageBottomView;
        UILabel * tipsLable;
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];



        //指定时间显示样式: HH表示24小时制 hh表示12小时制
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSString *lastTime = [info objectForKey:@"createdAt"];
        NSDate *lastDate = [formatter dateFromString:lastTime];



 

        //以 1970/01/01 GMT为基准，得到lastDate的时间戳
        long createdAt = [lastDate timeIntervalSince1970];
       
        NSNumber * momentType = [info objectForKey:@"moment_type"];
        if ([@"1" isEqualToString:[NSString stringWithFormat:@"%d",momentType.intValue]])//视频
        {
            imageBottomView = [[UIView alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x, messageLable.frame.origin.y+messageLable.frame.size.height+9*BILI, VIEW_WIDTH-24*BILI, 200*BILI)];
            [self addSubview:imageBottomView];


 

            
            NSArray * imageArray = [info objectForKey:@"moment_media_url"];
            TanLiaoCustomImageView * imageView;imageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(0, 0, 150*BILI, 200*BILI)];
            imageView.urlPath = [imageArray objectAtIndex:1];
            imageView.contentMode  = UIViewContentModeScaleAspectFill;
            imageView.autoresizingMask = UIViewAutoresizingNone;
            imageView.clipsToBounds = YES;
            [imageBottomView addSubview:imageView];




            
            UIImageView * boFangImageView = [[UIImageView alloc] initWithFrame:CGRectMake(55*BILI, 80*BILI, 40*BILI, 40*BILI)];
            boFangImageView.image = [UIImage imageNamed:@"dongtai_btn_bofang"];
            [imageView addSubview:boFangImageView];


            
            tipsLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x, imageBottomView.frame.origin.y+imageBottomView.frame.size.height, VIEW_WIDTH, 30*BILI)];
            tipsLable.text = [NSString stringWithFormat:@"%@  %@播放",[TanLiao_Common getReadableDateFromTimestamp:[NSString stringWithFormat:@"%ld",createdAt]],[info objectForKey:@"moment_view_count"]];//@"5分钟前  1314阅读";
            tipsLable.font = [UIFont systemFontOfSize:11*BILI];
            tipsLable.textColor = UIColorFromRGB(0x999999);
            [self addSubview:tipsLable];


 

 




        }
        else if ([@"2" isEqualToString:[NSString stringWithFormat:@"%d",momentType.intValue]])//图片
        {
            NSArray * imageArray = [info objectForKey:@"moment_media_url"];
            if (imageArray.count==1) {
                
                imageBottomView = [[UIView alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x, messageLable.frame.origin.y+messageLable.frame.size.height+9*BILI, VIEW_WIDTH-24*BILI, 160*BILI)];
                [self addSubview:imageBottomView];

                NSDictionary * info = [imageArray objectAtIndex:0];
                TanLiaoCustomImageView * imageView;imageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(0, 0, 160*BILI, 160*BILI)];
                    imageView.contentMode  = UIViewContentModeScaleAspectFill;
                    imageView.autoresizingMask = UIViewAutoresizingNone;
                    imageView.clipsToBounds = YES;
                    imageView.urlPath = [info objectForKey:@"photoUrl"];
                    [imageBottomView addSubview:imageView];




            }
            else if (imageArray.count==4)
            {
                imageBottomView = [[UIView alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x, messageLable.frame.origin.y+messageLable.frame.size.height+9*BILI, VIEW_WIDTH-24*BILI, 0)];
                [self addSubview:imageBottomView];


                if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
                {
                    UITextView * skgrbgV40974 = [[UITextView alloc]initWithFrame:CGRectMake(60,74,15,31)];
                    skgrbgV40974.backgroundColor = [UIColor whiteColor];
                    skgrbgV40974.layer.borderColor = [[UIColor greenColor] CGColor];
                    skgrbgV40974.layer.cornerRadius =7;
                    [self addSubview:skgrbgV40974];
                }
                

                
                for (int i=0; i<imageArray.count; i++) {
                    NSDictionary * info = [imageArray objectAtIndex:i];
                    TanLiaoCustomImageView * imageView;imageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake((236*BILI/2)*(i%2),(236*BILI/2)*(i/2) , 230*BILI/2, 230*BILI/2)];
                    imageView.contentMode  = UIViewContentModeScaleAspectFill;
                    imageView.autoresizingMask = UIViewAutoresizingNone;
                    imageView.clipsToBounds = YES;
                    imageView.urlPath = [info objectForKey:@"photoUrl"];
                    [imageBottomView addSubview:imageView];


 

                    
                    if (i==imageArray.count-1) {
                        
                        imageBottomView.frame = CGRectMake(headerImageView.frame.origin.x, messageLable.frame.origin.y+messageLable.frame.size.height+9*BILI, VIEW_WIDTH-24*BILI,imageView.frame.origin.y+imageView.frame.size.height);
                    }
                }
            }
            else
            {
                imageBottomView = [[UIView alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x, messageLable.frame.origin.y+messageLable.frame.size.height+9*BILI, VIEW_WIDTH-24*BILI, 0)];
              [self addSubview:imageBottomView];




                
                for (int i=0; i<imageArray.count; i++) {
                    NSDictionary * info = [imageArray objectAtIndex:i];
                    TanLiaoCustomImageView * imageView;imageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake((236*BILI/2)*(i%3),(236*BILI/2)*(i/3) , 230*BILI/2, 230*BILI/2)];
                    imageView.contentMode  = UIViewContentModeScaleAspectFill;
                    imageView.autoresizingMask = UIViewAutoresizingNone;
                    imageView.clipsToBounds = YES;
                    imageView.urlPath = [info objectForKey:@"photoUrl"];
                    [imageBottomView addSubview:imageView];



                    if (i==imageArray.count-1) {
                        
                        imageBottomView.frame = CGRectMake(headerImageView.frame.origin.x, messageLable.frame.origin.y+messageLable.frame.size.height+9*BILI, VIEW_WIDTH-24*BILI,imageView.frame.origin.y+imageView.frame.size.height);
                    }
                }
            }
            tipsLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x, imageBottomView.frame.origin.y+imageBottomView.frame.size.height, VIEW_WIDTH, 30*BILI)];
            tipsLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x, imageBottomView.frame.origin.y+imageBottomView.frame.size.height, VIEW_WIDTH, 30*BILI)];
            tipsLable.text = [NSString stringWithFormat:@"%@  %@阅读",[TanLiao_Common getReadableDateFromTimestamp:[NSString stringWithFormat:@"%ld",createdAt]],[info objectForKey:@"moment_view_count"]];
            tipsLable.font = [UIFont systemFontOfSize:11*BILI];
            tipsLable.textColor = UIColorFromRGB(0x999999);
            [self addSubview:tipsLable];

 

        }
        else//文字
        {
             tipsLable = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x, messageLable.frame.origin.y+messageLable.frame.size.height+9*BILI, VIEW_WIDTH, 30*BILI)];
            tipsLable.text = [NSString stringWithFormat:@"%@  %@阅读",[TanLiao_Common getReadableDateFromTimestamp:[NSString stringWithFormat:@"%ld",createdAt]],[info objectForKey:@"moment_view_count"]];
            tipsLable.font = [UIFont systemFontOfSize:11*BILI];
            tipsLable.textColor = UIColorFromRGB(0x999999);
            [self addSubview:tipsLable];



        }
        
       
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, tipsLable.frame.origin.y+tipsLable.frame.size.height, VIEW_WIDTH, 1)];
        lineView.backgroundColor = UIColorFromRGB(0xF8F8F8);
        [self addSubview:lineView];


 

 

        
        UIImageView * zanImageView = [[UIImageView alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x, lineView.frame.origin.y+lineView.frame.size.height+9*BILI, 21*BILI, 21*BILI)];
        [self addSubview:zanImageView];



        
        
        UILabel * zanLable = [[UILabel alloc] initWithFrame:CGRectMake(zanImageView.frame.origin.x+zanImageView.frame.size.width+5*BILI, zanImageView.frame.origin.y, 30*BILI, 21*BILI)];
        zanLable.adjustsFontSizeToFitWidth = YES;
        zanLable.font = [UIFont systemFontOfSize:12*BILI];
        
        [self addSubview:zanLable];



 

        zanLable.text = [info objectForKey:@"moment_like_count"];
        
        if([@"false" isEqualToString:[info objectForKey:@"moment_is_like"]])
        {
            zanImageView.image = [UIImage imageNamed:@"dongtai_btn_zan_n"];
            zanLable.textColor = [UIColor blackColor];




            zanLable.alpha = 0.2;
        }
        else
        {
            
            zanImageView.image = [UIImage imageNamed:@"dongtai_btn_zan_h"];
            zanLable.textColor = UIColorFromRGB(0xFF6161);
            zanLable.alpha =1;
        }
        
        UIButton * zanButton = [[UIButton alloc] initWithFrame:CGRectMake(0, lineView.frame.origin.y, 12*BILI+30*BILI, 38*BILI)];
        [zanButton addTarget:self action:@selector(zanButtonClick) forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:zanButton];
        
        UIImageView * commitImageView = [[UIImageView alloc] initWithFrame:CGRectMake(zanImageView.frame.origin.x+zanImageView.frame.size.width+46*BILI, lineView.frame.origin.y+lineView.frame.size.height+9*BILI, 21*BILI, 21*BILI)];
        commitImageView.image = [UIImage imageNamed:@"dongtai_btn_pinlun"];
        [self addSubview:commitImageView];


 

        
        UILabel * commitLable = [[UILabel alloc] initWithFrame:CGRectMake(commitImageView.frame.origin.x+commitImageView.frame.size.width+5*BILI, zanImageView.frame.origin.y, 30*BILI, 21*BILI)];
        commitLable.adjustsFontSizeToFitWidth = YES;
        commitLable.font = [UIFont systemFontOfSize:12*BILI];
        commitLable.textColor = [UIColor blackColor];
        commitLable.alpha = 0.2;
        [self addSubview:commitLable];


 

        commitLable.text = [info objectForKey:@"moment_comment_count"];
        
        UILabel * daShangLable = [[UILabel alloc] initWithFrame:CGRectMake(VIEW_WIDTH-100*BILI-41*BILI, zanImageView.frame.origin.y, 100*BILI, 21*BILI)];
        daShangLable.adjustsFontSizeToFitWidth = YES;
        daShangLable.font = [UIFont systemFontOfSize:12*BILI];
        daShangLable.textColor =UIColorFromRGB(0xF9B630);
        daShangLable.textAlignment = NSTextAlignmentRight;
        [self addSubview:daShangLable];

        if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
        {
            UIImageView * wqjjxuY44407 = [[UIImageView alloc]initWithFrame:CGRectMake(36,97,89,56)];
            wqjjxuY44407.layer.borderWidth = 1;
            wqjjxuY44407.clipsToBounds = YES;
            wqjjxuY44407.layer.cornerRadius =5;
            [self addSubview:wqjjxuY44407];
        }


        daShangLable.text = [NSString stringWithFormat:@"%@人送礼",[info objectForKey:@"moment_gift_count"]];
        
        UIImageView * daShangImageView = [[UIImageView alloc] initWithFrame:CGRectMake(daShangLable.frame.origin.x+daShangLable.frame.size.width+5*BILI, lineView.frame.origin.y+lineView.frame.size.height+9*BILI, 21*BILI, 21*BILI)];
        daShangImageView.image = [UIImage imageNamed:@"dongtai_btn_shang"];
        [self addSubview:daShangImageView];

        
        if([@"shenHeZhong" isEqualToString:[TanLiao_Common getShenHeStatusStr]])
        {
            daShangLable.hidden = YES;
            daShangImageView.hidden = YES;
        }
        
        UIView * bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, lineView.frame.origin.y+lineView.frame.size.height+38*BILI, VIEW_WIDTH, 5)];
        bottomLineView.backgroundColor = UIColorFromRGB(0xF8F8F8);
        [self addSubview:bottomLineView];



    }

    
}
- (NSArray *)gsc_yuuakkS87314xyhxV705
{
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@(238)];
    [array addObject:@(137)];
    [array addObject:@(419)];
    [array addObject:@(990)];
    [array addObject:@(288)];
    [array addObject:@(955)];
    return array;
}
-(void)zanButtonClick
{
    [self.delegate zanTrends:self.trendInfo];
}
-(void)deleteTrendsButtonClick
{
    [self.delegate deleteTrend:self.trendInfo];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
