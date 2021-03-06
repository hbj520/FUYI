//
//  PublishTreasureTableViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/1.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "PublishTreasureTableViewController.h"
#import "BBBadgeBarButtonItem.h"

@interface PublishTreasureTableViewController ()<UITextViewDelegate,UITextFieldDelegate>

{
    BBBadgeBarButtonItem * _chatBtn;    //自定制的导航栏按钮
    BBBadgeBarButtonItem * _chatBtn1;   //自定制的导航栏按钮
}

@property (weak, nonatomic) IBOutlet UILabel *placetitle1;
@property (weak, nonatomic) IBOutlet UILabel *placetitle2;
@property (weak, nonatomic) IBOutlet UITextView *textView1;
@property (weak, nonatomic) IBOutlet UITextView *textView2;
@property (weak, nonatomic) IBOutlet UITextField *priceField;
@property (weak, nonatomic) IBOutlet UITextField *translateField;

@end

@implementation PublishTreasureTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      [self addChatBtn];            //添加自定制导航栏按钮
    self.textView1.delegate = self;
    self.textView2.delegate = self;
    self.priceField.delegate = self;
    self.translateField.delegate = self;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField == self.priceField){
        NSString * priceString = self.priceField.text;
        NSArray * stringArray = [priceString componentsSeparatedByString:@"¥"];
        NSString * priceStr = [stringArray lastObject];
        NSString * priceLabel = [NSString stringWithFormat:@"¥%@",priceStr];
        self.priceField.text = priceLabel;
    }else if (textField == self.translateField){
        NSString * translateString = self.translateField.text;
        NSArray * stringArray = [translateString componentsSeparatedByString:@"¥"];
        NSString * translateStr = [stringArray lastObject];
        NSString * translateLabel = [NSString stringWithFormat:@"¥%@",translateStr];
        self.translateField.text = translateLabel;
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if(textView == self.textView1){
        self.placetitle1.hidden = YES;
    }else{
        self.placetitle2.hidden = YES;
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView == self.textView1) {
        if(textView.text.length>0){
            self.placetitle1.hidden = YES;
        }else{
        self.placetitle1.hidden = NO;
        }
    }else if(textView == self.textView2){
        if(textView.text.length>0){
            self.placetitle2.hidden = YES;
        }else{
        self.placetitle2.hidden = NO;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//添加自定制导航栏按钮
- (void)addChatBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 31, 27);
    [btn setImage:[UIImage imageNamed:@"messageBtn"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(chatAct:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 0, 20,20);
    [btn1 addTarget:self action:@selector(clickBtn1) forControlEvents:UIControlEventTouchUpInside];
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

//自定制导航栏按钮的事件响应方法
- (void)clickBtn1
{
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section==0){
        return 3;
    }else if (section==1){
        return 1;
    }else if (section==2){
        return 2;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section==0){
        return 1;
    }else if (section==1){
        return 10;
    }else if (section==2){
        return 10;
    }else{
        return 56;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section!=0){
        [self.textView1 endEditing:YES];
    }else if (indexPath.section!=1){
        [self.textView2 endEditing:YES];
    }
}

//退回到上级界面
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
