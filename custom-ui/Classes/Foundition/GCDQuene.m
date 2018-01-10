//
//  GCDQuene.m
//  customui-dev
//
//  Created by 张超 on 2018/1/9.
//  Copyright © 2018年 orzer. All rights reserved.
//

#import "GCDQuene.h"

@interface GCDQuene ()
@property (nonatomic, strong, readwrite) dispatch_queue_t quene_t;
@end

@implementation GCDQuene


+ (instancetype)mainQueneInstance
{
    GCDQuene* q = [[GCDQuene alloc] init];
    q.quene_t = GCDQuene.mainQuene();
    return q;
}

+ (void (^)(dispatch_block_t))main
{
    return ^ (dispatch_block_t t){
        dispatch_async(GCDQuene.mainQuene(), t);
    };
}

+ (void (^)(dispatch_block_t))global
{
    return ^ (dispatch_block_t t){
        dispatch_async(GCDQuene.globalQuene(), t);
    };
}

+ (dispatch_queue_t (^)(void))mainQuene
{
    return ^ {
        return dispatch_get_main_queue();
    };
}

+ (dispatch_queue_t (^)(void))globalQuene
{
    return ^ {
        return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    };
}

+ (dispatch_queue_t (^)(int))globalQueneWithPriority
{
    return ^(int p) {
        return dispatch_get_global_queue(p, 0);
    };
}

+ (dispatch_queue_t (^)(NSString *))quene
{
    return ^(NSString* p) {
        return [self queneWithName:p];
    };
}

+ (BOOL)isMainThread
{
    return [NSThread isMainThread];
}

+ (void)syncRunAtMainThread:(dispatch_block_t)block
{
    if ([[self class] isMainThread]) {
        if (block) {
            block();
        }
    }
    else{
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

+ (void)asyncRunAtMainThread:(dispatch_block_t)block
{
    dispatch_async(dispatch_get_main_queue(), block);
}

+ (void)syncRunAtOtherThread:(dispatch_queue_t)q block:(dispatch_block_t)block
{
    dispatch_sync(q, block);
}

+ (void)asyncRunAtOtherThread:(dispatch_queue_t)q block:(dispatch_block_t)block
{
    dispatch_async(q, block);
}

+ (dispatch_queue_t)syncRunBlock:(dispatch_block_t)block
{
    dispatch_queue_t t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_sync(t, block);
    return t;
}

+ (dispatch_queue_t)asyncRunBlock:(dispatch_block_t)block
{
    dispatch_queue_t t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(t, block);
    return t;
}

+ (void)asyncAtGlobalThread:(dispatch_block_t)block thanAtMainThread:(dispatch_block_t)mainBlock
{
    [[self class] asyncRunBlock:^{
        if (block) {
            block();
        }
        [[self class] asyncRunAtMainThread:mainBlock];
    }];
}

+ (instancetype)queneWithName:(NSString *)name
{
    GCDQuene * q = [[GCDQuene alloc] init];
    q.quene_t = dispatch_queue_create([name UTF8String], DISPATCH_QUEUE_SERIAL);
    return q;
}

- (void)test
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
    });
}

#pragma  mark - instance method

- (void)_async:(dispatch_block_t)t
{
    dispatch_async(self.quene_t, t);
}

- (void)_sync:(dispatch_block_t)t
{
    dispatch_sync(self.quene_t, t);
}

- (void)_barrier:(dispatch_block_t)t
{
    dispatch_barrier_sync(self.quene_t, t);
}

- (GCDQuene *(^)(dispatch_block_t))async
{
    return ^ (dispatch_block_t t)
    {
        dispatch_async(self.quene_t, t);
        return self;
    };
}

- (GCDQuene *(^)(dispatch_block_t))sync
{
    return ^ (dispatch_block_t t)
    {
        dispatch_sync(self.quene_t, t);
        return self;
    };
}

- (GCDQuene *(^)(dispatch_block_t))barrier
{
    return ^ (dispatch_block_t t)
    {
        dispatch_barrier_sync(self.quene_t, t);
        return self;
    };
}

- (GCDQuene *(^)(NSTimeInterval ,dispatch_block_t))after
{
    return ^(NSTimeInterval s,dispatch_block_t t)
    {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(s * NSEC_PER_SEC)), dispatch_get_main_queue(), t);
        return self;
    };
}

- (GCDQuene *(^)(_dispatch_block_t_self))semaphore
{
    return ^ (_dispatch_block_t_self t)
    {
        self.async(^{
            GCDSemaphore* s = [GCDSemaphore semaphore:0];
            if (t) {
                t(s);
            }
            s.wait(^{
                
            });
        });
        return self;
    };
}

@end

@interface GCDGroup ()
@property (nonatomic, strong, readwrite) dispatch_group_t group_t;
@end

@implementation GCDGroup

- (dispatch_group_t)group_t
{
    if (!_group_t) {
        _group_t = dispatch_group_create();
    }
    return _group_t;
}

- (GCDGroup *(^)(dispatch_queue_t, dispatch_block_t))async
{
    return ^ (dispatch_queue_t q , dispatch_block_t b)
    {
        dispatch_group_async(self.group_t, q, b);
        return self;
    };
}

- (GCDGroup *(^)(dispatch_queue_t, dispatch_block_t))notify
{
    return ^ (dispatch_queue_t q , dispatch_block_t b)
    {
        dispatch_group_notify(self.group_t, q, b);
        return self;
    };
}

@end


@interface GCDSemaphore()
{
    
}
@property (nonatomic, strong, readwrite) dispatch_semaphore_t semaphore_t;
@end


@implementation GCDSemaphore

//- (dispatch_semaphore_t)semaphore_t
//{
//    if (!_semaphore_t) {
//        _semaphore_t = dispatch_semaphore_create(10);
//    }
//    return _semaphore_t;
//}

- (GCDSemaphore* (^)(dispatch_block_t))wait
{
    return ^(dispatch_block_t t){
        dispatch_semaphore_wait(self.semaphore_t, DISPATCH_TIME_FOREVER);
        if (t) {
            t();
        }
        return self;
    };
}

- (GCDSemaphore*  (^)(_dispatch_block_t_self))run
{
    return ^ (_dispatch_block_t_self t){
        if (t) {
            t(self);
        }
        return self;
    };
}

- (void (^)(void))signal
{
    return ^ {
        dispatch_semaphore_signal(self.semaphore_t);
    };
}

+ (instancetype)semaphore:(int)value
{
    GCDSemaphore* s = [[GCDSemaphore alloc] init];
    s.semaphore_t = dispatch_semaphore_create(value);
    return s;
}

@end
