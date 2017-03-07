//
//  Animal.h
//  ZYP_KVO-Demo
//
//  Created by zhaoyunpeng on 17/3/7.
//  Copyright © 2017年 zhaoyunpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Animal : NSObject
@property (nonatomic, copy) NSString *dog;
@property (nonatomic, weak) NSObject *observer;
@end
