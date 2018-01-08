//
//  KXAccountRecordView.h
//  KXAccountRecord
//
//  Created by apple on 2018/1/8.
//  Copyright © 2018年 KX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KXSaveUserView;
@protocol KXAccountRecordViewDelegate <NSObject>
@optional

//提示 以下2个方法最好调用的时候 只使用其中一个
/**
 获取当前记录的账号
 @param account  账号
 */
- (void)selectedAccount:(NSString *)account;

/**
 获取当前记录的账号与密码
 @param account 账号
 @param password 密码
 */
- (void)selectedAccount:(NSString *)account password:(NSString*)password;
@end


@interface KXAccountRecordView : UIView
@property (nonatomic, weak  )  id<KXAccountRecordViewDelegate> delegete;
@end
