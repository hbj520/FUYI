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

#import <SDWebImage/UIImageView+WebCache.h>
#import "MyAPI.h"

#import "TeacherModel.h"

@interface TeacherPersonalViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    TeacherModel *_newModel;
    
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation TeacherPersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _newModel = [[TeacherModel alloc]init];
    [self creatUI];
    [self loadData];
}

- (void)loadData{
    [[MyAPI sharedAPI] getTeacherDetailDataWithToken:KToken teacherId:_model.teacherId result:^(BOOL success, NSString *msg, id object) {
        if (success) {
            _newModel = object;
            [self.tableView reloadData];
        }
        
    } errorResult:^(NSError *enginerError) {
        
    }];
}

- (void)creatUI{
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self addCustomNavigationItem];
    self.tableView.sectionHeaderHeight = 5;
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
        TeacherPersonalTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"TeacherPersonalTableViewCell" owner:self options:nil]lastObject];
        cell.teacherName.text = _model.teacherName;
        [cell.headImage sd_setImageWithURL:[NSURL URLWithString:_model.teacherImage] placeholderImage:[UIImage imageNamed:@"TeacherTeam_headImage"]];
        cell.focusNumLab.text = _model.teacherFansNum;
        
        
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        TeacherPersonalInfoTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"TeacherPersonalInfoTableViewCell" owner:self options:nil]lastObject];
        if (indexPath.row == 0) {
            cell.detailInfoLab.text = [NSString stringWithFormat:@"姓名： %@",_newModel.teacherName];
        }if (indexPath.row == 1) {
            cell.detailInfoLab.text = [NSString stringWithFormat:@"毕业院校： %@",_newModel.school];
        }if (indexPath.row == 2) {
            cell.detailInfoLab.text = [NSString stringWithFormat:@"所处位置： %@",_newModel.address];
        }if (indexPath.row == 3) {
            cell.detailInfoLab.text = [NSString stringWithFormat:@"发表文章： %@",_newModel.title];
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
