//
//  ETMainViewController.m
//  Etoken
//
//  Created by lingbyAir on 2018/4/19.
//  Copyright © 2018年 eosfans. All rights reserved.
//

#import "ETMainViewController.h"
#import "ETNavigateController.h"
#import "ETAssetsViewController.h"
#import "ETMarketViewController.h"
#import "ETFoundViewController.h"
#import "ETMeViewController.h"
@interface ETMainViewController ()

@end

@implementation ETMainViewController

-(instancetype)init
{
    if (self = [super init]) {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    ETAssetsViewController *assertVC = [[ETAssetsViewController alloc] init];
    ETMarketViewController *marketVC = [[ETMarketViewController alloc] init];
    ETFoundViewController *foundVC = [[ETFoundViewController alloc] init];
    ETMeViewController *meVC = [[ETMeViewController alloc] init];
    
    [self createChild:assertVC title:@"资产" imageName:@"label_assets" selectImageName:@"label_assets_Click"];
    [self createChild:marketVC title:@"行情" imageName:@"label_market" selectImageName:@"label_market_Click"];
    [self createChild:foundVC title:@"发现" imageName:@"label_found" selectImageName:@"label_found_Click"];
    [self createChild:meVC title:@"我" imageName:@"label_my" selectImageName:@"label_my_Click"];
}

- (void)createChild:(UIViewController *)childVC title:(NSString *)title imageName:(NSString *)imageName selectImageName:(NSString *)selectImageName
{
    ETNavigateController *nav = [[ETNavigateController alloc] initWithRootViewController:childVC];
    
    nav.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:imageName];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //设置底部栏文字颜色
    NSMutableDictionary *textAttributes = [NSMutableDictionary dictionary];
    textAttributes[NSForegroundColorAttributeName] = rgbaColor(65, 70, 90, 0.4);
    textAttributes[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    [nav.tabBarItem setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    
    NSMutableDictionary *selectTextAttributes = [NSMutableDictionary dictionary];
    selectTextAttributes[NSForegroundColorAttributeName] = [ETSystemTool colorWithHexString:@"#4159BB"];
    selectTextAttributes[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    [nav.tabBarItem setTitleTextAttributes:selectTextAttributes forState:UIControlStateSelected];
    
    //添加了子控制器
    [self addChildViewController:nav];
}


-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    
}

@end
