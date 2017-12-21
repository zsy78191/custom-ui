//
//  UIColor+bind.m
//  OrzKit
//
//  Created by 张超 on 16/10/28.
//  Copyright © 2016年 orzer. All rights reserved.
//

#import "UIColor+blend.h"

@implementation UIColor (blend)

/*
 extension UIColor {
 func blendedColorWithFraction(fraction: CGFloat, ofColor color: UIColor) -> UIColor {
 var r1: CGFloat = 1.0, g1: CGFloat = 1.0, b1: CGFloat = 1.0, a1: CGFloat = 1.0
 var r2: CGFloat = 1.0, g2: CGFloat = 1.0, b2: CGFloat = 1.0, a2: CGFloat = 1.0
 
 self.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
 color.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)
 
 return UIColor(red: r1 * (1 - fraction) + r2 * fraction,
 green: g1 * (1 - fraction) + g2 * fraction,
 blue: b1 * (1 - fraction) + b2 * fraction,
 alpha: a1 * (1 - fraction) + a2 * fraction);
 }
 }
 */

- (UIColor *)blendedColorWithFraction:(float)fraction ofColor:(UIColor *)color
{
    CGFloat r1,g1,b1,a1,r2,g2,b2,a2;
    [self getRed:&r1 green:&g1 blue:&b1 alpha:&a1];
    [color getRed:&r2 green:&g2 blue:&b2 alpha:&a2];
    
    
    return [UIColor colorWithRed:r1 *  (1 - fraction) + r2 * fraction
                           green:g1 *  (1 - fraction) + g2 * fraction
                            blue:b1 *  (1 - fraction) + b2 * fraction
                           alpha:a1 *  (1 - fraction) + a2 * fraction];
}

@end
