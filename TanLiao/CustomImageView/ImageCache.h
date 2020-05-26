//
//  ImageCache.h
//  DidiTravel
//
//  Created by Apple_yjh on 15-4-16.
//  Copyright (c) 2015年 yjh. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DEFAULT_CACHE_INVALIDATION (60*60*24)    // 1 day
#define DEFAULT_CACHE_EXPIRATION   (60*60*24*7)  // 1 week

@protocol ImageCacheDelegate <NSObject>

-(void) imageCache:(id)image didNotFindImageForKey:(NSString *)key userInfo:(NSDictionary *)info;
-(void) imageCache:(id)image didFindImage:(UIImage *)image forKey:(NSString *)key  userInfo:(NSDictionary *)info;

@end

@interface ImageCache : NSObject
{
    NSMutableDictionary *memCache;//内存缓存图片引用
    NSString *diskCachePath;//物理缓存路径
    NSOperationQueue *cacheInQueue, *cacheOutQueue;
}

@property (nonatomic) NSTimeInterval invalidationAge;

+ (ImageCache *)sharedImageCache;

//保存图片
- (void)storeImage:(UIImage *)image forKey:(NSString *)key;

//保存图片，并选择是否保存到物理存储上
- (void)storeImage:(UIImage *)image forKey:(NSString *)key toDisk:(BOOL)toDisk;

//保存图片，可以选择把NSData数据保存到物理存储上
- (void)storeImage:(UIImage *)image imageData:(NSData *)data forKey:(NSString *)key toDisk:(BOOL)toDisk;

//通过key返回UIImage
- (UIImage *)imageFromKey:(NSString *)key;

//如果获取内存图片失败，是否可以在物理存储上查找
- (UIImage *)imageFromKey:(NSString *)key fromDisk:(BOOL)fromDisk;


- (void)queryDiskCacheForKey:(NSString *)key delegate:(id <ImageCacheDelegate>)delegate userInfo:(NSDictionary *)info;

//清除key索引的图片
- (void)removeImageForKey:(NSString *)key;
//清除内存图片
- (void)clearMemory;
//清除物理缓存
- (void)clearDisk;
//清除过期物理缓存
- (void)cleanDisk;

@end
