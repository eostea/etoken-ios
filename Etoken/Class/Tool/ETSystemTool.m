//
//  ETSystemTool.m
//  Etoken
//
//  Created by lingbyAir on 2018/4/19.
//  Copyright © 2018年 eosfans. All rights reserved.
//

#import "ETSystemTool.h"
#import <CommonCrypto/CommonDigest.h>

@implementation ETSystemTool

/**
 *MD5加密
 */
+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",    // 小写 x 表示输出的是小写 MD5 ，大写 X 表示输出的是大写 MD5
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

/**
 * 获取当前VC
 */
+ (UIViewController *)getCurrentVC
{
    
    UIViewController * currVC = nil;
    UIViewController * Rootvc = [[UIApplication sharedApplication] keyWindow].rootViewController ;
    do {
        if ([Rootvc isKindOfClass:[UINavigationController class]]) {
            UINavigationController * nav = (UINavigationController *)Rootvc;
            UIViewController * v = [nav.viewControllers lastObject];
            currVC = v;
            Rootvc = v.presentedViewController;
            continue;
        }else if([Rootvc isKindOfClass:[UITabBarController class]]){
            UITabBarController * tabVC = (UITabBarController *)Rootvc;
            currVC = tabVC;
            Rootvc = [tabVC.viewControllers objectAtIndex:tabVC.selectedIndex];
            continue;
        }
    } while (Rootvc!=nil);
    
    return currVC;
}

/**
 * 按下组件变淡
 */
+ (void)touchEnable:(id)target completion:(void(^)(void))completion
{
    UIView *view = (UIView *)target;
    [UIView animateWithDuration:0.2 animations:^{
        view.alpha = 0.5;
    } completion:^(BOOL finished) {
        view.alpha = 1;
        completion();
    }];
    
}

/**
 * toast提示 需要引用Toast.h
 */
+ (void)toastWithMsg:(NSString *)msg
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
    style.messageFont = [UIFont systemFontOfSize:18.0f];
    [window makeToast:msg duration:2.0 position:CSToastPositionCenter style:style];
}


/**
 文字渐变色
 */
+ (UILabel *)gradientLabel:(UILabel *)label superView:(UIView *)superView colors:(NSArray *)colors{
    
    CAGradientLayer* gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = label.frame;
    gradientLayer.colors = colors;
    gradientLayer.startPoint = CGPointMake(0, 1);
    gradientLayer.endPoint = CGPointMake(1, 1);
    [superView.layer addSublayer:gradientLayer];
    
    gradientLayer.mask = label.layer;
    label.frame = gradientLayer.bounds;
    
    return label;
}

/**
 按钮渐变色
 */
+ (UIButton *)gradientBtn:(UIButton *)btn colors:(NSArray *)colors
{
    UIView *view = [[UIView alloc] initWithFrame:btn.frame];
    [view.layer addSublayer:[ETSystemTool setGradualChangingColor:view direction:GradualDirectionSlant colors:colors]];
    UIImage *img = [ETSystemTool convertViewToImage:view];
    [btn setBackgroundImage:img forState:UIControlStateNormal];
    
    return btn;
}


/**
 16进制颜色
 */
+ (UIColor *)colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}


/**
 生成渐变色view
 */
+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view direction:(GradualDirection)direction colors:(NSArray *)colors{
    //    CAGradientLayer类对其绘制渐变背景颜色、填充层的形状(包括圆角)
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = view.bounds;
    //  创建渐变色数组，需要转换为CGColor颜色
    gradientLayer.colors = colors;
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    if (direction == GradualDirectionHorizontal) {
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 0);
    }else if (direction == GradualDirectionVertical){
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(0, 1);
    }else{
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 1);
    }

    //  设置颜色变化点，取值范围 0.0~1.0
    gradientLayer.locations = @[@0,@1];
    return gradientLayer;
}

/**
 UIView转UIImage
 */
+ (UIImage*)convertViewToImage:(UIView*)v{
    CGSize s = v.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [v.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/**
 时间戳转到日期
 */
+ (NSString *)converTimeStampToDate:(id)time
{
    NSString *string = [time description];
    NSTimeInterval second = string.longLongValue / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:second];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *timeStr = [fmt stringFromDate:date];
    
    return timeStr;
}

@end
