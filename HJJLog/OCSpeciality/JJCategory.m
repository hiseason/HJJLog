//
//  JJCategory.m
//  HJJLog
//
//  Created by 郝旭姗 on 2021/1/22.
//

#import "JJCategory.h"
#import <objc/runtime.h>

/*
 使用
 1. 分解体积庞大的类, 比如 UIAppDelegate
 2. 为系统类添加方法,封装类经常复用的业务逻辑
 3. 为系统类添加属性
    MJRefresh: UIScrollView + mjHeader
    Masonry: UIView + mas_key
 4. 公开 framework 的私有方法
 */

/*
 struct _category_t {
    const char *name;
    struct _class_t *cls;
    const struct _method_list_t *instance_methods;
    const struct _method_list_t *class_methods;
    const struct _protocol_list_t *protocols;
    const struct _prop_list_t *properties;
 };
 */

@interface JJCategory()
@property (nonatomic, strong) id mas_key;
@end

@implementation JJCategory

- (id)mas_key {
    return objc_getAssociatedObject(self, @selector(mas_key));
}

- (void)setMas_key:(id)key {
    objc_setAssociatedObject(self, @selector(mas_key), key, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
/*
 添加属性需要用关联对象实现，所有对象的关联内容都放在同一个全局容器哈希表中:AssociationsHashMap,由 AssociationsManager 统一管理。
 
  关键策略是一个enum值
 OBJC_ASSOCIATION_ASSIGN = 0,      <指定一个弱引用关联的对象>
 OBJC_ASSOCIATION_RETAIN_NONATOMIC = 1,<指定一个强引用关联的对象>
 OBJC_ASSOCIATION_COPY_NONATOMIC = 3,  <指定相关的对象复制>
 OBJC_ASSOCIATION_RETAIN = 01401,      <指定强参考>
 OBJC_ASSOCIATION_COPY = 01403    <指定相关的对象复制>

 为什么没有weak?
 
 */



@end
