//
//  ViewController.m
//  HJJLog
//
//  Created by 郝旭姗 on 2021/1/12.
//

#import "ViewController.h"
#import "JJKVO.h"
#import "JJGCD.h"
#import "HJJLog-Swift.h"
#import "JJRuntime.h"

@interface ViewController ()
@property (nonatomic, strong) NSString *string;
@property (nonatomic, assign) NSInteger count;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[Sort new] execute];
//    [JJRuntime metaClass];
    
    
}

- (NSInteger)abc: (NSInteger)a {
    self.count += 1;
    if (a <= 2) return 1;
    NSInteger result = [self abc:a-1] + [self abc:a-2];
    return result;
}


@end
