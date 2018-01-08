# KXAccountRecord
KXAccountRecord-账号记录管理
## KXAccountRecord -- NSUserDefaults (未加密)
* 基本结构
    * KXAccountRecordCell   ---cell   显示具体的账号 与 删除 按钮
    * KXAccountRecordView   ---View   承载KXAccountRecordCell 所在的 UITableView
    * KXAcountRecordManager ---Modle  有关账号数据的 增加（保存）与删除
    * KXAccountRecordConst  ---       使用到的 宏定义   
   
````objc
//列表的每个cell 的高度
#define KXAccountRecordCellHeight  35.0
//最大能记录 的账号个数（KXAccountRecordMaxCount > KXAccountRecordMaxShowCount）
//#define KXAccountRecordMaxCount  10
//KXAccountRecordView  一次性最多显示 的账号个数
#define KXAccountRecordMaxShowCount  4
````
      
## 截图
![(账号列表)](https://github.com/KongXiangX/KXAccountRecord/blob/master/KXAccountRecord/账号列表.png)

## 注意 
````objc
#pragma mark -- 2.1 KXaccountRecordViewDelegate
//(以下2个方法最好 只是用一个)
- (void)selectedAccount:(NSString *)account;

- (void)selectedAccount:(NSString *)account password:(NSString*)password;


````
