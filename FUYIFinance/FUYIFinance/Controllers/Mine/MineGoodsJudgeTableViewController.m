//
//  MineGoodsJudgeTableViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/8/23.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MineGoodsJudgeTableViewController.h"
#import "starView.h"
@interface MineGoodsJudgeTableViewController ()
{
    NSString * starNum;
}
@property (weak, nonatomic) IBOutlet UIImageView *thumbImg;
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *teachername;
@property (weak, nonatomic) IBOutlet UILabel *placelabel1;
@property (weak, nonatomic) IBOutlet UILabel *placelabel2;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *stringcountlabel;
@property (weak, nonatomic) IBOutlet starView *starView1;
@property (weak, nonatomic) IBOutlet starView *starView2;
@property (weak, nonatomic) IBOutlet starView *starView3;
@property (weak, nonatomic) IBOutlet starView *starView4;
@property (weak, nonatomic) IBOutlet starView *starView5;

@end

@implementation MineGoodsJudgeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(renewStar:)];
    [self.starView1 configWithStarLevel:3];
    [self.starView2 configWithStarLevel:3];
    [self.starView3 configWithStarLevel:3];
    [self.starView4 configWithStarLevel:3];
    [self.starView5 configWithStarLevel:3];
    [self.starView1 addGestureRecognizer:tapGesture];
    [self.starView2 addGestureRecognizer:tapGesture];
    [self.starView3 addGestureRecognizer:tapGesture];
    [self.starView4 addGestureRecognizer:tapGesture];
    [self.starView5 addGestureRecognizer:tapGesture];
    
}

//手势方法的实现
- (void)renewStar:(UIGestureRecognizer *)sender
{
    starView * view = (starView *)sender.view.superview;
    CGPoint point = [sender locationInView:view];
    CGFloat pointX = point.x;
    
    float scale = pointX/136;
    int starnumber = scale * 5 + 1;
    starNum = [NSString stringWithFormat:@"%d",starnumber];
    [view configWithStarLevel:starnumber];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0){
        return 1;
    }else if (section == 1){
        return 1;
    }else{
        return 2;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [Tools hideKeyBoard];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
