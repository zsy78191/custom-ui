//
//  UIImage+cui.m
//  customui-dev
//
//  Created by 张超 on 2017/12/14.
//  Copyright © 2017年 orzer. All rights reserved.
//

#import "UIImage+cui.h"
#import "UIColor+blend.h"
#import "UIColor+cui_theme.h"
#import "NSObject+Functional.h"

@implementation UIImageDraw
- (NSMutableArray *)colors
{
    if (!_colors) {
        _colors = [NSMutableArray arrayWithCapacity:10];
    }
    return _colors;
}

+ (instancetype)defaultOne
{
    UIImageDraw* i = [[UIImageDraw alloc] init];
    i.startPoint = CGPointMake(0, 0);
    i.endPoint = CGPointMake(1, 1);
    i.size = CGSizeMake(100, 100);
    i.radius = 0;
    return i;
}

+ (UIImageDraw *(^)(void))begin
{
    return ^ {
        return [UIImageDraw defaultOne];
    };
}

- (UIImageDraw *(^)(CGSize))setSize
{
    return ^ (CGSize size){
        self.size = size;
        return self;
    };
}

- (UIImageDraw *(^)(UIColor *))addColor
{
    return ^ (UIColor * color){
        if (color) {
           [self.colors addObject:color];
        }
        return self;
    };
}

- (UIImageDraw *(^)(CGFloat))setRadius
{
    return ^ (CGFloat radius){
        self.radius = radius;
        return self;
    };
}

- (UIImageDraw *(^)(CGPoint))setStartPoint
{
    return ^ (CGPoint st){
        self.startPoint = st;
        return self;
    };
}

- (UIImageDraw *(^)(CGPoint))setEndPoint
{
    return ^ (CGPoint et){
        self.endPoint = et;
        return self;
    };
}


- (UIImage *(^)(void))draw
{
    return ^{
        return [UIImage gradientWithDraw:self];
    };
}


@end

@implementation UIImage (cui)

+ (UIImageDraw *(^)(void))beginGradient
{
    return ^{
        return UIImageDraw.begin();
    };
}

- (UIImage *(^)(CGFloat, CGFloat))asBorder
{
    return ^ (CGFloat width, CGFloat r){
        return [self asBorder:width r:r];
    };
}

- (UIImage*)asBorder:(CGFloat)width r:(CGFloat)r
{
    CUIRect * rect = CUIRect.r(CGRectMake(0, 0, self.size.width, self.size.height));
    CGRect fr =
    rect.margin(UIEdgeInsetsMake(width, width, width, width))
    .rect;
    return [self imageWithRoundedBorder:r frame:fr];
}

+ (UIImage *)rect:(CGSize)size color:(UIColor *)color
{
    CGFloat scale = [UIScreen mainScreen].scale;
    //设置长宽
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size,NO,scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

+ (UIImage *)gradient:(CGSize)size
{
    return [self gradient:size colors:@[UIColor.k(@"g1"),UIColor.k(@"g2")] startPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 1)];
}

+ (UIImage*)gradient:(CGSize)size colors:(NSArray*)colors startPoint:(CGPoint)st endPoint:(CGPoint)et radius:(CGFloat)radius
{
    if (colors.count == 0) {
        colors = @[[UIColor blackColor],[UIColor whiteColor]];
    }
    CGFloat scale = [UIScreen mainScreen].scale;
    //设置长宽
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size,NO,scale);
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIColor* c1 = [colors firstObject];
    UIColor* c2 = [colors lastObject];
    
    //// Gradient Declarations
    CGFloat gradientLocations[] = {0, 0.5, 1};
    CGGradientRef gradient = CGGradientCreateWithColors(NULL, (__bridge CFArrayRef)@[(id)c1.CGColor, (id)[c1 blendedColorWithFraction: 0.5 ofColor: c2].CGColor, (id)c2.CGColor], gradientLocations);
    
    //// Rectangle Drawing
    CGRect rectangleRect = CGRectMake(0, 0, size.width, size.height);
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect:rectangleRect cornerRadius:radius];
    CGContextSaveGState(context);
    [rectanglePath addClip];
    CGContextDrawLinearGradient(context, gradient,
                                CGPointMake(CGRectGetMaxX(rectangleRect)*st.x, CGRectGetMaxY(rectangleRect)*st.y),
                                CGPointMake(CGRectGetMaxX(rectangleRect)*et.x, CGRectGetMaxY(rectangleRect)*et.y),
                                kNilOptions);
    CGContextRestoreGState(context);
    //// Cleanup
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    UIGraphicsEndImageContext();
    return resultImage;
}

+ (UIImage*)gradient:(CGSize)size colors:(NSArray*)colors startPoint:(CGPoint)st endPoint:(CGPoint)et
{
    return [self gradient:size colors:colors startPoint:st endPoint:et radius:0];
}

