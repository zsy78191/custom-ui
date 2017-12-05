//
//  UIView+gradient.m
//  customui-dev
//
//  Created by 张超 on 2017/12/4.
//  Copyright © 2017年 orzer. All rights reserved.
//

#import "UIView+gradient.h"
#import "NSArray+Functional.h"

@interface CUIGradientLayer: CAGradientLayer

@end

@implementation CUIGradientLayer

@end

@implementation UIView (gradient)


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
    layer.frame = self.layer.frame;
    layer.position = self.center;
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(1, 1);
    [self.layer addSublayer:layer];
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


@end
