//
//  UIColor+cui_theme.h
//  customui-dev
//
//  Created by 张超 on 2017/12/4.
//  Copyright © 2017年 orzer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (cui_theme)
+ (UIColor *)cui_rgb:(uint32_t)rgbValue;
+ (UIColor *)cui_rgbHex:(NSString*)rgbHex;

+ (void)setColor:(UIColor*)color forKey:(NSString*)key;
+ (UIColor*)colorForKey:(NSString*)key;

#if UIKIT_DEFINE_AS_PROPERTIES
@property (class, readonly, nonatomic) void (^keyed)(NSString *,UIColor *);
@property (class, readonly, nonatomic) UIColor* (^k)(NSString *);
#else
+ (void (^)(NSString *,UIColor *))keyed;
+ (UIColor *(^)(NSString *))k;
#endif

//- (UIColor *(^)(CGFloat alpha))a;
@property (readonly, nonatomic) UIColor *(^a)(CGFloat alpha);
@end
