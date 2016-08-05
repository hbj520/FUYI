//
//  MineMyAddressViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/13.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MineMyAddressViewController.h"
#import "MyAddressFirstTableViewCell.h"
#import "MyAddressChoiceTableViewCell.h"
#import "MyAddressTextTableViewCell.h"
#import "BBBadgeBarButtonItem.h"
#import "chdButton.h"
#import "KGModal.h"
#import "MJExtension.h"
#import "ProvinceModel.h"
#import "cityModel.h"
#import "ZoneModel.h"
#import "AFNetworking.h"

@interface MineMyAddressViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString * provinceLabel;                //省份
    NSString * cityLabel;                    //城市
    NSString * citydefaultLabel;             //默认城市
    NSString * areaLabel;                    //地区
    NSString * areadefaultLabel;             //默认地区
    BBBadgeBarButtonItem * _chatBtn;         //自定制导航栏按钮
    BBBadgeBarButtonItem * _chatBtn1;        //自定制导航栏按钮
    
}
@property (nonatomic,strong)NSMutableArray * provinceArray;    //省份数组
@property (nonatomic,strong)NSMutableArray * cityArray;        //城市数组
@property (nonatomic,strong)NSMutableArray * areaArray;        //地区数组
@property (weak, nonatomic) IBOutlet UITableView *tableView1;  //界面
@property (nonatomic,strong)UITableView * tableView;           //省份界面
@property (nonatomic,strong)UITableView * citytableView;       //城市界面
@property (nonatomic,strong)UITableView * areatableView;       //地区界面

@end

@implementation MineMyAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addChatBtn];                      //添加自定制导航栏按钮
    [self configView];                      //搭接面
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

//添加自定制导航栏按钮
- (void)addChatBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 31, 27);
    [btn setImage:[UIImage imageNamed:@"messageBtn"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(chatAct:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 0,20,20);
    [btn1 addTarget:self action:@selector(btnclick1:) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setImage:[UIImage imageNamed:@"barimage"] forState:UIControlStateNormal];
    
    _chatBtn = [[BBBadgeBarButtonItem alloc] initWithCustomUIButton:btn];
    _chatBtn.badgeFont = [UIFont systemFontOfSize:10.0f];
    _chatBtn.badgeOriginX = 15.5;
    _chatBtn.badgeOriginY = -2.5;
    _chatBtn.badgePadding = 2;
    _chatBtn.badgeValue = @"0";
    
    _chatBtn1 = [[BBBadgeBarButtonItem alloc] initWithCustomUIButton:btn1];
    _chatBtn1.badgeFont = [UIFont systemFontOfSize:10.0f];
    _chatBtn1.badgeOriginX = 15.5;
    _chatBtn1.badgeOriginY = -2.5;
    _chatBtn1.badgePadding = 2;
    _chatBtn1.badgeValue = @"0";
    
    NSMutableArray *arryBtn = [NSMutableArray arrayWithObjects:_chatBtn,_chatBtn1, nil];
    self.navigationItem.rightBarButtonItems = arryBtn;
}

//自定制导航栏信息按钮的事件响应方法
- (void)chatAct:(id)sender{
    
}

- (void)btnclick1:(id)sender
{
    
}

//搭界面
- (void)configView
{
    self.tableView1.delegate = self;
    self.tableView1.dataSource = self;
    [self.tableView1 registerNib:[UINib nibWithNibName:@"MyAddressFirstTableViewCell" bundle:nil] forCellReuseIdentifier:@"addressid1"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"MyAddressChoiceTableViewCell" bundle:nil] forCellReuseIdentifier:@"addressid2"];
    [self.tableView1 registerNib:[UINib nibWithNibName:@"MyAddressTextTableViewCell" bundle:nil] forCellReuseIdentifier:@"addressid3"];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 300, 400) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.citytableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 300, 400) style:UITableViewStylePlain];
    self.citytableView.delegate = self;
    self.citytableView.dataSource = self;
    self.areatableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 300, 400) style:UITableViewStylePlain];
    self.areatableView.delegate = self;
    self.areatableView.dataSource = self;
}


