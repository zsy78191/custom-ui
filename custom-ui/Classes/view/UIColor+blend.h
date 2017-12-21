//
//  UIColor+bind.h
//  OrzKit
//
//  Created by 张超 on 16/10/28.
//  Copyright © 2016年 orzer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (blend)

- (UIColor*)blendedColorWithFraction:(float)fraction ofColor:(UIColor*)color;

@end
