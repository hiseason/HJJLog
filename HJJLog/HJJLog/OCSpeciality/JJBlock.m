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

//返回值（^名称)(形参类型) = ^(形参类型 形参名)(函数体)
//int (^myBlock)(int) = ^(int a){ return a*2 }
typedef int (^myBlock)(int); //block 前半部分

@interface JJBlock()

@property (nonatomic,copy) int (^myBlock)(int a); //block 前半部分+参数名称
@property (nonatomic,copy) myBlock calculateCallback; //blockName + block 作为属性的名称

- (void)updateValue:(myBlock)callback;
//-(void)updateBValue:(int)b a:(int(^)(int))myBlock {} //block 前半部分 blockName 提取到括号外面

@end

@implementation JJBlock

@end
