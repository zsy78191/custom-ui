//
//  UIImage+cui.h
//  customui-dev
//
//  Created by 张超 on 2017/12/14.
//  Copyright © 2017年 orzer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageDraw : NSObject
{
    
}
@property (nonatomic, strong) NSMutableArray* colors;
@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) CGPoint endPoint;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat radius;

@property (nonatomic, readonly, class) UIImageDraw* (^begin)(void);
@property (nonatomic, readonly) UIImageDraw* (^addColor)(UIColor* color);
@property (nonatomic, readonly) UIImageDraw* (^setStartPoint)(CGPoint st);
@property (nonatomic, readonly) UIImageDraw* (^setEndPoint)(CGPoint et);
@property (nonatomic, readonly) UIImageDraw* (^setSize)(CGSize size);
@property (nonatomic, readonly) UIImageDraw* (^setRadius)(CGFloat radius);
@property (nonatomic, readonly) UIImage* (^draw)(void);

@end

@interface UIImage (cui)
{
    
}
@property (nonatomic, readonly, class) UIImage* (^colorRect)(CGSize size, UIColor* color);
@property (nonatomic, readonly) UIImage* (^cornerRadius)(CGFloat radius);
@property (nonatomic, readonly) UIImage* (^resize)(UIEdgeInsets insets);
@property (nonatomic, readonly) UIImage* (^resizeWithMode)(UIEdgeInsets insets, UIImageResizingMode m);
@property (nonatomic, readonly, class) UIImage* (^gradientImage)(CGSize size,NSArray* colors, CGPoint st, CGPoint et);
@property (nonatomic, readonly, class) UIImageDraw* (^beginGradient)(void);
@property (nonatomic, readonly) UIImage* (^asBorder)(CGFloat width,CGFloat radius);
@property (nonatomic, readonly) UIImage* (^asIcon)(UIImage* icon);

+ (UIImage*)gradientWithDraw:(UIImageDraw*)draw;
+ (UIImage*)gradient:(CGSize)size;
+ (UIImage*)gradient:(CGSize)size colors:(NSArray*)colors startPoint:(CGPoint)st endPoint:(CGPoint)et;

@end
