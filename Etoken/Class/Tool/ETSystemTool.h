//
//  ETSystemTool.h
//  Etoken
//
//  Created by lingbyAir on 2018/4/19.
//  Copyright © 2018年 eosfans. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ETSystemTool : NSObject

/** MD5加密 */
+ (NSString *)md5:(NSString *)str;

/** 获取当前VC */
+ (UIViewController *)getCurrentVC;

/** 按下组件变淡 */
+ (void)touchEnable:(id)target completion:(void(^)(void))completion;

/** toast提示 需要引用Toast.h */
+ (void)toastWithMsg:(NSString *)msg;

/** 16进制颜色 */
+ (UIColor *)colorWithHexString: (NSString *)color;

/** 文字渐变色 */
+ (UILabel *)gradientLabel:(UILabel *)label superView:(UIView *)superView colors:(NSArray *)colors;

/** 按钮渐变色 */
+ (UIButton *)gradientBtn:(UIButton *)btn colors:(NSArray *)colors;

/** 生成渐变色view */
+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view colors:(NSArray *)colors;

/** UIView转UIImage */
+ (UIImage*)convertViewToImage:(UIView*)v;

/** 时间戳转到日期 */
+ (NSString *)converTimeStampToDate:(id)time;

/** 判断字符串是否全是空格 */
+ (BOOL)isEmptyStr:(NSString *)str;

@end
