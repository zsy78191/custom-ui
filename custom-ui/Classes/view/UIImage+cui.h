//
//  UIImage+cui.h
//  customui-dev
//
//  Created by 张超 on 2017/12/14.
//  Copyright © 2017年 orzer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (cui)
{
    
}
@property (nonatomic, readonly, class) UIImage* (^colorRect)(CGSize size, UIColor* color);
@property (nonatomic, readonly) UIImage* (^cornerRadius)(CGFloat radius);

@end
