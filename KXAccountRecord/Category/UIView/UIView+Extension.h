//
//  UIView+Extension.h
//  01-黑酷
//
//  Created by apple on 14-6-27.
//  Copyright (c) 2014年 heima. All rights reserved.
//  重写 视图类 frame  有关方法

#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;      //中心点 的x值
@property (nonatomic, assign) CGFloat centerY;      //中心点 的y值
@property (nonatomic, assign) CGFloat width;        //宽
@property (nonatomic, assign) CGFloat height;       //高
@property (nonatomic, assign) CGSize  size;         //尺寸
@end
