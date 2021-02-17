//
//  JJLock.m
//  HJJLog
//
//  Created by 郝旭姗 on 2021/2/15.
//

#import "JJLock.h"
#include <os/lock.h>

@implementation JJLock

+ (void)execute {
    JJLock *lock = [[JJLock alloc] init];
    [lock synchronized];
}

//线程锁: 确保同时只有一条线程在执行
- (void)synchronized {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        @synchronized (self) {
            NSLog(@"1");
            sleep(2);
            NSLog(@"1 ok");
        }
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        @synchronized (self) {
            NSLog(@"2");
            sleep(2);
            NSLog(@"2 ok");
        }
    });

}

@end
