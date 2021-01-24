//
//  JJGCD.m
//  HJJLog
//
//  Created by 郝旭姗 on 2021/1/24.
//

/*
 任务: 要做的操作, 即 GCD 中的 block
 队列: 存放任务的线性表, 遵循 FIFO (先进先出) 原则
 
 同步/异步:
 区别在于是否会开线程(是否会阻塞"当前"线程)
 同步执行: 当前 block 执行完毕后线程才会继续往下走;
 异步执行: 当前线程会一直往下走,不会阻塞, 本质是开其他线程执行任务
 
 串行队列/并发队列
 区别在于任务如何执行,同一时间有一个任务还是多个任务执行
 串行并列中的任务, GCD 取出来一个,执行完了,再取下一个, 一定是按照开始的顺序结束;
 并发队列中的任务, GCD 取了一个放到一个线程, 接着就下一个放到另一个线程, 不一定会按照开始的顺序结束(前提是得有多个线程, 如果遇上同步, 那就一个线程, 也会按序进行)
 */

#import "JJGCD.h"

@implementation JJGCD

- (instancetype)init {
    if (self = [super init]) {
        [self concurrentQueueAsync];
    }
    return self;
}

//串行队列同步执行
- (void)serialQueueSync {
    dispatch_queue_t serialQueue = dispatch_queue_create("serial_queue",
        DISPATCH_QUEUE_SERIAL);
    for (int i = 0; i<10; i++) {
        //同步执行: 不会开辟线程, 所以只有一条线程
        //串行队列: 执行完一个任务, GCD 才会取下一个任务
        dispatch_sync(serialQueue, ^{
            sleep(1);
            NSLog(@"%@ 执行任务%d current theard:%@",[NSDate date],i,[NSThread currentThread]);
        });
    }
}

//并发队列同步执行
- (void)concurrentQueueSync {
    dispatch_queue_t concurrentQueue = dispatch_queue_create("concurrent_queue",
    DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i<10; i++) {
        //同步执行: 不会开辟线程, 所以只有一条线程
        //并发队列: GCD 取完一个任务,会立即取下一个任务放到另一个线程, 但是同步执行不会开线程,所以只有一条线程, 同一时间只会有一个打印
        dispatch_sync(concurrentQueue, ^{
            sleep(1);
            NSLog(@"%@ 执行任务%d current theard:%@",[NSDate date],i,[NSThread currentThread]);
        });
    }
}

//串行并列异步执行
- (void)serialQueueAsync {
    dispatch_queue_t serialQueue = dispatch_queue_create("serial_queue",
        DISPATCH_QUEUE_SERIAL);
    for (int i = 0; i<10; i++) {
        //异步执行: 会开线程, 所以 thread 不是主线程,是新的线程
        //串行队列: 任务一个一个执行, 按序输出, 所以是"一个"新线程
        dispatch_async(serialQueue, ^{
            sleep(1);
            NSLog(@"%@ 执行任务%d current theard:%@",[NSDate date],i,[NSThread currentThread]);
        });
    }
}

//并发队列异步执行
- (void)concurrentQueueAsync {
    dispatch_queue_t concurrentQueue = dispatch_queue_create("concurrent_queue",
    DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i<10; i++) {
        //异步执行: 会开线程
        //并发队列: GCD 取完一个任务,会立即取下一个任务放到另一个线程, 所以会开多条线程, 并且不按顺序
        dispatch_async(concurrentQueue, ^{
            sleep(1);
            NSLog(@"%@ 执行任务%d current theard:%@",[NSDate date],i,[NSThread currentThread]);
        });
    }
}



@end
