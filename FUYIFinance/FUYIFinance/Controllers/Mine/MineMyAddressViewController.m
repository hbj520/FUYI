//
//  MineMyAddressViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/13.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MineMyAddressViewController.h"
#import "chdButton.h"
#import "KGModal.h"
#import "MJExtension.h"
#import "ProvinceModel.h"
#import "cityModel.h"
#import "ZoneModel.h"
#import <AFNetworking.h>

@interface MineMyAddressViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL isShow;
    BOOL isShow1;
    BOOL isShow2;
}
@property (weak, nonatomic) IBOutlet chdButton *provinceBtn;
@property (weak, nonatomic) IBOutlet chdButton *cityBtn;
@property (weak, nonatomic) IBOutlet chdButton *areaBtn;
@property (nonatomic,strong)NSMutableArray * provinceArray;
@property (nonatomic,strong)UITableView * tableView1;
@property (nonatomic,strong)UITableView * tableView;
@end

@implementation MineMyAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.provinceBtn setTitle:@"河南" forState:UIControlStateNormal];
    self.provinceBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.provinceBtn.backgroundColor = [UIColor whiteColor];
    [self.provinceBtn setImage:[UIImage imageNamed:@"up1"] forState:UIControlStateNormal];
    self.provinceBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI);
    self.provinceBtn.font = [UIFont systemFontOfSize:15];
    // [self.provinceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.provinceBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.provinceBtn.tag = 1;
    
    [self.cityBtn setTitle:@"洛阳" forState:UIControlStateNormal];
    self.cityBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.cityBtn.backgroundColor = [UIColor whiteColor];
    [self.cityBtn setImage:[UIImage imageNamed:@"up1"] forState:UIControlStateNormal];
    self.cityBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI);
    self.cityBtn.font = [UIFont systemFontOfSize:15];
    // [self.cityBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.cityBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.cityBtn.tag = 2;
    
    [self.areaBtn setTitle:@"东城区" forState:UIControlStateNormal];
    self.areaBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.areaBtn.backgroundColor = [UIColor whiteColor];
    [self.areaBtn setImage:[UIImage imageNamed:@"up1"] forState:UIControlStateNormal];
    self.areaBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI);
    self.areaBtn.font = [UIFont systemFontOfSize:15];
    // [self.areaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.areaBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.areaBtn.tag = 3;

    [self configView];
    NSString * urlStr = [NSString stringWithFormat:@"http://apis.map.qq.com/ws/district/v1/list?key=K3VBZ-M6WWV-PPSPY-UVGGC-DRM2Z-PGBMV"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        //       NSLog(@"%@",responseObject);
        
        //数组字典（JSON）转模型用框架
        
        NSMutableArray *messageData=[responseObject objectForKey:@"result"];
       
        self.provinceArray=(NSMutableArray *)[ProvinceModel mj_objectArrayWithKeyValuesArray:messageData[0]];
        
        //写plist 文件
        
        //       [messageData writeToFile:@"/Users/liuhao/Desktop/city_province.plist" atomically:YES];
        [self.tableView reloadData];
        // 默认选中左边表格的第0行
        
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        
    }];
    
    

}

- (void)btnClick:(UIButton*)sender
{
    
    NSInteger tag = sender.tag;
    if(tag == 1){
        isShow = !isShow;
        if(isShow){
            sender.imageView.transform = CGAffineTransformMakeRotation(0);
            [[KGModal sharedInstance] setCloseButtonType:KGModalCloseButtonTypeNone];
            [KGModal sharedInstance].modalBackgroundColor = [UIColor whiteColor];
            [[KGModal sharedInstance] showWithContentView:self.tableView andAnimated:YES];
        }else{
            sender.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        }
    }
    if(tag == 2){
        isShow1 = !isShow1;
        if(isShow1){
            sender.imageView.transform = CGAffineTransformMakeRotation(0);
            
        }else{
            sender.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        }
    }
    if(tag == 3){
        isShow2 = !isShow2;
        if(isShow2){
            sender.imageView.transform = CGAffineTransformMakeRotation(0);
        }else{
            sender.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        }
    }
}

- (void)configView
{
    
    self.tableView1 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-109) style:UITableViewStyleGrouped];
    self.tableView1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.tableView1];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 300, 400) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    ProvinceModel * model = self.provinceArray[indexPath.row];
    cell.textLabel.highlightedTextColor = [UIColor redColor];
    cell.textLabel.text = model.fullname;
    return cell;
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
