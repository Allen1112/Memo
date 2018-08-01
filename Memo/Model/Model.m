//
//  Model.m
//  Memo
//
//  Created by Allen on 2014/3/31.
//  Copyright © 2014年 Allen. All rights reserved.
//

#import "Model.h"

@implementation Model

+ (instancetype)modelWithNoteId:(NSInteger)noteId noteContent:(NSString *)noteContent noteTime:(NSString *)noteTime{
    Model *model = [Model new];
    model.noteId = noteId;
    model.noteContent = noteContent;
    model.noteTime = noteTime;
    return model;
}

@end
