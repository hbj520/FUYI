//
//  ManageTreasureTableViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/6/30.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "ManageTreasureTableViewController.h"
#import "UIViewController+HUD.h"
#import "BBBadgeBarButtonItem.h"
#import "ManageTreasureModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <MJRefresh/MJRefresh.h>
#import "ChangeHeadView.h"
#import "KGModal.h"
#import "Config.h"
#import "MyAPI.h"
@interface ManageTreasureTableViewController ()<UITextViewDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

{
    BBBadgeBarButtonItem * _chatBtn;   //自定制导航栏按钮
    BBBadgeBarButtonItem * _chatBtn1;  //自定制导航栏按钮
    UIImagePickerController * _picker;
    NSString * imageUrl;
    NSString * nameStr;
    NSString * priceString;
    ManageTreasureModel * model;
}
@property (weak, nonatomic) IBOutlet UITextView *textView;       //编辑宝贝的描述视图
@property (weak, nonatomic) IBOutlet UILabel *descLabel;         //提示标签
@property (weak, nonatomic) IBOutlet UITextField *PriceField;    //价格

@property (weak, nonatomic) IBOutlet UIImageView *thumbimg;

@property (weak, nonatomic) IBOutlet UITextField *namefield;



@end

@implementation ManageTreasureTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPickView];
    [self addChatBtn];     //添加自定制导航栏按钮
    self.textView.delegate = self;
    self.PriceField.delegate = self;
    self.namefield.delegate = self;
    self.PriceField.text = self.array[1];
    self.namefield.text = self.array[2];
    imageUrl = self.array[3];
    [self.thumbimg sd_setImageWithURL:[NSURL URLWithString:self.array[3]] placeholderImage:[UIImage imageNamed:@"myorderthumbimage"]];
    if(self.textView.text.length>0){
        self.descLabel.hidden = YES;
    }
    self.thumbimg.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choseImg)];
    [self.thumbimg addGestureRecognizer:tap];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
   // [self addRefresh];
}

- (void)choseImg
{
    [self showModalView];
}

- (void)initPickView
{
    _picker = [[UIImagePickerController alloc] init];
    _picker.delegate = self;
}


- (void)openCamera
{
    _picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:_picker animated:YES completion:nil];
}

- (void)openPhotoAlbun
{
    _picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:_picker animated:YES completion:nil];
}

- (void)showModalView
{
    
    [[KGModal sharedInstance] setCloseButtonType:KGModalCloseButtonTypeNone];
    [KGModal sharedInstance].modalBackgroundColor = [UIColor whiteColor];
    
    ChangeHeadView * modifyView = [[[NSBundle mainBundle] loadNibNamed:@"ChangeHeadView" owner:self options:nil] lastObject];
    
    [[KGModal sharedInstance] showWithContentView:modifyView andAnimated:YES];
    
    modifyView.LibraryBlock = ^(){
        [self openPhotoAlbun];
        [[KGModal sharedInstance] hideAnimated:YES];
    };
    modifyView.TakeBlock = ^(){
        [self openCamera];
        [[KGModal sharedInstance] hideAnimated:YES];
    };
    
    
}


#pragma mark-UINavigationControllerDelegate & UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage * image = info[UIImagePickerControllerOriginalImage];
    
    NSData * data = UIImageJPEGRepresentation(image, 0.1);
    
    [self showHudInView:self.view hint:@"上传图片中"];
    [[MyAPI sharedAPI] uploadImage:data result:^(BOOL sucess, NSString *msg) {
        if(sucess){
            imageUrl = msg;
             [self.thumbimg sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@""]];
            [[Config Instance] saveIcon:msg];
            
            [self hideHud];
        }else{
                  }
    } errorResult:^(NSError *enginerError) {
        
    }];
}

- (void)addRefresh
{
    __weak ManageTreasureTableViewController * weakself = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
    }];
    MJRefreshAutoNormalFooter * footerRefresh = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
    }];
    footerRefresh.automaticallyRefresh = NO;
   self.tableView.mj_footer = footerRefresh;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
 
        NSString * price = self.PriceField.text;
        priceString = price;
        NSArray * stringArray = [price componentsSeparatedByString:@"¥"];
        NSString * priceStr = [stringArray lastObject];
        self.PriceField.text = priceStr;
  }

//添加自定制导航栏按钮
- (void)addChatBtn{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 31, 27);
    [btn setImage:[UIImage imageNamed:@"messageBtn"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(chatAct:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 0, 20, 20);
    [btn1 setImage:[UIImage imageNamed:@"barimage"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(clickBtn1) forControlEvents:UIControlEventTouchUpInside];
    
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

//自定制导航栏信息按钮的事件响应方法
- (void)clickBtn1
{
    [self.tableView.mj_header beginRefreshing];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.descLabel.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(textView.text.length>0){
        self.descLabel.hidden = YES;
    }else{
    self.descLabel.hidden = NO;
    }
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if(section==0){
        return 2;
    }else if (section==1){
        return 1;
    }else if (section==2){
        return 1;
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
        return 8;
    }else{
        return 12;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0||indexPath.section==2){
        [self.textView endEditing:YES];
        [self.PriceField endEditing:YES];
       
    }
}


//确定修改
- (IBAction)Sure:(id)sender {
  
    [Tools hideKeyBoard];
    [[MyAPI sharedAPI] EditTreasureWithTreausreId:self.array[0] Name:self.namefield.text About:self.textView.text Price:self.PriceField.text ThumbImg:imageUrl result:^(BOOL sucess, NSString *msg) {
        if(sucess){
            NSLog(@"%@",imageUrl);
            [self showHint:@"修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"loadTreasureManageView" object:nil];
        }else{
            [self showHint:msg];
        }
    } errorResult:^(NSError *enginerError) {
        
    }];
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
