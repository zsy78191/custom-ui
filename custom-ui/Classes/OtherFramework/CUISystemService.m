//
//  AppleReviewHelper.m
//  mframe
//
//  Created by 张超 on 2017/4/13.
//  Copyright © 2017年 orzer. All rights reserved.
//

#import "CUISystemService.h"
#import <StoreKit/SKStoreReviewController.h>
#import <UserNotifications/UserNotifications.h>
#import "CUIAPIChecker.h"
@import EventKit;
@import StoreKit;


@implementation CUISystemService

+ (BOOL)cui_requestAppleReview
{
    if(![CACH checkClass:@"SKStoreReviewController" sel:@selector(requestReview)])
    {
        return NO;
    }
    if (@available(iOS 10.3, *)) {
        [SKStoreReviewController requestReview];
    } else {
        // Fallback on earlier versions
    }
    return YES;
}

+ (void)cui_hapticFeedback:(UIImpactFeedbackStyle)style
{
    if(![CACH checkClass:@"UIImpactFeedbackGenerator"])
    {
        NSLog(@"UIImpactFeedbackGenerator is not work for this version system");
        return;
    }
    if (@available(iOS 10.0, *)) {
        UIImpactFeedbackGenerator *generator = [[UIImpactFeedbackGenerator alloc] initWithStyle: style];
        [generator prepare];
        [generator impactOccurred];
    } else {
        // Fallback on earlier versions
    }
}


+ (void)cui_openAppStore:(NSString *)appId vc:(id<SKStoreProductViewControllerDelegate>)vc complate:(void (^)(BOOL))finish
{
    if(![CACH checkClass:@"SKStoreProductViewController"])
    {
        NSLog(@"SKStoreProductViewController is not work for this version system");
        if (finish) {
            finish(NO);
        }
        return;
    }
    SKStoreProductViewController *storeProductVC = [[SKStoreProductViewController alloc] init];
    storeProductVC.delegate = vc;
    
    NSDictionary *dict = [NSDictionary dictionaryWithObject:appId forKey:SKStoreProductParameterITunesItemIdentifier];
    [storeProductVC loadProductWithParameters:dict completionBlock:^(BOOL result, NSError *error)
     {
         if (result)
         {
             [(UIViewController*)vc presentViewController:storeProductVC animated:YES completion:nil];
             if(finish)
             {
                 finish(YES);
             }
         }
         else {
             if(finish)
             {
                 finish(NO);
             }
         }
     }];
}

- (EKEventStore *)cui_event_store
{
    if (!_cui_event_store) {
        _cui_event_store = [[EKEventStore alloc] init];
    }
    return _cui_event_store;
}
 

+ (void)startForStore:(id<SKPaymentTransactionObserver,SKProductsRequestDelegate>)delegate products:(NSSet*)products
{
    [[SKPaymentQueue defaultQueue] addTransactionObserver:delegate];
    SKProductsRequest* r = [[SKProductsRequest alloc] initWithProductIdentifiers:products];
    r.delegate = delegate;
    [r start];
}

+ (void)endForStore:(id<SKPaymentTransactionObserver,SKProductsRequestDelegate>)delegate
{
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:delegate];
}

+ (void)purchaseProduct:(SKProduct *)product
{
    SKPayment* p = [SKPayment paymentWithProduct:product];
    [[SKPaymentQueue defaultQueue] addPayment:p];
}

+ (void)restoreProduct;
{
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}


@end
