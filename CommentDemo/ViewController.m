//
//  ViewController.m
//  CommentDemo
//
//  Created by 123 on 16/6/28.
//  Copyright © 2016年 asura. All rights reserved.
//

#import "ViewController.h"
#import "CommmentTableViewCell.h"
#import "AFNetworking.h"
#import "CommentModel.h"

static NSString *const indentifier = @"CommmentTableViewCell";
static NSString *const indentifierNormal = @"UITableViewCell    ";

@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datasource;

@end

@implementation ViewController

- (NSMutableArray *)datasource{
    if (!_datasource) {
        self.datasource = [NSMutableArray array];
    }
    return _datasource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self networking];
    
    [_tableView registerClass:[CommmentTableViewCell class] forCellReuseIdentifier:indentifier];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:indentifierNormal];
    
}

- (void)networking{
    /*
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"http://192.168.2.152:808/OtherApi/GetCommentList.do" parameters:@{@"pagesize" : @"5",
                                                       @"pageindex": @"1",
                                                       @"mid": @"1",
                                                       @"taskId"   : @"1"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                                           
                                                           NSArray *dataArr = responseObject[@"data"];
                                                           for (NSDictionary *dict in dataArr) {
                                                               CommentModel *model = [[CommentModel alloc] init];
                                                               [model setValuesForKeysWithDictionary:dict];
                                                               [self.datasource addObject:model];
                                                           }
                                                                NSLog(@"%@",responseObject);
                                                           [_tableView reloadData];
                                                           
                                                       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                                           NSLog(@"%@",error);
                                                       }];
     */
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Data" ofType:@"plist"];
    
    NSArray *dataArr = [[NSArray alloc] initWithContentsOfFile:filePath];
    
    for (NSDictionary *dict in dataArr) {
        CommentModel *model = [[CommentModel alloc] init];
        [model setValuesForKeysWithDictionary:dict];
        [self.datasource addObject:model];
    }
    [_tableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.datasource.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifierNormal forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"评论";
        return cell;
    }
    CommmentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier forIndexPath:indexPath];
    cell.assignment(self.datasource[indexPath.row - 1]);
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 44;
    }

    CommentModel *commentModel = self.datasource[indexPath.row - 1];
        //51为第一个内容剧 cell 上的距离
    CGFloat cellHeight = 51 + (commentModel.Replay.count * 8) + commentModel.contentHeight;
    
        //如果没有回复,直接返回
    if (commentModel.Replay == nil) {
            //8为据底部的边距
        return cellHeight + 8;
    }
        //计算回复的评论高度
    for (ReplayModel *replayModel in commentModel.Replay) {
        NSArray *replayArr = [replayModel.Content componentsSeparatedByString:@"#"];
        cellHeight += [replayArr.firstObject floatValue];
    }
    return cellHeight;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
