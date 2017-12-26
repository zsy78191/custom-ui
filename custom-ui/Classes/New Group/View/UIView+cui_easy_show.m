//
//  UIView+cui_easy_show.m
//  customui-dev
//
//  Created by 张超 on 2017/12/4.
//  Copyright © 2017年 orzer. All rights reserved.
//

#import "UIView+cui_easy_show.h"

@implementation UIView (cui_easy_show)

- (__kindof UIView * _Nonnull (^)(CGFloat, CGFloat))t
{
    return ^ (CGFloat dx, CGFloat dy){
        self.transform = CGAffineTransformMakeTranslation(dx, dy);
        return self;
    };
}


+ (void (^)(NSTimeInterval, void (^ _Nonnull)(void)))a
{
    return ^ (NSTimeInterval t, void (^ _Nonnull b)(void)){
        [UIView animateWithDuration:t animations:^{
            if (b) {
                b();
            }
        }];
    };
}

@end
