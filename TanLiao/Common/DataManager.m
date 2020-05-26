//
//  DataManager.m
//  fenbei
//
//  Created by UserMain on 16/3/16.
//  Copyright © 2016年 fnks. All rights reserved.
//

#import "AppDelegate.h"
#import "DataManager.h"

@implementation DataManager {
    
}

#pragma mark - 单例

static DataManager *dataManager = nil;

+ (DataManager*)getInstance {
    return dataManager;
}

+ (void) initialize {
    static BOOL initialized = NO;
    if (initialized == NO) {
        dataManager = [[DataManager alloc]init];
        initialized = YES;
    }
}

@end


