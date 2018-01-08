//
//  KXAcountRecordManager.h
//  KXAccountRecord
//
//  Created by apple on 2018/1/8.
//  Copyright © 2018年 KX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KXAcountRecordManager : NSObject
//1.储存数据
//保存 密码(NSString) 与 账号
+ (void)savePassword:(NSString *)password account:(NSString *)account;


//2.获取数据
// 获取指定账号的 密码(NSString)
+ (NSString *)getPasswordForAccount:(NSString *)account;



//3.删除数据
// 删除 指定账号的数据
+ (BOOL)deletePasswordForAccount:(NSString *)account;


//4. 获取所有帐号信息
+ (NSArray<NSDictionary<NSString *, id> *> *)getAllAccounts;
@end