#pragma mark - TableViewDelegate & TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView == self.tableView1){
        return 1;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.tableView1){
        return 6;
    }
    if(tableView == self.tableView)
    {
    return self.provinceArray.count;
    }
    if(tableView == self.citytableView)
    {
        return self.cityArray.count;
    }
    if(tableView == self.areatableView)
    {
        return self.areaArray.count;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.tableView1){
        if(indexPath.row == 5){
            return 116;
        }else{
            return 45;
        }
    }
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(tableView == self.tableView1){
        if(indexPath.row == 0 ||indexPath.row==1){
            MyAddressFirstTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"addressid1" forIndexPath:indexPath];
            if(indexPath.row == 0){
                cell.titlename.text = @"收货人";
                cell.desctitle.text = @"李小刚";
            }else{
                cell.titlename.text = @"手机号码";
            cell.desctitle.text = @"158567812345";
            }
            return cell;
        }else if (indexPath.row == 2 ||indexPath.row==3 ||indexPath.row==4){
            MyAddressChoiceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"addressid2" forIndexPath:indexPath];
            if(indexPath.row == 2){
                cell.arealabel.text = @"省份";
                if(provinceLabel){
                    cell.areadetaillabel.text = provinceLabel;
                }else{
                cell.areadetaillabel.text = @"河南";
                    }
                
            }else if (indexPath.row == 3){
                cell.arealabel.text = @"城市";
                
                if(cityLabel){
                    cell.areadetaillabel.text = cityLabel;
                        }else{
                            if(citydefaultLabel){
                                cell.areadetaillabel.text = citydefaultLabel;
                            }else{
                cell.areadetaillabel.text = @"洛阳";
                            }
                }
            }else{
                cell.arealabel.text = @"地区";
                if(areaLabel){
                    cell.areadetaillabel.text = areaLabel;
                }else{
                    if(areadefaultLabel){
                        cell.areadetaillabel.text = areadefaultLabel;
                    }else{
                cell.areadetaillabel.text = @"东城区";
                    }
                }
            }
            return cell;
        }else{
            MyAddressTextTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"addressid3" forIndexPath:indexPath];
            cell.block = ^(){
                
            };
            return cell;
        }
    }else if (tableView == self.tableView)
    {
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    ProvinceModel * model = self.provinceArray[indexPath.row];
    cell.textLabel.highlightedTextColor = [UIColor redColor];
    cell.textLabel.text = model.fullname;
    return cell;
    }else if (tableView == self.citytableView){
        UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cityModel * model = self.cityArray[indexPath.row];
        cell.textLabel.highlightedTextColor = [UIColor redColor];
        cell.textLabel.text = model.fullname;
        return cell;
    }else{
        UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        ZoneModel * model = self.areaArray[indexPath.row];
        cell.textLabel.highlightedTextColor = [UIColor redColor];
        cell.textLabel.text = model.fullname;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.tableView1){
        if(indexPath.row == 2){
        [[KGModal sharedInstance] setCloseButtonType:KGModalCloseButtonTypeNone];
        [KGModal sharedInstance].modalBackgroundColor = [UIColor whiteColor];
        [[KGModal sharedInstance] showWithContentView:self.tableView andAnimated:YES];
        }else if (indexPath.row == 3){
           
            [[KGModal sharedInstance] setCloseButtonType:KGModalCloseButtonTypeNone];
            [KGModal sharedInstance].modalBackgroundColor = [UIColor whiteColor];
            [[KGModal sharedInstance] showWithContentView:self.citytableView andAnimated:YES];
        }else if (indexPath.row == 4){
            [[KGModal sharedInstance] setCloseButtonType:KGModalCloseButtonTypeNone];
            [KGModal sharedInstance].modalBackgroundColor = [UIColor whiteColor];
            [[KGModal sharedInstance] showWithContentView:self.areatableView andAnimated:YES];
            
        }
    }else if(tableView == self.tableView) {
        ProvinceModel * model = self.provinceArray[indexPath.row];
        provinceLabel = model.fullname;
        NSString *urlStr=[NSString stringWithFormat:@"http://apis.map.qq.com/ws/district/v1/getchildren?&id=%@&key=K3VBZ-M6WWV-PPSPY-UVGGC-DRM2Z-PGBMV",model.id];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        
        [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            
            // NSLog(@"%@",responseObject);
            
            //        //数组字典（JSON）转模型用框架
            NSMutableArray *messageData=[responseObject objectForKey:@"result"];
            //
            //     NSLog(@"%@",messageData);
            self.cityArray=[NSMutableArray array];
            self.cityArray = (NSMutableArray *)[cityModel mj_objectArrayWithKeyValuesArray:messageData[0]];
            cityModel * model1 = self.cityArray[0];
            citydefaultLabel = model1.fullname;
            [self.tableView1 reloadData];
            [self.citytableView reloadData];
          
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];

        [[KGModal sharedInstance] hideAnimated:YES];
        [self.tableView1 reloadData];
    }else if (tableView == self.citytableView){
        cityModel * model = self.cityArray[indexPath.row];
        cityLabel = model.fullname;
        NSString *urlString = [NSString stringWithFormat:@"http://apis.map.qq.com/ws/district/v1/getchildren?&id=%@&key=K3VBZ-M6WWV-PPSPY-UVGGC-DRM2Z-PGBMV", model.id];
        NSURL *URL = [NSURL URLWithString:urlString];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        //        //数组字典（JSON）转模型用框架
        NSMutableArray *messageData=[dic objectForKey:@"result"];
        //
        //     NSLog(@"%@",messageData);
        self.areaArray = [NSMutableArray array];
        self.areaArray = (NSMutableArray *)[ZoneModel mj_objectArrayWithKeyValuesArray:messageData[0]];
        ZoneModel* model1 = self.areaArray[0];
        areadefaultLabel = model1.fullname;
         [[KGModal sharedInstance] hideAnimated:YES];
        [self.areatableView reloadData];
        [self.tableView1 reloadData];
    }else{
        ZoneModel * model = self.areaArray[indexPath.row];
        areaLabel = model.fullname;
        [[KGModal sharedInstance] hideAnimated:YES];
        [self.tableView1 reloadData];
    }

}

//确定修改
- (IBAction)sureModify:(id)sender {
    [self.view endEditing:YES];
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
