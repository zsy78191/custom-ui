//
//  UIView+POP.m
//  customui-dev
//
//  Created by 张超 on 2017/12/4.
//  Copyright © 2017年 orzer. All rights reserved.
//

#import "UIView+POP.h"

@implementation UIView (POP)

- (POPSpringAnimation *(^)(NSString *))cui_spring
{
    return ^(NSString* keyPath){
        POPSpringAnimation* p = [POPSpringAnimation animationWithPropertyNamed:keyPath];
        return p;
    };
}

- (POPBasicAnimation *(^)(NSString *))cui_base
{
    return ^(NSString* keyPath){
        POPBasicAnimation* p = [POPBasicAnimation animationWithPropertyNamed:keyPath];
        return p;
    };
}

@end

@implementation POPPropertyAnimation (cui_add)

- (__kindof POPPropertyAnimation *(^)(id))cui_to
{
    return ^ (id tV) {
        self.toValue = tV;
        return self;
    };
}

- (__kindof POPPropertyAnimation *(^)(id))cui_from
{
    return ^ (id fV) {
        self.fromValue = fV;
        return self;
    };
}

- (void (^)(id, NSString *))cui_show
{
    return ^(id x,NSString* key){
        if ([x isKindOfClass:[UIView class]] || [x isKindOfClass:[CALayer class]]) {
            [x pop_addAnimation:self forKey:key];
        }
    };
}

@end

@implementation POPSpringAnimation (cui_add)

- (POPSpringAnimation *(^)(CGFloat, CGFloat, CGFloat))cui_set
{
    return ^ (CGFloat x, CGFloat y, CGFloat z){
        self.springBounciness = x;
        self.springSpeed = y;
        self.dynamicsTension = z;
        return self;
    };
}

- (POPSpringAnimation *(^)(id))cui_velocity
{
    return ^ (id x){
        self.velocity = x;
        return self;
    };
}

-(POPSpringAnimation *(^)(CGFloat))cui_springBounciness
{
    return ^ (CGFloat x){
        self.springBounciness = x;
        return self;
    };
}

- (POPSpringAnimation *(^)(CGFloat))cui_springSpeed
{
    return ^ (CGFloat x){
        self.springSpeed = x;
        return self;
    };
}

- (POPSpringAnimation *(^)(CGFloat))cui_dynamicsTension
{
    return ^ (CGFloat x){
        self.dynamicsTension = x;
        return self;
    };
}


@end


@implementation POPBasicAnimation (cui_add)

- (POPBasicAnimation *(^)(CGFloat))cui_duration
{
    return ^ (CGFloat x){
        self.duration = x;
        return self;
    };
}

- (POPBasicAnimation *(^)(CAMediaTimingFunction *))cui_timing
{
    return ^ (CAMediaTimingFunction* x){
        self.timingFunction = x;
        return self;
    };
}

- (POPBasicAnimation *(^)(CGFloat, CGFloat, CGFloat, CGFloat))cui_ease_custom
{
    return ^ (CGFloat p1, CGFloat p2, CGFloat p3, CGFloat p4){
        self.timingFunction = [CAMediaTimingFunction functionWithControlPoints:p1 :p2 :p3 :p4];
        return self;
    };
}

- (POPBasicAnimation *(^)(NSString *))cui_ease
{
    return ^ (NSString* ease){
        self.timingFunction = [CAMediaTimingFunction functionWithName:ease];
        return self;
    };
}

@end
