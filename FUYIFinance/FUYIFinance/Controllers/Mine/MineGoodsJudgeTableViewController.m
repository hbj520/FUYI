//
//  MineGoodsJudgeTableViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/8/23.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MineGoodsJudgeTableViewController.h"
#import "UIViewController+HUD.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "starView.h"
#import "MyAPI.h"
#import "Config.h"
@interface MineGoodsJudgeTableViewController ()<UITextViewDelegate>
{
    NSString * starNum;
    NSString * starnum1;
    NSString * starnum2;
    NSString * starnum3;
    NSString * starnum4;
    BOOL IsCommit;
    NSString * anostr;
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
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end

@implementation MineGoodsJudgeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    anostr = @"0";
    [self.thumbImg sd_setImageWithURL:[NSURL URLWithString:self.image] placeholderImage:[UIImage imageNamed:@"myorderthumbimage"]];
    self.name.text = self.goodsname;
    self.teachername.text = [NSString stringWithFormat:@"讲师：%@",self.teachname];
    self.price.text = [NSString stringWithFormat:@"%@",self.goodsprice];
    self.textView.delegate = self;

    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(renewStar:)];
    [self.starView1 configWithStarLevel:0];
    [self.starView2 configWithStarLevel:0];
    [self.starView3 configWithStarLevel:0];
    [self.starView4 configWithStarLevel:0];
    [self.starView5 configWithStarLevel:0];
    [self.starView1 addGestureRecognizer:tapGesture];
    
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(updatestar2:)];
    [self.starView2 addGestureRecognizer:tap1];
    
    UITapGestureRecognizer * tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(updatestarthree:)];
    [self.starView3 addGestureRecognizer:tap2];
    
    UITapGestureRecognizer * tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(updatestarfour:)];
    [self.starView4 addGestureRecognizer:tap3];
    
    UITapGestureRecognizer * tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(updatestarfive:)];
    [self.starView5 addGestureRecognizer:tap4];
    
    self.sureBtn.layer.cornerRadius = 5;
}

//手势方法的实现
- (void)renewStar:(UIGestureRecognizer *)sender
{
    CGPoint point = [sender locationInView:self.starView1];
    CGFloat pointX = point.x;
    int starnumber;
    float scale = pointX/136;
    if(scale<0.1){
        starnumber = 0;
    }else{
    starnumber = scale * 5 + 1;
    }
    starNum = [NSString stringWithFormat:@"%d",starnumber];
    [self.starView1 configWithStarLevel:starnumber];

}

- (void)updatestar2:(UITapGestureRecognizer *)sender
{
    CGPoint point = [sender locationInView:self.starView2];
    CGFloat pointX = point.x;
    int starnumber;
    float scale = pointX/136;
    if(scale<0.1){
        starnumber = 0;
    }else{
    starnumber = scale * 5 + 1;
    }
    starnum1 = [NSString stringWithFormat:@"%d",starnumber];
    [self.starView2 configWithStarLevel:starnumber];
}

- (void)updatestarthree:(UITapGestureRecognizer *)sender
{
    CGPoint point = [sender locationInView:self.starView3];
    CGFloat pointX = point.x;
    int starnumber;
    float scale = pointX/136;
    if(scale<0.1){
        starnumber = 0;
    }else{
    starnumber = scale * 5 + 1;
    }
    starnum2 = [NSString stringWithFormat:@"%d",starnumber];
    [self.starView3 configWithStarLevel:starnumber];
}

- (void)updatestarfour:(UITapGestureRecognizer *)sender
{
    CGPoint point = [sender locationInView:self.starView4];
    CGFloat pointX = point.x;
    int starnumber;
    float scale = pointX/136;
    if(scale<0.1){
        starnumber = 0;
    }else{
    starnumber = scale * 5 + 1;
    }
    starnum3 = [NSString stringWithFormat:@"%d",starnumber];
    [self.starView4 configWithStarLevel:starnumber];
}

- (void)updatestarfive:(UITapGestureRecognizer *)sender
{
    CGPoint point = [sender locationInView:self.starView5];
    CGFloat pointX = point.x;
    int starnumber;
    float scale = pointX/136;
    if(scale<0.1){
        starnumber = 0;
    }else{
    starnumber = scale * 5 + 1;
    }
    starnum4 = [NSString stringWithFormat:@"%d",starnumber];
    [self.starView5 configWithStarLevel:starnumber];

}

- (void)textViewDidChange:(UITextView *)textView
{
    self.placelabel1.hidden = YES;
    self.placelabel2.hidden = YES;
    NSInteger count = textView.text.length;
    self.stringcountlabel.text = [NSString stringWithFormat:@"%ld",count];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(textView.text.length == 0){
    self.placelabel1.hidden = NO;
    self.placelabel2.hidden = NO;
    }else{
    self.placelabel1.hidden = YES;
    self.placelabel2.hidden = YES;
    }
}

//是否匿名
- (IBAction)Commit:(id)sender {
    IsCommit = !IsCommit;
    if(IsCommit){
        [sender setImage:[UIImage imageNamed:@"btnhighlighted"] forState:UIControlStateNormal];
        
    }else{
        [sender setImage:[UIImage imageNamed:@"btndark"] forState:UIControlStateNormal];
        
    }

}

- (IBAction)SureJudge:(id)sender {
    [Tools hideKeyBoard];
    if(!KToken){
        [self logOut];
    }else{
        if(IsCommit){
            anostr = @"1";
        }
        if(self.textView.text.length == 0){
            [self showHint:@"评论内容不能为空"];
            return;
        }else{
        if(!starNum){
            starNum = @"1";
        }
        if(!starnum1){
            starnum1 = @"1";
        }
        if(!starnum2){
            starnum2 = @"1";
        }
        if(!starnum3){
            starnum3 = @"1";
        }
        if(!starnum4){
            starnum4 = @"1";
        }
    [[MyAPI sharedAPI] GoodsJudgeWithParameters:starNum Manner_score:starnum1 Quality_score:starnum2 Rational_score:starnum3 Satisfy_score:starnum4 OrderNum:self.ordernum Anonymous:anostr Content:self.textView.text Goodstype:self.ustyle Goodsid:self.uid result:^(BOOL sucess, NSString *msg) {
        if (sucess) {
            [self showHint:@"评价成功"];
            if (self.deleteblock) {
                self.deleteblock(self.indexpath);
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"updatepage" object:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self showHint:msg];
        }
    } errorResult:^(NSError *enginerError) {
        
    }];
    
}
    }
}

- (void)logOut
{
    if (KToken) {
        [[Config Instance] logout];
    }
    UIStoryboard *storybord = [UIStoryboard storyboardWithName:@"Mine" bundle:nil];
    UINavigationController *loginVC = [storybord instantiateViewControllerWithIdentifier:@"LoginStorybordId"];
    loginVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self.navigationController presentModalViewController:loginVC animated:YES];
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
        return 3;
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
