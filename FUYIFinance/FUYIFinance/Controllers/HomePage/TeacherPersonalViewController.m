//
//  TeacherPersonalViewController.m
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/7/15.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "TeacherPersonalViewController.h"

#import "TeacherTeamNavigationItem.h"
#import "TeacherPersonalTableViewCell.h"
#import "TeacherPersonalInfoTableViewCell.h"
#import "FooterView.h"

@interface TeacherPersonalViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation TeacherPersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatUI];
    
}

- (void)creatUI{
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self addCustomNavigationItem];
    
        [self.tableView registerNib:[UINib nibWithNibName:@"TeacherPersonalTableViewCell" bundle:nil] forCellReuseIdentifier:@"TeacherPersonalId"];
            [self.tableView registerNib:[UINib nibWithNibName:@"TeacherPersonalInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"TeacherPersonalInfoId"];
}

- (void)addCustomNavigationItem{
    TeacherTeamNavigationItem *navItem = [[[NSBundle mainBundle]loadNibNamed:@"TeacherTeamNavigationItem" owner:self options:nil]lastObject];
    navItem.frame = CGRectMake(0, 0, ScreenWidth, 64);
    navItem.ItemTitleLab.text = @"李老师";
    navItem.newsBtn.hidden = YES;
    
    navItem.backBlock = ^(){
        [self.navigationController popViewControllerAnimated:YES];
    };
    
    [self.view addSubview:navItem];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0){
        return 1;
    }else{
        return 4;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        TeacherPersonalTableViewCell *Cell = [[[NSBundle mainBundle]loadNibNamed:@"TeacherPersonalTableViewCell" owner:self options:nil]lastObject];
           Cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return Cell;
    }else{
        TeacherPersonalInfoTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"TeacherPersonalInfoTableViewCell" owner:self options:nil]lastObject];
        if (indexPath.row == 0) {
            cell.detailInfoLab.text = @"姓名： 李小龙";
        }if (indexPath.row == 1) {
            cell.detailInfoLab.text = @"毕业院校： 北京大学，营销管理";
        }if (indexPath.row == 2) {
            cell.detailInfoLab.text = @"所处位置：安徽合肥";
        }else{
            cell.detailInfoLab.text = @"发表文章：关于原油的投资分析";
        }
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
       return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 72;
    }else{
        return 45;
    }
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *headView = [[UIView alloc]init];
        headView.backgroundColor = RGBACOLOR(246, 245, 248, 1);
        return headView;
    }else{
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 11;
    }else{
        return 0;
    }
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 1) {
        FooterView *footView = [[[NSBundle mainBundle]loadNibNamed:@"FooterView" owner:self options:nil]lastObject];
        return footView;
    }else{
        UIView *foot = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 19)];
        return foot;
    }
 
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return 19;
    }else{
        return 315;
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
