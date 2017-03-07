//
//  Animal.m
//  ZYP_KVO-Demo
//
//  Created by zhaoyunpeng on 17/3/7.
//  Copyright © 2017年 zhaoyunpeng. All rights reserved.
//

#import "Animal.h"

@implementation Animal

- (instancetype)init {
    self = [super init];
    if (self) {
        self.dog = @"puppy";
    }
    return self;
}

- (void)dealloc {
    // 添加弱引用持有观察者并释放
    [self removeObserver:self.observer forKeyPath:@"dog"];
}

@end
