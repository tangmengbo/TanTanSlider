//
//  BackListTableViewCell.m
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLiao_BackListTableViewCell.h"

@implementation TanLiao_BackListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];


   

    if (self)
    {
        self.headerImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(12*BILI, 10*BILI, 45*BILI, 45*BILI)];
        self.headerImageView.imgType = IMAGEVIEW_TYPE_CENTER;
        [self addSubview:self.headerImageView];




        
        self.nameLable = [[UILabel alloc] initWithFrame:CGRectMake(self.headerImageView.frame.origin.x+self.headerImageView.frame.size.width+13*BILI, 10*BILI, VIEW_WIDTH-(self.headerImageView.frame.origin.x+self.headerImageView.frame.size.width+13*BILI+12*BILI), 45*BILI)];
        self.nameLable.font = [UIFont systemFontOfSize:15*BILI];
        self.nameLable.textColor = [UIColor blackColor];




        self.nameLable.alpha = 0.9;
        [self addSubview:self.nameLable];





 

        
        UIButton * deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-25*BILI, (65*BILI-15*BILI)/2, 20*BILI, 20*BILI)];
        [deleteButton setImage:[UIImage imageNamed:@"yydb_close"] forState:UIControlStateNormal];
        [deleteButton addTarget:self action:@selector(removeButtonClick) forControlEvents:UIControlEventTouchUpInside];




        [self addSubview:deleteButton];
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 65*BILI-1, VIEW_WIDTH, 1)];
        lineView.backgroundColor = [UIColor blackColor];




        lineView.alpha = 0.05;
        [self addSubview:lineView];


        
    }
    return self;
    
}
-(void)removeButtonClick
{
    [self.delegate removeFromBlackList:self.info];
}

-(void)initData:(NSDictionary *)info
{
    self.info = info;
    self.headerImageView.urlPath =[info objectForKey:@"photoUrl"];
    self.nameLable.text = [info objectForKey:@"nick"];
   // self.lastMessageLable.text = @"最后一条消息内容";
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
