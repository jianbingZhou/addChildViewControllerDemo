//
//  ViewController.m
//  AddChildViewControllerDemo
//
//  Created by Terra MacBook on 16/8/19.
//  Copyright © 2016年 JianbingZhou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    NSArray *_titileArray;
    UIViewController *_currentVc;
    NSMutableArray *_vcArray;
}

@property (nonatomic,strong) UIScrollView *headerScroll;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Demo";
    self.automaticallyAdjustsScrollViewInsets = NO;
    _headerScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 40)];
    _headerScroll.contentSize = CGSizeMake(self.view.frame.size.width, 0);
    [self.view addSubview:_headerScroll];
    _titileArray = @[@"First",@"Two",@"Three"];
     _vcArray = [[NSMutableArray alloc] initWithCapacity:_titileArray.count];
    for (int i = 0; i < _titileArray.count; i ++) {
         NSString *title = _titileArray[i];
        //btn
        CGFloat margin = 10.0;
        CGFloat width =  (self.view.frame.size.width - ( _titileArray.count + 1)*margin)/_titileArray.count;
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(margin +i *(margin + width), 0, width, 40)];
        [btn setTitle:title forState:0];
        btn.tag = 100 + i;
        btn.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
        [_headerScroll addSubview:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        Class clazz = NSClassFromString([NSString stringWithFormat:@"%@TableViewController",title]);
        UIViewController *vc = (UIViewController *)[clazz new];
        vc.view.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
        vc.view.frame = CGRectMake(0, 104, self.view.frame.size.width, self.view.frame.size.height - 104);
       
        [_vcArray addObject:vc];
#warning *************************只加载一个vc******************************
        if (i  == 0) {
            [self addChildViewController:vc];
            [self.view addSubview:vc.view];
            _currentVc = vc;
        }
    }
}

- (void)btnClick:(UIButton *)btn {
    UIViewController *vc = _vcArray[btn.tag - 100];
    
    
    if (_currentVc == vc) {
        return;
    }else {
          [self replaceCurrentVc:_currentVc WithVc:vc];
    }
}
/*
 苹果新的API(ios 5)增加了addChildViewController方法，并且希望我们在使用addSubview时，同时调用[self addChildViewController:child]方法将sub view对应的viewController也加到当前ViewController的管理中。
 对于那些当前暂时不需要显示的subview，只通过addChildViewController把subViewController加进去；需要显示时再调用transitionFromViewController方法。将其添加进入底层的ViewController中。
 这样做的好处：
 
 1.无疑，对页面中的逻辑更加分明了。相应的View对应相应的ViewController。
 2.当某个子View没有显示时，将不会被Load，减少了内存的使用。
 3.当内存紧张时，没有Load的View将被首先释放，优化了程序的内存释放机制。
 */

/**
 *  在iOS5中，ViewController中新添加了下面几个方法：
 *  addChildViewController:
 *  removeFromParentViewController
 *  transitionFromViewController:toViewController:duration:options:animations:completion:
 *  willMoveToParentViewController:
 *  didMoveToParentViewController:
 */
- (void)replaceCurrentVc:(UIViewController *)currentVc WithVc:(UIViewController *)Vc {
    /**
     *			着重介绍一下它
     *  transitionFromViewController:toViewController:duration:options:animations:completion:
     *  fromViewController	  当前显示在父视图控制器中的子视图控制器
     *  toViewController		将要显示的姿势图控制器
     *  duration				动画时间(这个属性,old friend 了 O(∩_∩)O)
     *  options				 动画效果(渐变,从下往上等等,具体查看API)
     *  animations			  转换过程中得动画
     *  completion			  转换完成
     */
    [self addChildViewController:Vc];
    [self transitionFromViewController:currentVc toViewController:Vc duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        if (finished) {
            [Vc didMoveToParentViewController:self];
            [currentVc willMoveToParentViewController:nil];
            [currentVc removeFromParentViewController];
            _currentVc = Vc;
        }else {
            _currentVc = currentVc;
        }
    }];
    
}

@end
