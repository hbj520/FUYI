//
//  MineTableViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/6/28.
//  Copyright © 2016年 youyou. All rights reserved.
//
#import "MineLoginViewController.h"
#import "MineTableViewController.h"
#import "UIViewController+HUD.h"
#import "MyOrderWaitJudgeViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Config.h"
@interface MineTableViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *headimage;
@property (weak, nonatomic) IBOutlet UILabel *teachername;
@property (weak, nonatomic) IBOutlet UIButton *messagebtn;
@property (weak, nonatomic) IBOutlet UIView *preparPay;   //待付款
@property (weak, nonatomic) IBOutlet UIButton *accountbtn;

@property (weak, nonatomic) IBOutlet UIImageView *goldTeacherImageView;
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;//欢迎label
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;//登录注册按钮
- (IBAction)loginBtn:(id)sender;//登录注册按钮
@property (weak, nonatomic) IBOutlet UIView *prepareForgood;   //待收货
@property (weak, nonatomic) IBOutlet UIView *prepareForjudge;   //待评价
@property (weak, nonatomic) IBOutlet UIView *myOrder;    //我的订单
@property (weak, nonatomic) IBOutlet UILabel *waitjudgecount;//待评价按钮上面的自定义badge标签
@property (weak, nonatomic) IBOutlet UILabel *waitpaycountlabel;
@property (weak, nonatomic) IBOutlet UILabel *teacherName;
@property (weak, nonatomic) IBOutlet UIButton *treasuebtn;
@property (weak, nonatomic) IBOutlet UIButton *YouBiCount;
@property (weak, nonatomic) IBOutlet UIButton *GoalCount;


@end

@implementation MineTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self CreateUI];
   self.navigationController.navigationBarHidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -PrivateMethod
- (void)LoginAct{
    UIStoryboard *storybord = [UIStoryboard storyboardWithName:@"Mine" bundle:nil];
    UINavigationController *loginVC = [storybord instantiateViewControllerWithIdentifier:@"LoginStorybordId"];
    loginVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)LoginActCell{
    UIStoryboard *storybord = [UIStoryboard storyboardWithName:@"Mine" bundle:nil];
    UINavigationController *loginVC = [storybord instantiateViewControllerWithIdentifier:@"LoginStorybordId"];
    loginVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self.navigationController presentModalViewController:loginVC animated:YES];
}

//创建界面

- (void)CreateUI{
    if (KToken) {
        self.teacherName.text = [[Config Instance] getUserName];
        self.headimage.hidden = NO;
        self.goldTeacherImageView.hidden = NO;
        self.headimage.layer.cornerRadius = 35;
        self.headimage.layer.masksToBounds = YES;
        NSString * imageurl = [[Config Instance] getIcon];
        [self.headimage sd_setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:[UIImage imageNamed:@"defaulticon"]];
        self.treasuebtn.hidden = NO;
        self.YouBiCount.hidden = NO;
        self.GoalCount.hidden = NO;
           }else{
        self.headimage.image = [UIImage imageNamed:@"person_headicon"];
        self.goldTeacherImageView.hidden = YES;
        self.teachername.text = @"未登录请登录";
               self.treasuebtn.hidden = YES;
               self.YouBiCount.hidden = YES;
               self.GoalCount.hidden = YES;
    }
    
    [self addBadgeLabel];
    //添加点击事件
    [self addTapGes];
    
}
- (IBAction)clickyoubi:(id)sender {
    [self performSegueWithIdentifier:@"moneySegue" sender:nil];

}

- (IBAction)topupAccount:(id)sender {
    [self performSegueWithIdentifier:@"topupSegue" sender:nil];
}


- (void)addTapGes{
    //待付款按钮添加响应事件
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(prepareAct:)];
    [self.preparPay addGestureRecognizer:tap];
    
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
- (IBAction)accountManage:(id)sender {
    if (!KToken) {
        [self LoginActCell];
    }else{
        [self performSegueWithIdentifier:@"protectaccountSegue" sender:nil];
 
    }
}

//显示未操作数
- (void)addBadgeLabel
{
    if(!KToken){
        self.waitpaycountlabel.hidden = YES;
        self.waitjudgecount.hidden = YES;
        
    }else{
        //待评价按钮的自定义badge标签
        self.waitpaycountlabel.hidden = NO;
        self.waitjudgecount.hidden = NO;
        self.waitpaycountlabel.layer.cornerRadius = 6;
        self.waitpaycountlabel.layer.masksToBounds = YES;
        self.waitpaycountlabel.text = @"0";
        if(self.waitpaycountlabel.text.length<=0){
            self.waitpaycountlabel.hidden = YES;
        }
        if([self.waitpaycountlabel.text isEqualToString:@"0"]){
            self.waitpaycountlabel.hidden = YES;
        }
        self.waitjudgecount.layer.cornerRadius = 6;
        self.waitjudgecount.layer.masksToBounds = YES;
        self.waitjudgecount.text = @"0";
        if(self.waitjudgecount.text.length<=0){
            self.waitjudgecount.hidden = YES;
        }
        if([self.waitjudgecount.text isEqualToString:@"0"]){
            self.waitjudgecount.hidden = YES;
        }
    }

}

- (IBAction)setting:(id)sender {
    if (!KToken) {
        [self LoginActCell];
    }else{
        if (KGesturePsassword) {
            if ([[GestureHelper sharedGesture] isTimeOut]) {
                [self gestureAct];
            }else{
            [self performSegueWithIdentifier:@"settingSegue" sender:nil];
            }
        }else{
            [self performSegueWithIdentifier:@"settingSegue" sender:nil];
  
        }
    }
}

