//
//  JJGCD.m
//  HJJLog
//
//  Created by 郝旭姗 on 2021/1/24.
//

/*
 任务: 要做的操作, 即 GCD 中的 block
 队列: 存放任务的线性表, 遵循 FIFO (先进先出) 原则
 
 同步异步区别在于是否阻塞当前线程；串行并发区别在于是否按顺序执行任务
 
 同步/异步:
 区别在于是否会阻塞"当前"线程 (有几个入口)
 同步执行: 在当前线程执行任务, 当前 block 执行完毕后线程才会继续往下走,会阻塞当前线程;
 异步执行: 不会阻塞当前线程(但是不一定会开辟线程)
 
 串行队列/并发队列
 区别在于任务是一个一个执行, 还是在多个线程同时进行 (排几个队)
 串行并列中的任务, 顺序执行, GCD 取出来一个,执行完了,再取下一个, 一定是按照开始的顺序结束;
 并发队列中的任务, GCD 取了一个放到一个线程, 接着就下一个放到另一个线程, 不一定会按照开始的顺序结束(前提是得有多个线程, 如果遇上同步, 那就一个线程, 也会按序进行)
 
 线程所占内存: 主线程(1M),子线程(512KB), 线程越多,cpu 在线程之前的调度效率变慢;多线程是为了提高用户体验, 太多时执行效率也会变慢,所以多线程 3-6 条最好
 串行队列异步执行,3个异步任务,串行队列肯定是按照顺序执行, 即使开辟了多个线程,任务也是一个一个执行,所以没有必要开辟多个线程

 https://juejin.cn/post/6844903566398717960
 */

/*
 NSOperation(AFNetworking SDWebImage)
 1.任务执行状态控制 isReady isExecuting isFinished isCancelled
   只重写main 方法, 底层控制任务状态
   重写 start 方法, 自行控制任务状态
 2.添加任务依赖
 3.最大并发量
 NSOperation 对象在 Finished 后如何从 queue 中移除的
 
 NSThread 实现常驻线程
 */

/*
 @synchroniced 创建单例对象, 保证多线程环境下创建对象是单一的
 atomic 只保证赋值操作的线程安全性, 不保证使用操作的线程安全
 OSSpinLock 自旋锁, 循环等待询问, 不释放当前资源(一般的锁在第一次获取到后,后续线程是获取不到的,它会释放它当前的资源, OSSpinLock 不能获得锁,就会一直轮询,直到获得锁,类似while循环)
            用于轻量级数据访问, 引用计数器 +1,-1
 NSLock
 NSRecursiveLock 递归锁, 解决递归方法在多线程中的调用问题
 dispatch_semaphore_t 信号量
 */

#import "JJGCD.h"

@interface JJGCD()

@property(nonatomic, strong) NSMutableArray *array;
@property(nonatomic, strong) NSLock *lock;
@property(nonatomic, strong) dispatch_queue_t readWriteQueue;
@end

@implementation JJGCD

