//
//  NSString+Functional.h
//  NewFrame
//
//  Created by 张超 on 2017/6/21.
//  Copyright © 2017年 orzer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (Functional)

@property (nonatomic, strong, readonly) NSInteger (^to_int)(void);
@property (nonatomic, strong, readonly) float (^to_float)(void);
@property (nonatomic, strong, readonly) NSArray* (^split)(NSString* s);

@property (nonatomic,readonly) NSString* (^l)(void);
@property (nonatomic,readonly) NSString* (^localizedString)(void);
@property (nonatomic,readonly) NSString* (^localizedStringFromTable)(NSString* table);

@property (class,nonatomic,readonly) NSString* (^p)(CGPoint p);
@property (class,nonatomic,readonly) NSString* (^s)(CGSize s);
@property (class,nonatomic,readonly) NSString* (^r)(CGRect r);
@end
