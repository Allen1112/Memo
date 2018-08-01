//
//  MemoCell.m
//  Memo
//
//  Created by Allen on 2014/3/31.
//  Copyright © 2014年 Allen. All rights reserved.
//

#import "MemoCell.h"

#define kWidth     [UIScreen mainScreen].bounds.size.width
#define kHeight    [UIScreen mainScreen].bounds.size.height


@interface MemoCell()

@property (nonatomic,strong) UILabel *title;
@property (nonatomic,strong) UILabel *time;

@end

@implementation MemoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.time];
        [self.contentView addSubview:self.title];
    }
    return self;
}


- (void)setModel:(Model *)model{
    _time.text = model.noteTime;
    _title.text = model.noteContent;
}

- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, kWidth - 20, 17)];
        _title.font = [UIFont systemFontOfSize:15];
        _title.textColor = [UIColor blackColor];
    }
    return _title;
}

- (UILabel *)time{
    if (!_time) {
        _time = [[UILabel alloc] initWithFrame:CGRectMake(10, 32, kWidth - 20, 17)];
        _time.font = [UIFont systemFontOfSize:13];
        _time.textColor = [UIColor orangeColor];
    }
    return _time;
}

@end
