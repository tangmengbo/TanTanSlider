//
//  BusinessCardMessageCell.m
//  FanQieSQ
//
//  Created by 唐蒙波 on 2018/3/5.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ChatBusinessCardMessageCell.h"


#define Test_Message_Font_Size 16

#define CURRENT_SYS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define XH_STRETCH_IMAGE(image, edgeInsets) (CURRENT_SYS_VERSION < 6.0 ? [image stretchableImageWithLeftCapWidth:edgeInsets.left topCapHeight:edgeInsets.top] : [image resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeStretch])

@implementation ChatBusinessCardMessageCell
+ (CGSize)sizeForMessageModel:(RCMessageModel *)model
      withCollectionViewWidth:(CGFloat)collectionViewWidth
         referenceExtraHeight:(CGFloat)extraHeight {
    FQSQ_ChatBusinessCardMessage *message = (FQSQ_ChatBusinessCardMessage *)model.content;
    CGSize size = [ChatBusinessCardMessageCell getBubbleBackgroundViewSize:message];
    
    CGFloat __messagecontentview_height = size.height;
    __messagecontentview_height += extraHeight;
    
    return CGSizeMake(collectionViewWidth, __messagecontentview_height);
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    self.bubbleBackgroundView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.messageContentView addSubview:self.bubbleBackgroundView];
    
    self.textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.textLabel setFont:[UIFont systemFontOfSize:Test_Message_Font_Size]];
    
    self.textLabel.numberOfLines = 0;
    [self.textLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.textLabel setTextAlignment:NSTextAlignmentLeft];
    [self.textLabel setTextColor:[UIColor blackColor]];
    [self.bubbleBackgroundView addSubview:self.textLabel];
    self.bubbleBackgroundView.userInteractionEnabled = YES;
    
    
    UITapGestureRecognizer *textMessageTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTextMessage:)];
    textMessageTap.numberOfTapsRequired = 1;
    textMessageTap.numberOfTouchesRequired = 1;
    [self.textLabel addGestureRecognizer:textMessageTap];
    self.textLabel.userInteractionEnabled = YES;
}

- (void)tapTextMessage:(UIGestureRecognizer *)gestureRecognizer {
    if ([self.delegate respondsToSelector:@selector(didTapMessageCell:)]) {
        [self.delegate didTapMessageCell:self.model];
    }
}

- (void)setDataModel:(RCMessageModel *)model {
    
    [super setDataModel:model];
    
    [self setAutoLayout];
}

