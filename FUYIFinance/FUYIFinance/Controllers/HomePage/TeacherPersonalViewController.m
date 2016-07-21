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

#import "LPPopup.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MyAPI.h"

#import "TeacherModel.h"

@interface TeacherPersonalViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    TeacherModel *_newModel;
}


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign) BOOL stateChange;

@end

@implementation TeacherPersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //_newModel = [[TeacherModel alloc]init];
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
        if (self.stateChange) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"refresh" object:self userInfo:nil];
           }
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
        cell.teacherName.text = _newModel.teacherName;
        [cell.headImage sd_setImageWithURL:[NSURL URLWithString:_model.teacherImage] placeholderImage:[UIImage imageNamed:@"TeacherTeam_headImage"]];
        cell.headImage.layer.cornerRadius = 28;
        cell.headImage.layer.masksToBounds = YES;
        cell.focusNumLab.text = _newModel.fans;
        
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
        [footView.FocusOrNotBtn setImage:[UIImage imageNamed:@"TeacherPersonal_FOCUS"] forState:UIControlStateNormal];
        [footView.FocusOrNotBtn setImage:[UIImage imageNamed:@"TeacherPersonal_cancelFOCUS"] forState:UIControlStateSelected];
        [footView.FocusOrNotBtn addTarget:self action:@selector(FocusOrNotClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if ([_newModel.type isEqualToString:@"1"]) {
            footView.FocusOrNotBtn.selected = YES;
        }else{
            footView.FocusOrNotBtn.selected = NO;
        }
        
        return footView;
    }else{
        UIView *foot = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 19)];
        return foot;
    }
 
}

- (void)FocusOrNotClick:(UIButton*)button{

    if (button.selected == NO) {
        button.selected = !button.selected;
         [self FocusTeacherWithId:_model.teacherId];
    }else{
        button.selected = !button.selected;
        [self CancelFocusTeacherWithId:_model.teacherId];
    }
}

//关注
-(void)FocusTeacherWithId:(NSString*)tId{
    [[MyAPI sharedAPI] focusTeacherWithToken:KToken teacherId:tId result:^(BOOL sucess, NSString *msg) {
        if (sucess) {
            [self showPopup:msg];
               _model.teacherType = @"1";
            TeacherPersonalTableViewCell *cell = (TeacherPersonalTableViewCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            NSInteger y = [cell.focusNumLab.text integerValue];
            y = y + 1;
            cell.focusNumLab.text = [NSString stringWithFormat:@"%ld",(long)y];
            self.stateChange = YES;
        }else{
            [self showPopup:msg];
        }
    } errorResult:^(NSError *enginerError) {
    }];
}

//取消
-(void)CancelFocusTeacherWithId:(NSString*)tId{
    [[MyAPI sharedAPI] cancelFocusTeacherWithToken:KToken
                                         teacherId:tId result:^(BOOL sucess, NSString *msg) {
        if (sucess) {
            TeacherPersonalTableViewCell *cell = (TeacherPersonalTableViewCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
            NSInteger y = [cell.focusNumLab.text integerValue];
            y = y - 1;
            cell.focusNumLab.text = [NSString stringWithFormat:@"%ld",(long)y];
            [self showPopup:msg];
            _model.teacherType = @"0";
            self.stateChange = YES;
        }else{
            [self showPopup:msg];
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
