//
//  TrendsDianZanOrDaShangTableViewCell.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/4/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "TrendsDianZanOrDaShangTableViewCell.h"

@implementation TrendsDianZanOrDaShangTableViewCell

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
    TanLiaoCustomImageView * headerImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(12*BILI, 10*BILI, 45*BILI, 45*BILI)];
    headerImageView.urlPath = [info objectForKey:@"avatarUrl"];
    headerImageView.imgType = IMAGEVIEW_TYPE_CENTER;
    headerImageView.contentMode  = UIViewContentModeScaleAspectFill;
    headerImageView.autoresizingMask = UIViewAutoresizingNone;
    [self addSubview:headerImageView];
    
    NSNumber * vipNumber = [info objectForKey:@"isVip"];
    if ([@"1" isEqualToString:[NSString stringWithFormat:@"%d",vipNumber.intValue]]) {
        
        UIImageView * vipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x+29*BILI, headerImageView.frame.origin.y+29*BILI, 16*BILI, 16*BILI)];
        vipImageView.image = [UIImage imageNamed:@"vip_grade_wg_h"];
        [self addSubview:vipImageView];
    }
    
    UILabel * nameLbale = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.frame.origin.x+headerImageView.frame.size.width+12*BILI, 11*BILI, 150*BILI, 16*BILI)];
    nameLbale.font = [UIFont systemFontOfSize:12*BILI];
    nameLbale.textColor = UIColorFromRGB(0xF9B630);
    nameLbale.adjustsFontSizeToFitWidth = YES;
    nameLbale.text = [info objectForKey:@"name"];
    [self addSubview:nameLbale];
    NSString * nameStr =  [info objectForKey:@"name"];
    
    if ([info objectForKey:@"goodsIconUrl"])
    {
    NSString * str = [NSString stringWithFormat:@"%@  打赏给你",nameStr];
    NSAttributedString * str1 = [[NSAttributedString alloc] initWithString:str];
    NSMutableAttributedString * text1 = [[NSMutableAttributedString alloc] initWithAttributedString:str1];
    [text1 addAttribute:NSForegroundColorAttributeName
                  value:UIColorFromRGB(0xFF1A4E)
                  range:NSMakeRange(0, nameStr.length)];
    [text1 addAttribute:NSFontAttributeName
                  value:[UIFont fontWithName:@"Helvetica-Bold" size:15*BILI]
                  range:NSMakeRange(0, nameStr.length)];
    nameLbale.attributedText = text1;
    }
    else
    {
        nameLbale.font = [UIFont systemFontOfSize:15*BILI];
        nameLbale.textColor = UIColorFromRGB(0xFF1A4E);
        nameLbale.text = nameStr;
    }
    
    UIImageView * sexAgeView = [[UIImageView alloc] initWithFrame:CGRectMake(nameLbale.frame.origin.x, nameLbale.frame.origin.y+nameLbale.frame.size.height+8*BILI, 32*BILI, 15*BILI)];
    if ([@"0" isEqualToString:[info objectForKey:@"sex"]]) {
        
        sexAgeView.image = [UIImage imageNamed:@"pic_old_woman"];
        
    }
    else
    {
        sexAgeView.image = [UIImage imageNamed:@"pic_old_man"];
        
    }
    [self addSubview:sexAgeView];
    
    if (![info objectForKey:@"sex"])
    {
        sexAgeView.hidden = YES;
        nameLbale.frame = CGRectMake(nameLbale.frame.origin.x, 0, VIEW_WIDTH, 130*BILI/2);
    }
    
    UILabel * ageLable = [[UILabel alloc] initWithFrame:CGRectMake(3, (sexAgeView.frame.size.height-(10*BILI))/2, 20, 10*BILI)];
    ageLable.font = [UIFont systemFontOfSize:10*BILI];
    ageLable.textColor = [UIColor whiteColor];
    [sexAgeView addSubview:ageLable];
    ageLable.adjustsFontSizeToFitWidth = YES;
    NSNumber * number = [info objectForKey:@"age"];
    ageLable.text = [NSString stringWithFormat:@"%d",number.intValue];
    
    UILabel * addressLable = [[UILabel alloc] initWithFrame:CGRectMake(sexAgeView.frame.origin.x+sexAgeView.frame.size.width+5*BILI, sexAgeView.frame.origin.y, 100*BILI, 15*BILI)];
    addressLable.font = [UIFont systemFontOfSize:12*BILI];
    addressLable.textColor = [UIColor blackColor];
    addressLable.alpha = 0.5;
    addressLable.adjustsFontSizeToFitWidth = YES;
    addressLable.text = [info objectForKey:@"cityName"];
    [self addSubview:addressLable];
    
    if ([info objectForKey:@"goodsIconUrl"]) {
        
        UILabel * giftNameLable = [[UILabel alloc] initWithFrame:CGRectMake(0,0, (516+96)*BILI/2, 130*BILI/2)];
        giftNameLable.font = [UIFont systemFontOfSize:12*BILI];
        giftNameLable.textColor = UIColorFromRGB(0xF9B630);
        giftNameLable.textAlignment = NSTextAlignmentRight;
        giftNameLable.text = [info objectForKey:@"goodsName"];
        [self addSubview:giftNameLable];
        
        UIView * giftBottomView = [[UIView alloc] initWithFrame:CGRectMake(636*BILI/2, 10*BILI, 45*BILI, 45*BILI)];
        giftBottomView.backgroundColor = [UIColor blackColor];
        giftBottomView.layer.cornerRadius =8*BILI;
        giftBottomView.layer.masksToBounds = YES;
        giftBottomView.alpha = 0.05;
        [self addSubview:giftBottomView];
        
        TanLiaoCustomImageView * giftImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(636*BILI/2, 10*BILI, 45*BILI, 45*BILI)];
        giftImageView.urlPath = [info objectForKey:@"goodsIconUrl"];
        [self addSubview:giftImageView];
        
    }
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 130*BILI/2-1, VIEW_WIDTH, 1)];
    lineView.backgroundColor = UIColorFromRGB(0xF8F8F8);
    [self addSubview:lineView];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
