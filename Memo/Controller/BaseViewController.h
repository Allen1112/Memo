//
//  BaseViewController.h
//  Memo
//
//  Created by Allen on 2014/3/31.
//  Copyright © 2014年 Allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseManager.h"
#import "Model.h"

#define kWidth     [UIScreen mainScreen].bounds.size.width
#define kHeight    [UIScreen mainScreen].bounds.size.height
#define NSLog(format, ...) NSLog((@"%s" "[Line:%d]" format),__FUNCTION__, __LINE__, ##__VA_ARGS__);

@interface BaseViewController : UIViewController<UITextViewDelegate>

@property (nonatomic,strong) UIBarButtonItem *rightItem;

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) UITextView *textView;

- (void)hiddenExtralLine:(UITableView *)tableView;

- (void)tableView:(UITableView *)tableView rowCount:(NSInteger)rowCount backgrountMsg:(NSString *)message;

- (NSString *)getCurrentTime;

@end
