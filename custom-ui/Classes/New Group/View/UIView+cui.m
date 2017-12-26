//
//  UIView+cui.m
//  custom-ui
//
//  Created by 张超 on 2017/11/30.
//  Copyright © 2017年 orzer. All rights reserved.
//

#import "UIView+cui.h"
#import "NSArray+Functional.h"
#import <objc/runtime.h>

@interface CUIGradientLayer: CAGradientLayer

@end

@implementation CUIGradientLayer

@end

@interface CUIImageLayer: CALayer

@end

@implementation CUIImageLayer

@end

@implementation UIView (cui)

- (__kindof UIView *(^)(UIColor *, CGSize, CGFloat))cui_shadow
{
    return ^(UIColor * color, CGSize offset, CGFloat blur){
        self.layer.shadowColor = color.CGColor;
        self.layer.shadowOffset = offset;
        self.layer.shadowRadius = blur;
        self.layer.shadowOpacity = 1.0;
        return self;
    };
}

- (__kindof UIView *(^)(CGFloat))cui_shadow_alpha
{
    return ^(CGFloat alpha) {
        if (self.layer.shadowOpacity != alpha) {
            self.layer.shadowOpacity = alpha;
        }
        return self;
    };
}


- (__kindof UIView *(^)(CGPathRef))cui_shadow_path
{
    return ^ (CGPathRef r){
        [self setShadowPath:r];
        return self;
    };
}

- (__kindof UIView *(^)(void (^)(CGMutablePathRef)))cui_shadow_shape
{
    return ^ (void (^b)(CGMutablePathRef)) {
        CGMutablePathRef r = CGPathCreateMutable();
        if (b) {
            b(r);
        }
        [self setShadowPath:r];
        CGPathRelease(r);
        return self;
    };
}

- (void)setShadowPath:(CGPathRef)path
{
    self.layer.shadowPath = path;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (__kindof UIView *(^)(CGPoint))cui_center
{
    return ^(CGPoint p){
        self.center = p;
        return self;
    };
}

- (__kindof UIView *(^)(CGRect))cui_framed
{
    return ^(CGRect p){
        self.frame = p;
        return self;
    };
}

- (__kindof UIView *(^)(void))cui_sizeToFit
{
    return ^{
        [self sizeToFit];
        return self;
    };
}

- (BOOL)cui_hasGradientLayer
{
    __block BOOL has = NO;
    [self.layer.sublayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[CUIGradientLayer class]]) {
            has = YES;
            *stop = YES;
        }
    }];
    return has;
}


- (BOOL)cui_addGradientLayer
{
    if ([self cui_hasGradientLayer]) {
        return NO;
    }
    CUIGradientLayer* layer = [[CUIGradientLayer alloc] init];
    layer.frame = CGRectMake(0, 0, self.layer.bounds.size.width, self.layer.bounds.size.height);
    //    layer.frame = self.frame;
    //    layer.position = self.center;
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(1, 1);
    [self.layer insertSublayer:layer atIndex:0];
    return YES;
}

- (CUIGradientLayer*)_gradientLayer
{
    return [[[self.layer sublayers] filter:^BOOL(id x) {
        return [x isKindOfClass:[CUIGradientLayer class]];
    }] firstObject];
}

- (void)cui_setGradientColors:(NSArray<UIColor *> *)colors
{
    NSAssert([[colors filter:^BOOL(id x) {
        return [x isKindOfClass:[UIColor class]];
    }] count] == colors.count, @"cui_setGradientColors 只能接收UIColor对象");
    CAGradientLayer* l = [self _gradientLayer];
    [l setColors:[colors map:^id(id x) {
        return (id)[x CGColor];
    }]];
}

- (void)cui_setGradientLocations:(NSArray<NSNumber *> *)locations
{
    NSAssert([[locations filter:^BOOL(id x) {
        return [x isKindOfClass:[NSNumber class]];
    }] count] == locations.count, @"cui_setGradientLocations 只能接收UINumber对象");
    CAGradientLayer* l = [self _gradientLayer];
    if (!l) {
        return;
    }
    [l setLocations:locations];
}

- (void)cui_setGradientStartPoint:(CGPoint)sp endPoint:(CGPoint)ep
{
    CAGradientLayer* l = [self _gradientLayer];
    if (!l) {
        return;
    }
    [l setStartPoint:sp];
    [l setEndPoint:ep];
}

- (BOOL)cui_hasImageBackgroundLayer
{
    __block BOOL has = NO;
    [self.layer.sublayers enumerateObjectsUsingBlock:^(CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[CUIImageLayer class]]) {
            has = YES;
            *stop = YES;
        }
    }];
    return has;
}

- (BOOL)cui_addImageBackground:(UIImage *)image
{
    if ([self cui_hasGradientLayer]) {
        return NO;
    }
    CUIImageLayer* layer = [[CUIImageLayer alloc] init];
    layer.frame = CGRectMake(0, 0, self.layer.bounds.size.width, self.layer.bounds.size.height);
    layer.contents = (id)image.CGImage;
    layer.contentsGravity = @"resizeAspectFill";
    [self.layer insertSublayer:layer atIndex:0];
    return YES;
}

- (CUIImageLayer*)_bgLayer
{
    return [[[self.layer sublayers] filter:^BOOL(id x) {
        return [x isKindOfClass:[CUIImageLayer class]];
    }] firstObject];
}

- (void)cui_setImageBackgroundOpcity:(CGFloat)opcity
{
    CUIImageLayer * layer = [self _bgLayer];
    if (!layer) {
        return;
    }
    layer.opacity = opcity;
}

- (void)cui_addBlurEffectView:(UIBlurEffectStyle)style
{
    __block BOOL has = NO;
    __block UIView* old = nil;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIVisualEffectView class]]) {
            has = YES;
            old = obj;
            * stop = YES;
        }
    }];
    if (has && old) {
        [old removeFromSuperview];
    }
    
    UIBlurEffect* e = [UIBlurEffect effectWithStyle:style];
    UIVisualEffectView* view = [[UIVisualEffectView alloc] initWithEffect:e];
    view.frame = self.bounds;
    view.autoresizingMask = 0xff;
    
    if ([self _bgLayer]) {
        [self insertSubview:view atIndex:1];
    }
    else {
        [self insertSubview:view atIndex:0];
    }
//    [self ];
}

@end

void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector)
{
    // the method might not exist in the class, but in its superclass
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    // class_addMethod will fail if original method already exists
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    // the method doesn’t exist and we just added one
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@implementation UIControl (cui)

+ (void)load
{
    swizzleMethod([UIControl class],@selector(swiz_setHighlighted:),@selector(setHighlighted:));
}

- (void)swiz_setHighlighted:(BOOL)highlighted
{
//    NSLog(@"%s",__func__);
    if ([self cui_hasGradientLayer]) {
        [[self _gradientLayer] setOpacity:highlighted?0.5:1];
    }
    [self swiz_setHighlighted:highlighted];
}

@end

