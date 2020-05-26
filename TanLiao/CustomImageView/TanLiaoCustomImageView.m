//
//  CustomImageView.m
//  DidiTravel
//
//  Created by Apple_yjh on 15-4-16.
//  Copyright (c) 2015年 yjh. All rights reserved.
//

#import "TanLiaoCustomImageView.h"
#import "ASIHTTPRequest.h"

@implementation TanLiaoCustomImageView

@synthesize urlPath;
@synthesize defaultImage;
@synthesize imgType;
@synthesize borderColor;
@synthesize borderWidth;


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self)
    {
        self.borderColor = [UIColor whiteColor];
        self.borderWidth = 2.0;
        
        if ([@"1" isEqualToString:[TanLiao_Common getCurrentUserAnchorType]])
        {
            defaultImage = [UIImage imageNamed:@"user_placeholder_woman"];
        }
        else
        {
            defaultImage = [UIImage imageNamed:@"user_placeholder_man"];
        }
        self.image = defaultImage;
    }
    return self;
}
-(void)noPlacehold;
{
    self.image = nil;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self setView];
}

-(void)setView
{
    switch (imgType) {
        case IMAGEVIEW_TYPE_NONE:
        {
        }
            break;
        case IMAGEVIEW_TYPE_CENTER:
        {
            self.layer.masksToBounds = YES;
            self.layer.cornerRadius = self.bounds.size.width/2;
        }
            break;
        case IMAGEVIEW_TYPE_BORDERCENTER:
        {
            self.layer.masksToBounds = YES;
            self.layer.cornerRadius = self.bounds.size.width/2;
            self.layer.borderColor = [self.borderColor CGColor];
            self.layer.borderWidth = self.borderWidth;
            self.layer.bounds = CGRectMake(self.borderWidth, self.borderWidth, self.bounds.size.width-(2*self.borderWidth), self.bounds.size.height-(2*self.borderWidth));
        }
            break;
    }
}

-(void)setUrlPath:(NSString *)path
{
   
    if(![path isEqualToString:@""]&& [path length] > 0)
    {
        UIImage* newImage = [[ImageCache sharedImageCache] imageFromKey:path fromDisk:YES];
        if(!newImage)
        {
            NSURL *URL = [NSURL URLWithString:path];
            __block ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:URL];
            [request setCompletionBlock:^{
                // Use when fetching binary data
                NSData *responseData = [request responseData];
                if([responseData length] >100)
                {
                    self.image = [[UIImage alloc] initWithData:responseData];
                    [[ImageCache sharedImageCache] storeImage:[[UIImage alloc] initWithData:responseData]  imageData:responseData forKey:path toDisk:YES];
                }
            }];
            [request setFailedBlock:^{
                self.image = defaultImage;
            }];
            [request startAsynchronous];
        }
        else
        {
            self.image = newImage;
        }
    }
}

@end
