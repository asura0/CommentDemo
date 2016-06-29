//
//  CommentModel.m
//  CommentDemo
//
//  Created by 123 on 16/6/28.
//  Copyright © 2016年 asura. All rights reserved.
//

#import "CommentModel.h"


@implementation ReplayModel

- (void)setNilValueForKey:(NSString *)key{
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

}

- (void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"Content"]) {
            //计算高度
        CGFloat replyHeight = [[value stringByAppendingString:@"回复: "] boundingRectWithSize:CGSizeMake(SCREENWIDTH - 80, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil].size.height;
            //拼接到数据中
        value = [NSString stringWithFormat:@"%f#回复: %@",replyHeight,value];
        [super setValue:value forKey:key];
    }else{
        [super setValue:value forKey:key];
    }
}

@end

@implementation CommentModel

- (void)setNilValueForKey:(NSString *)key{
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues{
    [super setValuesForKeysWithDictionary:keyedValues];
    
        //计算文本高度
    [keyedValues enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        if ([key isEqualToString:@"Content"]) {
            self.contentHeight =  [obj boundingRectWithSize:CGSizeMake(SCREENWIDTH - 103, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil].size.height;
            
            return ;
        }
        
        
        if ([key isEqualToString:@"Replay"]) {
            NSMutableArray *relayArr = [NSMutableArray array];
            [obj enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                ReplayModel *replayModel = [[ReplayModel alloc] init];
                [replayModel setValuesForKeysWithDictionary:obj];
                [relayArr addObject:replayModel];
                
            }];
            self.Replay = relayArr;
        }
    }];
}



@end
