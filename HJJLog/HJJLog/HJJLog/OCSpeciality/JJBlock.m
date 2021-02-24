//
//  JJBlock.m
//  HJJLog
//
//  Created by 郝旭姗 on 2021/1/23.
//

/*
 block 作为回调函数好处
 1.写代码更顺畅，不用中途跑到另一个地方写回调函数，可以直接在调用函数处写后续处理代码
 2.block 作为回调函数，可以直接访问内部变量
 
 为什么用 copy
 block 默认是存储在栈上，block copy 的功能是把 block 从栈复制到堆上。__block 会把变量随着 block copy 到堆上，所以才能被block共享
 
 OC：返回值（^名称)(形参类型) = ^(形参类型 形参名)(函数体)
 swift： 闭包名 = { (形参名：形参类型) -> 返回值 in }

 */

#import "JJBlock.h"
#import "JJView.h"

int gloablA = 10;
static int staticGloablA = 10;

@interface JJBlock()

@end

@implementation JJBlock

#pragma mark - 捕获变量
+ (void)catchVariable {
    int a = 10;
    void (^block)(void) = ^{
        //a = 15;
        //Variable is not assignable (missing __block type specifier)
        NSLog(@"intA: %d",a);
    };
    a = 20;
    block();
    //基本类型捕获值 10
    
    static int staticA = 10;
    void (^block2)(void) = ^{
        NSLog(@"staticA: %d",staticA);
    };
    staticA = 20;
    block2();
    //静态局部变量捕获指针 20
    
    void (^block3)(void) = ^{
        NSLog(@"staticA: %d",gloablA);
    };
    gloablA = 20;
    block3();

    void (^block4)(void) = ^{
        NSLog(@"staticGloablA: %d",staticGloablA);
    };
    staticGloablA = 20;
    block4();
    //全局变量不捕获 20
    
    NSString *str = @"10";
    void (^block5)(void) = ^{
        NSLog(@"str: %@",str);
    };
    str = @"20";
    block5();
    //对象类型捕获值 10
    
    __block int underlineBlockA = 10;
    void (^block6)(void) = ^{
        NSLog(@"underlineBlockA: %d",underlineBlockA);
        underlineBlockA = 15;
        NSLog(@"underlineBlockA changed: %d",underlineBlockA);

    };
    underlineBlockA = 20;
    block6();
    //__block 捕获指针 20
    //__block 使 block 内部允许修改外部变量
    
    __block NSString *underlineBlockS = @"10";
    void (^block7)(void) = ^{
        NSLog(@"underlineBlockS: %@",underlineBlockS);
        underlineBlockS = @"15";
        NSLog(@"underlineBlockS changed: %@",underlineBlockS);

    };
    underlineBlockS = @"20";
    block7();

}


- (void)updateValue:(blockName)callback {
    
}


@end
