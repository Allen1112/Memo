//
//  MemoViewController.m
//  Memo
//
//  Created by Allen on 2014/3/31.
//  Copyright © 2014年 Allen. All rights reserved.
//

#import "MemoViewController.h"
#import "MemoCell.h"
#import "AddViewController.h"
#import "EditViewController.h"

@interface MemoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation MemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.rightBarButtonItem = self.rightItem;
    
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initWithData];
}

- (void)initWithData{
    [self.dataArray removeAllObjects];
    NSArray *array = [DatabaseManager queryData:nil];
    [self.dataArray addObjectsFromArray:[[array reverseObjectEnumerator] allObjects]];
    [self.tableView reloadData];
}

- (void)rightClick{
    AddViewController *addVC = [[AddViewController alloc] init];
    [self.navigationController pushViewController:addVC animated:YES];
}



#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    [self tableView:_tableView rowCount:self.dataArray.count backgrountMsg:@"还没有写备忘录"];
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"cell";
    MemoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[MemoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    cell.model = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    EditViewController *editVC = [[EditViewController alloc] init];
    editVC.model = [self.dataArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:editVC animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"删除数据%@",[self.dataArray objectAtIndex:indexPath.row]);
        Model *model = [self.dataArray objectAtIndex:indexPath.row];
        
        if ([DatabaseManager deleteData:model]) {
            [self initWithData];
        }
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

#pragma mark - get方法
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self hiddenExtralLine:_tableView];
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
