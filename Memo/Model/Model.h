//
//  Model.h
//  Memo
//
//  Created by Allen on 2014/3/31.
//  Copyright © 2014年 Allen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

@property (nonatomic,copy) NSString *noteContent;

@property (nonatomic,copy) NSString *noteTime;

@property (nonatomic,assign) NSInteger noteId;


+ (instancetype)modelWithNoteId:(NSInteger)noteId noteContent:(NSString *)noteContent noteTime:(NSString *)noteTime;

@end
