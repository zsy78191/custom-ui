//
//  NSString+Functional.m
//  NewFrame
//
//  Created by 张超 on 2017/6/21.
//  Copyright © 2017年 orzer. All rights reserved.
//

#import "NSString+Functional.h"

@implementation NSString (Functional)

@dynamic to_float,to_int,split;

- (NSInteger (^)(void))to_int
{
    return ^ {
        return [self integerValue];
    };
}

- (float (^)(void))to_float
{
    return ^ {
        return [self floatValue];
    };
}

-(NSArray* (^)(NSString *))split
{
    return ^ (NSString* s) {
        return [self componentsSeparatedByString:s];
    };
}


+ (NSString *(^)(CGPoint))p
{
    return ^(CGPoint p){
        return NSStringFromCGPoint(p);
    };
}

+ (NSString *(^)(CGSize))s
{
    return ^(CGSize p){
        return NSStringFromCGSize(p);
    };
}

+ (NSString *(^)(CGRect))r
{
    return ^(CGRect p){
        return NSStringFromCGRect(p);
    };
}

- (NSString *(^)(void))l
{
    return [self localizedString];
}

- (NSString *(^)(void))localizedString
{
    return ^ {
        return NSLocalizedString(self, nil);
    };
}

- (NSString *(^)(NSString *))localizedStringFromTable
{
    return ^ (NSString* table){
        return NSLocalizedStringFromTable(self, table, nil);
    };
}


@end
