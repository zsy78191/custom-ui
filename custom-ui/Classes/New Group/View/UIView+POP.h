//
//  UIView+POP.h
//  customui-dev
//
//  Created by 张超 on 2017/12/4.
//  Copyright © 2017年 orzer. All rights reserved.
//

#import <UIKit/UIKit.h>
@import pop;
@interface UIView (POP)
@property (nonatomic, readonly) POPSpringAnimation* (^cui_spring)(NSString* keyPath);
@property (nonatomic, readonly) POPBasicAnimation* (^cui_base)(NSString* keyPath);
@end


@interface POPPropertyAnimation(cui_add)
@property (nonatomic, readonly) __kindof POPPropertyAnimation* (^cui_from)(id);
@property (nonatomic, readonly) __kindof POPPropertyAnimation* (^cui_to)(id);
@property (nonatomic, readonly) void (^cui_show)(id,NSString*);
@end

@interface POPSpringAnimation(cui_add)
@property (nonatomic, readonly) POPSpringAnimation* (^cui_set)(CGFloat springBounciness, CGFloat springSpeed, CGFloat dynamicsTension);
@property (nonatomic, readonly) POPSpringAnimation* (^cui_velocity)(id velocity);
@property (nonatomic, readonly) POPSpringAnimation* (^cui_springBounciness)(CGFloat springBounciness);
@property (nonatomic, readonly) POPSpringAnimation* (^cui_springSpeed)(CGFloat springSpeed);
@property (nonatomic, readonly) POPSpringAnimation* (^cui_dynamicsTension)(CGFloat dynamicsTension);
@end


@interface POPBasicAnimation(cui_add)
@property (nonatomic, readonly) POPBasicAnimation* (^cui_duration)(CGFloat duration);
@property (nonatomic, readonly) POPBasicAnimation* (^cui_timing)(CAMediaTimingFunction* timing);
@property (nonatomic, readonly) POPBasicAnimation* (^cui_ease_custom)(CGFloat p1x,CGFloat p1y,CGFloat p2x,CGFloat p2y);
@property (nonatomic, readonly) POPBasicAnimation* (^cui_ease)(NSString*);
@end
