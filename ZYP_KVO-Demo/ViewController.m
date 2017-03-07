//
//  ViewController.m
//  ZYP_KVO-Demo
//
//  Created by zhaoyunpeng on 17/3/7.
//  Copyright © 2017年 zhaoyunpeng. All rights reserved.
//

#import "ViewController.h"
#import "KVOController.h"
#import "Person.h"
#import "Animal.h"
#import "Toy.h"

@interface ViewController ()
@property (nonatomic, copy) NSString *labelString;
@property (nonatomic, strong) Person *man;
@property (nonatomic, strong) Animal *animal;
@property (nonatomic, strong) Toy *toy;
@property (nonatomic, strong) FBKVOController *fbKVO;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self example4];
    
}


- (void)example1 {
    self.labelString = @"oldString";
    [self addObserver:self
           forKeyPath:@"labelString"
              options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
              context:nil];
    self.labelString = @"newString";
}


- (void)example2 {
    /*
        Person * man = [[Person alloc]init];
        NSLog(@"old height = %f",man.height);

        [man addObserver:self
              forKeyPath:@"height"
                 options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
                 context:nil];
        man.height ++;
     */
    
    self.man = [[Person alloc]init];
    NSLog(@"old height = %f",self.man.height);
    [self.man addObserver:self
          forKeyPath:@"height"
             options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
             context:nil];
    self.man.height ++;
}

- (void)example3 {
    // 在Animal类添加弱引用持有观察者对象
    self.animal = [[Animal alloc]init];
    [self.animal addObserver:self
               forKeyPath:@"dog"
                  options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
                  context:nil];
    self.animal.dog = @"dog";
    
}

#pragma mark - facebook开源封装KVO

- (void)example4 {
    
    self.toy = [[Toy alloc]init];
    
    
    [self.fbKVO observe:self.toy
                keyPath:@"car"
                options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
                  block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change)
     {
         NSLog(@"fbKVO change = %@",change);
     }];
    
    self.toy.car = @"ambulance";
    
    
    /*
     参考
     https://gold.xitu.io/post/58be0b40128fe1006451f586?utm_source=gold_browser_extension
     */
    
//    不需要手动移除观察者；
//    实现 KVO 与事件发生处的代码上下文相同，不需要跨方法传参数；
//    使用 block 来替代方法能够减少使用的复杂度，提升使用 KVO 的体验；
//    每一个 keyPath 会对应一个属性，不需要在 block 中使用 if 判断 keyPath；
}


//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
//    
//    // example1
//    if ([keyPath isEqualToString:@"labelString"]) {
//        NSLog(@"%@",change);
//    }
//    
//    // example2
//    if ([keyPath isEqualToString:@"height"]) {
//        NSLog(@"%@",change);
//    }
//    
//    // example3
//    if ([keyPath isEqualToString:@"dog"]) {
//        NSLog(@"%@",change);
//    }
//    
//    
//}

- (void)dealloc {
    // 局部变量被回收，由于观察者未被移除会造成崩溃，因此观察对象为全局变量，同时需要移除观察者(example2)
    [self removeObserver:self forKeyPath:@"height"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
