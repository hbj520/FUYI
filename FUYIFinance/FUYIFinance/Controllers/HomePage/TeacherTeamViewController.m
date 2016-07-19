//
//  TeacherTeamViewController.m
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/7/14.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "TeacherTeamViewController.h"
#import "TeacherPersonalViewController.h"

#import "TeacherTeamNavigationItem.h"
#import "TeacherTeamTableViewCell.h"

#import "MyAPI.h"

#import <MJRefresh.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "LPPopup.h"

#import "TeacherTeamModel.h"

@interface TeacherTeamViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    NSInteger _page;
    NSMutableArray *TeacherTeamArr;
    
    
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation TeacherTeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatUI];
    TeacherTeamArr = [NSMutableArray array];
    _page = 1;
    [self loadDataWithToken:KToken page:_page];
    [self addRefresh];
    
}



- (void)addRefresh{
    //添加刷新
    __weak TeacherTeamViewController *weakself = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 1;
        if (TeacherTeamArr.count > 0) {
            [TeacherTeamArr removeAllObjects];
        }
        [weakself loadDataWithToken:KToken page:_page];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _page++;
        [weakself loadDataWithToken:KToken page:_page];
    }];
}

- (void)loadDataWithToken:(NSString*)token page:(NSInteger)page{
    
    NSString *nowPage = [NSString stringWithFormat:@"%ld",(long)_page];
   [[MyAPI sharedAPI] getTeacherTeamDataWithToken:KToken page:nowPage result:^(BOOL success, NSString *msg, NSMutableArray *arrays) {
       
       if ([msg isEqualToString:@"err token"]) {
           [self logOut];
       }
       if (success) {
           [TeacherTeamArr addObjectsFromArray:arrays];

           [self.tableView reloadData];
       }
       [self.tableView.mj_header endRefreshing];
       [self.tableView.mj_footer endRefreshing];
   } errorResult:^(NSError *enginerError) {
    
       [self.tableView.mj_header endRefreshing];
       [self.tableView.mj_footer endRefreshing];
   }];

    
}

- (void)creatUI{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self addCustomerNavgationItem];
    self.searchBar.delegate = self;
    UITextField *searchField=[_searchBar valueForKey:@"_searchField"];
    searchField.borderStyle = UITextBorderStyleNone;
    searchField.backgroundColor = RGBACOLOR(235, 235, 235, 1);
    searchField.layer.cornerRadius = 10;
}

- (void)addCustomerNavgationItem{
    TeacherTeamNavigationItem *navItem = [[[NSBundle mainBundle]loadNibNamed:@"TeacherTeamNavigationItem" owner:self options:nil]lastObject];
    navItem.frame = CGRectMake(0, 0, ScreenWidth, 64);
    
    
    navItem.backBlock = ^(){
        [self.navigationController popViewControllerAnimated:YES];
    };
    navItem.newsBlock = ^(){
        
    };
    
    [self.view addSubview:navItem];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return TeacherTeamArr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TeacherTeamTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"TeacherTeamTableViewCell" owner:self options:nil] lastObject];
  
    
    TeacherTeamModel *model = [TeacherTeamArr objectAtIndex:indexPath.row];
    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:model.teacherImage] placeholderImage:[UIImage imageNamed:@"TeacherTeam_headImage"]];
    cell.teacherNameLab.text = model.teacherName;
    cell.teacherSaying.text = model.teacherDescription;
    cell.focusNum.text = model.teacherFansNum;
    
    //关注&取消关注
    cell.focusBtnBlock = ^(UIButton *button){
        
        if ([model.teacherType isEqualToString:@"0"]) {
            button.selected = NO;
            [self FocusTeacherWithId:model.teacherId];
            model.teacherId = @"1";
        }else{
            button.selected = YES;
            [self CancelFocusTeacherWithId:model.teacherId];
            model.teacherId = @"0";
        }
    };
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)FocusTeacherWithId:(NSString*)tId{
    [[MyAPI sharedAPI] focusTeacherWithToken:KToken teacherId:tId result:^(BOOL sucess, NSString *msg) {
        if (sucess) {
             [self showPopup:msg];
        }else{
             [self showPopup:msg];
        }
    } errorResult:^(NSError *enginerError) {
        
    }];
}

-(void)CancelFocusTeacherWithId:(NSString*)tId{
    
}

#pragma mark - creatLPPopup

- (void)showPopup:(NSString *)popupWithText
{
    LPPopup *popup = [LPPopup popupWithText:popupWithText];
    [popup showInView:self.view
        centerAtPoint:self.view.center
             duration:kLPPopupDefaultWaitDuration
           completion:nil];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 66;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TeacherTeamModel *model = [TeacherTeamArr objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"TeacherPersonalSegue" sender:model];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    TeacherPersonalViewController *personVC = segue.destinationViewController;
    personVC.model = sender;
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
