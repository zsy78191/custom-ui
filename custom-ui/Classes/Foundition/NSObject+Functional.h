//
//  NSObject+Functional.h
//  customui-dev
//
//  Created by 张超 on 2017/12/4.
//  Copyright © 2017年 orzer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSValue (functional)
@property (class,nonatomic,readonly) NSValue* (^p)(CGPoint p);
@property (class,nonatomic,readonly) NSValue* (^s)(CGSize s);
@property (class,nonatomic,readonly) NSValue* (^r)(CGRect r);
@end

@interface CUIGeometry : NSObject
@property (class,nonatomic,readonly) CGPoint (^point)(CGFloat x, CGFloat y);
@property (class,nonatomic,readonly) CGSize (^size)(CGFloat w, CGFloat h);
@property (class,nonatomic,readonly) CGRect (^rect)(CGFloat x, CGFloat y, CGFloat w, CGFloat h);
@property (class,nonatomic,readonly) UIEdgeInsets (^insets)(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right);
@end

@interface _CG: CUIGeometry

@end


@interface CUIRect : NSObject

@property (class,nonatomic,readonly) CUIRect* (^r)(CGRect r);

- (instancetype)initWithRect:(CGRect)rect;
+ (instancetype)instanceWithRect:(CGRect)rect;

@property (nonatomic, assign) CGRect rect;

@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize  size;

@property (nonatomic,readonly) CUIRect* (^l)(CGFloat left);
@property (nonatomic,readonly) CUIRect* (^t)(CGFloat top);
@property (nonatomic,readonly) CUIRect* (^r)(CGFloat right);
@property (nonatomic,readonly) CUIRect* (^b)(CGFloat bottom);
@property (nonatomic,readonly) CUIRect* (^w)(CGFloat width);
@property (nonatomic,readonly) CUIRect* (^h)(CGFloat height);
@property (nonatomic,readonly) CUIRect* (^o)(CGPoint origin);
@property (nonatomic,readonly) CUIRect* (^s)(CGSize size);


@property (nonatomic,readonly) CUIRect* (^margin)(UIEdgeInsets inset);
@end
