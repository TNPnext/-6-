//
//  LoginTextField.m
//  Jest
//
//  Created by 段振伟 on 16/4/19.
//  Copyright © 2016年 段振伟. All rights reserved.
//

#import "LoginTextField.h"

@implementation LoginTextField
- (BOOL)validatePhone:(NSString *)phone {
     NSString *phoneRegex = @"1[3|5|7|8|][0-9]{9}";
     NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
     return [phoneTest evaluateWithObject:phone];
}
- (BOOL)validatePassword:(NSString *)password {
//    NSString *passwordRegex = @"1[3|5|7|8|][0-9]{9}";
    NSString *passwordRegex = @"(?=^.{6,15}$)(?=.*\\d)(?=.*\\W+)(?=.*[A-Z])(?=.*[a-z])(?!.*\n).*$";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegex];
    return [passwordTest evaluateWithObject:password];
}
- (BOOL)checkPassword:(NSString *) password{
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,15}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
}
//控制左视图位置
- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(5, 4, (31.0/34.0)*21, 21);
    return inset;
}

//控制编辑文本的位置
-(CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(40, bounds.origin.y, bounds.size.width - 40, bounds.size.height);
    return inset;
}

//控制显示文本的位置
-(CGRect)textRectForBounds:(CGRect)bounds
{
    //return CGRectInset(bounds, 50, 0);
    CGRect inset = CGRectMake(bounds.origin.x + 40, bounds.origin.y, bounds.size.width - 40, bounds.size.height);//更好理解些
    
    return inset;
    
}
//控制placeHolder的位置，左右缩20
-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    
    //return CGRectInset(bounds, 20, 0);
    CGRect inset = CGRectMake(bounds.origin.x + 40, bounds.origin.y, bounds.size.width - 10, bounds.size.height);//更好理解些
    return inset;
}

@end
