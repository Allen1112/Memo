//
//  DatabaseManager.h
//  Memo
//
//  Created by Allen on 2014/3/31.
//  Copyright © 2014年 Allen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"

#define NSLog(format, ...) NSLog((@"%s" "[Line:%d]" format),__FUNCTION__, __LINE__, ##__VA_ARGS__);

@interface DatabaseManager : NSObject

//插入数据
+ (BOOL)insertData:(Model *)dataModel;
//删除数据
+ (BOOL)deleteData:(Model *)dataModel;
//修改数据
+ (BOOL)modifyData:(Model *)dataModel;
//查询数据
+ (NSArray *)queryData:(NSString *)querySql;


@end
