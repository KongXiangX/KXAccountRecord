//
//  ViewController.m
//  KXAccountRecord
//
//  Created by apple on 2018/1/8.
//  Copyright © 2018年 KX. All rights reserved.
//

#import "ViewController.h"
#import "KXAccountRecordView.h"      //记录列表
#import "KXAccountRecordConst.h"     //宏定义
#import "KXAcountRecordManager.h"    //账号 数据 处理


@interface ViewController ()<KXAccountRecordViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *accountTF;  //账号
@property (weak, nonatomic) IBOutlet UITextField *passWordTF; //密码
@property (weak, nonatomic) IBOutlet UIButton *listBtn;       //列表 按钮
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;      //登录 按钮

//记录列表
@property (nonatomic, strong) KXAccountRecordView * accountRecordView;
@end

@implementation ViewController

#pragma mark - 1.登录按钮点击事件
- (IBAction)loginBtnClick:(id)sender {
    //1.
    if (self.accountTF.text.length <= 2) {
        NSLog(@"账号   需要输入至少3个");
        return;
    }
    
    if (self.passWordTF.text.length <= 2) {
        NSLog(@"密码   需要输入至少3个");
        return;
    }
    
    
    //2.存储
    [KXAcountRecordManager savePassword:self.passWordTF.text account:self.accountTF.text];
    
    
    
    //3.提示
    UIAlertController * alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"登录成功" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        self.listBtn.selected = NO;
        [self.listBtn setImage:[UIImage imageNamed:@"LoginVC_listBtn_up"] forState:UIControlStateNormal];
        
        [self removeAccountRecordView];
    }];
    
    [alertC addAction:action2];
    [self presentViewController:alertC animated:YES completion:nil];
}
#pragma mark - 2.箭头列表按钮 点击事件
- (IBAction)listBtnClick:(UIButton *)sender {
    //1.展开-->关闭
    if (sender.selected == YES) {
        sender.selected = NO;

        [self setupHiddenaccountRecordView:YES];

    }else{
        //2.关闭-->展开
        sender.selected = YES;
        
        //2.1 初始化KXaccountRecordView
        [self.view addSubview:self.accountRecordView];
    
        [self setupHiddenaccountRecordView:NO];
    }

}

//隐藏 与 显示动画
-(void)setupHiddenaccountRecordView:(BOOL)hidden
{
 
    [UIView animateWithDuration:0.5f animations:^{
        if (hidden == NO) {
            //1.关闭-->展开
            self.listBtn.transform = CGAffineTransformMakeRotation(M_PI);
        }else{
            //2.展开-->关闭
            self.listBtn.transform = CGAffineTransformIdentity;
        }
        
        CATransition *animation = [CATransition animation];
        animation.type = kCATransitionFade;
        animation.duration = 0.4;
        [self.accountRecordView.layer addAnimation:animation forKey:nil];
        self.accountRecordView.hidden = hidden;
    } completion:nil];
 
}

- (KXAccountRecordView *)accountRecordView
{
    if (!_accountRecordView) {
        NSArray * arr = [KXAcountRecordManager getAllAccounts];
        if (arr.count != 0) {
            
            CGFloat accountRecordViewH;
            if (arr.count >=KXAccountRecordMaxShowCount) {
                accountRecordViewH = KXAccountRecordMaxShowCount*KXAccountRecordCellHeight;
            }else{
                accountRecordViewH = arr.count * KXAccountRecordCellHeight;
            }
            
            _accountRecordView = [[KXAccountRecordView alloc] initWithFrame:CGRectMake(self.accountTF.x, self.accountTF.y + self.accountTF.height + 5, self.accountTF.width, accountRecordViewH)];
            _accountRecordView.delegete = self;
        }
    }
    return _accountRecordView;
}


#pragma mark -- 2.1 KXaccountRecordViewDelegate
//(以下2个方法最好 只是用一个)
//- (void)selectedAccount:(NSString *)account;
//
//- (void)selectedAccount:(NSString *)account password:(NSString*)password;

- (void)selectedAccount:(NSString *)account
{
    self.accountTF.text = account;
    
    self.listBtn.selected = NO;
    [self removeAccountRecordView];
    [self setupHiddenaccountRecordView:YES];
}


//- (void)selectedAccount:(NSString *)account password:(NSString *)password
//{
//    self.accountTF.text = account;
//    self.passWordTF.text = password;
//    self.listBtn.selected = NO;
//    [self removeAccountRecordView];
//    [self setupHiddenaccountRecordView:YES];
//
//}

#pragma mark - 移除视图
- (void)removeAccountRecordView
{
    [self.accountRecordView removeFromSuperview];
    self.accountRecordView = nil;
}

#pragma mark - 隐藏键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.listBtn.selected = YES;
    [self listBtnClick:self.listBtn];
    
    [self.accountTF resignFirstResponder];
    [self.passWordTF resignFirstResponder];
}



@end
