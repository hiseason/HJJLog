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
#import "JJBlock.h"

@interface ViewController ()
@property (nonatomic, strong) NSString *string;
@property (nonatomic, assign) NSInteger count;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[Sort new] execute];
//    [JJRuntime metaClass];
//    [JJBlock catchVariable];
    
}


@end
