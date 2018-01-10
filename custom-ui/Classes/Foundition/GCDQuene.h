//
//  GCDQuene.h
//  customui-dev
//
//  Created by 张超 on 2018/1/9.
//  Copyright © 2018年 orzer. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GCDSemaphore;
typedef void (^_dispatch_block_t_self)(GCDSemaphore* t);
@interface GCDQuene : NSObject


@property (nonatomic, strong, readonly) dispatch_queue_t quene_t;
@property (nonatomic, class,readonly) dispatch_queue_t (^globalQuene)(void);
@property (nonatomic, class,readonly) dispatch_queue_t (^globalQueneWithPriority)(int priority);
@property (nonatomic, class,readonly) dispatch_queue_t (^mainQuene)(void);
@property (nonatomic, class,readonly) dispatch_queue_t (^quene)(NSString* name);
@property (nonatomic, class,readonly) void (^main)(dispatch_block_t t);
@property (nonatomic, class,readonly) void (^global)(dispatch_block_t t);

+ (instancetype)queneWithName:(NSString*)name;
+ (instancetype)mainQueneInstance;

+ (BOOL)isMainThread;
+ (void)syncRunAtMainThread:(dispatch_block_t)block;
+ (void)asyncRunAtMainThread:(dispatch_block_t)block;
+ (void)syncRunAtOtherThread:(dispatch_queue_t)q block:(dispatch_block_t)block;
+ (void)asyncRunAtOtherThread:(dispatch_queue_t)q block:(dispatch_block_t)block;
+ (dispatch_queue_t)syncRunBlock:(dispatch_block_t)block;
+ (dispatch_queue_t)asyncRunBlock:(dispatch_block_t)block;

+ (void)asyncAtGlobalThread:(dispatch_block_t)block thanAtMainThread:(dispatch_block_t)mainBlock;

// instance method

- (void)_async:(dispatch_block_t)t;
- (void)_sync:(dispatch_block_t)t;
- (void)_barrier:(dispatch_block_t)t;

@property (nonatomic, readonly) GCDQuene* (^async)(dispatch_block_t t);
@property (nonatomic, readonly) GCDQuene* (^sync)(dispatch_block_t t);
@property (nonatomic, readonly) GCDQuene* (^barrier)(dispatch_block_t t);
@property (nonatomic, readonly) GCDQuene* (^after)(NSTimeInterval,dispatch_block_t t);

@property (nonatomic, readonly) GCDQuene* (^ semaphore)(_dispatch_block_t_self);

@end

@interface GCDGroup : NSObject
{
    
}
@property (nonatomic, strong, readonly) dispatch_group_t group_t;
@property (nonatomic, readonly) GCDGroup* (^ async)(dispatch_queue_t,dispatch_block_t);
@property (nonatomic, readonly) GCDGroup* (^ notify)(dispatch_queue_t,dispatch_block_t);

@end


@interface GCDSemaphore : NSObject
{
    
}

+(instancetype)semaphore:(int)value;

@property (nonatomic, strong, readonly) dispatch_semaphore_t semaphore_t;
@property (nonatomic, readonly) GCDSemaphore* (^ run)(_dispatch_block_t_self);
@property (nonatomic, readonly) GCDSemaphore* (^ wait)(dispatch_block_t t);
@property (nonatomic, readonly) void (^ signal)(void);
@end
