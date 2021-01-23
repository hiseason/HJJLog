//
//  JJKVO.m
//  HJJLog
//
//  Created by 郝旭姗 on 2021/1/23.
//

#import "JJKVO.h"
#import <objc/runtime.h>

@interface JJKVO()

@property (nonatomic, copy) NSString *name;

@end

@implementation JJKVO

- (instancetype)init {
    if (self = [super init]) {
        [self uses];
    }
    return  self;
}

#pragma mark - 应用场景
- (void)uses {
    self.name = @"kvo_name";
    NSLog(@"监听前: %@", object_getClass(self));

    NSKeyValueObservingOptions options = NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew;
    [self addObserver:self forKeyPath:@"name" options:options context:@"123"];
    self.name = @"kvo_newName";
    NSLog(@"监听后: %@", object_getClass(self));
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"监听到%@的%@属性值改变了 change: %@ context: %@", object, keyPath, change, context);
}


@end
