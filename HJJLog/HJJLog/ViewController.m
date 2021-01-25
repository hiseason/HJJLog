//
//  ViewController.m
//  HJJLog
//
//  Created by 郝旭姗 on 2021/1/12.
//

#import "ViewController.h"
#import "JJKVO.h"
#import "JJGCD.h"

@interface ViewController ()
@property (nonatomic, strong) NSString *string;
@property (nonatomic, assign) NSInteger count;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    JJKVO *kvo = [[JJKVO alloc] init];
    JJGCD *gcd = [[JJGCD alloc] init];
    
//    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
//    for (int i = 0; i < 100  ; i++) {
//        dispatch_sync(queue, ^{
//            NSLog(@"并行+异步，i=%d, currentThread: %@", i, [NSThread currentThread]);
//            self.string = [NSString stringWithFormat:@"aaaaaaaaaaaaaaaa:%d",i];
//        });
//    }
//    [self abc:10];
//    NSLog(@"执行次数: %ld",(long)self.count);
    
}

- (NSInteger)abc: (NSInteger)a {
    self.count += 1;
    if (a <= 2) return 1;
    NSInteger result = [self abc:a-1] + [self abc:a-2];
    return result;
}


@end
