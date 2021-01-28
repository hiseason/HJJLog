//
//  JJView.m
//  HJJLog
//
//  Created by 郝旭姗 on 2021/1/12.
//

#import "JJView.h"

@implementation JJView

// 什么时候调用:只要事件一传递给一个控件，那么这个控件就会调用自己的这个方法
// 作用:寻找并返回最合适的view
// UIApplication -> [UIWindow hitTest:withEvent:]寻找最合适的view告诉系统
// point:当前手指触摸的点
// point:是方法调用者坐标系上的点
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    // 1.判断下窗口能否接收事件
     if (self.userInteractionEnabled == NO || self.hidden == YES ||  self.alpha <= 0.01) return nil;
    // 2.判断下点在不在窗口上
    // 不在窗口上
    if ([self pointInside:point withEvent:event] == NO) return nil;
    // 3.从后往前遍历子控件数组
    int count = (int)self.subviews.count;
    for (int i = count - 1; i >= 0; i--) {
        // 获取子控件
        UIView *childView = self.subviews[i];
        // 坐标系的转换,把窗口上的点转换为子控件上的点
        // 把自己控件上的点转换成子控件上的点
        CGPoint childP = [self convertPoint:point toView:childView];
        UIView *fitView = [childView hitTest:childP withEvent:event];
        if (fitView) {
            // 如果能找到最合适的view
            return fitView;
        }
    }
    // 4.没有找到更合适的view，也就是没有比自己更合适的view
    return self;
}

// 作用:判断下传入过来的点在不在方法调用者的坐标系上
// point:是方法调用者坐标系上的点
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    return NO;
}


- (UIViewController *)currentController {
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}

//超出父视图坐标范围的子视图也能响应事件（tabBar 中间凸起）
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    UIView *view = [super hitTest:point withEvent:event];
//      if (view == nil) {
//        for (UIView *subView in self.subviews) {
//            CGPoint tp = [subView convertPoint:point fromView:self];
//            if (CGRectContainsPoint(subView.bounds, tp)) {
//                if ([subView isKindOfClass:[UIButton class]]) {
//                     view = subView;
//                  }
//              }
//          }
//      }
//     return view;
//}


@end
