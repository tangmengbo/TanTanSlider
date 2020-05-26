//
//  AvatarImageVIew.m
//  DidiTravel
//
//  Created by Apple_yjh on 15/5/30.
//  Copyright (c) 2015年 yjh. All rights reserved.
//

#import "AvatarImageVIew.h"
#import "ImageCache.h"

@implementation AvatarImageVIew

@synthesize defaultImage;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self)
    {
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.bounds.size.width/2;
    if (!self.image)
    {
        self.image = defaultImage;
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
