//
//  UIView+Maker.m
//  mframe
//
//  Created by 张超 on 2017/4/14.
//  Copyright © 2017年 orzer. All rights reserved.
//

#import "UIView+Clone.h"

@interface UIViewMakerCore : NSObject

+ (instancetype)core;
- (void)regist:(NSString*)key make:(id)make;
- (id)makeForKey:(NSString*)key;
@property (nonatomic, strong) NSMutableDictionary* hashD;

@end

@implementation UIViewMakerCore

+ (instancetype)core
{
    static UIViewMakerCore * __g_core_maker;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __g_core_maker = [[UIViewMakerCore alloc] init];
    });
    return __g_core_maker;
}

- (NSMutableDictionary *)hashD
{
    if (!_hashD) {
        _hashD = [[NSMutableDictionary alloc] init];
    }
    return _hashD;
}

- (void)regist:(NSString *)key make:(id)make
{
    [self.hashD setValue:make forKey:key];
}

- (__kindof UIView*)makeForKey:(NSString*)key;
{
    return [self.hashD valueForKey:key];
}

@end

@implementation UIView (Clone)

+ (void)cui_registStyle:(NSString *)key make:(nonnull void (^)(id _Nonnull))makeBlock
{
    id a = [[[self class] alloc] init];
    if (makeBlock) {
        makeBlock(a);
    }
    [[UIViewMakerCore core] regist:key make:a];
}

+ (__kindof UIView *)cui_cloneForKey:(NSString *)key
{
    return [[[UIViewMakerCore core] makeForKey:key] cui_clone];
}

+ (__kindof UIView*)duplicate:(__kindof UIView*)view
{
    NSData * tempArchive = [NSKeyedArchiver archivedDataWithRootObject:view];
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
}

- (void)cui_copyTimes:(NSUInteger)times make:(nonnull void (^)(id _Nonnull, NSUInteger))makeBlock
{
    for (int i = 0; i < times; ++i) {
        id a = [self cui_clone];
        if (makeBlock) {
            makeBlock(a,i);
        }
    }
}

- (UIView *)cui_clone
{
    return [[self class] duplicate:self];
}

- (void)cui_setAttr:(void (^)(id _Nonnull))makeBlock
{
    if (makeBlock) {
        makeBlock(self);
    }
}

@end
