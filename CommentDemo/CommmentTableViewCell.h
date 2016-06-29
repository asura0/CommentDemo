//
//  CommmentTableViewCell.h
//  CommentDemo
//
//  Created by 123 on 16/6/28.
//  Copyright © 2016年 asura. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"

@interface CommmentTableViewCell : UITableViewCell

- (void (^)(CommentModel *))assignment;

@end
