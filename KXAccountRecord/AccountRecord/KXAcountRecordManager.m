//
//  KXAcountRecordManager.m
//  KXAccountRecord
//
//  Created by apple on 2018/1/8.
//  Copyright © 2018年 KX. All rights reserved.
//

#import "KXAcountRecordManager.h"
#import <CommonCrypto/CommonDigest.h>

#import "KXAccountRecordConst.h"
//第三方加密
// CocoaSecurity :  https://github.com/mokey1422/GBEncodeTool

@implementation KXAcountRecordManager
#pragma mark - 1.储存数据

/**
 保存 密码（NSString类型）与 账号
 
 @param password 密码
 @param account 账号
 */
+ (void)savePassword:(NSString *)password account:(NSString *)account
{
    
    NSDictionary * dic = @{KXAccountRecord_accout : account,
                           KXAccountRecord_password : password};
    
    
    NSArray * arr = [KXSaveDefaults objectForKey:KXAccountRecordArr];
    NSMutableArray * recordArr = [NSMutableArray arrayWithCapacity:1];
    [recordArr addObjectsFromArray:arr];
    
    
    
    //是否包含
    BOOL  isContain = NO;
    //判定用户名是否相同
    if (arr.count == 0) {
        
        [recordArr addObject:dic];
        NSArray * arr = recordArr;
        [KXSaveDefaults setObject:arr forKey:KXAccountRecordArr];
        [KXSaveDefaults synchronize];
        
    }else{
        for (int i = 0; i < recordArr.count; i++) {
            NSDictionary * dic = recordArr[i];
            NSString * accountStr = dic[KXAccountRecord_accout];
            
            //如果不包含 当前的名字 保存
            if ([account isEqualToString:accountStr]) {
                //为了他们的排序
                [recordArr removeObjectAtIndex:i];
                
                
                [recordArr insertObject:dic atIndex:0];
                NSArray * arr = recordArr;
                [KXSaveDefaults setObject:arr forKey:KXAccountRecordArr];
                [KXSaveDefaults synchronize];
                
                isContain = YES;
            }
        }
        
        if (isContain == NO) {
            [recordArr addObject:dic];
            NSArray * arr = recordArr;
            [KXSaveDefaults setObject:arr forKey:KXAccountRecordArr];
            [KXSaveDefaults synchronize];
        }
        
    }
}




#pragma mark - 2.获取数据

/**
 获取指定账号的 密码
 
 @param account 指定账号
 @return 密码 (NSString)
 */
+ (NSString *)getPasswordForAccount:(NSString *)account
{
    
    NSString * pasawordStr = @"未找到密码";
    
    //1.
    NSArray * arr = [KXSaveDefaults objectForKey:KXAccountRecordArr];
    
    for (int i = 0; i < arr.count; i++) {
        NSDictionary * dic = arr[i];
        
        NSString * accountStr = dic[KXAccountRecord_accout];
        
        if ([accountStr isEqualToString:account]) {
            pasawordStr = dic[KXAccountRecord_password];
        }
    }
    
    return pasawordStr;
}

#pragma mark - 3.删除数据

/**
 删除 指定账号的数据
 @param account 账号
 @return 是否删除成功
 */
+ (BOOL)deletePasswordForAccount:(NSString *)account
{
    BOOL tem = NO;
    
    NSArray * arr = [KXSaveDefaults objectForKey:KXAccountRecordArr];
    NSMutableArray * mutaArr = [NSMutableArray arrayWithArray:arr];
    
    for (int i = 0; i < arr.count; i++) {
        NSDictionary * dic = arr[i];
        
        NSString * accountStr = dic[KXAccountRecord_accout];
        
        if ([accountStr isEqualToString:account]) {
            [mutaArr removeObject:dic];
            NSArray * temArr= mutaArr;
            [KXSaveDefaults setObject:temArr forKey:KXAccountRecordArr];
            [KXSaveDefaults synchronize];
            tem = YES;
        }
    }
    
    
    if (tem == NO) {
        NSLog(@"删除  账号:%@失败。\n（deletePasswordForAccount:）",account);
    }
    return tem;
}

#pragma mark - 4. 获取所有帐号信息
/**
 所有账号的数据
 @return  所有账号的数据
 */
+ (NSArray<NSDictionary<NSString *, id> *> *)getAllAccounts
{
    
    NSArray * arr = [KXSaveDefaults objectForKey:KXAccountRecordArr];
    
    NSMutableArray * mutableArr = [NSMutableArray arrayWithCapacity:1];
    for (int i = 0; i < arr.count; i++) {
        NSDictionary * dic = arr[i];
        NSString * accountStr = dic[KXAccountRecord_accout];
        [mutableArr addObject:accountStr];
    }
    NSArray * accountArr = mutableArr;
    return accountArr;
}




#pragma mark - 32位 大写
+(NSString *)MD5ForUpper32Bate:(NSString *)str{
    
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02X", result[i]];
    }
    
    return digest;
}



+ (NSString *)md5AgainString:(NSString *)str
{
    NSString * aa = [self MD5ForUpper32Bate:str];
    int bb = arc4random() % 10;
    NSString * numStr = [NSString stringWithFormat:@"%d", bb];
    
    NSMutableString* str1=[[NSMutableString alloc]initWithString:aa];//存在堆区，可变字符串
    
    [str1 insertString:numStr atIndex:2];
    
    NSString * str2 = [self MD5ForUpper32Bate:str1];
    
    NSLog(@"aa::%@  num:  %@    str1: %@   str2:%@",aa,numStr,str1,str2);
    return str2;
    
}



@end
