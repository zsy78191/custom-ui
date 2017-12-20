//
//  UIImage+cui.m
//  customui-dev
//
//  Created by 张超 on 2017/12/14.
//  Copyright © 2017年 orzer. All rights reserved.
//

#import "UIImage+cui.h"

@implementation UIImage (cui)

+ (UIImage *)rect:(CGSize)size color:(UIColor *)color
{
    //设置长宽
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

+ (UIImage *(^)(CGSize, UIColor *))colorRect
{
    return ^(CGSize size, UIColor * color) {
        return [UIImage rect:size color:color];
    };
}

//生成圆角UIIamge 的方法
- (UIImage *)imageWithRoundedCornersSize:(float)cornerRadius
{
    UIImage *original = self;
    CGRect frame = CGRectMake(0, 0, original.size.width, original.size.height);
    // 开始一个Image的上下文
    UIGraphicsBeginImageContextWithOptions(original.size, NO, 1.0);
    // 添加圆角
    [[UIBezierPath bezierPathWithRoundedRect:frame
                                cornerRadius:cornerRadius] addClip];
    // 绘制图片
    [original drawInRect:frame];
    // 接受绘制成功的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *(^)(CGFloat))cornerRadius
{
    return ^ (CGFloat r){
        return [self imageWithRoundedCornersSize:r];
    };
}
@end
