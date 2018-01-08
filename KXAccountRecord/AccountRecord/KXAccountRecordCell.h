//
//  KXAccountRecordCell.h
//  KXAccountRecord
//
//  Created by apple on 2018/1/8.
//  Copyright © 2018年 KX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KXSaveUserCell;
@protocol KXAccountRecordCellDelegate <NSObject>
@optional

/**
 删除按钮点击事件  的监听
 */
-(void)tapAccountRecordCellDelBtn:(NSIndexPath *)path;
@end




@interface KXAccountRecordCell : UITableViewCell
@property (nonatomic, weak  ) id<KXAccountRecordCellDelegate> delegate;
@property (nonatomic, strong) NSIndexPath * path;      //cell 所在位置
@property (nonatomic, strong) UILabel * accountLab;    //账号lab
/**
 初始化 AccountRecordCell
 
 @param tableView cell所在的tableView
 @return KXAccountRecordCell
 */
+ (instancetype)accountRecordCellWithTableView:(UITableView *)tableView;
@end
