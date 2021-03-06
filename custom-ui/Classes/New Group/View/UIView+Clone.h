//
//  UIView+Maker.h
//  mframe
//
//  Created by 张超 on 2017/4/14.
//  Copyright © 2017年 orzer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Clone)

/**
 获取预定样式副本

 @param key key
 @return 副本实例
 */
+ (__kindof UIView*)cui_cloneForKey:(NSString*)key;

/**
 注册样式
 
 @param key key
 @param makeBlock 样式配置block
 */
+ (void)cui_registStyle:(NSString*)key make:(void(^)(id view))makeBlock;


/**
 实例拷贝

 @return 拷贝实例
 */
- (__kindof UIView*)cui_clone;


/**
 多次拷贝

 @param times 拷贝次数
 @param makeBlock 样式配置block
 */
- (void)cui_copyTimes:(NSUInteger)times make:(void(^)(id view, NSUInteger idx))makeBlock;


/**
 设置样式
 
 @param makeBlock 样式配置block
 */
- (void)cui_setAttr:(void(^)(id view))makeBlock;

@end

NS_ASSUME_NONNULL_END
