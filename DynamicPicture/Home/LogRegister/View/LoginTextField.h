//
//  LoginTextField.h
//  Jest
//
//  Created by 段振伟 on 16/4/19.
//  Copyright © 2016年 段振伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginTextField : UITextField
- (BOOL)validatePhone:(NSString *)phone;
- (BOOL)validatePassword:(NSString *)password;
- (BOOL)checkPassword:(NSString *) password;
@end