- (instancetype)init {
    if (self = [super init]) {
        self.array = [NSMutableArray array]; //✅ atomic 保证赋值操作的线程安全
        //[self.array addObject: @"atomic"]; //❌ atomic 不保证使用操作的线程安全
        self.lock = [[NSLock alloc] init];
        
        self.readWriteQueue = dispatch_queue_create("readWrite", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

+ (void)execute {
    JJGCD *gcd = [[JJGCD alloc] init];
    [gcd mainQueue2];
//    [gcd executeBarrierAsync];
//    [gcd readWrite];
//    [gcd gcdSemaphore];
}

#pragma mark - 锁
- (void)methodA {
    [self.lock lock];
    [self methodB];
    [self.lock unlock];
}

- (void)methodB {
    [self.lock lock];
    //操作逻辑
    [self.lock unlock];
}

//执行两个异步的AFN网络请求，第二个网络请求需要等待第一个网络请求响应后再执行
- (void)semaphore {
    NSString *urlString1 = @"/Users/ws/Downloads/Snip20161223_20.png";
    NSString *urlString2 = @"/Users/ws/Downloads/Snip20161223_21.png";
    // 创建信号量
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//        [manager POST:urlString1 parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            NSLog(@"1完成！");
//            // 发送信号量
//            dispatch_semaphore_signal(sem);
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            NSLog(@"1失败！");
//            // 发送信号量
//            dispatch_semaphore_signal(sem);
//        }];
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 等待信号量
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
//        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//
//        [manager POST:urlString2 parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//
//        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            NSLog(@"2完成！");
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            NSLog(@"2失败！");
//        }];
    });
}

- (void)gcdSemaphore {
    dispatch_queue_t workConcurrentQueue = dispatch_queue_create("cccccccc", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t serialQueue = dispatch_queue_create("sssssssss",DISPATCH_QUEUE_SERIAL);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(3);

    for (NSInteger i = 0; i < 10; i++) {
      dispatch_async(serialQueue, ^{
          dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
          dispatch_async(workConcurrentQueue, ^{
              NSLog(@"thread-info:%@开始执行任务%d",[NSThread currentThread],(int)i);
              sleep(1);
              NSLog(@"thread-info:%@结束执行任务%d",[NSThread currentThread],(int)i);
              dispatch_semaphore_signal(semaphore);});
      });
    }
    NSLog(@"主线程...!");
}


#pragma mark - 多读单写
- (void)readWrite {
    [self write:@"1" sleep:3.0];
    [self read];
    [self write:@"2" sleep:1.0];
    [self read];
    [self read];
    [self write:@"3" sleep:0.0];
    [self read];
}

- (void)read {
    dispatch_async(self.readWriteQueue, ^{
        NSLog(@"读 array: %@",self.array);
    });
}

- (void)write: (NSString *)str sleep:(double)time {
    NSLog(@"array: %@",self.array);
    dispatch_barrier_async(self.readWriteQueue, ^{
        [NSThread sleepForTimeInterval:time];              // 模拟耗时操作
        [self.array addObject:str];
        NSLog(@"array: %@  thread:%@",self.array,[NSThread currentThread]);
    });

}

#pragma mark - barrier
/*
 * 特点：
 * 1.barrier之前的任务并发执行，barrier之后的任务在barrier任务完成之后并发执行
 * 2.会开启新线程执行任务
 * 3.不会阻塞当前线程（主线程）
 */
- (void)executeBarrierAsync {
    dispatch_queue_t concurrentQueue = dispatch_queue_create("concurrent_queue",DISPATCH_QUEUE_CONCURRENT);

    NSLog(@"CurrentThread---%@",[NSThread currentThread]);  // 打印当前线程
    NSLog(@"---begin---");
    
    NSLog(@"追加任务1");
    dispatch_async(concurrentQueue, ^{
        // 追加任务1
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"1---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    NSLog(@"追加任务2");
    dispatch_async(concurrentQueue, ^{
        // 追加任务2
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"2---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    NSLog(@"追加barrier_async任务");
    dispatch_barrier_sync(concurrentQueue, ^{
        // 追加barrier任务
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"barrier---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    /*
     barrier_sync会阻塞它之后的任务的入队，必须等到barrier_sync任务执行完毕，才会把后面的异步任务添加到并发队列中，而barrier_async不需要等自身的block执行完成，就可以把后面的任务添加到队列中。
     */
    
    NSLog(@"追加任务3");
    dispatch_async(concurrentQueue, ^{
        // 追加任务3
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"3---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    NSLog(@"追加任务4");
    dispatch_async(concurrentQueue, ^{
        // 追加任务4
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"4---%@",[NSThread currentThread]);      // 打印当前线程
        }
    });
    
    NSLog(@"---end---");
    NSLog(@"*********************************************************");
}

//作者：左耳钉zed
//链接：https://juejin.cn/post/6844903833831735310
//来源：掘金
//著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。


#pragma mark - 多线程高级考察
//主队列特点: 必须等待主线程中的任务执行完,再执行主队列中的任务
- (void)mainQueue2 {
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_sync(mainQueue, ^{//block1
        NSLog(@"1");
    });
    NSLog(@"end");
    //mainQueueSync 和 block1 相互等待
}

- (void)mainQueue {
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_async(mainQueue, ^{
        NSLog(@"1");
    });
    NSLog(@"end");
}

- (void)serialQueueAsyncSync {
    NSLog(@"begin--%@",[NSThread currentThread]);
    dispatch_queue_t serialQueue = dispatch_queue_create("serial_queue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(serialQueue, ^{//block1
        NSLog(@"1--%@",[NSThread currentThread]);
        dispatch_sync(serialQueue, ^{ //block2
            NSLog(@"2--%@",[NSThread currentThread]);
            //block2 等 block1 走完
            //3 需要等 block2 走完
        });
        NSLog(@"3--%@",[NSThread currentThread]);
    });
    NSLog(@"end--%@",[NSThread currentThread]);
}


//碰到异步才可能切换线程
- (void)serialQueueSyncAsync {
    NSLog(@"begin--%@",[NSThread currentThread]);
    dispatch_queue_t serialQueue = dispatch_queue_create("serial_queue", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(serialQueue, ^{
        NSLog(@"1--%@",[NSThread currentThread]);
        dispatch_async(serialQueue, ^{
            NSLog(@"2--%@",[NSThread currentThread]);
        });
        //TODO: 为什么即使耗时了,2 还是会等 3,不在一个线程啊,3 在主线程,2 在子线程?????????
        sleep(5);
        NSLog(@"3--%@",[NSThread currentThread]);

//        dispatch_async(serialQueue, ^{
//            NSLog(@"3--%@",[NSThread currentThread]);
//        });
//        sleep(2);
//        NSLog(@"4--%@",[NSThread currentThread]);
    });
    NSLog(@"end--%@",[NSThread currentThread]);
}


- (void)concurrentQueueSyncAsync {
    NSLog(@"begin--%@",[NSThread currentThread]);
    dispatch_queue_t concurrentQueue = dispatch_queue_create("concurrent_queue",DISPATCH_QUEUE_CONCURRENT);
    dispatch_sync(concurrentQueue, ^{
        NSLog(@"1--%@",[NSThread currentThread]);
        dispatch_async(concurrentQueue, ^{
            NSLog(@"2--%@",[NSThread currentThread]);
        });
        dispatch_async(concurrentQueue, ^{
            NSLog(@"3--%@",[NSThread currentThread]);
        });
        NSLog(@"4--%@",[NSThread currentThread]);
    });
    NSLog(@"end--%@",[NSThread currentThread]);
}

//主队列同步执行
- (void)mainQueueSync {
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    for (int i = 0; i<10; i++) {
        //同步执行: 不会开辟线程, 所以只有一条线程
        //串行队列: 执行完一个任务, GCD 才会取下一个任务
        /*
         但是现在是分派到了主队列, 主队列的任务必须在主线程执行, 主线程正在执行 mainQueueSync 函数, 而 mainQueueSync 执行完必须依赖于 block 执行完
         而 block 的执行依赖于队列先进先出的性质,必须得让先进 mainQueueSync 函数执行完才能执行
         "队列"引起的相互等待
         主队列同步与串行队列同步关键区别点在于 block 放在了主队列中,要想执行它,必须让队列中的 mainQueueSync 执行完才可以
         而放到串行队列中, 串行队列只有 block 这一个任务, 执行完了, 主线程继续执行 serialQueueSync 这个函数, 不会死锁
         所以只要是两个任务分派到一个串行队列中,就会形成死锁
         */
        dispatch_sync(mainQueue, ^{
            sleep(1);
            NSLog(@"%@ 执行任务%d current theard:%@",[NSDate date],i,[NSThread currentThread]);
        });
    }
}

//并发队列同步执行的嵌套
- (void)concurrentQueueSyncNest {
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSLog(@"1");
    //以同步方式提交一个任务到并发队列
    dispatch_sync(globalQueue, ^{ //任务 1: 打印 2,3,4
        NSLog(@"2");
        //并发队列特点就是任务可以并发执行, 所以任务 1 没有执行完也不影响任务 2
        dispatch_sync(globalQueue, ^{
            NSLog(@"3"); //任务 2: 打印 3
        });
        NSLog(@"4");
    });
    NSLog(@"5");
}

//performSelector
- (void)concurrentQueuePerformSelector {
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(globalQueue, ^{
        NSLog(@"1");
        //performSelector 需要提交任务到 runloop 上面
        //performSelector 要想执行,必须是方法调用的当前线程是有 runloop 的,如果没有就会失效
        [self performSelector:@selector(printLog) withObject:nil afterDelay:0];
        NSLog(@"3");
    });
}

- (void)printLog {
    NSLog(@"2");
}

#pragma mark - 基础操作
- (void)executeGCDBasic {
//    [self serialQueueSync];
    [self concurrentQueueSync];
    [self serialQueueAsync];
}

//串行队列同步执行
- (void)serialQueueSync {
    dispatch_queue_t serialQueue = dispatch_queue_create("serial_queue", DISPATCH_QUEUE_SERIAL);
    for (int i = 0; i<10; i++) {
        //同步执行: 不会开辟线程, 所以只有一条线程
        //串行队列: 执行完一个任务, GCD 才会取下一个任务
        dispatch_sync(serialQueue, ^{
            sleep(1);
            NSLog(@"%@ 串行队列同步执行任务 **%d** current theard:%@",[NSDate date],i,[NSThread currentThread]);
        });
    }
}

//并发队列同步执行
- (void)concurrentQueueSync {
    dispatch_queue_t concurrentQueue = dispatch_queue_create("concurrent_queue",DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i<10; i++) {
        //同步执行: 不会开辟线程, 所以只有一条线程
        //并发队列: GCD 取完一个任务,会立即取下一个任务放到另一个线程, 但是同步执行不会开线程,所以只有一条线程, 同一时间只会有一个打印
        dispatch_sync(concurrentQueue, ^{
            sleep(1);
            NSLog(@"%@ 并发队列同步执行任务 **%d** current theard:%@",[NSDate date],i,[NSThread currentThread]);
        });
    }
}

//串行并列异步执行
- (void)serialQueueAsync {
    dispatch_queue_t serialQueue = dispatch_queue_create("serial_queue",DISPATCH_QUEUE_SERIAL);
    for (int i = 0; i<10; i++) {
        //异步执行: 会开线程, 所以 thread 不是主线程,是新的线程
        //串行队列: 任务一个一个执行, 按序输出, 所以是"一个"新线程
        dispatch_async(serialQueue, ^{
            sleep(1);
            NSLog(@"%@ 串行并列异步执行任务%d current theard:%@",[NSDate date],i,[NSThread currentThread]);
        });
    }
}

//并发队列异步执行
- (void)concurrentQueueAsync {
    dispatch_queue_t concurrentQueue = dispatch_queue_create("concurrent_queue",DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i<100000; i++) {
        //异步执行: 会开线程
        //并发队列: GCD 取完一个任务,会立即取下一个任务放到另一个线程, 所以会开多条线程, 并且不按顺序
        dispatch_async(concurrentQueue, ^{
            sleep(1);
            NSLog(@"%@ 执行任务%d current theard:%@",[NSDate date],i,[NSThread currentThread]);
        });
    }
}

@end