- (void)setAutoLayout {
    FQSQ_ChatBusinessCardMessage *testMessage = (FQSQ_ChatBusinessCardMessage *)self.model.content;
    if (testMessage) {
        self.textLabel.text = testMessage.content;
    }
    self.nicknameLabel.hidden = NO;
    self.textLabel.hidden = YES;
    
    NSDictionary * info = [TanLiao_Common dictionaryWithJsonString:testMessage.extra];
    
    CGSize textLabelSize = [[self class] getTextLabelSize:testMessage];
    CGSize bubbleBackgroundViewSize = [[self class] getBubbleSize:textLabelSize];
    CGRect messageContentViewRect = self.messageContentView.frame;
    self.bubbleBackgroundView.clipsToBounds = YES;
    self.bubbleBackgroundView.layer.cornerRadius = 4*BILI;
    self.bubbleBackgroundView.layer.masksToBounds = YES;
    //拉伸图片
    if (MessageDirection_RECEIVE == self.messageDirection) {
        self.textLabel.frame = CGRectMake(20, 7, textLabelSize.width, textLabelSize.height);
        
        messageContentViewRect.size.width = bubbleBackgroundViewSize.width;
        self.messageContentView.frame = messageContentViewRect;
        
        self.bubbleBackgroundView.frame =
        CGRectMake(0, 0, bubbleBackgroundViewSize.width, bubbleBackgroundViewSize.height);
        UIImage *image = [RCKitUtility imageNamed:@"chat_from_bg_normal" ofBundle:@"RongCloud.bundle"];
        self.bubbleBackgroundView.image =
        [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height * 0.8, image.size.width * 0.8,
                                                            image.size.height * 0.2, image.size.width * 0.2)];
    } else {
        self.textLabel.frame = CGRectMake(12, 7, textLabelSize.width, textLabelSize.height);
        
        messageContentViewRect.size.width = bubbleBackgroundViewSize.width;
        messageContentViewRect.size.height = bubbleBackgroundViewSize.height;
        messageContentViewRect.origin.x =
        self.baseContentView.bounds.size.width - (messageContentViewRect.size.width + HeadAndContentSpacing +
                                                  [RCIM sharedRCIM].globalMessagePortraitSize.width + 10);
        self.messageContentView.frame = messageContentViewRect;
        
        self.bubbleBackgroundView.frame =
        CGRectMake(0, 0, bubbleBackgroundViewSize.width, bubbleBackgroundViewSize.height);
        UIImage *image = [RCKitUtility imageNamed:@"chat_to_bg_normal" ofBundle:@"RongCloud.bundle"];
        self.bubbleBackgroundView.image =
        [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height * 0.8, image.size.width * 0.2,
                                                            image.size.height * 0.2, image.size.width * 0.8)];
    }
    [self.bubbleBackgroundView removeAllSubviews];
    self.bubbleBackgroundView.userInteractionEnabled = YES;
    
    UIImageView * bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5*BILI, 0, 512*BILI/2, 238*BILI/2)];
    bottomImageView.image = [UIImage imageNamed:@"mingpian_Group 4"];
    bottomImageView.userInteractionEnabled = YES;
    [self.bubbleBackgroundView addSubview:bottomImageView];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPressed)];
    [bottomImageView addGestureRecognizer:tap];

    
    UILabel * nameLable = [[UILabel alloc] initWithFrame:CGRectMake(39*BILI/2, 24*BILI/2, 70*BILI, 15*BILI)];
    nameLable.font = [UIFont systemFontOfSize:15*BILI];
    nameLable.textColor = UIColorFromRGB(0x333333);
    nameLable.text = [info objectForKey:@"nick"];
    nameLable.adjustsFontSizeToFitWidth = YES;
    [self.bubbleBackgroundView addSubview:nameLable];
    
    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(nameLable.frame.origin.x+nameLable.frame.size.width+5*BILI, nameLable.frame.origin.y+4*BILI, 150*BILI, 11*BILI)];
    tipLable.font = [UIFont systemFontOfSize:11*BILI];
    tipLable.textColor =UIColorFromRGB(0x333333);
    tipLable.alpha =0.5;
    tipLable.text = @"关注了你";
    [self.bubbleBackgroundView addSubview:tipLable];
    
    UIImageView * sexAgeView = [[UIImageView alloc] initWithFrame:CGRectMake(39*BILI/2, nameLable.frame.origin.y+nameLable.frame.size.height+12*BILI, 32*BILI, 15*BILI)];
    if ([@"1" isEqualToString:[info objectForKey:@"sex"]]) {
        
        sexAgeView.image = [UIImage imageNamed:@"pic_old_woman"];
        
    }
    else
    {
        sexAgeView.image = [UIImage imageNamed:@"pic_old_man"];
        
    }
    [self.bubbleBackgroundView addSubview:sexAgeView];
    
    UILabel * ageLable = [[UILabel alloc] initWithFrame:CGRectMake(3, (sexAgeView.frame.size.height-(10*BILI))/2, 20, 10*BILI)];
    ageLable.font = [UIFont systemFontOfSize:10*BILI];
    ageLable.textColor = [UIColor whiteColor];
    [sexAgeView addSubview:ageLable];
    ageLable.adjustsFontSizeToFitWidth = YES;
    ageLable.text = [NSString stringWithFormat:@"%@",[info objectForKey:@"age"]];
    
    UILabel * addressLable = [[UILabel alloc] initWithFrame:CGRectMake(sexAgeView.frame.origin.x+sexAgeView.frame.size.width+5*BILI, nameLable.frame.origin.y+nameLable.frame.size.height+11*BILI, 70*BILI, 15*BILI)];
    addressLable.font = [UIFont systemFontOfSize:15*BILI];
    addressLable.textColor = [UIColor blackColor];
    addressLable.adjustsFontSizeToFitWidth = YES;
    addressLable.alpha = 0.6;
    addressLable.text = [info objectForKey:@"cityName"];
    [self.bubbleBackgroundView addSubview:addressLable];
    
    UILabel * idLable = [[UILabel alloc] initWithFrame:CGRectMake(39*BILI/2, sexAgeView.frame.origin.y+sexAgeView.frame.size.height+14*BILI, 70*BILI, 12*BILI)];
    idLable.font = [UIFont systemFontOfSize:12*BILI];
    idLable.textColor = [UIColor blackColor];
    idLable.adjustsFontSizeToFitWidth = YES;
    idLable.text = [info objectForKey:@"userId"];
    idLable.alpha = 0.6;
    [self.bubbleBackgroundView addSubview:idLable];

}
-(void)tapPressed
{
    [self.delegate didTapMessageCell:self.model];
}
- (void)longPressed:(id)sender {
    UILongPressGestureRecognizer *press = (UILongPressGestureRecognizer *)sender;
    if (press.state == UIGestureRecognizerStateEnded) {
        return;
    } else if (press.state == UIGestureRecognizerStateBegan) {
        [self.delegate didLongTouchMessageCell:self.model inView:self.bubbleBackgroundView];
    }
}

+ (CGSize)getTextLabelSize:(FQSQ_ChatBusinessCardMessage *)message {
    if ([message.content length] > 0) {
        float maxWidth = [UIScreen mainScreen].bounds.size.width -
        (10 + [RCIM sharedRCIM].globalMessagePortraitSize.width + 10) * 2 - 5 - 35;
        CGRect textRect = [message.content
                           boundingRectWithSize:CGSizeMake(maxWidth, 8000)
                           options:(NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin |
                                    NSStringDrawingUsesFontLeading)
                           attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:Test_Message_Font_Size]}
                           context:nil];
        textRect.size.height = ceilf(textRect.size.height);
        textRect.size.width = ceilf(textRect.size.width);
        return CGSizeMake(textRect.size.width + 5, textRect.size.height + 5);
    } else {
        return CGSizeZero;
    }
}

+ (CGSize)getBubbleSize:(CGSize)textLabelSize {
    CGSize bubbleSize = CGSizeMake(textLabelSize.width, textLabelSize.height);
    
    if (bubbleSize.width + 12 + 20 > 50) {
        bubbleSize.width = bubbleSize.width + 12 + 20;
    } else {
        bubbleSize.width = 50;
    }
    if (bubbleSize.height + 7 + 7 > 40) {
        bubbleSize.height = bubbleSize.height + 7 + 7;
    } else {
        bubbleSize.height = 40;
    }
    
    return CGSizeMake(512*BILI/2, 238*BILI/2);
}

+ (CGSize)getBubbleBackgroundViewSize:(FQSQ_ChatBusinessCardMessage *)message {
    CGSize textLabelSize = [[self class] getTextLabelSize:message];
    return [[self class] getBubbleSize:textLabelSize];
}
@end
