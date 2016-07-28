//
//  StoreViewController.m
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/7/21.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "StoreViewController.h"

//view
#import "StoreHeaderTableViewCell.h"
#import "ShopTopTableViewCell.h"
#import "MyShopDetailTableViewCell.h"

#import "MyAPI.h"

#import "TeacherStoreHeaderModel.h"

@interface StoreViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _page;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,retain)NSMutableArray * VideoArr;
@property(nonatomic,copy)TeacherStoreHeaderModel * teacherMod;

@end

@implementation StoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _VideoArr = [[NSMutableArray alloc]init];
    _teacherMod = [[TeacherStoreHeaderModel alloc]init];
    
    
    _page = 1;
    [self creatUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)loadData{
    
    NSString *nowPage = [NSString stringWithFormat:@"%ld",(long)_page];
    
    [[MyAPI sharedAPI] getTeacherTeamDataWithToken:KToken page:nowPage result:^(BOOL success, NSString *msg, NSMutableArray *arrays) {
        if (success) {
            [_VideoArr addObjectsFromArray:arrays[1]];
            _teacherMod = arrays[0];
        }
        
        
    } errorResult:^(NSError *enginerError) {
        
    }];
}

- (void)creatUI{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"StoreHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:@"StoreHeadCellId"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ShopTopTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID2"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MyShopDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID4"];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else{
        return 10;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            StoreHeaderTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"StoreHeaderTableViewCell" owner:self options:nil]lastObject];
            
            [cell.collectStoreBtn setBackgroundImage:[UIImage imageNamed:@"colloectStoreCancel"] forState:UIControlStateNormal];
            [cell.collectStoreBtn setBackgroundImage:[UIImage imageNamed:@"colloectStore"] forState:UIControlStateSelected];
            [cell.collectStoreBtn addTarget:self action:@selector(collectStoreClick:) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
        }if (indexPath.row == 1) {
            ShopTopTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"ShopTopTableViewCell" owner:self options:nil]lastObject];
            return cell;
        }
    }else{
        MyShopDetailTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"MyShopDetailTableViewCell" owner:self options:nil]lastObject];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0&&indexPath.row == 0) {
        return 80;
    }if (indexPath.section == 0&&indexPath.row == 1 ) {
        return 40;
    }else{
        return 96;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else{
        return 10;
    }
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }else{
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
        view.backgroundColor = RGBACOLOR(245, 244, 245, 1);
        return view;
    }
}

- (void)collectStoreClick:(UIButton*)button{
    button.selected = !button.selected;
    
    
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
