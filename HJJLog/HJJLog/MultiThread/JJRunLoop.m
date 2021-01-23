//
//  JJRunLoop.m
//  HJJLog
//
//  Created by 郝旭姗 on 2021/1/22.
//

/*
RunLoop 核心就是保证线程有事做事，无事休息，它的设计是为了节省CPU资源。底层是通过系统内核态和用户态的切换来实现的，有事件时切换到用户态(内核态可以访问系统所有资源，包括硬件，比如键盘输入；用户态只能访问自己程序的资源，所有程序都是运行在用户态的，内核态和用户态的设计就是为了限制一个程序不能访问其他程序的内存数据。)
 
RunLoop 与线程
1.一对一，runLoop 与线程的映射保存在一个 NSDictionary 中
2.app 一启动就会开启一个主线程 ，主线程的 runLoop 要一直运行，因为 runLoop 在执行完事件后就会休眠，那么就会退出 app，无法保证 app 的持续运行，所以主线程的 runLoop 默认会一直开启，内部是个 do-while 的死循环，保证 app 一直在等待事件的状态。 当 app 在后台挂起时，线程同时被挂起，runLoop 也被挂起。
3.子线程的runLoop 默认不会开启，而且启动前内部必须要有至少一个 Timer/Observer/Source，所以子线程要想保持 runLoop 常活，就需要一直有事件。
 
 RunLoopMode
 一个 runLoop 同时只能有一种 mode
 */

#import "JJRunLoop.h"

@implementation JJRunLoop

@end
