//
//  XYUtility.h
//  SkiLogger
//
//  Created by Jiao Jianhua on 15/10/19.
//  Copyright © 2015年 Samuel Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

#define CloudImageWidth                             960
#define CloudImageHeight                            1280

#define Phasset2NSdataOptionsSize                   @"Phasset2NSdataOptionsSize"
#define Phasset2NSdataOptionsSizeWidth              @"Phasset2NSdataOptionsSizeWidth"
#define Phasset2NSdataOptionsSizeHeight             @"Phasset2NSdataOptionsSizeHeight"
#define Phasset2NSdataOptionsCompressionFactor      @"Phasset2NSdataOptionsCompressionFactor"

@interface XYUtility : NSObject

+ (NSDate* __nullable) string2Date:(NSString* __nullable)string;
+ (NSString* __nullable)date2Text:(NSDate* __nullable)date withFormatter:(NSString * __nullable)formatterStr;
+ (NSString* __nullable)timeStampSince1970ToText:(NSTimeInterval)fromTimeStamp to:(NSTimeInterval)toTimeStamp;
+ (NSString* __nullable)duration2Text:(double)duration;
+ (NSString* __nullable)duration2Text_2:(double)duration;
+ (NSString* __nullable)duration2Text_3:(double)duration;
+ (NSTimeInterval) timestampFrom2001To1970:(NSTimeInterval)timeInterval;

+ (void)showHUD:(NSString* __nullable)title;
+ (void)hideHUD;
+ (void)showAlert:(NSString* __nullable)message;
+ (void)showToast:(NSString* __nullable)message;

+ (id __nullable)generateRequestParameter:(NSDictionary* __nullable)parameterDict withSessionid:( NSString* __nullable)sessionId;

+ (UIImage* __nullable) prepareImage4CDN:(UIImage* __nullable) image;

+ (BOOL)validateEmail:(NSString* __nullable)email;
+ (BOOL)validateMobile:(NSString* __nullable)mobile;

+ (void) changeModule:(NSString* __nullable)name;

+ (void) disableIQKeyboardManager;
+ (void) enableIQKeyboardManager;
+ (void)disableToolBar;

+ (BOOL)isConnetionAvailabe;


@end
