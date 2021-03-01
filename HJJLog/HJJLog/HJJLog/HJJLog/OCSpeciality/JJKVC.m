//
//  JJKVC.m
//  HJJLog
//
//  Created by 郝旭姗 on 2021/1/12.
//

/*
 kvc: key-value-coding 键值编码
 黑魔法, 按道理说 private/readonly 的成员变量与属性是无法访问和修改的,但是通过 kvc 却可以做到, 只要知道属性或成员变量的名字就可以
 */

#import "JJKVC.h"
#import <ReplayKit/ReplayKit.h>


@implementation JJKVC

/*
 setValueForKey
 1. 看访问器方法是否存在
 setAge - (void)setAge:(int)age
 _setAge - (void)_setAge:(int)age
 2. 看成员变量是否存在（可通过 accessInstanceVariablesDirectly 返回 NO 拦截）
 int _age
 int _isAge
 int age
 int isAge
 3. 看属性是否存在
 都没有，就会调用 setValue:(id)value forUndefinedKey:(NSString *)key 抛出异常
 valueForKey

 看访问器方法是否存在
 age
 isAge
 _age
 _isAge
 valueForUndefinedKey
 */

#pragma mark - 应用场景
- (void)uses {
    //RPPreviewViewController
    [RPScreenRecorder.sharedRecorder stopRecordingWithHandler:^(RPPreviewViewController * _Nullable previewViewController, NSError * _Nullable error) {
        NSURL *videoURL = [previewViewController valueForKey:@"movieURL"];
        NSLog(@"movieURL: %@",videoURL);
    }];
}

@end
