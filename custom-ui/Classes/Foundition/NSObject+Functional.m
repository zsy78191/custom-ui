//
//  NSObject+Functional.m
//  customui-dev
//
//  Created by 张超 on 2017/12/4.
//  Copyright © 2017年 orzer. All rights reserved.
//

#import "NSObject+Functional.h"

@implementation NSValue(functional)


+ (NSValue *(^)(CGPoint))p
{
    return ^ (CGPoint p) {
        return [NSValue valueWithCGPoint:p];
    };
}

+ (NSValue *(^)(CGSize))s
{
    return ^ (CGSize p) {
        return [NSValue valueWithCGSize:p];
    };
}

+ (NSValue *(^)(CGRect))r
{
    return ^ (CGRect p) {
        return [NSValue valueWithCGRect:p];
    };
}
@end
 

@implementation CUIGeometry

+ (CGPoint (^)(CGFloat, CGFloat))point
{
    return ^ (CGFloat x , CGFloat y){
        return CGPointMake(x, y);
    };
}

+ (CGSize (^)(CGFloat, CGFloat))size
{
    return ^ (CGFloat x , CGFloat y){
        return CGSizeMake(x, y);
    };
}

+ (CGRect (^)(CGFloat, CGFloat, CGFloat, CGFloat))rect
{
    return ^ (CGFloat x , CGFloat y, CGFloat w, CGFloat h){
        return CGRectMake(x, y, w, h);
    };
}

+ (UIEdgeInsets (^)(CGFloat, CGFloat, CGFloat, CGFloat))insets
{
    return ^ (CGFloat x , CGFloat y, CGFloat w, CGFloat h){
        return UIEdgeInsetsMake(x, y, w, h);
    };
}

@end

@implementation _CG

@end


@implementation CUIRect

+ (CUIRect *(^)(CGRect))r
{
    return ^ (CGRect r)
    {
        return [CUIRect instanceWithRect:r];
    };
}

- (instancetype)initWithRect:(CGRect)rect
{
    self = [super init];
    if (self) {
        self.rect = rect;
    }
    return self;
}

+ (instancetype)instanceWithRect:(CGRect)rect
{
    return [[CUIRect alloc] initWithRect:rect];
}

- (CGFloat)left {
    return self.rect.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.rect;
    frame.origin.x = x;
    self.rect = frame;
}

- (CGFloat)top {
    return self.rect.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.rect;
    frame.origin.y = y;
    self.rect = frame;
}

- (CGFloat)right {
    return self.origin.x + self.rect.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.rect;
    frame.origin.x = right - frame.size.width;
    self.rect = frame;
}

- (CGFloat)bottom {
    return self.rect.origin.y + self.rect.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.rect;
    frame.origin.y = bottom - frame.size.height;
    self.rect = frame;
}

- (CGFloat)width {
    return self.rect.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.rect;
    frame.size.width = width;
    self.rect = frame;
}

- (CGFloat)height {
    return self.rect.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.rect;
    frame.size.height = height;
    self.rect = frame;
}


- (CGPoint)origin {
    return self.rect.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.rect;
    frame.origin = origin;
    self.rect = frame;
}

- (CGSize)size {
    return self.rect.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.rect;
    frame.size = size;
    self.rect = frame;
}

- (CUIRect *(^)(CGFloat))block:(void (^)(CGFloat value))block
{
    return ^ (CGFloat x) {
        if (block) {
            block(x);
        }
        return self;
    };
}

- (CUIRect *(^)(CGFloat))t
{
    return [self block:^(CGFloat value) {
        self.top = value;
    }];
}

- (CUIRect *(^)(CGFloat))b
{
    return [self block:^(CGFloat value) {
        self.bottom = value;
    }];
}

- (CUIRect *(^)(CGFloat))l
{
    return [self block:^(CGFloat value) {
        self.left = value;
    }];
}

- (CUIRect *(^)(CGFloat))r
{
    return [self block:^(CGFloat value) {
        self.right = value;
    }];
}

- (CUIRect *(^)(CGFloat))w
{
    return [self block:^(CGFloat value) {
        self.width = value;
    }];
}

- (CUIRect *(^)(CGFloat))h
{
    return [self block:^(CGFloat value) {
        self.height = value;
    }];
}

- (CUIRect *(^)(CGPoint))o
{
    return ^(CGPoint p){
        self.origin = p;
        return self;
    };
}

- (CUIRect *(^)(CGSize))s
{
    return ^(CGSize p){
        self.size = p;
        return self;
    };
}

- (CUIRect *(^)(UIEdgeInsets))margin
{
    return ^ (UIEdgeInsets i) {
        return self.l(self.left + i.left).t(self.top + i.top).w(self.width - i.left - i.right).h(self.height - i.top - i.bottom);
    };
}

@end

