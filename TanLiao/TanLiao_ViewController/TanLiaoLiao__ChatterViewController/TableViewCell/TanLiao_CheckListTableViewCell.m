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

    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:@(744)];
        [array addObject:@(814)];
    }


    if (self)
    {
        self.headerImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(12*BILI, 25*BILI/2, 45*BILI, 45*BILI)];
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
- (void)initDataMglfzzVvknykVC:(NSDictionary *)info
{
    
    NSMutableArray * viewArray = [NSMutableArray array];
    UIView * HlbsTrpu = [[UIView alloc]initWithFrame:CGRectMake(93,71,11,51)];
    HlbsTrpu.layer.cornerRadius =9;
    [self addSubview:HlbsTrpu];
    [viewArray addObject:HlbsTrpu];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
