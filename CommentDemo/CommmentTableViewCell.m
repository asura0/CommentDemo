//
//  CommmentTableViewCell.m
//  CommentDemo
//
//  Created by 123 on 16/6/28.
//  Copyright © 2016年 asura. All rights reserved.
//

#import "CommmentTableViewCell.h"
#import "UIView+EXTENSION.h"


@interface CommmentTableViewCell ()
{
    UIImageView *_imagView;
    UILabel *_nameLable;
    UILabel *_timeLabel;
    UILabel *_contentLabel;
}

/** 存放评论lable 高度的数组 **/
@property (nonatomic, strong) NSMutableArray *replayLabelHeights;
/** 存放评论lable文本的数组 **/
@property (nonatomic, strong) NSMutableArray *replayLabelTexts;

@end

@implementation CommmentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self confguireSubViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)confguireSubViews{
    
        //头像
    _imagView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 40, 40)];
    _imagView.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:_imagView];
    
    
        //姓名
    _nameLable = [[UILabel alloc] initWithFrame:CGRectMake(50, 8, 200, 25)];
    [self.contentView addSubview:_nameLable];
    
    
        //时间
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 33, 200 ,20)];
    _timeLabel.textColor = [UIColor lightGrayColor];
    _timeLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_timeLabel];
    
    _contentLabel  = [[UILabel alloc] initWithFrame:CGRectMake(83, 51, SCREENWIDTH - 83 - 20, 0)];
    [self.contentView addSubview:_contentLabel];
    _contentLabel.font = [UIFont systemFontOfSize:16];

}

- (void (^)(CommentModel *))assignment{
    return ^ (CommentModel *commentModel){
            //姓名
        _nameLable.text = commentModel.FromNickname;
        
            //时间
        _timeLabel.text = commentModel.CreateDateStr;
        
        //内容
        _contentLabel.numberOfLines = 0;
        _contentLabel.height = commentModel.contentHeight;
        _contentLabel.text = commentModel.Content;
        
        //如果是没回复的,返回
        if (commentModel.Replay == nil) {
            return ;
        }
            //存放评论lable 高度的数组
        _replayLabelHeights = [NSMutableArray array];
        _replayLabelTexts = [NSMutableArray array];
        
        
            //回复
        [commentModel.Replay enumerateObjectsUsingBlock:^(ReplayModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            ReplayModel *replayModel = obj;
                //分割数据.收集评论lable的高度和文本
            [_replayLabelHeights addObject:[replayModel.Content componentsSeparatedByString:@"#"].firstObject];
            
            NSString *textStr = @"";
            int i = 0;
            
            for (NSString *text in [replayModel.Content componentsSeparatedByString:@"#"]) {
                i ++;

                if (i == 1) {
                    continue;
                }
                
               textStr = [textStr stringByAppendingString:text];
            }
            [_replayLabelTexts addObject:textStr];
        }];
        
        //判断移除动态添加的 replylabel, 防止重用出错
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:NSClassFromString(@"UITableViewCellContentView")]) {
                for (UIView *subView in view.subviews) {
                    if ([subView isKindOfClass:[UILabel class]] && (subView != _nameLable && subView != _timeLabel && subView != _contentLabel)) {
                        [subView removeFromSuperview];
                    }
                }
            }
        }
        
            //动态添加回复 label
        for (int i = 0; i < _replayLabelHeights.count; i ++) {
            
            CGFloat height = [self addHeightWithI:i - 1];
            UILabel *replyLabel = [[UILabel alloc] initWithFrame:CGRectMake(76, _contentLabel.bottomY + height, SCREENWIDTH - 80, [_replayLabelHeights[i] floatValue])];
            replyLabel.numberOfLines = 0;
            replyLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
            replyLabel.layer.borderWidth = 1;
            replyLabel.backgroundColor = [UIColor colorWithRed:200 / 255.0 green:205 / 255.0 blue:246 / 255.0 alpha:1];
            replyLabel.font = [UIFont systemFontOfSize:16];
            replyLabel.text = _replayLabelTexts[i];
            [self.contentView addSubview:replyLabel];
        }
    };

}

- (CGFloat)addHeightWithI:(int)i{
    __block CGFloat height = 0;
    
        //第一行直接返回,不取值
    if (i < 0) {
        return height;
    }
    
    [_replayLabelHeights enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        height += [obj floatValue];
        height += 8;
        
            //取到对应行后返回值
        if (idx == i) {
            *stop = YES;
        }
    }];
    return height;
}

@end
