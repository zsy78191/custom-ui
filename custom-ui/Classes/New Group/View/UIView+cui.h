//
//  UIView+cui.h
//  custom-ui
//
//  Created by 张超 on 2017/11/30.
//  Copyright © 2017年 orzer. All rights reserved.
//

@import UIKit;

@interface UIView (cui)

@property (nonatomic) CGFloat left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGFloat centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint origin;      ///< Shortcut for frame.origin.
@property (nonatomic) CGSize  size;        ///< Shortcut for frame.size.

@property (nonatomic, readonly)  __kindof UIView* (^cui_shadow)(UIColor* shadowColor,CGSize offset,CGFloat blur);
@property (nonatomic, readonly)  __kindof UIView* (^cui_shadow_alpha)(CGFloat alpha);
@property (nonatomic, readonly)  __kindof UIView* (^cui_shadow_path)(CGPathRef r);
@property (nonatomic, readonly)  __kindof UIView* (^cui_shadow_shape)(void (^)(CGMutablePathRef r));

@property (nonatomic, readonly)  __kindof UIView* (^cui_center)(CGPoint center);
@property (nonatomic, readonly)  __kindof UIView* (^cui_framed)(CGRect frame);
@property (nonatomic, readonly)  __kindof UIView* (^cui_sizeToFit)(void);

- (BOOL)cui_hasGradientLayer;
- (BOOL)cui_addGradientLayer;
- (void)cui_setGradientColors:(NSArray<UIColor*>*)colors;
- (void)cui_setGradientLocations:(NSArray<NSNumber *> *)locations;
- (void)cui_setGradientStartPoint:(CGPoint)sp endPoint:(CGPoint)ep;

- (BOOL)cui_hasImageBackgroundLayer;
- (BOOL)cui_addImageBackground:(UIImage*)image;
- (void)cui_setImageBackgroundOpcity:(CGFloat)opcity;

- (__kindof CALayer*)_gradientLayer;

- (void)cui_addBlurEffectView:(UIBlurEffectStyle)style;

@end


@interface UIControl (cui)

@end
