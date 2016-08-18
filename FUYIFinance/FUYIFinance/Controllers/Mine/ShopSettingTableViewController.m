//
//  ShopSettingTableViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/4.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "ShopSettingTableViewController.h"
#import "UIViewController+HUD.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ModifyHeadView.h"
#import "ChangeHeadView.h"
#import "TeacherShopInfoModel.h"
#import "KGModal.h"
#import "MyAPI.h"

@interface ShopSettingTableViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImagePickerController * _picker;
    TeacherShopInfoModel * userinfo;
}
@property (weak, nonatomic) IBOutlet UIImageView *headicon;

@property (weak, nonatomic) IBOutlet UITextField *shopintroduce;

@property (weak, nonatomic) IBOutlet UILabel *shopname;

@end

@implementation ShopSettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPickView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeShopName:) name:@"returnShopName" object:nil];
    [self loadData];
}

- (void)changeShopName:(NSNotification *)noti
{
    self.shopname.text = noti.userInfo[@"shopname"];
}

- (void)loadData
{
    [[MyAPI sharedAPI] requestTeacherShopInfoWithResult:^(BOOL success, NSString *msg, id object) {
        if(success){
            userinfo = object;
            self.shopname.text = userinfo.name;
            self.shopintroduce.text = userinfo.about;
            
            NSString * imageUrl = [[Config Instance] getIcon];
            [self.headicon sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"myorderthumbimage"]];
        }
    } ErrorResult:^(NSError *enginerError) {
        
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.headicon.layer.cornerRadius = 24;
    self.headicon.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section==0) {
        return 3;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section==0){
        return 15;
    }else if(section==1){
        return ScreenHeight - 371 - 64 + 65 + 63;
    }else{
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if(indexPath.row == 0){
           // [self showModalView];
        }
        if(indexPath.row == 1){
            [self performSegueWithIdentifier:@"shopnameSegue" sender:nil];
        }
           }
}

- (void)showModalView
{
   // [[KGModal sharedInstance] setTapOutsideToDismiss:NO];
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
#pragma mark-UINavigationControllerDelegate & UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage * image = info[UIImagePickerControllerOriginalImage];
    [self showHudInView:self.view hint:@"上传图片..."];
    NSData * data = UIImageJPEGRepresentation(image, 0.1);
    
}
- (IBAction)commit:(id)sender {
    [self.shopintroduce endEditing:YES];
    [[MyAPI sharedAPI] modifyTeacherInfoWithName:self.shopname.text About:self.shopintroduce.text Result:^(BOOL sucess, NSString *msg) {
        if(sucess){
            [self showHint:@"修改成功"];
        }
    } ErrorResult:^(NSError *enginerError) {
        
    }];
}

- (IBAction)back:(id)sender {
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [Tools hideKeyBoard];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
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
