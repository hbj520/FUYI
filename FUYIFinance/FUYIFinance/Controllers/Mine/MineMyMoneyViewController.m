//
//  MineMyMoneyViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/9/1.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MineMyMoneyViewController.h"
#import "Config.h"

@interface MineMyMoneyViewController ()
{
    NSString * ucoinValue;
    NSInteger firstCout;
    NSInteger secondCout;
}
@property (weak, nonatomic) IBOutlet UILabel *YouBiCount;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelconstant;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *youbiconstant;

@end

@implementation MineMyMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    if(ScreenHeight == 480){
        self.labelconstant.constant = 50;
        self.youbiconstant.constant = 50;
    }
    self.YouBiCount.layer.cornerRadius = 76.5;
    self.YouBiCount.layer.borderWidth = 2;
    self.YouBiCount.layer.borderColor = [UIColor colorWithRed:222/255.0 green:94/255.0 blue:136/255.0 alpha:1].CGColor;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateucoin:) name:@"changeucoin" object:nil];
    if(ucoinValue){
        NSInteger ucoin = ucoinValue.integerValue;
        NSInteger newucoin = ucoin/1000;
        NSString * ucoinstring = [NSString stringWithFormat:@"%ld",newucoin];
        self.YouBiCount.text = ucoinstring;
    }else{
        NSString * ucoin = [[Config Instance] getUcoin];
        NSInteger uCoin = ucoin.integerValue;
        NSInteger newucoin = uCoin/1000;
        NSString * ucoinstring = [NSString stringWithFormat:@"%ld",newucoin];
        self.YouBiCount.text = ucoinstring;
    }
    if(self.YouBiCount.text.length>3){
        self.YouBiCount.font = [UIFont fontWithName:@"IowanOldStyle-Roman" size:25];
        NSString * nowcount = [NSString stringWithFormat:@"%@k",self.YouBiCount.text];
        self.YouBiCount.text = nowcount;
        self.label.hidden = YES;
    }else{
        self.YouBiCount.font = [UIFont fontWithName:@"IowanOldStyle-Roman" size:60];
        self.label.hidden = NO;
    }

     self.navigationController.navigationBarHidden = NO;
}

- (void)updateucoin:(NSNotification *)noti
{
    NSString * ucoinvalue = noti.userInfo[@"ucoin"];
    NSLog(@"ucoinvalue = %@",ucoinvalue);
    ucoinValue = ucoinvalue;
}

- (IBAction)convertYoubi:(id)sender {
    [self performSegueWithIdentifier:@"convertSegue" sender:nil];
}

- (IBAction)back:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateucoin" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBar.hidden = YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScreenHeight - 64;
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
