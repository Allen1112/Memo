//
//  EditViewController.m
//  Memo
//
//  Created by Allen on 2014/3/31.
//  Copyright © 2014年 Allen. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController ()



@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.textView];
}

- (void)setModel:(Model *)model{
    if (_model != model) {
        _model = model;
    }
    self.textView.text = model.noteContent;
}

- (void)textViewDidChange:(UITextView *)textView{
    self.rightItem.title = @"完成";
    self.navigationItem.rightBarButtonItem = self.rightItem;
}

- (void)rightClick{
    _model.noteContent = self.textView.text;
    _model.noteTime = [self getCurrentTime];
    [DatabaseManager modifyData:_model];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
