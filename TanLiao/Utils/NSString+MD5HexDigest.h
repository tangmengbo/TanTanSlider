//
//  NSString+MD5HexDigest.h
//  account
//
//  Created by creso on 13-1-15.
//  Copyright (c) 2013年 User. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5HexDigest)

-(NSString *) md5HexDigest;
-(NSString*)removeFloatAllZero:(NSString*)string;

@end
