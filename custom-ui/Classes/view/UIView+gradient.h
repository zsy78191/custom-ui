//
//  UIView+gradient.h
//  customui-dev
//
//  Created by 张超 on 2017/12/4.
//  Copyright © 2017年 orzer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (gradient)

- (BOOL)cui_hasGradientLayer;
- (BOOL)cui_addGradientLayer;
- (void)cui_setGradientColors:(NSArray<UIColor*>*)colors;
- (void)cui_setGradientLocations:(NSArray<NSNumber *> *)locations;
- (void)cui_setGradientStartPoint:(CGPoint)sp endPoint:(CGPoint)ep;
@end
