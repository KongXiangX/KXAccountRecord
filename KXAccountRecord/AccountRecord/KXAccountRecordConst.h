#ifdef __OBJC__
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

//1.
//快速获取frame
#import "UIView+Extension.h"
//宏定义 NSDefaults
#define KXSaveDefaults ([NSUserDefaults standardUserDefaults])

//2.
//列表的每个cell 的高度
#define KXAccountRecordCellHeight  35.0
//最大能记录 的账号个数（KXAccountRecordMaxCount > KXAccountRecordMaxShowCount）
//#define KXAccountRecordMaxCount  10
//KXAccountRecordView  一次性最多显示 的账号个数
#define KXAccountRecordMaxShowCount  4


//3.
//记录账号密码  数组
#define KXAccountRecordArr        @"KXAccountRecordArr"
//记录的 账号
#define KXAccountRecord_accout    @"KXAccountRecord_accout"
//记录的 密码
#define KXAccountRecord_password  @"KXAccountRecord_password"


#endif

