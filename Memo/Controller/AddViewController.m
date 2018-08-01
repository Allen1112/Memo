//
//  AddViewController.m
//  Memo
//
//  Created by Allen on 2014/3/31.
//  Copyright © 2014年 Allen. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()<UITextViewDelegate>

@property (nonatomic,assign) NSInteger noteIdentifier;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.textView];
    
    NSNumber *defaultID = [[NSUserDefaults standardUserDefaults] objectForKey:@"noteIdentifier"];
    _noteIdentifier = [defaultID integerValue] + 1;
}
//添加数据完成
- (void)rightClick{
    if ([self.textView.text length] > 0) {
        Model *model = [Model modelWithNoteId:_noteIdentifier noteContent:self.textView.text noteTime:[self getCurrentTime]];
        BOOL isIsert = [DatabaseManager insertData:model];
        if (isIsert) {
            NSLog(@"插入数据成功");
            NSNumber *noteIdentifier = [NSNumber numberWithInteger:_noteIdentifier];
            [[NSUserDefaults standardUserDefaults] setValue:noteIdentifier forKey:@"noteIdentifier"];
        } else {
            NSLog(@"插入数据失败");
        }
        [self.navigationController popViewControllerAnimated:YES];
    } else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"还没有输入信息" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"取消");
        }];
        UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"确认");
        }];
        [alert addAction:cancel];
        [alert addAction:confirm];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    self.rightItem.title = @"完成";
    self.navigationItem.rightBarButtonItem = self.rightItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
