//
//  mjb_CommitListTableViewCell.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/4/3.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "mjb_CommitListTableViewCell.h"

@implementation mjb_CommitListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
}
-(void)initData:(NSDictionary *)info
{
    [self removeAllSubviews];
    
    TanLiaoCustomImageView * headerImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(12*BILI, 12*BILI, 40*BILI, 40*BILI)];
    headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    headerImageView.autoresizingMask = UIViewAutoresizingNone;
    headerImageView.imgType = IMAGEVIEW_TYPE_CENTER;
    headerImageView.urlPath = [info objectForKey:@"avatarUrl"];
    [self addSubview:headerImageView];
    
    UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(64*BILI, 13*BILI, VIEW_WIDTH, 15*BILI)];
    nameLable.textColor = [UIColor blackColor];
    nameLable.alpha = 0.4;
    nameLable.font = [UIFont systemFontOfSize:15*BILI];
    nameLable.text = [info objectForKey:@"applyUserName"];
    [self addSubview:nameLable];
    
    if([info objectForKey:@"applyToUserName"])
    {
         nameLable.text = [NSString stringWithFormat:@"%@ 回复  %@",[info objectForKey:@"applyUserName"],[info objectForKey:@"applyToUserName"]] ;
    }
    
    UILabel * commitLable = [[UILabel alloc] initWithFrame:CGRectMake(nameLable.frame.origin.x, 35*BILI, 577*BILI/2, 0)];
    commitLable.backgroundColor = [UIColor clearColor];
    commitLable.numberOfLines = 0;
    //lable中要显示的文字
    NSString * describle = [info objectForKey:@"content"];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:describle];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //调整行间距
    [paragraphStyle setLineSpacing:2];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [describle length])];
    commitLable.attributedText = attributedString;
    //设置自适应
    [commitLable  sizeToFit];
    [self addSubview:commitLable];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, commitLable.frame.origin.y+commitLable.frame.size.height+13*BILI, VIEW_WIDTH, 1*BILI)];
    lineView.backgroundColor = UIColorFromRGB(0xF5F5F5);
    [self addSubview:lineView];

    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
