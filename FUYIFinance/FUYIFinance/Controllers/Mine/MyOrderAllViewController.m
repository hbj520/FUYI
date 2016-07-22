//
//  MyOrderAllViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/6/28.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MyOrderAllViewController.h"
#import "PersonalWaitPayTableViewCell.h"
#import "PersonalWaitJudgeTableViewCell.h"
#import "MyJudgeTableViewCell.h"
#import "AllOderModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <MJRefresh/MJRefresh.h>
#import "LabelHelper.h"
#import "MyAPI.h"

@interface MyOrderAllViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
    NSMutableArray * waitjudgeArray;
    NSMutableArray * waitpayArray;
    NSMutableArray * isjudgeArray;
    NSInteger page;
}
@end

@implementation MyOrderAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 100) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"PersonalWaitPayTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyOrderId"];
    [_tableView registerNib:[UINib nibWithNibName:@"PersonalWaitJudgeTableViewCell" bundle:nil] forCellReuseIdentifier:@"WaitJudgeId"];
    [_tableView registerNib:[UINib nibWithNibName:@"MyJudgeTableViewCell" bundle:nil] forCellReuseIdentifier:@"MyJudgeId"];
    
    [self.view addSubview:_tableView];
    waitjudgeArray = [NSMutableArray array];
    waitpayArray = [NSMutableArray array];
    isjudgeArray = [NSMutableArray array];
    page = 1;
    [self loadData];
    [self addRefresh];
}

- (void)addRefresh
{
    __weak MyOrderAllViewController * weakself = self;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        page = 1;
        if(waitjudgeArray.count>0||waitpayArray.count>0||isjudgeArray.count>0){
            [waitpayArray removeAllObjects];
            [waitjudgeArray removeAllObjects];
            [isjudgeArray removeAllObjects];
        }
        [weakself loadData];
        
    }];
    MJRefreshAutoNormalFooter * footerRefresh = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page++;
        [weakself loadData];
    }];
    footerRefresh.automaticallyRefresh = NO;
    _tableView.mj_footer = footerRefresh;
}


- (void)loadData
{
    NSString * pagestr = [NSString stringWithFormat:@"%ld",page];
    [[MyAPI sharedAPI] requestAllOrderDataWithParameters:pagestr result:^(BOOL success, NSString *msg, NSMutableArray *arrays) {
        if([msg isEqualToString:@"-1"]){
            [self logOut];
        }

        if(success){
            for(AllOderModel * model in arrays){
                if([model.state isEqualToString:@"0"]){
                    [waitpayArray addObject:model];
                }else if ([model.state isEqualToString:@"1"]){
                    [waitjudgeArray addObject:model];
                }else{
                    [isjudgeArray addObject:model];
                }
            }
            [_tableView reloadData];
            [_tableView.mj_header endRefreshing];
            [_tableView.mj_footer endRefreshing];
        }else{
          
        }
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
        
    } errorResult:^(NSError *enginerError) {
        [_tableView.mj_header endRefreshing];
        [_tableView.mj_footer endRefreshing];
    }];
    
    /**
     *    if([msg isEqualToString:@"-1"]){
     [self logOut];
     }
     if(success){
     [dataSource addObjectsFromArray:arrays];
     [_tableView reloadData];
     }else{
     
     }
     [_tableView.mj_header endRefreshing];
     [_tableView.mj_footer endRefreshing];
     
     } errorResult:^(NSError *enginerError) {
     [_tableView.mj_header endRefreshing];
     [_tableView.mj_footer endRefreshing];
     }];
     

     *
     *  @param NSInteger <#NSInteger description#>
     *
     *  @return <#return value description#>
     */
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        return waitpayArray.count;
    }else if (section == 1){
        return waitjudgeArray.count;
    }else{
        return isjudgeArray.count;
    }

}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        PersonalWaitPayTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyOrderId" forIndexPath:indexPath];
        AllOderModel * model = [[AllOderModel alloc] init];
        model = waitpayArray[indexPath.row];
        [cell.thumbImage sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"placeimage"]];
        cell.shopname.text = model.shopname;
        cell.titlename.text = model.name;
        NSString * pricelabel = [NSString stringWithFormat:@"¥%@",model.price];
        cell.price.text = pricelabel;
        NSString * teacherlabel = [NSString stringWithFormat:@"讲师：%@",model.teacher];
        cell.teachername.text = teacherlabel;
       cell.totalPrice.attributedText = [[LabelHelper alloc] attributedStringWithString:pricelabel];
        return cell;
    }else if(indexPath.section == 1){
        PersonalWaitJudgeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"WaitJudgeId" forIndexPath:indexPath];
        AllOderModel * model = [[AllOderModel alloc] init];
        model = waitjudgeArray[indexPath.row];
        [cell.thumbImage sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"placeimage"]];
        cell.shopname.text = model.shopname;
        cell.title.text = model.name;
        NSString * teacherlabel = [NSString stringWithFormat:@"讲师：%@",model.teacher];
        cell.teacherName.text = teacherlabel;
        NSString * pricelabel = [NSString stringWithFormat:@"¥%@",model.price];
        cell.price.text = pricelabel;
        cell.totalPrice.attributedText = [[LabelHelper alloc] attributedStringWithString:pricelabel];
        return cell;
    }else{
        MyJudgeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MyJudgeId" forIndexPath:indexPath];
        AllOderModel * model = [[AllOderModel alloc] init];
        model = isjudgeArray[indexPath.row];
        [cell.thumbimage sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:[UIImage imageNamed:@"placeimage"]];
        cell.titlename.text = model.name;
        cell.timelabel.text = model.ctime;
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 2){
        return 80;
    }
    else{
    return 217;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
