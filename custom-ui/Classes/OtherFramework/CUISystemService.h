//
//  AppleReviewHelper.h
//  mframe
//
//  Created by 张超 on 2017/4/13.
//  Copyright © 2017年 orzer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@class EKEventStore;
@import StoreKit;
NS_ASSUME_NONNULL_BEGIN

@protocol SKStoreProductViewControllerDelegate;

@interface CUISystemService : NSObject


/**
 调用系统评分，iOS 10开始支持
 
 @return 系统是否支持
 */
+ (BOOL)cui_requestAppleReview;


/**
 调用系统振动反馈，iOS 10开始支持
 
 @param style 反馈强度
 */
+ (void)cui_hapticFeedback:(UIImpactFeedbackStyle)style;



/**
 软件内打开商店页面

 @param appId 应用的AppID
 @param vc 当前的ViewController
 @param finish 结果block
 */
+ (void)cui_openAppStore:(NSString *)appId vc:(id<SKStoreProductViewControllerDelegate>)vc complate:(void (^)(BOOL))finish;


+ (void)startForStore:(id<SKPaymentTransactionObserver,SKProductsRequestDelegate>)delegate products:(NSSet*)products;
+ (void)endForStore:(id<SKPaymentTransactionObserver,SKProductsRequestDelegate>)delegate;
+ (void)purchaseProduct:(SKProduct*)product;
+ (void)restoreProduct;

/**
 操作系统日历的Store实例
 */
@property (nonatomic, strong) EKEventStore* cui_event_store;

@end


NS_ASSUME_NONNULL_END
