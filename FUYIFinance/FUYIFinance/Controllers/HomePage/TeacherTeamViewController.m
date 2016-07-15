//
//  TeacherTeamViewController.m
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/7/14.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "TeacherTeamViewController.h"

#import "TeacherTeamNavigationItem.h"
#import "TeacherTeamTableViewCell.h"

@interface TeacherTeamViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation TeacherTeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatUI];
    
    
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
    //去掉上线边界黑线代码
//    for (UIView *obj in [_searchBar subviews]) {
//        for (UIView *objs in [obj subviews]) {
//            if ([objs isKindOfClass:NSClassFromString(@"UISearchBarBackground")]){
//                [objs removeFromSuperview];
//            }
//        }
//        if ([obj isKindOfClass:NSClassFromString(@"UISearchBarBackground")]){
//            [obj removeFromSuperview];
//        }
//    }
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
    return 10;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TeacherTeamTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"TeacherTeamTableViewCell" owner:self options:nil] lastObject];
    
    cell.focusBtnBlock = ^(UIButton *button){
        
        button.selected = !button.selected;
        
    };
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 66;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"TeacherPersonalSegue" sender:nil];
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
