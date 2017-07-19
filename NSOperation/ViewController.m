//
//  ViewController.m
//  NSOperation
//
//  Created by DB_MAC on 2017/6/26.
//  Copyright © 2017年 db. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic , strong) NSOperationQueue *opQueue;


@end


//GCD 提供NSOperation 不具备的功能  1、一次执行  2、延迟执行
//NSOperation  提供了 GCD实现比较困难的功能  1、最大并发数  2、队列暂停 继续  3、取消所有操作  4、指定操作间的依赖关系（GCD 用同步实现）


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

//懒加载
-(NSOperationQueue *)opQueue
{
    if (!_opQueue) {
        _opQueue = [[NSOperationQueue alloc] init];
    }
    return _opQueue;
}

/*
    NSOperation  核心概念：将”操作“ 添加 到“队列”
    GCD 将“任务”  添加 到“队列“
 
 
    NSOperation 类是一个抽象类
    特点：不能直接使用
    目的：定义子类共有的属性和方法
    子类：NSInvocationOperation NSBlockOperation
*/

-(void)demo6{
    //线程间 通讯
    [self.opQueue addOperationWithBlock:^{
        //耗时操作
        
       [[NSOperationQueue mainQueue] addOperationWithBlock:^{
          //到主线程  更新UI
       }];
    }];
}

-(void)demo5{//只要是NSOperation的子类 都可以添加到队列
    //全局队列直接添加 操作
    for (int i = 0; i<10; i++) {
        [self.opQueue addOperationWithBlock:^{
           
        }];
    }
}


// NSInvocationOperation
-(void)demo1{
    
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downLoad) object:@""];
//    [op start];//start 会在当前线程 执行调度
    NSOperationQueue *q = [[NSOperationQueue alloc] init];
    //将操作添加到队列  会自动异步执行调度方法
    [q addOperation:op];
    
    
}

-(void)demo2{
    NSOperationQueue *q = [[NSOperationQueue alloc] init];
    for (int i = 0; i<10; i++) {
        NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downLoad) object:nil];
        [q addOperation:op];//每次都会开启一个线程
        //NSOperation 本质上是对GCD的面向对象封装
    }
}

-(void)demo3{
    NSOperationQueue *q = [[NSOperationQueue alloc] init];
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        //block执行代码   方便快捷
    }];
    [q addOperation:op];
}
-(void)demo4{
    //队列 如果每次分配会比较浪费
    //实际开发中会使用全局队列
    NSOperationQueue *q = [[NSOperationQueue alloc] init];//队列
    //添加操作
    [q addOperationWithBlock:^{
        
    }];
    
}

-(void)downLoad{
    NSLog(@"1--%@",[NSThread currentThread]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
