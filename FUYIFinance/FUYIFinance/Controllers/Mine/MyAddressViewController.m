//
//  MyAddressViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/13.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MyAddressViewController.h"
#import "chdButton.h"
#import "KGModal.h"

@interface MyAddressViewController ()<UITextViewDelegate>
{
    BOOL isShow;
    BOOL isShow1;
    BOOL isShow2;
}
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet chdButton *provinceBtn;
@property (weak, nonatomic) IBOutlet chdButton *cityBtn;
@property (weak, nonatomic) IBOutlet chdButton *areaBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end

@implementation MyAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textView.delegate = self;
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
    
    }

- (void)btnClick:(UIButton*)sender
{
   
   NSInteger tag = sender.tag;
    if(tag == 1){
         isShow = !isShow;
        if(isShow){
            sender.imageView.transform = CGAffineTransformMakeRotation(0);
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


#pragma mark -textViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.label1.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    self.label1.hidden = NO;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    if(section == 0){
        return 6;
    }else{
    return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0){
        return 1;
    }else {
        return 230;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
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
