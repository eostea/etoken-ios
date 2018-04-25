//
//  ETWalletHomeViewController.m
//  Etoken
//
//  Created by lingbyAir on 2018/4/24.
//  Copyright © 2018年 eosfans. All rights reserved.
//

#import "ETWalletHomeViewController.h"
#import "SVGKit.h"
#import "SVGKImage.h"
#import "SVGKParser.h"

@interface ETWalletHomeViewController ()

@end

@implementation ETWalletHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self initUI];
}

- (void)initUI {
    
    NSArray *colors =  @[(__bridge id)[ETSystemTool colorWithHexString:@"#41246B"].CGColor,
                         (__bridge id)[ETSystemTool colorWithHexString:@"#4159BB"].CGColor];
    [self.view.layer addSublayer:[ETSystemTool setGradualChangingColor:self.view direction:GradualDirectionVertical colors:colors]];
    
    
}



@end
