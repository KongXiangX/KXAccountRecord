//
//  KXAccountRecordView.m
//  KXAccountRecord
//
//  Created by apple on 2018/1/8.
//  Copyright © 2018年 KX. All rights reserved.
//

#import "KXAccountRecordView.h"
#import "KXAccountRecordCell.h"         //cell
#import "KXAccountRecordConst.h"        //const
#import "KXAcountRecordManager.h"       //manager


@interface KXAccountRecordView ()<UITableViewDelegate,UITableViewDataSource,KXAccountRecordCellDelegate>
@property (nonatomic, strong) UITableView * tableView;
@end


@implementation KXAccountRecordView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //0.
        self.backgroundColor = [UIColor clearColor];
        
        //1.列表
        UITableView * table = [[UITableView alloc] init];
        table.rowHeight = KXAccountRecordCellHeight;
        table.separatorStyle =  UITableViewCellSeparatorStyleNone;
        table.delegate = self;
        table.dataSource = self;
        [self addSubview:table];
        self.tableView = table;
        
    }
    return self;
}

#pragma mark - UITableViewDelegate/DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([KXAcountRecordManager getAllAccounts] == nil || [KXAcountRecordManager getAllAccounts].count == 0) {
        
        return 0;
    }else{
        
        NSArray * arr = [KXAcountRecordManager getAllAccounts];
        return arr.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KXAccountRecordCell * cell = [KXAccountRecordCell accountRecordCellWithTableView:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.path = indexPath;
    cell.delegate = self;
    cell.backgroundColor = [UIColor lightGrayColor];
    cell.accountLab.text = [self backAcounts][indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //1.只返回账号（实际上 根据 账号循环，也可以 拿到对应账号的密码 ）
    if ([self.delegete respondsToSelector:@selector(selectedAccount:)]) {
 
        NSArray * arr = [KXSaveDefaults objectForKey:KXAccountRecordArr];
        NSDictionary * dic = arr[indexPath.row];
        [self.delegete selectedAccount:dic[KXAccountRecord_accout]];
        
        //重新排序
        [self reorderWithPath:indexPath];
    }
    
    
    //2.返回账号与密码
    if ([self.delegete respondsToSelector:@selector(selectedAccount:password:)]) {
    
        NSArray * arr = [KXSaveDefaults objectForKey:KXAccountRecordArr];
        NSDictionary * dic = arr[indexPath.row];
        [self.delegete selectedAccount:dic[KXAccountRecord_accout] password:dic[KXAccountRecord_password]];
        //重新排序
        [self reorderWithPath:indexPath];
   
    }
  
}

/**
 重新 排序
 */
- (void)reorderWithPath:(NSIndexPath *)indexPath
{
    NSArray * arr = [KXSaveDefaults objectForKey:KXAccountRecordArr];
    NSDictionary * dic = arr[indexPath.row];

    //重新排序
    NSMutableArray * mutaArr = [NSMutableArray arrayWithCapacity:1];
    [mutaArr addObjectsFromArray:arr];
    [mutaArr removeObjectAtIndex:indexPath.row];
    [mutaArr insertObject:dic atIndex:0];
    
    NSArray * arr2 = mutaArr;
    [KXSaveDefaults setObject:arr2 forKey:KXAccountRecordArr];
    [KXSaveDefaults synchronize];
}



#pragma mark - 3.删除
-(void)tapAccountRecordCellDelBtn:(NSIndexPath *)path
{
    
    //1.删除 钥匙扣中的指定数据 并刷新列表
    NSString * delStr = [self backAcounts][path.row];
    [KXAcountRecordManager deletePasswordForAccount:delStr];
    
    [self.tableView reloadData];
    
    
    //2.最多为一次显示 4个cell的长度
    CGFloat popViewH;
    if ([self backAcounts].count >=  KXAccountRecordMaxShowCount) {
        popViewH = KXAccountRecordMaxShowCount*KXAccountRecordCellHeight;
    }else{
        popViewH = [self backAcounts].count * KXAccountRecordCellHeight;
    }
    
    
    self.height =  popViewH;
    self.frame = CGRectMake(self.x, self.y , self.width, popViewH);
    
    
}

#pragma mark - 4.返回所有的账号信息
- (NSArray *)backAcounts
{
    //1.获取所有账号信息
    NSArray * arr = [KXAcountRecordManager getAllAccounts];
    
    return arr;
}

#pragma mark -  布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.tableView.frame = self.bounds;
}

@end
