//
//  DDAlertViewController.h
//  Follow-Up
//
//  Created by 张超 on 2017/11/9.
//  Copyright © 2017年 orzer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIAlertController (Functional)
{
    
}

UIAlertController* UI_Alert(void);
UIAlertController* UI_ActionSheet(void);

@property (nonatomic, strong, readonly, class)  UIAlertController* (^actionSheet)(void);
@property (nonatomic, strong, readonly, class)  UIAlertController* (^alert)(void);

@property (nonatomic, strong, readonly)  UIAlertController* (^titled)(NSString* title);
@property (nonatomic, strong, readonly)  UIAlertController* (^descripted)(NSString* description);
@property (nonatomic, strong, readonly)  UIAlertController* (^action)(NSString* title,void (^ __nullable)(UIAlertAction *action,UIAlertController* alert));
@property (nonatomic, strong, readonly)  UIAlertController* (^recommend)(NSString* title,void (^ __nullable)(UIAlertAction *action,UIAlertController* alert));
@property (nonatomic, strong, readonly)  UIAlertController* (^cancell)(NSString* title,void (^ __nullable)(UIAlertAction *action));
@property (nonatomic, strong, readonly)  UIAlertController* (^input)(NSString* title,void (^ __nullable)(UITextField *field));
@property (nonatomic, strong, readonly)  void (^show)(__kindof UIViewController* vc);

@end

NS_ASSUME_NONNULL_END
