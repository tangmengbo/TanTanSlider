//
//  RCDTestMessageCell.m
//  RCloudMessage
//
//  Created by 岑裕 on 15/12/17.
//  Copyright © 2015年 RongCloud. All rights reserved.
//

#import "FQSQ_ChatVideoMessageCell.h"

#define Test_Message_Font_Size 16

#define CURRENT_SYS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define XH_STRETCH_IMAGE(image, edgeInsets) (CURRENT_SYS_VERSION < 6.0 ? [image stretchableImageWithLeftCapWidth:edgeInsets.left topCapHeight:edgeInsets.top] : [image resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeStretch])


@implementation FQSQ_ChatVideoMessageCell
+ (CGSize)sizeForMessageModel:(RCMessageModel *)model
      withCollectionViewWidth:(CGFloat)collectionViewWidth
         referenceExtraHeight:(CGFloat)extraHeight {
    ChatVideoMessage *message = (ChatVideoMessage *)model.content;
    CGSize size = [FQSQ_ChatVideoMessageCell getBubbleBackgroundViewSize:message];

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
    ChatVideoMessage *testMessage = (ChatVideoMessage *)self.model.content;
    if (testMessage) {
        self.textLabel.text = testMessage.content;
    }
    self.nicknameLabel.hidden = YES;
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
            CGRectMake(0, -16, bubbleBackgroundViewSize.width, bubbleBackgroundViewSize.height);
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
            CGRectMake(0, -16, bubbleBackgroundViewSize.width, bubbleBackgroundViewSize.height);
        UIImage *image = [RCKitUtility imageNamed:@"chat_to_bg_normal" ofBundle:@"RongCloud.bundle"];
        self.bubbleBackgroundView.image =
            [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height * 0.8, image.size.width * 0.2,
                                                                image.size.height * 0.2, image.size.width * 0.8)];
    }
     [self.bubbleBackgroundView removeAllSubviews];
    self.bubbleBackgroundView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPressed)];
    [self.bubbleBackgroundView addGestureRecognizer:tap];
    
    
    UILabel * titleLable = [[UILabel alloc] initWithFrame:CGRectMake(39*BILI/2, 20*BILI/2, 150*BILI, 14*BILI)];
    titleLable.font = [UIFont systemFontOfSize:14*BILI];
    titleLable.textColor = UIColorFromRGB(0x291A33);
    titleLable.text = @"发来一个私密视频！";
    [self.bubbleBackgroundView addSubview:titleLable];
    
    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(titleLable.frame.origin.x, titleLable.frame.origin.y+titleLable.frame.size.height+3*BILI, 150*BILI, 10*BILI)];
    tipLable.font = [UIFont systemFontOfSize:10*BILI];
    tipLable.textColor =[UIColor blackColor];
    tipLable.alpha =0.5;
    tipLable.text = @"该消息为隐私消息，仅限您本人";
    [self.bubbleBackgroundView addSubview:tipLable];
    
    TanLiaoCustomImageView * imageView = [[TanLiaoCustomImageView alloc] initWithFrame:CGRectMake(39*BILI/2, tipLable.frame.origin.y+tipLable.frame.size.height+13*BILI, 150*BILI, 200*BILI)];
    [self.bubbleBackgroundView addSubview:imageView];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *image = [CIImage imageWithContentsOfURL:[NSURL URLWithString:[info objectForKey:@"picUrl"]]];
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:image forKey:kCIInputImageKey];
    // 设置模糊值
    [filter setValue:@10.0f forKey: @"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef outImage = [context createCGImage: result fromRect:CGRectMake(0, 0, 150*BILI, 200*BILI)];
    UIImage * blurImage = [UIImage imageWithCGImage:outImage];
    imageView.image = blurImage;
    
    
    UIImageView * boFangImageView = [[UIImageView alloc] initWithFrame:CGRectMake(153*BILI/2, 132*BILI, 36*BILI, 36*BILI)];
    boFangImageView.image = [UIImage imageNamed:@"pic_play-block"];
    [self.bubbleBackgroundView addSubview:boFangImageView];
    
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(6*BILI, self.bubbleBackgroundView.frame.size.height-34*BILI, self.bubbleBackgroundView.frame.size.width-6*BILI, 34*BILI)];
    bottomView.backgroundColor = UIColorFromRGB(0xA2CD96);
    [self.bubbleBackgroundView addSubview:bottomView];

    UIImageView * suoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15*BILI, 551*BILI/2, 12*BILI, 12*BILI)];
    suoImageView.image = [UIImage imageNamed:@"pic_messages_lock"];
    [self.bubbleBackgroundView addSubview:suoImageView];
    
    UILabel * siMiMesLable = [[UILabel alloc] initWithFrame:CGRectMake(suoImageView.frame.origin.x+suoImageView.frame.size.width+19*BILI/2, suoImageView.frame.origin.y, 150*BILI, 12*BILI)];
    siMiMesLable.font = [UIFont systemFontOfSize:12*BILI];
    siMiMesLable.textColor =[UIColor whiteColor];
    siMiMesLable.text = @"隐私消息";
    [self.bubbleBackgroundView addSubview:siMiMesLable];
    
    UILabel * chaKanLable = [[UILabel alloc] initWithFrame:CGRectMake(self.bubbleBackgroundView.frame.size.width-112*BILI, suoImageView.frame.origin.y, 100*BILI, 12*BILI)];
    chaKanLable.font = [UIFont systemFontOfSize:12*BILI];
    chaKanLable.textColor =[UIColor whiteColor];
    chaKanLable.textAlignment = NSTextAlignmentRight;
    chaKanLable.text = @"立即播放";
    [self.bubbleBackgroundView addSubview:chaKanLable];
    
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

+ (CGSize)getTextLabelSize:(ChatVideoMessage *)message {
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

    return CGSizeMake(369*BILI/2, 598*BILI/2);
}

+ (CGSize)getBubbleBackgroundViewSize:(ChatVideoMessage *)message {
    CGSize textLabelSize = [[self class] getTextLabelSize:message];
    return [[self class] getBubbleSize:textLabelSize];
}

@end
