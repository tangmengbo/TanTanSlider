//
//  SearchListTableViewCell.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/3/13.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TanLiao_SearchListTableViewCell.h"

@implementation TanLiao_SearchListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];


   

    if (self)
    {
        
        self.headerImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(15*BILI, (45-30)*BILI/2, 30*BILI, 30*BILI)];
        self.headerImageView.imgType = IMAGEVIEW_TYPE_CENTER;
        [self addSubview:self.headerImageView];

        
        self.nameLable = [[UILabel alloc] initWithFrame:CGRectMake(self.headerImageView.frame.origin.x+self.headerImageView.frame.size.width+10*BILI,0,VIEW_WIDTH ,45*BILI)];
        self.nameLable.font = [UIFont systemFontOfSize:15*BILI];
        self.nameLable.textColor =UIColorFromRGB(0x333333);
        [self addSubview:self.nameLable];

        self.idLable = [[UILabel alloc] initWithFrame:CGRectMake(self.headerImageView.frame.origin.x+self.headerImageView.frame.size.width+10*BILI,0,VIEW_WIDTH ,45*BILI)];
        self.idLable.font = [UIFont systemFontOfSize:15*BILI];
        self.idLable.textColor =UIColorFromRGB(0x444444);
        self.idLable.alpha = 0.5;
        [self addSubview:self.idLable];


        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 45*BILI-1*BILI, VIEW_WIDTH, 1*BILI)];
        lineView.backgroundColor = [UIColor blackColor];

        lineView.alpha = 0.05;
        [self addSubview:lineView];


    }
    return self;
}

-(void)initData:(NSDictionary *)info alsoFinish:(NSString *)status
{

    if ([status isEqualToString:@"finish"])
    {
        self.nameLable.frame = CGRectMake(self.nameLable.frame.origin.x, 0, VIEW_WIDTH-2*self.nameLable.frame.origin.x, self.nameLable.frame.size.height);
        self.nameLable.textAlignment = NSTextAlignmentCenter;
        self.nameLable.adjustsFontSizeToFitWidth = YES;
        self.nameLable.text = @"没有搜到想要的结果? 多增加些关键字试试~";
        
        self.idLable.hidden  = YES;
        self.headerImageView.hidden = YES;
    }
    else
    {
    self.headerImageView.urlPath = [info objectForKey:@"avatarUrl"];
    
    self.nameLable.adjustsFontSizeToFitWidth = NO;
    NSString * nick = [info objectForKey:@"nick"];
    CGSize nameSize = [TanLiao_Common setSize:nick withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_WIDTH) withFontSize:15*BILI];
    self.nameLable.frame = CGRectMake(self.nameLable.frame.origin.x, self.nameLable.frame.origin.y, nameSize.width, self.nameLable.frame.size.height);
    self.nameLable.text = nick;
   
    self.idLable.frame = CGRectMake(self.nameLable.frame.origin.x+nameSize.width+10*BILI, self.nameLable.frame.origin.y, VIEW_WIDTH, self.nameLable.frame.size.height);
     NSNumber * idNUmber = [info objectForKey:@"userId"];
    self.idLable.text = [NSString stringWithFormat:@"ID:%d",idNUmber.intValue];


        if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
        {
            UIScrollView * CtqdWdvk = [[UIScrollView alloc]initWithFrame:CGRectMake(81,9,37,81)];
            CtqdWdvk.layer.cornerRadius =10;
            [self addSubview:CtqdWdvk];
            
        }

        
        self.idLable.hidden  = NO;
        self.headerImageView.hidden = NO;

    }
}
- (NSArray *)asc_szhesE492
{
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@(567)];
    [array addObject:@(745)];
    [array addObject:@(740)];
    [array addObject:@(595)];
    [array addObject:@(931)];
    [array addObject:@(418)];
    [array addObject:@(820)];
    [array addObject:@(320)];
    return array;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
