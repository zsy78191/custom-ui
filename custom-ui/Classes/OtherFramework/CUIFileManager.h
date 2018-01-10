//
//  PWFileController.h
//  mframe
//
//  Created by 张超 on 2017/5/12.
//  Copyright © 2017年 orzer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CUIFileManager : NSObject

/**
 根据bytes大小返回kb,mb,gb描述

 @param bytes 字节数
 @return 描述
 */
- (NSString *)  bytesToAvaiUnit:(long long)bytes;


/**
 获取Home路径

 @return home路径
 */
- (NSString *)  getHomeDirectory;


/**
 获取设备存储空间大小

 @return 存储字节数
 */
- (long long)   getTotalDiskSpace;


/**
 单个文件大小

 @param filePath 文件路径
 @return 字节数
 */
- (long long)   fileSizeAtPath:(NSString*) filePath;


/**
 获取目录大小

 @param folderPath 目录路径
 @return 字节数
 */
- (long long)   folderSizeAtPath:(NSString*) folderPath;

/**
 清空一个目录

 @param folderPath 目录路径
 */
- (void)        clearFolderAtPath:(NSString*) folderPath;

@end
