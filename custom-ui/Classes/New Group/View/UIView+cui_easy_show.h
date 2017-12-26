//
//  UIView+cui_easy_show.h
//  customui-dev
//
//  Created by 张超 on 2017/12/4.
//  Copyright © 2017年 orzer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (cui_easy_show)

#if UIKIT_DEFINE_AS_PROPERTIES
@property (class, readonly, nonatomic) void (^a)(NSTimeInterval t,void (^)(void));
@property (readonly, nonatomic) __kindof UIView* (^t)(CGFloat dx,CGFloat dy);
#else
+ (void (^)(NSTimeInterval t,void (^)(void)))a;
- (__kindof UIView *(^)(CGFloat dx,CGFloat dy))t;
#endif

@end

NS_ASSUME_NONNULL_END
