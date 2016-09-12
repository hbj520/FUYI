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

#import "MJRefresh.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "LPPopup.h"

#import "TeacherTeamModel.h"

@interface TeacherTeamViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    NSInteger _page;
    NSString * _key;
    NSMutableArray *TeacherTeamArr;
    TeacherTeamModel *_saveModel;
    
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation TeacherTeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _key = @"";
    [self creatUI];
    _saveModel = [[TeacherTeamModel alloc]init];
    TeacherTeamArr = [[NSMutableArray alloc]init];
    _page = 1;
    [self loadDataWithToken:KToken page:_page];
    [self addRefresh];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(selector:)
                                                 name:@"refresh"
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [Tools hideKeyBoard];
    _key = searchBar.text;
    _page = 1;
    [self loadDataWithToken:KToken page:_page];
}

#pragma mark - privateMethod
- (void)selector:(NSNotification*)sender{
    
    [self loadDataWithToken:KToken page:_page];
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)addRefresh{
    //添加刷新
    __weak TeacherTeamViewController *weakself = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 1;
                
        [weakself loadDataWithToken:KToken page:_page];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        _page++;
        [weakself loadDataWithToken:KToken page:_page];
    }];
}

- (void)loadDataWithToken:(NSString*)token page:(NSInteger)page{
    
    NSString *nowPage = [NSString stringWithFormat:@"%ld",(long)_page];
    
    if (KToken) {
        [[MyAPI sharedAPI] getTeacherTeamDataWithToken:KToken Key:_key page:nowPage result:^(BOOL success, NSString *msg, NSMutableArray *arrays) {
         
            if (success) {
                if(_page == 1){
                    if (TeacherTeamArr.count > 0) {
                        [TeacherTeamArr removeAllObjects];
                    }
                }
                [TeacherTeamArr addObjectsFromArray:arrays];
            }else{
                if([msg isEqualToString:@"没有数据"]){
                    if(_page == 1){
                    [TeacherTeamArr removeAllObjects];
                    }
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                });
                _page--;
            }
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        } errorResult:^(NSError *enginerError) {
            
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }];

    }else{
        [self logOut];
    }
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
    _saveModel = model;
    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:model.teacherImage] placeholderImage:[UIImage imageNamed:@"TeacherTeam_headImage"]];
    cell.headImage.layer.cornerRadius = 27;
    cell.headImage.layer.masksToBounds = YES;
    cell.teacherNameLab.text = model.teacherName;
    cell.teacherSaying.text = model.teacherDescription;
    cell.focusNum.text = model.teacherFansNum;
    cell.focusAndCancelBtn.str = model.teacherId;
    
    [cell.focusAndCancelBtn addTarget:self action:@selector(focusClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.focusAndCancelBtn setImage:[UIImage imageNamed:@"TeacherTeam_focus"] forState:UIControlStateNormal];
    [cell.focusAndCancelBtn setImage:[UIImage imageNamed:@"TeacherTeam_cancel"] forState:UIControlStateSelected];
    cell.focusAndCancelBtn.index = indexPath;
    
    //刚进来判断按钮状态
    if ([_saveModel.teacherType isEqualToString:@"1"]) {
         cell.focusAndCancelBtn.selected = YES;
    }else{
         cell.focusAndCancelBtn.selected = NO;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)focusClick:(CustomBtn*)button{
    if (button.selected == NO) {
        button.selected = !button.selected;
       [self FocusTeacherWithId:button];
    }else{
        button.selected = !button.selected;
        [self CancelFocusTeacherWithId:button];
    }
}
//关注
-(void)FocusTeacherWithId:(CustomBtn*)button{
    [[MyAPI sharedAPI] focusTeacherWithToken:KToken teacherId:button.str result:^(BOOL sucess, NSString *msg) {
        if (sucess) {
            TeacherTeamTableViewCell *cell = (TeacherTeamTableViewCell*)[self.tableView cellForRowAtIndexPath:button.index];
            NSInteger x = [cell.focusNum.text integerValue];
            x = x + 1;
            cell.focusNum.text = [NSString stringWithFormat:@"%ld",(long)x];
             [self showPopup:msg];
        }else{
            if([msg isEqualToString:@"-1"]){
                [self logOut];
            }else{
             [self showPopup:msg];
            }
        }
    } errorResult:^(NSError *enginerError) {
        
    }];
}

//取消
-(void)CancelFocusTeacherWithId:(CustomBtn*)button{
    [[MyAPI sharedAPI] cancelFocusTeacherWithToken:KToken teacherId:button.str result:^(BOOL sucess, NSString *msg) {
        if (sucess) {
            TeacherTeamTableViewCell *cell = (TeacherTeamTableViewCell*)[self.tableView cellForRowAtIndexPath:button.index];
            NSInteger x = [cell.focusNum.text integerValue];
            x = x - 1;
            cell.focusNum.text = [NSString stringWithFormat:@"%ld",(long)x];
            
            [self showPopup:msg];
        }else{
            if([msg isEqualToString:@"-1"]){
                [self logOut];
            }else{
            [self showPopup:msg];
            }
        }
    } errorResult:^(NSError *enginerError) {
        
    }];
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [Tools hideKeyBoard];
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
