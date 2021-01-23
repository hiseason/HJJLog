//
//  ViewController.m
//  HJJLog
//
//  Created by 郝旭姗 on 2021/1/12.
//

#import "ViewController.h"
#import "JJKVO.h"

@interface ViewController ()
@property (nonatomic, strong) NSString *string;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    JJKVO *kvo = [[JJKVO alloc] init];
    
//    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
//    for (int i = 0; i < 100000  ; i++) {
//        dispatch_async(queue, ^{
//            NSLog(@"并行+异步，i=%d, currentThread: %@", i, [NSThread currentThread]);
//            self.string = [NSString stringWithFormat:@"aaaaaaaaaaaaaaaa:%d",i];
//        });
//        NSLog(@"self.string: %@",self.string);
//    }
}



@end