+ (UIImage *)gradientWithDraw:(UIImageDraw *)draw
{
    return [self gradient:draw.size colors:draw.colors startPoint:draw.startPoint endPoint:draw.endPoint radius:draw.radius];
}

+ (UIImage *(^)(CGSize, NSArray *, CGPoint, CGPoint))gradientImage
{
    return ^ (CGSize size, NSArray *colors, CGPoint st, CGPoint et){
        return [[self class] gradient:size colors:colors startPoint:st endPoint:et];
    };
}


+ (UIImage *(^)(CGSize, UIColor *))colorRect
{
    return ^(CGSize size, UIColor * color) {
        return [UIImage rect:size color:color];
    };
}

- (UIImage *(^)(UIImage *))asIcon
{
    return ^(UIImage * oi){
        return [self imageWithMaskImage:oi];
    };
}

- (UIImage*)imageWithMaskImage:(UIImage*)maskImage
{
    CGImageRef maskRef = maskImage.CGImage;
//    CGImageAlphaInfo info = CGImageGetAlphaInfo(maskRef);
    
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                    CGImageGetHeight(maskRef),
                                    CGImageGetBitsPerComponent(maskRef),
                                    CGImageGetBitsPerPixel(maskRef),
                                    CGImageGetBytesPerRow(maskRef),
                                    CGImageGetDataProvider(maskRef), NULL, false);
//    CGImageRef mask = CGImageCreateWithImageInRect(maskRef, CGRectMake(0, 0, maskImage.size.width, maskImage.size.height));
    /*
    CGImageRef mask = CGImageCreate(CGImageGetWidth(maskRef),
                                    CGImageGetHeight(maskRef),
                                    CGImageGetBitsPerComponent(maskRef),
                                    CGImageGetBitsPerPixel(maskRef),
                                    CGImageGetBytesPerRow(maskRef),
                                    CGImageGetColorSpace(maskRef),
                                    CGImageGetBitmapInfo(maskRef),
                                    CGImageGetDataProvider(maskRef),
                                    NULL,
                                    false,
                                    CGImageGetRenderingIntent(maskRef));
    */
//    CGImageAlphaInfo info1 = CGImageGetAlphaInfo([self CGImage]);
    
    CGImageRef masked = CGImageCreateWithMask([self CGImage],mask);
    CGImageRelease(mask);
//    UIImage *maskedImage = [UIImage imageWithCGImage:masked ];
    UIImage * maskedImage = [UIImage imageWithCGImage:masked 
                                                scale:self.scale                                          orientation:UIImageOrientationUp];
 

    CGImageRelease(masked);
    return maskedImage;
}

//切圆边
- (UIImage *)imageWithRoundedBorder:(float)cornerRadius frame:(CGRect)frame;{
    UIImage *original = self;
    // 开始一个Image的上下文
    UIGraphicsBeginImageContextWithOptions(original.size, NO, self.scale);
    // 绘制图片
    CGRect or = CGRectMake(0, 0, self.size.width, self.size.height);
    [[UIBezierPath bezierPathWithRoundedRect:or
                                cornerRadius:cornerRadius] addClip];
    [original drawInRect:or];

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetBlendMode(context, kCGBlendModeDestinationOut);
    
    CGFloat dr = (self.size.width - frame.size.width)/2;
    UIBezierPath* p1 = [UIBezierPath bezierPathWithRoundedRect:frame
                                              cornerRadius:cornerRadius-dr];
    [p1 fill];
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    // 接受绘制成功的图片
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//切圆角
- (UIImage *)imageWithRoundedCornersSize:(float)cornerRadius frame:(CGRect)frame;{
    UIImage *original = self;
    // 开始一个Image的上下文
    UIGraphicsBeginImageContextWithOptions(original.size, NO, self.scale);
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

//生成圆角UIIamge 的方法
- (UIImage *)imageWithRoundedCornersSize:(float)cornerRadius
{
    UIImage *original = self;
    CGRect frame = CGRectMake(0, 0, original.size.width, original.size.height);
    return [self imageWithRoundedCornersSize:cornerRadius frame:frame];
}

- (UIImage *(^)(CGFloat))cornerRadius
{
    return ^ (CGFloat r){
        return [self imageWithRoundedCornersSize:r];
    };
}

- (UIImage *(^)(UIEdgeInsets))resize
{
    return ^ (UIEdgeInsets i){
        return [self resizableImageWithCapInsets:i resizingMode:UIImageResizingModeStretch];
    };
}

- (UIImage *(^)(UIEdgeInsets, UIImageResizingMode))resizeWithMode
{
    return ^ (UIEdgeInsets i, UIImageResizingMode m){
        return [self resizableImageWithCapInsets:i resizingMode:m];
    };
}
@end
