//
//  JJBlock.h
//  HJJLog
//
//  Created by 郝旭姗 on 2021/1/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//返回值（^名称)(形参类型) = ^(形参类型 形参名)(函数体)
//int (^myBlock)(int) = ^(int a){ return a*2 }
typedef int (^blockName)(int); //block 前半部分

@interface JJBlock: NSObject

@property (nonatomic,copy) int (^blockName_property)(int a); //block 前半部分+参数名称
@property (nonatomic,copy) blockName calculateCallback; //blockName + block 作为属性的名称

- (void)updateValue:(blockName)callback;
+ (void)catchVariable;

@end
NS_ASSUME_NONNULL_END
