//
//  ViewController.m
//  HJJLog
//
//  Created by 郝旭姗 on 2021/1/12.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSString *string;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 100000  ; i++) {
        dispatch_async(queue, ^{
            NSLog(@"并行+异步，i=%d, currentThread: %@", i, [NSThread currentThread]);
            self.string = [NSString stringWithFormat:@"aaaaaaaaaaaaaaaa:%d",i];
        });
        NSLog(@"self.string: %@",self.string);
    }

//    dispatch_queue_t q1 = dispatch_queue_create("mulQueue", DISPATCH_QUEUE_CONCURRENT);
//        for (int i = 0; i < 100; i++){
//            dispatch_async(q1, ^{
//                NSLog(@"并行+异步，i=%d, currentThread: %@", i, [NSThread currentThread]);
//            });
//        }
//        NSLog(@"并行队列+异步函数测试执行 end....");
}



@end
