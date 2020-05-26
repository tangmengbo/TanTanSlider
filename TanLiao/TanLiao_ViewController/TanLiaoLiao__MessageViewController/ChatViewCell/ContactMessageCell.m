//
//  RCDTestMessageCell.m
//  RCloudMessage
//
//  Created by 岑裕 on 15/12/17.
//  Copyright © 2015年 RongCloud. All rights reserved.
//

#import "ContactMessageCell.h"

#define Test_Message_Font_Size 16

#define CURRENT_SYS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define XH_STRETCH_IMAGE(image, edgeInsets) (CURRENT_SYS_VERSION < 6.0 ? [image stretchableImageWithLeftCapWidth:edgeInsets.left topCapHeight:edgeInsets.top] : [image resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeStretch])


@implementation ContactMessageCell
+ (CGSize)sizeForMessageModel:(RCMessageModel *)model
      withCollectionViewWidth:(CGFloat)collectionViewWidth
         referenceExtraHeight:(CGFloat)extraHeight {
    
    RCContactNotificationMessage *message = (RCContactNotificationMessage *)model.extra;
    CGSize size = [ContactMessageCell getBubbleBackgroundViewSize:message];

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
    RCContactNotificationMessage *testMessage = (RCContactNotificationMessage *)self.model.content;
    
    if (testMessage) {
        
        self.textLabel.text = testMessage.message;
    }
   // self.nicknameLabel.hidden = YES;

    CGSize textLabelSize = [[self class] getTextLabelSize:testMessage];
    CGSize bubbleBackgroundViewSize = [[self class] getBubbleSize:textLabelSize];
    CGRect messageContentViewRect = self.messageContentView.frame;
    self.bubbleBackgroundView.clipsToBounds = YES;
    self.bubbleBackgroundView.layer.cornerRadius = 4*BILI;
    self.bubbleBackgroundView.layer.masksToBounds = YES;
    
    CGSize  textSize = [TanLiao_Common setSize:testMessage.message withCGSize:CGSizeMake(VIEW_WIDTH, VIEW_HEIGHT) withFontSize:Test_Message_Font_Size];
    //拉伸图片
    if (MessageDirection_RECEIVE == self.messageDirection) {
        self.textLabel.frame = CGRectMake(20, 7, textSize.width, textLabelSize.height);
        
        messageContentViewRect.size.width = bubbleBackgroundViewSize.width;
        self.messageContentView.frame = messageContentViewRect;
        
        self.bubbleBackgroundView.frame =
        CGRectMake(0, 0, textSize.width+12+15, bubbleBackgroundViewSize.height);
        UIImage *image = [RCKitUtility imageNamed:@"chat_from_bg_normal" ofBundle:@"RongCloud.bundle"];
        self.bubbleBackgroundView.image =
        [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height * 0.8, image.size.width * 0.8,
                                                            image.size.height * 0.2, image.size.width * 0.2)];
    } else {
        
        self.textLabel.frame = CGRectMake(12, 7, textSize.width, textLabelSize.height);
        
        messageContentViewRect.size.width = bubbleBackgroundViewSize.width;
        messageContentViewRect.size.height = bubbleBackgroundViewSize.height;
        messageContentViewRect.origin.x =
        self.baseContentView.bounds.size.width - (messageContentViewRect.size.width + HeadAndContentSpacing +
                                                  [RCIM sharedRCIM].globalMessagePortraitSize.width + 10);
        self.messageContentView.frame = messageContentViewRect;
        
        self.bubbleBackgroundView.frame =
        CGRectMake(bubbleBackgroundViewSize.width-(textSize.width+12+15), 0, textSize.width+12+15, bubbleBackgroundViewSize.height);
        UIImage *image = [RCKitUtility imageNamed:@"chat_to_bg_normal" ofBundle:@"RongCloud.bundle"];
        self.bubbleBackgroundView.image =
        [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height * 0.8, image.size.width * 0.2,
                                                            image.size.height * 0.2, image.size.width * 0.8)];
    
    }

    // [self.bubbleBackgroundView removeAllSubviews];

//    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(10*BILI, 19*BILI/2, 150*BILI, 14*BILI)];
//    titleLable.font = [UIFont systemFontOfSize:14*BILI];
//    titleLable.textColor = UIColorFromRGB(0x291A33);
//    titleLable.text = testMessage.extra;
//    [self.bubbleBackgroundView addSubview:titleLable];



   
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

+ (CGSize)getTextLabelSize:(RCContactNotificationMessage *)message {
    
    if ([message.message length] > 0) {
        float maxWidth = [UIScreen mainScreen].bounds.size.width -
                         (10 + [RCIM sharedRCIM].globalMessagePortraitSize.width + 10) * 2 - 5 - 35;
        CGRect textRect = [message.message
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

    return CGSizeMake(200*BILI/2, 70*BILI/2);
}

+ (CGSize)getBubbleBackgroundViewSize:(RCContactNotificationMessage *)message {
    CGSize textLabelSize; //= [[self class] getTextLabelSize:message];
    return [[self class] getBubbleSize:textLabelSize];
}

@end
