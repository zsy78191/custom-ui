//
//  GCDQuene.h
//  customui-dev
//
//  Created by 张超 on 2018/1/9.
//  Copyright © 2018年 orzer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GCDQuene : NSObject

@property (nonatomic, strong, readonly) dispatch_queue_t quene_t;
@property (nonatomic, class,readonly) dispatch_queue_t (^golbalQuene)(void);
@property (nonatomic, class,readonly) dispatch_queue_t (^golbalQueneWithPriority)(int priority);
@property (nonatomic, class,readonly) dispatch_queue_t (^mainQuene)(void);
@property (nonatomic, class,readonly) dispatch_queue_t (^quene)(NSString* name);


+ (instancetype)queneWithName:(NSString*)name;

+ (BOOL)isMainThread;
+ (void)syncRunAtMainThread:(dispatch_block_t)block;
+ (void)asyncRunAtMainThread:(dispatch_block_t)block;
+ (void)syncRunAtOtherThread:(dispatch_queue_t)q block:(dispatch_block_t)block;
+ (void)asyncRunAtOtherThread:(dispatch_queue_t)q block:(dispatch_block_t)block;
+ (dispatch_queue_t)syncRunBlock:(dispatch_block_t)block;
+ (dispatch_queue_t)asyncRunBlock:(dispatch_block_t)block;

+ (void)asyncAtGlobalThread:(dispatch_block_t)block thanAtMainThread:(dispatch_block_t)mainBlock;

@end

@interface GCDGroup : NSObject
{
    
}
@property (nonatomic, strong, readonly) dispatch_group_t group_t;
@property (nonatomic, readonly) GCDGroup* (^ async)(dispatch_queue_t,dispatch_block_t);
@property (nonatomic, readonly) GCDGroup* (^ notify)(dispatch_queue_t,dispatch_block_t);
@end
