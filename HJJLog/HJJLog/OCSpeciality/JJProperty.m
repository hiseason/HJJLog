//
//  JJProperty.m
//  HJJLog
//
//  Created by 郝旭姗 on 2021/1/22.
//

#import "JJProperty.h"
#import <objc/runtime.h>

/*
 atomic 保证“赋值和获取”是线程安全的，但不保证“操作和访问”是线程安全的，比如数组的添加和移除
 */

@interface JJProperty()
//成员变量
{
    @public NSString *name; //@public公开的，可以被在任何地方访问。
    @protected NSString *age; //@protected是受保护的，只能在本类及其子类中访问，在{}声明的变量默认是@protected
    @private int idCardNumber;//@private是私有的，只能在本类访问
    //如果成员变量的类型是一个类, 就称为实例变量,比如name就是实例变量, idCardNumber则不是
}
//属性变量
@property (nonatomic,strong) NSArray *propertyString;

@end

@implementation JJProperty

- (void)getProperties{
    unsigned int count = 0; //count记录变量的数量
    // 获取类的所有成员变量
    Ivar *members = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = members[i];
        // 取得变量名并转成字符串类型
        const char *memberName = ivar_getName(ivar);
        NSLog(@"变量名 = %s",memberName);
    }
    // 获取类的所有成员属性
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i<count; i++){
        objc_property_t property = properties[i];
        const char* char_f = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        NSLog(@"属性名 = %@",propertyName);
    }

}

@end
