//
//  JJUserCenter.m
//  HJJLog
//
//  Created by 郝旭姗 on 2021/1/25.
//

#import "JJUserCenter.h"

@interface JJUserCenter()
{
    dispatch_queue_t concurrent_queue;
    NSMutableDictionary *userCenterDic;
}
@property(nonatomic, strong) NSMutableArray *array;
@property(nonatomic, strong) dispatch_queue_t readWriteTestQueue;
@end

@implementation JJUserCenter

- (instancetype)init {
    if (self = [super init]) {
        concurrent_queue = dispatch_queue_create("read_write_queue", DISPATCH_QUEUE_CONCURRENT);
        userCenterDic = [NSMutableDictionary dictionary];
        self.readWriteTestQueue = dispatch_queue_create("read_write_queue", DISPATCH_QUEUE_CONCURRENT);
    }
    return  self;
}

//读读并发
- (id)objectForKey:(NSString *)key {
    __block id obj;
    //同步读取指定数据
    //需要立刻返回结果,所以用同步,如果用异步的话, 会开辟另一条线程,当前线程继续往下执行其他任务了
    //并发队列, 这样 a 线程和 b 线程可以同时读取
    dispatch_sync(concurrent_queue, ^{
        obj = [userCenterDic objectForKey:key];
    });
    return obj;
}

//读写互斥 写写互斥
- (void)setObject:(id)obj forKey:(NSString *)key {
    //barrier 保证读写互斥
    //并发队列, 保证写写互斥
    dispatch_barrier_async(concurrent_queue, ^{
        [self->userCenterDic setObject:obj forKey:key];
    });
}

#pragma mark - 多读单写测试
- (void)readWriteTest {
    [self write:@"1" sleep:3.0];
    [self read];
    [self write:@"2" sleep:1.0];
    [self read];
    [self read];
    [self write:@"3" sleep:0.0];
    [self read];
}

- (void)read {
    dispatch_async(self.readWriteTestQueue, ^{
        NSLog(@"读 array: %@",self.array);
    });
}

- (void)write: (NSString *)str sleep:(double)time {
    NSLog(@"array: %@",self.array);
    dispatch_barrier_async(self.readWriteTestQueue, ^{
        [NSThread sleepForTimeInterval:time];              // 模拟耗时操作
        [self.array addObject:str];
        NSLog(@"array: %@  thread:%@",self.array,[NSThread currentThread]);
    });

}


@end
