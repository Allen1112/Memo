//
//  DatabaseManager.m
//  Memo
//
//  Created by Allen on 2014/3/31.
//  Copyright © 2014年 Allen. All rights reserved.
//

#import "DatabaseManager.h"
#import "FMDB.h"

static FMDatabase *_fmdb;

@implementation DatabaseManager

+ (void)initialize{
    
    _fmdb = [FMDatabase databaseWithPath:[DatabaseManager getdocumentPath]];
    
    [_fmdb open];
    [_fmdb executeUpdate:@"create table if not exists memo_table(id integer primary key,noteContent text not NULL,noteId integer not NULL,noteTime text not NULL);"];
    [_fmdb close];
}

+ (NSString *)getdocumentPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentDirectory stringByAppendingString:@"memo.db"];
    NSLog(@"path = %@",filePath);
    return filePath;
}

+ (BOOL)insertData:(Model *)dataModel{
    [_fmdb open];
    BOOL isSuccess = [_fmdb executeUpdate:@"insert into memo_table(noteId,noteContent,noteTime) values(?,?,?)",[NSString stringWithFormat:@"%ld",dataModel.noteId],[NSString stringWithFormat:@"%@",dataModel.noteContent],[NSString stringWithFormat:@"%@",dataModel.noteTime]];
    [_fmdb close];
    if (isSuccess) {
        return YES;
    } else{
        return NO;
    }
}

+ (BOOL)deleteData:(Model *)dataModel{
    [_fmdb open];
    BOOL isSuccess = [_fmdb executeUpdate:@"delete from memo_table where noteId = ?",[NSString stringWithFormat:@"%ld",dataModel.noteId]];
    [_fmdb close];
    if (isSuccess) {
        return YES;
    } else{
        return NO;
    }
}

+ (BOOL)modifyData:(Model *)dataModel{
    [_fmdb open];
    BOOL isSuccess = [_fmdb executeUpdate:@"update memo_table set noteContent = ?,noteTime = ? where noteId = ?",[NSString stringWithFormat:@"%@",dataModel.noteContent],[NSString stringWithFormat:@"%@",dataModel.noteTime],[NSString stringWithFormat:@"%ld",dataModel.noteId]];
    [_fmdb close];
    if (isSuccess) {
        return YES;
    } else{
        return NO;
    }
}

+ (NSArray *)queryData:(NSString *)querySql{
    if (querySql == nil) {
        querySql = @"select * from memo_table";
    }
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    [_fmdb open];
    FMResultSet *set = [_fmdb executeQuery:querySql];
    while ([set next]) {
        NSString *noteId = [set stringForColumn:@"noteId"];
        NSString *noteContent = [set stringForColumn:@"noteContent"];
        NSString *noteTime = [set stringForColumn:@"noteTime"];
        Model *model = [Model modelWithNoteId:[noteId integerValue] noteContent:noteContent noteTime:noteTime];
        [array addObject:model];
    }
    [_fmdb close];
    return array;
}


- (void)multithread{
    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:[DatabaseManager getdocumentPath]];
    dispatch_queue_t q1 = dispatch_queue_create("queue1", NULL);
    dispatch_queue_t q2 = dispatch_queue_create("queue2", NULL);
    
    dispatch_async(q1, ^{
        for (int i = 0; i < 100; ++i) {
            [queue inDatabase:^(FMDatabase *db) {
                NSString * sql = @"insert into user (name, password) values(?, ?) ";
                NSString * name = [NSString stringWithFormat:@"queue111 %d", i];
                BOOL res = [db executeUpdate:sql, name, @"boy"];
                if (!res) {
                    NSLog(@"error to add db data: %@", name);
                } else {
                    NSLog(@"succ to add db data: %@", name);
                }
            }];
        }
    });
    
    dispatch_async(q2, ^{
        for (int i = 0; i < 100; ++i) {
            [queue inDatabase:^(FMDatabase *db) {
                NSString * sql = @"insert into user (name, password) values(?, ?) ";
                NSString * name = [NSString stringWithFormat:@"queue222 %d", i];
                BOOL res = [db executeUpdate:sql, name, @"boy"];
                if (!res) {
                    NSLog(@"error to add db data: %@", name);
                } else {
                    NSLog(@"succ to add db data: %@", name);
                }
            }];
        }
    });
}


@end
