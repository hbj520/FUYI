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

static NSString *videoShopReuseId = @"videoShopReuseId";

@interface VideoShopViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)back:(id)sender;

@end

@implementation VideoShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatUI];

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
//    [self.tableView registerNib:[UINib nibWithNibName:@"VideoStoreTableViewCell" bundle:nil] forCellReuseIdentifier:@"VideoStoreCellReuseID"];
    
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
