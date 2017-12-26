//
//  UIViewController+cui.m
//  customui-dev
//
//  Created by 张超 on 2017/12/5.
//  Copyright © 2017年 orzer. All rights reserved.
//

#import "UIViewController+cui.h"
#import "UIView+cui.h"
#import "UIColor+cui_theme.h"
//#import "UIView+gradient.h"

@implementation UIViewController (cui)

- (void)showBottomButton:(SEL)selector
{
    
    UIButton * b = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 60)];
    if (@available(iOS 11.0, *)) {
        if (self.navigationController && ![self isKindOfClass:[UITableViewController class]] && ![self isKindOfClass:[UICollectionViewController class]]) {
            UILayoutGuide* guide = [self.navigationController.view layoutMarginsGuide];
            CGFloat detla = [UIScreen mainScreen].bounds.size.height - guide.layoutFrame.size.height - guide.layoutFrame.origin.y;
            b.height = b.height + detla;
            b.contentEdgeInsets = UIEdgeInsetsMake(0, 0, detla, 0);
        }
    } else {
        // Fallback on earlier versions
    }

    [b removeTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [b addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
    if ([self isKindOfClass:[UITableViewController class]]) {
        [[(UITableViewController*)self tableView] setTableFooterView:b];
    }
    else
    {
        [self.view addSubview:b];
    }
    
    b.bottom = self.view.height;
    
    NSDictionary * d = @{NSForegroundColorAttributeName:UIColor.blackColor,NSFontAttributeName:[UIFont fontWithName:@"PingFangTC-Regular" size:10]};
    [b setAttributedTitle:[[NSAttributedString alloc] initWithString:@"NEXT" attributes:d] forState:UIControlStateNormal];
    [b setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    
    [b cui_addGradientLayer];
    [b cui_setGradientColors:@[UIColor.k(@"g1"),UIColor.k(@"g2")]];
    [b cui_setGradientStartPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
}


+ (UIViewController *)topedViewController {
    UIViewController *resultVC;
    resultVC = [[self class] _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [[self class] _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

+ (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [[self class] _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [[self class] _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}



@end

@implementation UINavigationController (cui)



@end
