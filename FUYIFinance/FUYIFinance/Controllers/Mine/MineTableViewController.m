//
//  MineTableViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/6/28.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MineTableViewController.h"
#import "MyOrderWaitJudgeViewController.h"
@interface MineTableViewController ()
@property (weak, nonatomic) IBOutlet UIView *preparPay;   //待付款
@property (weak, nonatomic) IBOutlet UIView *collectionShop;   //收藏的店铺

@property (weak, nonatomic) IBOutlet UIView *ShopKeeper;   //我是商家
@property (weak, nonatomic) IBOutlet UIView *MyJudgeMent;  //我的评价
@property (weak, nonatomic) IBOutlet UIView *FavoriteCollection;   //收藏的宝贝

@property (weak, nonatomic) IBOutlet UIView *prepareForgood;   //待收货
@property (weak, nonatomic) IBOutlet UIView *prepareForjudge;   //待评价
@property (weak, nonatomic) IBOutlet UIView *myOrder;    //我的订单
@property (weak, nonatomic) IBOutlet UILabel *badgeLabel3;//待评价按钮上面的自定义badge标签

@end

@implementation MineTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self CreateUI];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     self.navigationController.navigationBar.hidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -PrivateMethod
- (void)CreateUI{
    
    //待评价按钮的自定义badge标签
    self.badgeLabel3.layer.cornerRadius = 8;
    self.badgeLabel3.layer.masksToBounds = YES;
    
    //待付款按钮添加响应事件
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(prepareAct:)];
    [self.preparPay addGestureRecognizer:tap];
    
    //收藏的店铺按钮添加响应事件
    UITapGestureRecognizer * tapReceive = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(collectionShopAct)];
    [self.collectionShop addGestureRecognizer:tapReceive];
    
    //我是商家按钮添加响应事件
    UITapGestureRecognizer * tapshop = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shopKeeperAct)];
    [self.ShopKeeper addGestureRecognizer:tapshop];
    
    //我的评价按钮添加响应事件
    UITapGestureRecognizer * judgetap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(judgeAct)];
    [self.MyJudgeMent addGestureRecognizer:judgetap];
    
    //收藏的宝贝按钮添加响应事件
    UITapGestureRecognizer * tapfavoritecollection = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(favoriteCollectionAct)];
    [self.FavoriteCollection addGestureRecognizer:tapfavoritecollection];
    
    //待收货按钮添加响应事件
    UITapGestureRecognizer * tapPrepareforgood = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(PrePareforgoodAct)];
    [self.prepareForgood addGestureRecognizer:tapPrepareforgood];
    
    //待评价按钮添加响应事件
    UITapGestureRecognizer * tapPrepareforjudge = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(prepareForjudgeAct)];
    [self.prepareForjudge addGestureRecognizer:tapPrepareforjudge];
    
    //我的订单按钮添加响应事件
    UITapGestureRecognizer * tapMyorder = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(MyorderAct)];
    [self.myOrder addGestureRecognizer:tapMyorder];
    
    
    
}


//待付款
- (void)prepareAct:(UIGestureRecognizer *)ges{
    [self performSegueWithIdentifier:@"waitpaySegue" sender:nil];
}

//收藏的店铺
- (void)collectionShopAct
{
    
}

//我是商家
- (void)shopKeeperAct
{
   // [self performSegueWithIdentifier:@"treasureSegue" sender:nil];
    [self performSegueWithIdentifier:@"myshopSegue" sender:nil];
}

//我的评价
- (void)judgeAct
{
    [self performSegueWithIdentifier:@"myjudgeSegue" sender:nil];
}

//收藏的宝贝
- (void)favoriteCollectionAct
{
    [self performSegueWithIdentifier:@"mycollectionSegue" sender:nil];
}

//待收货
- (void)PrePareforgoodAct
{
    
}

//待评价
- (void)prepareForjudgeAct
{
    
    [self performSegueWithIdentifier:@"waitjudgeSegue" sender:nil];
}

//我的订单
- (void)MyorderAct
{
    [self performSegueWithIdentifier:@"myorderSegue" sender:nil];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    if(section==0){
        return 1;
    }else if (section==1){
        return 1;
    }else if (section==2){
        return 4;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section==0){
        return 1;
    }else if (section==1){
        return 8;
    }else if (section==2){
        return 7;
    }else{
    return 13;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 2){
        if(indexPath.row==0){
            
        }else if (indexPath.row==1){
            
        }else if (indexPath.row==2){
            
        }else if (indexPath.row==3){
            
        }
    }else if (indexPath.section == 3){
        
    }
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
