//
//  JJThread.m
//  HJJLog
//
//  Created by haojiajia on 2021/2/25.
//

/*
 多线程方案
 
 NSThread 需要程序员管理"线程生命周期"
 GCD NSOperation 系统自动管理"线程生命周期"
 

 */

#import "JJThread.h"

@implementation JJThread

- (void)useNSThread {
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadAction) object:nil];
    [thread start];
    
    NSThread *mainThread = [NSThread mainThread];
    NSThread *currentThread = [NSThread currentThread];
}

- (void)threadAction {
    
}

@end
