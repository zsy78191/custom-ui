//
//  UIColor+cui_theme.m
//  customui-dev
//
//  Created by 张超 on 2017/12/4.
//  Copyright © 2017年 orzer. All rights reserved.
//

#import "UIColor+cui_theme.h"
#import <objc/runtime.h>
@implementation UIColor (cui_theme)

- (UIColor *(^)(CGFloat))a
{
    return ^ (CGFloat alpha){
        return [self colorWithAlphaComponent:alpha];
    };
}

+ (void (^)(NSString *, UIColor *))keyed
{
    return ^ (NSString* k, UIColor * color) {
        [UIColor setColor:color forKey:k];
    };
}

+ (UIColor *(^)(NSString *))k
{
    return ^ (NSString* k) {
        return [UIColor colorForKey:k];
    };
}

+ (UIColor *)cui_rgb:(uint32_t)rgbValue {
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16) / 255.0f
                           green:((rgbValue & 0xFF00) >> 8) / 255.0f
                            blue:(rgbValue & 0xFF) / 255.0f
                           alpha:1];
}

+ (UIColor *)cui_rgbHex:(NSString *)rgbHex
{
    return [UIColor colorWithHexString:rgbHex];
}

+ (UIColor *(^)(NSString *))hex
{
    return ^ (NSString* hexStr) {
        return [UIColor colorWithHexString:hexStr];
    };
}

+ (UIColor *(^)(uint32_t))rgb
{
    return ^ (uint32_t n) {
        return [UIColor cui_rgb:n];
    };
}

+ (void)setColor:(UIColor *)color forKey:(NSString *)key
{
    key = [NSString stringWithFormat:@"color_key_%@",key];
    [[NSUserDefaults standardUserDefaults] setObject:[color hexString] forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (UIColor *)colorForKey:(NSString *)key
{
    key = [NSString stringWithFormat:@"color_key_%@",key];
    if([[NSUserDefaults standardUserDefaults] objectForKey:key])
    {
        return [UIColor colorWithHexString:[[NSUserDefaults standardUserDefaults] objectForKey:key]];
    }
    return [UIColor blackColor];
}

static BOOL hexStrToRGBA(NSString *str,
                         CGFloat *r, CGFloat *g, CGFloat *b, CGFloat *a) {
    str = [str uppercaseString];
    if ([str hasPrefix:@"#"]) {
        str = [str substringFromIndex:1];
    } else if ([str hasPrefix:@"0X"]) {
        str = [str substringFromIndex:2];
    }
    
    NSUInteger length = [str length];
    //         RGB            RGBA          RRGGBB        RRGGBBAA
    if (length != 3 && length != 4 && length != 6 && length != 8) {
        return NO;
    }
    
    //RGB,RGBA,RRGGBB,RRGGBBAA
    if (length < 5) {
        *r = hexStrToInt([str substringWithRange:NSMakeRange(0, 1)]) / 255.0f;
        *g = hexStrToInt([str substringWithRange:NSMakeRange(1, 1)]) / 255.0f;
        *b = hexStrToInt([str substringWithRange:NSMakeRange(2, 1)]) / 255.0f;
        if (length == 4)  *a = hexStrToInt([str substringWithRange:NSMakeRange(3, 1)]) / 255.0f;
        else *a = 1;
    } else {
        *r = hexStrToInt([str substringWithRange:NSMakeRange(0, 2)]) / 255.0f;
        *g = hexStrToInt([str substringWithRange:NSMakeRange(2, 2)]) / 255.0f;
        *b = hexStrToInt([str substringWithRange:NSMakeRange(4, 2)]) / 255.0f;
        if (length == 8) *a = hexStrToInt([str substringWithRange:NSMakeRange(6, 2)]) / 255.0f;
        else *a = 1;
    }
    return YES;
}


+ (instancetype)colorWithHexString:(NSString *)hexStr {
    CGFloat r, g, b, a;
    if (hexStrToRGBA(hexStr, &r, &g, &b, &a)) {
        return [UIColor colorWithRed:r green:g blue:b alpha:a];
    }
    return nil;
}

- (NSString *)hexString {
    return [self hexStringWithAlpha:NO];
}

- (NSString *)hexStringWithAlpha {
    return [self hexStringWithAlpha:YES];
}

- (NSString *)hexStringWithAlpha:(BOOL)withAlpha {
    CGColorRef color = self.CGColor;
    size_t count = CGColorGetNumberOfComponents(color);
    const CGFloat *components = CGColorGetComponents(color);
    static NSString *stringFormat = @"%02x%02x%02x";
    NSString *hex = nil;
    if (count == 2) {
        NSUInteger white = (NSUInteger)(components[0] * 255.0f);
        hex = [NSString stringWithFormat:stringFormat, white, white, white];
    } else if (count == 4) {
        hex = [NSString stringWithFormat:stringFormat,
               (NSUInteger)(components[0] * 255.0f),
               (NSUInteger)(components[1] * 255.0f),
               (NSUInteger)(components[2] * 255.0f)];
    }
    
    if (hex && withAlpha) {
        hex = [hex stringByAppendingFormat:@"%02lx",
               (unsigned long)(self.alpha * 255.0 + 0.5)];
    }
    return hex;
}

- (CGFloat)alpha {
    return CGColorGetAlpha(self.CGColor);
}

static inline NSUInteger hexStrToInt(NSString *str) {
    uint32_t result = 0;
    sscanf([str UTF8String], "%X", &result);
    return result;
}
@end



@implementation CUITheme

+ (void)load
{
    NSDictionary* defalutKeyAndValue =
    @{
      @"g1":@"DEFFC9",
      @"g2":@"A3F8FF"
      };
    NSLog(@"%@",defalutKeyAndValue);
    [[NSUserDefaults standardUserDefaults] registerDefaults:defalutKeyAndValue];
    
    NSDictionary* d = [CUITheme setupCustomTheme];
    NSMutableDictionary* temp = [NSMutableDictionary dictionaryWithCapacity:10];
    [d enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString* key1 = [NSString stringWithFormat:@"color_key_%@",key];
        [temp setValue:obj forKey:key1];
    }];
    if (d) {
        NSLog(@"User Defalut");
        NSLog(@"%@",d);
        [[NSUserDefaults standardUserDefaults] setValuesForKeysWithDictionary:temp];
    }
    else{
        NSLog(@"User Defalut Not Found");
    }
}

+ (NSDictionary*)setupCustomTheme
{
    NSURL* url = [[NSBundle mainBundle] URLForResource:@"custom-ui" withExtension:@"plist"];
//    NSLog(@"%@",url);
    return [NSDictionary dictionaryWithContentsOfFile:url.path];
}

@end
