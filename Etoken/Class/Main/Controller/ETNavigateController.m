//
//  ETNavigateController.m
//  Etoken
//
//  Created by lingbyAir on 2018/4/19.
//  Copyright © 2018年 eosfans. All rights reserved.
//

#import "ETNavigateController.h"
#import <ViewDeck/ViewDeck.h>

@interface ETNavigateController ()

@end

@implementation ETNavigateController

+ (void)initialize
{
    //获取全局导航按钮
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    //当item正常显示状态下
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:16.0f];
    [item setTitleTextAttributes:dict forState:UIControlStateNormal];
    [item setTitleTextAttributes:dict forState:UIControlStateHighlighted];
    
    //当item无法点击的状态下
    NSMutableDictionary *dictDisabble = [NSMutableDictionary dictionary];
    dictDisabble[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    dictDisabble[NSFontAttributeName] = [UIFont systemFontOfSize:16.0f];
    [item setTitleTextAttributes:dictDisabble forState:UIControlStateDisabled];
    
    
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    
    if (self.viewControllers.count > 1) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIImage *backImg = [[UIImage imageNamed:@"return"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backImg style:UIBarButtonItemStylePlain target:self action:@selector(popViewControllerAnimated:)];
    }else{
        
        UIImage *menuImg = [[UIImage imageNamed:@"spreads"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:menuImg style:UIBarButtonItemStylePlain target:self action:@selector(operateMenu)];
    }
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    
    UIViewController *VC = [super popViewControllerAnimated:animated];
    
    if (self.viewControllers.count == 1) {
        VC.hidesBottomBarWhenPushed = NO;
    }
    
    return VC;
}

- (void)operateMenu
{
    [self.viewDeckController openSide:IIViewDeckSideLeft animated:YES];
}

@end
