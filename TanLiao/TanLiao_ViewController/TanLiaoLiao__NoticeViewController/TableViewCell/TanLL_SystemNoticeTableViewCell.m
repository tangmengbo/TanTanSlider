//
//  SystemNoticeTableViewCell.m
//  FanQieSQ
//
//  Created by 周璟琳 on 2017/4/10.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "TanLL_SystemNoticeTableViewCell.h"

@implementation TanLL_SystemNoticeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];


 

   

    if (self)
    {
        self.titleLable = [[UILabel alloc] initWithFrame:CGRectMake(12*BILI, 14*BILI, VIEW_WIDTH-(12*BILI)*2, 15*BILI)];
        self.titleLable.font = [UIFont systemFontOfSize:15*BILI];
        self.titleLable.textColor = [UIColor blackColor];




        self.titleLable.alpha = 0.9;
        [self addSubview:self.titleLable];



 

        
        self.messageLable = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLable.frame.origin.x, self.titleLable.frame.origin.y+self.titleLable.frame.size.height+13*BILI/2, self.titleLable.frame.size.width, 12*BILI)];
        self.messageLable.font = [UIFont systemFontOfSize:12*BILI];
        self.messageLable.textColor = [UIColor blackColor];


 

   

        self.messageLable.alpha = 0.5;
        [self addSubview:self.messageLable];



 
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 65*BILI-1, VIEW_WIDTH, 1)];
        lineView.backgroundColor = UIColorFromRGB(0xD8D8D8);
        [self addSubview:lineView];


 

        
    }
    return self;
}


-(void)initData:(NSDictionary *)info
{
    
    NSString* string =  [info objectForKey:@"createdAt"];
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];


 


    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
    [inputFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate* inputDate = [inputFormatter dateFromString:string];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];

    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *str = [outputFormatter stringFromDate:inputDate];


    
    if (![@"FQSQStatus" isEqualToString:FQSQSHSTATUS])
    {
        NSMutableArray *array = [NSMutableArray array];
        [array addObject:@(905)];
        [array addObject:@(164)];
        [array addObject:@(932)];
        [array addObject:@(380)];
        [array addObject:@(404)];
        [array addObject:@(637)];
        [array addObject:@(912)];
        [array addObject:@(420)];
    }

    
    self.titleLable.text = [NSString stringWithFormat:@"%@ %@",[info objectForKey:@"name"],str ];
    self.messageLable.text = [info objectForKey:@"content"];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
