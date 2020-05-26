//
//  CheckListTableViewCell.m
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/11.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_CheckListTableViewCell.h"

@implementation TanLiao_CheckListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];




    if (self)
    {
        self.headerImageView = [[KuaiLiaoCustomImageView alloc] initWithFrame:CGRectMake(12*BILI, 25*BILI/2, 45*BILI, 45*BILI)];
        self.headerImageView.contentMode = UIViewContentModeScaleAspectFill;

        self.headerImageView.imgType = IMAGEVIEW_TYPE_CENTER;
        [self addSubview:self.headerImageView];


        
        self.nameLable = [[UILabel alloc] initWithFrame:CGRectMake(self.headerImageView.frame.origin.x+self.headerImageView.frame.size.width+13*BILI, 12*BILI, VIEW_WIDTH-(self.headerImageView.frame.origin.x+self.headerImageView.frame.size.width+13*BILI+12*BILI), 15*BILI)];
        self.nameLable.font = [UIFont systemFontOfSize:15*BILI];
        self.nameLable.textColor = [UIColor blackColor];
        self.nameLable.alpha = 0.9;
        [self addSubview:self.nameLable];

        
        self.sexImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.nameLable.frame.origin.x, self.nameLable.frame.origin.y+self.nameLable.frame.size.height+2*BILI, 15*BILI*32/15, 15*BILI)];
        [self addSubview:self.sexImageView];

        
        self.ageLable = [[UILabel alloc] initWithFrame:CGRectMake(4.8*BILI, 0, 15*BILI, 15*BILI)];
        self.ageLable.textColor = [UIColor whiteColor];
        self.ageLable.font = [UIFont systemFontOfSize:10*BILI];
        [self.sexImageView addSubview:self.ageLable];


        self.messageLable = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLable.frame.origin.x, self.sexImageView.frame.origin.y+self.sexImageView.frame.size.height+2*BILI, VIEW_WIDTH-self.nameLable.frame.origin.x-12*BILI, 12*BILI)];
        self.messageLable.textColor = [UIColor blackColor];
        self.messageLable.alpha = 0.5;
        self.messageLable.font = [UIFont systemFontOfSize:12*BILI];
        [self addSubview:self.messageLable];

        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 70*BILI-1, VIEW_WIDTH, 1)];
        lineView.backgroundColor = UIColorFromRGB(0xD8D8D8);
        [self addSubview:lineView];



    }
    return self;
}


-(void)initData:(NSDictionary *)info
{
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        UIImageView * hathX714 = [[UIImageView alloc]initWithFrame:CGRectMake(5,65,100,65)];
        hathX714.backgroundColor = [UIColor whiteColor];
        hathX714.layer.borderColor = [[UIColor greenColor] CGColor];
        hathX714.layer.cornerRadius =7;
        UIScrollView * mwbmD265 = [[UIScrollView alloc]initWithFrame:CGRectMake(92,69,35,19)];
        mwbmD265.layer.borderWidth = 1;
        mwbmD265.clipsToBounds = YES;
        mwbmD265.layer.cornerRadius =7;
        UITableView * oqavkF6717 = [[UITableView alloc]initWithFrame:CGRectMake(74,89,64,56)];
        oqavkF6717.backgroundColor = [UIColor whiteColor];
        oqavkF6717.layer.borderColor = [[UIColor greenColor] CGColor];
        oqavkF6717.layer.cornerRadius =7;
        UILabel * mftzufH31418 = [[UILabel alloc]initWithFrame:CGRectMake(100,32,98,15)];
        mftzufH31418.layer.cornerRadius =8;
        mftzufH31418.userInteractionEnabled = YES;
        mftzufH31418.layer.masksToBounds = YES;
        UIView * jlzmS095 = [[UIView alloc]initWithFrame:CGRectMake(73,23,61,21)];
        jlzmS095.layer.borderWidth = 1;
        jlzmS095.clipsToBounds = YES;
        jlzmS095.layer.cornerRadius =8;
        UIImageView * bnqeM840 = [[UIImageView alloc]initWithFrame:CGRectMake(69,2,55,11)];
        bnqeM840.backgroundColor = [UIColor whiteColor];
        bnqeM840.layer.borderColor = [[UIColor greenColor] CGColor];
        bnqeM840.layer.cornerRadius =9;
        UITextView * wqvzjI2475 = [[UITextView alloc]initWithFrame:CGRectMake(49,44,69,53)];
        wqvzjI2475.layer.cornerRadius =10;
        wqvzjI2475.userInteractionEnabled = YES;
        wqvzjI2475.layer.masksToBounds = YES;
        UITableView * weftZ014 = [[UITableView alloc]initWithFrame:CGRectMake(5,14,54,38)];
        weftZ014.backgroundColor = [UIColor whiteColor];
        weftZ014.layer.borderColor = [[UIColor greenColor] CGColor];
        weftZ014.layer.cornerRadius =9;
        UIScrollView * rkxnE820 = [[UIScrollView alloc]initWithFrame:CGRectMake(25,78,75,13)];
        rkxnE820.layer.cornerRadius =5;
        rkxnE820.userInteractionEnabled = YES;
        rkxnE820.layer.masksToBounds = YES;
        UIView * nmdvhmK13386 = [[UIView alloc]initWithFrame:CGRectMake(88,12,26,19)];
        nmdvhmK13386.layer.borderWidth = 1;
        nmdvhmK13386.clipsToBounds = YES;
        nmdvhmK13386.layer.cornerRadius =9;
        
    }
    //@"pic_old_man"
    if ([@"1" isEqualToString:[info objectForKey:@"sex"]]) {
        
        self.sexImageView.image = [UIImage imageNamed:@"pic_old_man"];

    }
    else
    {
    self.sexImageView.image = [UIImage imageNamed:@"pic_old_woman"];
    }
    self.headerImageView.urlPath =  [info objectForKey:@"avatarUrl"];
    self.nameLable.text = [info objectForKey:@"nick"];
    self.ageLable.text = [info objectForKey:@"age"];
    self.messageLable.text = [info objectForKey:@"content"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
