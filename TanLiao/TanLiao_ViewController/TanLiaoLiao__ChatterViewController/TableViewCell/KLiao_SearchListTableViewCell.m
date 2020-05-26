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
        
        self.headerImageView = [[KuaiLiaoCustomImageView alloc] initWithFrame:CGRectMake(15*BILI, (45-30)*BILI/2, 30*BILI, 30*BILI)];
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
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        UITableView * omhhvI1498 = [[UITableView alloc]initWithFrame:CGRectMake(86,8,48,38)];
        omhhvI1498.layer.cornerRadius =6;
        omhhvI1498.userInteractionEnabled = YES;
        omhhvI1498.layer.masksToBounds = YES;
        UITextView * ivglgsB81816 = [[UITextView alloc]initWithFrame:CGRectMake(44,60,20,35)];
        ivglgsB81816.layer.borderWidth = 1;
        ivglgsB81816.clipsToBounds = YES;
        ivglgsB81816.layer.cornerRadius =9;
        UIScrollView * wnwgtbK18817 = [[UIScrollView alloc]initWithFrame:CGRectMake(38,96,11,22)];
        wnwgtbK18817.backgroundColor = [UIColor whiteColor];
        wnwgtbK18817.layer.borderColor = [[UIColor greenColor] CGColor];
        wnwgtbK18817.layer.cornerRadius =7;
        UITableView * zqofapJ35939 = [[UITableView alloc]initWithFrame:CGRectMake(3,34,74,45)];
        zqofapJ35939.layer.cornerRadius =5;
        zqofapJ35939.userInteractionEnabled = YES;
        zqofapJ35939.layer.masksToBounds = YES;
        UIView * nsfzW165 = [[UIView alloc]initWithFrame:CGRectMake(31,57,76,70)];
        nsfzW165.layer.cornerRadius =5;
        nsfzW165.userInteractionEnabled = YES;
        nsfzW165.layer.masksToBounds = YES;
        UITableView * fprwejO27003 = [[UITableView alloc]initWithFrame:CGRectMake(91,69,30,79)];
        fprwejO27003.layer.borderWidth = 1;
        fprwejO27003.clipsToBounds = YES;
        fprwejO27003.layer.cornerRadius =6;
        UITableView * huvvqsQ40467 = [[UITableView alloc]initWithFrame:CGRectMake(34,27,79,20)];
        huvvqsQ40467.backgroundColor = [UIColor whiteColor];
        huvvqsQ40467.layer.borderColor = [[UIColor greenColor] CGColor];
        huvvqsQ40467.layer.cornerRadius =6;
        
    }
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
    CGSize nameSize = [Common setSize:nick withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_WIDTH) withFontSize:15*BILI];
    self.nameLable.frame = CGRectMake(self.nameLable.frame.origin.x, self.nameLable.frame.origin.y, nameSize.width, self.nameLable.frame.size.height);
    self.nameLable.text = nick;
   
    self.idLable.frame = CGRectMake(self.nameLable.frame.origin.x+nameSize.width+10*BILI, self.nameLable.frame.origin.y, VIEW_WIDTH, self.nameLable.frame.size.height);
     NSNumber * idNUmber = [info objectForKey:@"userId"];
    self.idLable.text = [NSString stringWithFormat:@"ID:%d",idNUmber.intValue];




        
        self.idLable.hidden  = NO;
        self.headerImageView.hidden = NO;

    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
