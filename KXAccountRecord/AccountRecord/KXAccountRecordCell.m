//
//  KXAccountRecordCell.m
//  KXAccountRecord
//
//  Created by apple on 2018/1/8.
//  Copyright © 2018年 KX. All rights reserved.
//

#import "KXAccountRecordCell.h"
#import "KXAccountRecordConst.h"

@interface KXAccountRecordCell ()
@property (nonatomic, strong) UIButton * delBtn;     //删除按钮
@property (nonatomic, strong) UIImageView * barImg;  //分割线

@end


@implementation KXAccountRecordCell
#pragma mark - 0. 初始化 子控件
+ (instancetype)accountRecordCellWithTableView:(UITableView *)tableView
{
    static NSString * KXAccountRecordCellID = @"KXAccountRecordCellID";
    KXAccountRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:KXAccountRecordCellID];
    if (cell == nil) {
        cell = [[KXAccountRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:KXAccountRecordCellID];
    }
    return cell;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //1. 账号 lab
        [self setupAccountLab];
        
        //2.删除按钮
        [self setupDelBtn];
        
        //3.分割线
        [self setupBarImg];
        
        
    }
    return self;
}



#pragma mark - 1. 账号 lab
- (void)setupAccountLab
{
    UILabel * accountLab = [[UILabel alloc] init];
    accountLab.font = [UIFont systemFontOfSize:15];
    accountLab.textColor = [UIColor whiteColor];
    accountLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:accountLab];
    self.accountLab = accountLab;
    
}


#pragma mark - 2.删除按钮
- (void)setupDelBtn
{
    UIButton * delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [delBtn setImage:[UIImage imageNamed:@"LoginVC_listBtn_del"] forState:UIControlStateNormal];
    
    [delBtn addTarget:self action:@selector(delBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:delBtn];
    self.delBtn = delBtn;
}
- (void)delBtnClick
{
    if ([self.delegate respondsToSelector:@selector(tapAccountRecordCellDelBtn:)]) {
        [self.delegate tapAccountRecordCellDelBtn:self.path];
    }
    
}

#pragma mark - 3.分割线
- (void)setupBarImg
{
    UIImageView * barImg = [[UIImageView alloc] init];
    barImg.image = [UIImage imageNamed:@"Cell_barImg"];
    barImg.backgroundColor = [UIColor whiteColor];
    [self addSubview:barImg];
    self.barImg = barImg;
    
}

#pragma mark - 4. 布局 cell 的子控件位置
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat delBtnW = self.height - 10;
    //1.账号
    self.accountLab.frame = CGRectMake(0, 0, self.width - self.height, self.height);
    
    
    //2.删除按钮
    self.delBtn.frame = CGRectMake(self.width - self.height, (self.height - delBtnW)*0.5, delBtnW, delBtnW);
    
    //3.分割线
    self.barImg.frame = CGRectMake(0, self.height - 1.0, self.width, 1.0);
    
    
}


#pragma mark - 5. 解析 数据
- (void)setPath:(NSIndexPath *)path
{
    _path = path;
}




@end
