//
//  UIButton+JJCategory.h
//  HJJLog
//
//  Created by 郝旭姗 on 2021/1/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (JJCategory)

/**
自定义响应边界 UIEdgeInsetsMake(-3, -4, -5, -6). 表示扩大
例如： self.btn.hitEdgeInsets = UIEdgeInsetsMake(-3, -4, -5, -6);
*/
@property(nonatomic, assign) UIEdgeInsets hitEdgeInsets;

@end

NS_ASSUME_NONNULL_END