- (IBAction)message:(id)sender {
    if(!KToken){
        [self LoginActCell];
    }else{
        if (KGesturePsassword) {
            if ([[GestureHelper sharedGesture] isTimeOut]) {
                [self gestureAct];
            }else{
                [self performSegueWithIdentifier:@"noticeSegue" sender:nil];
            }
        }else{
            [self performSegueWithIdentifier:@"noticeSegue" sender:nil];
            
        }
    }
}

//待付款
- (void)prepareAct:(UIGestureRecognizer *)ges{
    if (!KToken) {
//        [self LoginAct];
        [self LoginActCell];
    }else{
        if (KGesturePsassword) {
            if ([[GestureHelper sharedGesture] isTimeOut]) {
                [self gestureAct];
            }else{
                [self performSegueWithIdentifier:@"waitpaySegue" sender:nil];
            }
        }else{
            [self performSegueWithIdentifier:@"waitpaySegue" sender:nil];
            
        }
    }
}


//我是商家
- (void)shopKeeperAct
{
   // [self performSegueWithIdentifier:@"treasureSegue" sender:nil];
    if (!KToken) {
        [self LoginAct];
    }else{
        if (KGesturePsassword) {
            if ([[GestureHelper sharedGesture] isTimeOut]) {
                [self gestureAct];
            }else{
                [self performSegueWithIdentifier:@"myshopSegue" sender:nil];
            }
        }else{
            [self performSegueWithIdentifier:@"myshopSegue" sender:nil];
            
        }
    }
}

//我的评价
- (void)judgeAct
{
    if (!KToken) {
        [self LoginAct];
    }else{
        if (KGesturePsassword) {
            if ([[GestureHelper sharedGesture] isTimeOut]) {
                [self gestureAct];
            }else{
                [self performSegueWithIdentifier:@"myjudgeSegue" sender:nil];
            }
        }else{
            [self performSegueWithIdentifier:@"myjudgeSegue" sender:nil];
            
        }
    }
}

//收藏的宝贝
- (void)favoriteCollectionAct
{
    if (!KToken) {
        [self LoginAct];
    }else{
        if (KGesturePsassword) {
            if ([[GestureHelper sharedGesture] isTimeOut]) {
                [self gestureAct];
            }else{
                [self performSegueWithIdentifier:@"mycollectionSegue" sender:nil];
            }
        }else{
            [self performSegueWithIdentifier:@"mycollectionSegue" sender:nil];
            
        }
    }
}

//待收货
- (void)PrePareforgoodAct
{
    if(!KToken){
        [self LoginActCell];
    }else{
        if(KGesturePsassword){
            if([[GestureHelper sharedGesture] isTimeOut]){
                [self gestureAct];
            }else{
                [self performSegueWithIdentifier:@"myjudgeSegue" sender:nil];
            }
        }else{
            [self performSegueWithIdentifier:@"myjudgeSegue" sender:nil];
        }
    }
}

//待评价
- (void)prepareForjudgeAct
{
    if (!KToken) {
       [self LoginActCell];
    }else{
        if (KGesturePsassword) {
            if ([[GestureHelper sharedGesture] isTimeOut]) {
                [self gestureAct];
            }else{
                [self performSegueWithIdentifier:@"waitjudgeSegue" sender:nil];
            }
        }else{
            [self performSegueWithIdentifier:@"waitjudgeSegue" sender:nil];
            
        }
    }
}

//我的订单
- (void)MyorderAct
{
    if (!KToken) {
        [self LoginActCell];
    }else{
        if (KGesturePsassword) {
            if ([[GestureHelper sharedGesture] isTimeOut]) {
                [self gestureAct];
            }else{
                [self performSegueWithIdentifier:@"myorderSegue" sender:nil];
            }
        }else{
            [self performSegueWithIdentifier:@"myorderSegue" sender:nil];
            
        }
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section==0){
        return 1;
    }else if (section==1){
        return 5;
    }else{
        return 2;
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

    if (!KToken) {
        [self LoginActCell];
    }else{
        if (KGesturePsassword) {
            if ([[GestureHelper sharedGesture] isTimeOut]) {
                [self gestureAct];
            }else{
                [self selectCellActWithIndexPath:indexPath];
            }
        }else{
            [self selectCellActWithIndexPath:indexPath];
        }
        }
}
- (void)gestureAct{
    [[GestureHelper sharedGesture] showGestureUnlockViewFromNowVC:self.navigationController];
}
- (void)selectCellActWithIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1){
        if(indexPath.row==0){
            [self performSegueWithIdentifier:@"modifyinfoSegue" sender:nil];
        }else if (indexPath.row==1){
            [self performSegueWithIdentifier:@"protectaccountSegue" sender:nil];
        }else if (indexPath.row==2){
            [self performSegueWithIdentifier:@"noticeSegue" sender:nil];
        }else if (indexPath.row == 3){
            [self performSegueWithIdentifier:@"mycollectionSegue" sender:nil];
        }else{
            [self performSegueWithIdentifier:@"myjudgeSegue" sender:nil];
        }
        
    }else if (indexPath.section == 2){
        if(indexPath.row == 0){
            [self performSegueWithIdentifier:@"settingSegue" sender:nil];
        }else{
            [self performSegueWithIdentifier:@"feedbackSegue" sender:nil];
        }
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

- (IBAction)loginBtn:(id)sender {   
    [self LoginAct];
}
@end
