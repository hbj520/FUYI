//
//  VideoShopViewController.m
//  FUYIFinance
//
//  Created by youyoumacmini3 on 16/7/5.
//  Copyright © 2016年 youyou. All rights reserved.
//
#import "VideoDetailViewController.h"
#import "VideoShopViewController.h"

#import "VideoStoreTableViewCell.h"
#import "VideoShopTableViewCell.h"

#import "DOPDropDownMenu.h"

#import "SelectModel.h"

static NSString *videoShopReuseId = @"videoShopReuseId";

@interface VideoShopViewController ()<UITableViewDataSource,UITableViewDelegate,DOPDropDownMenuDataSource,DOPDropDownMenuDelegate>
{
    NSMutableArray *financeSelectData;
    NSMutableArray *classSelectData;
    
    NSMutableArray *moArr;
}


//@property (nonatomic, strong) NSArray *financeSelectArr;//金融品种类型
//@property (nonatomic, strong) NSArray *classSelectArr;//课程类型

@property (nonatomic, weak) DOPDropDownMenu *menu;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)back:(id)sender;

@end

@implementation VideoShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatUI];
    [self loadData];
    

}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma   mark -PrivateMethod 
-(void)creatUI{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[VideoShopTableViewCell class] forCellReuseIdentifier:videoShopReuseId];
    [self dropDownMenu];//下拉菜单
}

- (void)loadData{
    [[MyAPI sharedAPI] videoStoreWithResult:^(BOOL success, NSString *msg, NSMutableArray *arrays) {
        if (success) {
            financeSelectData = arrays[0];
            classSelectData = arrays[1];
    
            NSLog(@"%@----",financeSelectData[0]);
        }
    } errorResult:^(NSError *enginerError) {
        
    }];
    
    for (SelectModel *model in financeSelectData) {
        [moArr addObject:model.selectName];
    }
    
}

- (void)dropDownMenu
{
    //SelectModel *model = financeSelectData[indexPath.row];
    //NSMutableArray *moArr = [NSMutableArray array];
  
    
//    self.financeSelectArr = @[@"金融品种",@"芙蓉区",@"雨花区",@"天心区",@"开福区",@"岳麓区"];
//    self.classSelectArr = @[@"课程类型",@"离我最近",@"好评优先",@"人气优先",@"最新发布"];
    
    // 添加下拉菜单
    DOPDropDownMenu *menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:44];
    menu.delegate = self;
    menu.dataSource = self;
    [self.view addSubview:menu];
    _menu = menu;
    
    // 创建menu 第一次显示 不会调用点击代理，可以用这个手动调用
    [menu selectDefalutIndexPath];
    
}

#pragma mark - DOPDropDownMenuDelegate
- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu
{
    return 2;
}

- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column
{
    if (column == 0) {
        return moArr.count;
    }else {
        return classSelectData.count;
    }
}

- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.column == 0) {
      //  SelectModel *model = financeSelectData[indexPath.row];
        return moArr[indexPath.row];
   
    }else {
        SelectModel *model = classSelectData[indexPath.row];

        return model.selectName;
    }
}


- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath
{
    if (indexPath.item == 0) {
        NSLog(@"点击了 %ld - %ld 项目",indexPath.column,indexPath.row);
    }else {
        NSLog(@"点击了 %ld - %ld 项目",indexPath.column,indexPath.row);
    }
}


#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    VideoShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:videoShopReuseId forIndexPath:indexPath];
//    if (cell == nil) {
        VideoShopTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"VideoShopTableViewCell" owner:self options:nil] lastObject];
       // NSLog(@"我进来了");
        
//    }
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 115;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"====");
    [self performSegueWithIdentifier:@"videoDetailSegue" sender:nil];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UIVew
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
