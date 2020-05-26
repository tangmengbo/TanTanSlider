//
//  HomePageTableViewCell.m
//  SeeYou
//
//  Created by mac on 2017/4/6.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "PostCardTableViewCell.h"

@implementation PostCardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        self.backgroundColor = UIColorFromRGB(0xF5F5F5);
        
        self.view1 = [[UIView alloc] initWithFrame:CGRectMake(5*BILI, 0, (VIEW_WIDTH-15*BILI)/2, 478*BILI/2)];
        self.view1.layer.cornerRadius = 8*BILI;
        self.view1.clipsToBounds = YES;
        self.view1.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.view1];
        
        self.view2 = [[UIView alloc] initWithFrame:CGRectMake(5*BILI+(VIEW_WIDTH-15*BILI)/2+5*BILI,0 , (VIEW_WIDTH-15*BILI)/2, 478*BILI/2)];
        self.view2.layer.cornerRadius = 8*BILI;
        self.view2.clipsToBounds = YES;
        self.view2.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.view2];
        
    }
    return self;
}
-(void)initData:(NSDictionary *)info1 data2:(NSDictionary *)info2  listTagId:(NSString *)listTagId
{
    
    [self.view1 removeAllSubviews];
    [self.view2 removeAllSubviews];
    
    self.listTagId = listTagId;
    self.info1 = info1;
    
    TanLiaoCustomImageView * imageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(0, 0, (VIEW_WIDTH-15*BILI)/2, (VIEW_WIDTH-15*BILI)/2)];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *imageViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTap:)];
    [imageView addGestureRecognizer:imageViewTap];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.autoresizingMask = UIViewAutoresizingNone;
    imageView.clipsToBounds = YES;
    imageView.tag = 1;
    imageView.userInteractionEnabled = YES;
    imageView.urlPath = [info1 objectForKey:@"picUrl"];
    [self.view1 addSubview:imageView];
    
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTap:)];
    [imageView addGestureRecognizer:tap1];
    
    TanLiaoCustomImageView * userHeaderImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(10*BILI, imageView.frame.size.height+10*BILI, 18*BILI ,18*BILI)];
    userHeaderImageView.imgType = IMAGEVIEW_TYPE_CENTER;
    userHeaderImageView.contentMode = UIViewContentModeScaleAspectFill;
    userHeaderImageView.autoresizingMask = UIViewAutoresizingNone;
    userHeaderImageView.urlPath = [info1 objectForKey:@"avatarUrl"];
    [self.view1 addSubview:userHeaderImageView];
    
    UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(userHeaderImageView.frame.origin.x+userHeaderImageView.frame.size.width+7*BILI, userHeaderImageView.frame.origin.y+1.5*BILI, (78+150)*BILI/2, 15*BILI)];
    nameLable.font =[UIFont systemFontOfSize:15*BILI];
    nameLable.textColor = [UIColor blackColor];
    nameLable.text = [info1 objectForKey:@"name"];
    [self.view1 addSubview:nameLable];
    
    if ([@"show" isEqualToString:self.alsoShowDeleteStr]) {
        UIButton * deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(310*BILI/2, userHeaderImageView.frame.origin.y, 15*BILI, 15*BILI)];
        deleteButton.tag = 1;
        [deleteButton setBackgroundImage:[UIImage imageNamed:@"mjb_shanchu"] forState:UIControlStateNormal];
        [deleteButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view1 addSubview:deleteButton];

    }
    
    UILabel * dianZanLable = [[UILabel alloc] initWithFrame:CGRectMake(userHeaderImageView.frame.origin.x, userHeaderImageView.frame.origin.y+userHeaderImageView.frame.size.height+11*BILI, VIEW_WIDTH, 10*BILI)];
    dianZanLable.textColor = [UIColor lightGrayColor];
    dianZanLable.font = [UIFont systemFontOfSize:10*BILI];
    [self.view1 addSubview:dianZanLable];
    
    
    NSString * numStr = [info1 objectForKey:@"moment_like_count"];
    NSString * str = [NSString stringWithFormat:@"%@人觉得很赞",numStr];
    NSAttributedString * str1 = [[NSAttributedString alloc] initWithString:str];
    NSMutableAttributedString * text1 = [[NSMutableAttributedString alloc] initWithAttributedString:str1];
    [text1 addAttribute:NSForegroundColorAttributeName
                  value:UIColorFromRGB(0xFF5C93)
                  range:NSMakeRange(0, numStr.length)];
    dianZanLable.attributedText = text1;
    
    CGSize dianZanLableSize = [TanLiao_Common setSize:str withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_WIDTH) withFontSize:10*BILI];
    
    UIImageView * zanImageView = [[UIImageView alloc] initWithFrame:CGRectMake(dianZanLable.frame.origin.x+dianZanLableSize.width+2*BILI, dianZanLable.frame.origin.y, 10*BILI, 10*BILI)];
    zanImageView.image = [UIImage imageNamed:@"mjb_xiao_zan"];
    [self.view1 addSubview:zanImageView];

    
    UIImageView * daShangImageView = [[UIImageView alloc] initWithFrame:CGRectMake(320*BILI/2, zanImageView.frame.origin.y, 10*BILI, 10*BILI)];
    daShangImageView.image = [UIImage imageNamed:@"mjb_shang"];
    [self.view1 addSubview:daShangImageView];
    
    UILabel * daShangLable = [[UILabel alloc] initWithFrame:CGRectMake(320*BILI/2-100*BILI-2*BILI, userHeaderImageView.frame.origin.y+userHeaderImageView.frame.size.height+11*BILI, 100*BILI, 10*BILI)];
    daShangLable.textColor =[UIColor lightGrayColor];
    daShangLable.font = [UIFont systemFontOfSize:10*BILI];
    daShangLable.textAlignment = NSTextAlignmentRight;
    daShangLable.adjustsFontSizeToFitWidth = YES;
    [self.view1 addSubview:daShangLable];
    

    numStr = [info1 objectForKey:@"moment_gift_count"];
    str = [NSString stringWithFormat:@"%@人送礼",numStr];
    str1 = [[NSAttributedString alloc] initWithString:str];
    text1 = [[NSMutableAttributedString alloc] initWithAttributedString:str1];
    [text1 addAttribute:NSForegroundColorAttributeName
                  value:UIColorFromRGB(0xFF5C93)
                  range:NSMakeRange(0, numStr.length)];
    daShangLable.attributedText = text1;
    
    if (info2) {
        
        self.info2 = info2;
        
        TanLiaoCustomImageView * imageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(0, 0, (VIEW_WIDTH-15*BILI)/2, (VIEW_WIDTH-15*BILI)/2)];
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *imageViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTap:)];
        [imageView addGestureRecognizer:imageViewTap];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.autoresizingMask = UIViewAutoresizingNone;
        imageView.clipsToBounds = YES;
        imageView.tag = 2;
        imageView.userInteractionEnabled = YES;

        imageView.urlPath = [info2 objectForKey:@"picUrl"];
        [self.view2 addSubview:imageView];

        UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTap:)];
        [imageView addGestureRecognizer:tap1];
        
        TanLiaoCustomImageView * userHeaderImageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(10*BILI, imageView.frame.size.height+10*BILI, 18*BILI ,18*BILI)];
        userHeaderImageView.imgType = IMAGEVIEW_TYPE_CENTER;
        userHeaderImageView.contentMode = UIViewContentModeScaleAspectFill;
        userHeaderImageView.autoresizingMask = UIViewAutoresizingNone;
        userHeaderImageView.urlPath =[info2 objectForKey:@"avatarUrl"];
        [self.view2 addSubview:userHeaderImageView];
        
        UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(userHeaderImageView.frame.origin.x+userHeaderImageView.frame.size.width+7*BILI, userHeaderImageView.frame.origin.y+1.5*BILI, (78+150)*BILI/2, 15*BILI)];
        nameLable.font =[UIFont systemFontOfSize:15*BILI];
        nameLable.textColor = [UIColor blackColor];
        nameLable.text = [info2 objectForKey:@"name"];
        [self.view2 addSubview:nameLable];
        
        
        if ([@"show" isEqualToString:self.alsoShowDeleteStr]) {
            UIButton * deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(310*BILI/2, userHeaderImageView.frame.origin.y, 15*BILI, 15*BILI)];
            deleteButton.tag = 2;
            [deleteButton setBackgroundImage:[UIImage imageNamed:@"mjb_shanchu"] forState:UIControlStateNormal];
            [deleteButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.view2 addSubview:deleteButton];
            
        }
        
        UILabel * dianZanLable = [[UILabel alloc] initWithFrame:CGRectMake(userHeaderImageView.frame.origin.x, userHeaderImageView.frame.origin.y+userHeaderImageView.frame.size.height+11*BILI, VIEW_WIDTH, 10*BILI)];
        dianZanLable.textColor = [UIColor lightGrayColor];
        dianZanLable.font = [UIFont systemFontOfSize:10*BILI];
        [self.view2 addSubview:dianZanLable];
        
        NSString * numStr = [info2 objectForKey:@"moment_like_count"];
        NSString * str = [NSString stringWithFormat:@"%@人觉得很赞",numStr];
        NSAttributedString * str1 = [[NSAttributedString alloc] initWithString:str];
        NSMutableAttributedString * text1 = [[NSMutableAttributedString alloc] initWithAttributedString:str1];
        [text1 addAttribute:NSForegroundColorAttributeName
                      value:UIColorFromRGB(0xFF5C93)
                      range:NSMakeRange(0, numStr.length)];
        dianZanLable.attributedText = text1;
        
        CGSize dianZanLableSize = [TanLiao_Common setSize:str withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_WIDTH) withFontSize:10*BILI];
        
        UIImageView * zanImageView = [[UIImageView alloc] initWithFrame:CGRectMake(dianZanLable.frame.origin.x+dianZanLableSize.width+2*BILI, dianZanLable.frame.origin.y, 10*BILI, 10*BILI)];
        zanImageView.image = [UIImage imageNamed:@"mjb_xiao_zan"];
        [self.view2 addSubview:zanImageView];
        
        
        UIImageView * daShangImageView = [[UIImageView alloc] initWithFrame:CGRectMake(320*BILI/2, zanImageView.frame.origin.y, 10*BILI, 10*BILI)];
        daShangImageView.image = [UIImage imageNamed:@"mjb_shang"];
        [self.view2 addSubview:daShangImageView];
        
        UILabel * daShangLable = [[UILabel alloc] initWithFrame:CGRectMake(320*BILI/2-100*BILI-2*BILI, userHeaderImageView.frame.origin.y+userHeaderImageView.frame.size.height+11*BILI, 100*BILI, 10*BILI)];
        daShangLable.textColor = [UIColor lightGrayColor];
        daShangLable.font = [UIFont systemFontOfSize:10*BILI];
        daShangLable.textAlignment = NSTextAlignmentRight;
        [self.view2 addSubview:daShangLable];
        
        numStr = [info2 objectForKey:@"moment_gift_count"];
        str = [NSString stringWithFormat:@"%@人送礼",numStr];
        str1 = [[NSAttributedString alloc] initWithString:str];
        text1 = [[NSMutableAttributedString alloc] initWithAttributedString:str1];
        [text1 addAttribute:NSForegroundColorAttributeName
                      value:UIColorFromRGB(0xFF5C93)
                      range:NSMakeRange(0, numStr.length)];
        daShangLable.attributedText = text1;
        
    }
}
-(void)imageViewTap:(UITapGestureRecognizer *)gesture
{
    TanLiaoCustomImageView * imageView = (TanLiaoCustomImageView *)gesture.view;
    if (imageView.tag==1)
    {
        [self.delegate pushToDatailVC:self.info1 listTagId:self.listTagId];
    }
    else
    {
        [self.delegate pushToDatailVC:self.info2 listTagId:self.listTagId];
    }
}
-(void)deleteButtonClick:(id)sender
{
    UIButton * button = (UIButton *)sender;
    if (button.tag==1)
    {
        [self.delegate deletePostCard:self.info1 listTagId:self.listTagId];
    }
    else
    {
         [self.delegate deletePostCard:self.info2 listTagId:self.listTagId];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
