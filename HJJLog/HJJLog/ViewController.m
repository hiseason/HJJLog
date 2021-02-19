//
//  ViewController.m
//  HJJLog
//
//  Created by 郝旭姗 on 2021/1/12.
//

#import "ViewController.h"
#import "HJJLog-Swift.h"
#import "JJKVO.h"
#import "JJGCD.h"
#import "JJRuntime.h"
#import "JJBlock.h"
#import "JJLock.h"
#import "UIButton+HitRect.h"
#import <Masonry/Masonry.h>

@interface ViewController ()
@property (nonatomic, strong) NSString *string;
@property (nonatomic, assign) NSInteger count;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [[Reserve new] execute];
//    [[Sort new] execute];
//    [JJRuntime metaClass];
//    [JJBlock catchVariable];
//    [Compare execute];
//    [JJGCD execute];
    [JJLock execute];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 60, 100, 100)];
    btn.backgroundColor = [UIColor redColor];
    btn.hitTestEdgeInsets = UIEdgeInsetsMake(-30, -30, -30, -30);
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
    }];
}

- (void)btnAction{
    NSLog(@"click");
}




@end
