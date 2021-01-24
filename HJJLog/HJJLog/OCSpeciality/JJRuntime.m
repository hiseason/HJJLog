//
//  JJRuntime.m
//  HJJLog
//
//  Created by 郝旭姗 on 2021/1/23.
//

#import "JJRuntime.h"
#import <objc/runtime.h>

@implementation JJRuntime

#pragma mark - 获取方法列表
- (NSString *)getClassNameList {
    Class cls = object_getClass(self);
    unsigned int count;
    // 获取方法数组
    Method *methodList = class_copyMethodList(cls, &count);
    // 存储方法名
    NSMutableString *methodNames = [NSMutableString new];
    // 遍历所有方法
    for (int i=0; i<count; i++) {
        // 获得方法
        Method method = methodList[i];
        // 获得方法名
        NSString *methodName = NSStringFromSelector(method_getName(method));
        // 拼接方法名
        [methodNames appendString:methodName];
        [methodNames appendString:@", "];
    }
    // 释放
    free(methodList);
    return [methodNames copy];
}


#pragma mark - 获取成员变量和属性名
- (void)getIvarList {
    unsigned int count = 0;
    //该方法是C函数，获取所有属性
    Ivar * ivars = class_copyIvarList([self class], &count);
    NSMutableArray *ivarNames = [NSMutableArray array];
    for (unsigned int i = 0; i < count; i ++)
    {
        Ivar ivar = ivars[i];
        //获取属性名
        const char * name = ivar_getName(ivar);
        //使用KVC直接获取相关属性的值
        [ivarNames addObject:[NSString stringWithUTF8String:name]];
        NSObject *value = [self valueForKey:[NSString stringWithUTF8String:name]];
        NSLog(@"%@的成员变量: %s %@",[self class], name, value);
    }
    NSLog(@"成员变量列表: %@",ivarNames);
    //需要释放获取到的属性
    free(ivars);
}


// 打印属性列表
- (void)getPropertyList {
    unsigned int count;
    NSMutableArray *propertyNames = [NSMutableArray array];
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (unsigned int i = 0; i < count; i++) {
        const char *propertyName = property_getName(propertyList[i]);
        [propertyNames addObject:[NSString stringWithUTF8String:propertyName]];
    }
    NSLog(@"属性列表: %@",propertyNames);
    free(propertyList);
}


@end
