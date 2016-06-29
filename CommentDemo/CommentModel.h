//
//  CommentModel.h
//  CommentDemo
//
//  Created by 123 on 16/6/28.
//  Copyright © 2016年 asura. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width

@interface ReplayModel : NSObject

/** 评论方式 **/
@property (nonatomic, copy) NSString *CommentType;
/** 评论内容 **/
@property (nonatomic, copy) NSString *Content;
/** 来自评论者的 id **/
@property (nonatomic, strong) NSNumber *FromMemberId;

@property (nonatomic, strong) NSNumber *Id;
/** 被评论者的 id **/
@property (nonatomic, strong) NSNumber *ToMemberId;
/** 被评论者发表的任务 id **/
@property (nonatomic, strong) NSNumber *ToTaskId;


@end

@interface CommentModel : NSObject

/** 评论方式 **/
@property (nonatomic, copy) NSString *CommentType;
/** 内容 **/
@property (nonatomic, copy) NSString *Content;
/** 创建时间 **/
@property (nonatomic, copy) NSString *CreateDateStr;
/** 来自评论者的名称 **/
@property (nonatomic, copy) NSString *FromNickname;
/** 来自评论者的头像 **/
@property (nonatomic, copy) NSString *FromHeadImage;
/** 来自评论者的id **/
@property (nonatomic, strong) NSNumber *FromMemberId;

@property (nonatomic, strong) NSNumber *Id;
/** 回复 **/
@property (nonatomic, strong) NSArray <ReplayModel *> *Replay;


/** 内容高度 **/
@property (nonatomic, assign) CGFloat contentHeight;

@end

